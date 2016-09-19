//
//  TextFlowView.h
//  Label跑马灯_练习
//
//  Created by mz on 15/4/8.
//  Copyright (c) 2015年 mz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextFlowView : UIView

{
    //显示文本的标签
    UILabel *_firstLabel;
    UILabel *_secondLabel;
    NSTimer *_timer;//定时器
    NSString *_text;//显示的文本
    CGRect _frame;//控件的框架大小
    UIFont *_font;//文本的字体
    UIColor *_color;//文字颜色
    NSInteger _startIndex;//当前第一个控件的索引
    CGFloat _XOffset;//定时器每次执行偏移后，累计的偏移量之和
    CGSize _textSize;//文本显示一行，需要的框架大小
    BOOL _alignLeft;//如果不开启滚动，文字对齐方式
}

- (id)initWithFrame:(CGRect)frame Text:(NSString *)text textColor:(UIColor *)color font:(UIFont *)font backgroundColor:(UIColor *)backColor alignLeft:(BOOL)direction;

@end
