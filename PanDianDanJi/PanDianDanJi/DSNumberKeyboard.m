//
//  DSNumberKeyboard.m
//  DSFramework
//
//  Created by DomSheldon on 15/12/23.
//  Copyright © 2015年 Derek. All rights reserved.
//

#import "DSNumberKeyboard.h"

#define kNumberMarginH  10
#define kNumberMarginV  10
#define kColCount       3
#define kRowCount       4

@implementation DSNumberKeyboard

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = self.kbBackgroundColor;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    NSString *btnTitle = [NSString string];
    int j = 0;
    NSArray *numberArr = [self randomNumberArray];
    CGFloat btnW = (self.bounds.size.width - (kColCount + 1) * kNumberMarginH) / kColCount;
    CGFloat btnH = (self.bounds.size.height - (kRowCount + 1) * kNumberMarginV) / kRowCount;
    for (int i = 0; i < 12; i++) {
        int row = i / kColCount;
        int col = i % kColCount;
        CGFloat x = kNumberMarginH + col * (kNumberMarginH + btnW);
        CGFloat y = kNumberMarginV + row * (kNumberMarginV + btnH);
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(x, y, btnW, btnH);
        btn.tag = 120 + i;
        btn.backgroundColor = [UIColor whiteColor];
        btn.layer.cornerRadius = kButtonCornerRadius;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:self.kbButtonSelectedColor forState:UIControlStateHighlighted];
        
        if (8 == i) {
            btnTitle = @"删除";
        } else if (11 == i) {
            btnTitle = @"完成";
        } else {
            btnTitle = numberArr[j++];
        }
        [btn setTitle:btnTitle forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(numberBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}
- (NSArray *)randomNumberArray {
    NSArray *tempArr = @[ @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9",@"0"];
//    return [tempArr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//        int seed = arc4random() % 2;
//        if (seed) {
//            return [obj2 compare:obj1 options:0];
//        } else {
//            return ![obj2 compare:obj1 options:0];
//        }
//    }];
    return tempArr;
}

- (void)numberBtnClick:(UIButton *)btn {
    NSString *text = [NSString string];
    if (128 == btn.tag) {
        text = @"删除";
    } else if (131 == btn.tag) {
        text = @"完成";
    } else {
        text = btn.titleLabel.text;
    }
    if (self.kbInput) {
        self.kbInput(text);
    }
}

- (void)getDSKeyboardInputWithInput:(DSKeyboardInput)kbInput {
    self.kbInput = kbInput;
}

@end
