//
//  TextFlowView.m
//  Label跑马灯_练习
//
//  Created by mz on 15/4/8.
//  Copyright (c) 2015年 mz. All rights reserved.
//

#import "TextFlowView.h"

@implementation TextFlowView

#define SPACE_WIDTH 50//前后两个Label的距离

//改变一个TRect的起始点位置，但是其终止点的位置不变，因此会导致整个框架大小的变化
- (CGRect)moveNewPoint:(CGPoint)point rect:(CGRect)rect
{
    CGSize tmpSize;
    tmpSize.height = rect.size.height + (rect.origin.y - point.y);
    tmpSize.width = rect.size.width + (rect.origin.x - point.x);
    return CGRectMake(point.x, point.y, tmpSize.width, tmpSize.height);
}

- (void)startRun//开启定时器
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}

- (void)timerAction//定时器执行的操作
{
    static CGFloat offsetOnce = -1;
    _XOffset += offsetOnce;
    if (_XOffset + _textSize.width <= 0) {
        _XOffset += _textSize.width;
        _XOffset += SPACE_WIDTH;
    }
    [self setNeedsDisplay];
}
//计算在给定字体下，文本仅显示一行需要的框架大小
- (CGSize)computeTextSize:(NSString *)text textFont:(UIFont *)font
{
    if (text == nil) {
        return CGSizeMake(0, 0);
    }
    CGRect frame = [_text boundingRectWithSize:CGSizeMake(10000, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return frame.size;
}

- (id)initWithFrame:(CGRect)frame Text:(NSString *)text textColor:(UIColor *)color font:(UIFont *)font backgroundColor:(UIColor *)backColor alignLeft:(BOOL)direction
{
    if ([super initWithFrame:frame]) {
        _frame = frame;
        _text = text;
        _color = color;
        _font = font;
        _alignLeft = direction;
        self.backgroundColor = backColor;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAct:)];
        tap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tap];
        
        //初始化标签
        //判断是否需要滚动效果
        _textSize = [self computeTextSize:text textFont:_font];
        //需要滚动效果
        if (_textSize.width > frame.size.width) {
            [self startRun];
        }
    }
    return self;
}

- (void)tapAct:(UITapGestureRecognizer *)tap
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
        NSLog(@"stop");
    } else {
        NSLog(@"open");
        [self startRun];
    }
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor orangeColor].CGColor);
    // Drawing code
    CGFloat startYOffset = (rect.size.height - _textSize.height) / 2;
    CGPoint origin = rect.origin;
    if (_timer) {
//        NSLog(@"OFFSETX:%f", _XOffset);
//        NSLog(@"textwidth:%f",_textSize.width);
        rect = [self moveNewPoint:CGPointMake(_XOffset, startYOffset) rect:rect];
//        NSLog(@"rect X:%f  Y:%f",rect.origin.x, rect.origin.y);
//        NSLog(@"rect W:%f  H:%f", rect.size.width, rect.size.height);
        while (rect.origin.x <= rect.size.width + rect.origin.x) {
            [_text drawInRect:rect withAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_font, NSFontAttributeName, _color, NSForegroundColorAttributeName, nil]];
            rect = [self moveNewPoint:CGPointMake(rect.origin.x + _textSize.width + SPACE_WIDTH, rect.origin.y) rect:rect];
//            NSLog(@"inner -> rect X:%f  Y:%f", rect.origin.x, rect.origin.y);
//            NSLog(@"inner -> rect W:%f  H:%f",  rect.size.width, rect.size.height);
        }
    } else {//没有滚动时
        if (_alignLeft) {
            //左对齐
            origin.x = 0;
        } else {
            //在控件的中间绘制文本
            origin.x = (rect.size.width - _textSize.width)/2;
        }
        origin.y = (rect.size.height - _textSize.height)/2;
        rect.origin = origin;
        [_text drawInRect:rect withAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_font, NSFontAttributeName, _color, NSForegroundColorAttributeName, nil]];
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
