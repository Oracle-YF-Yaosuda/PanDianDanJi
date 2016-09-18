//
//  DSLetterKeyboard.m
//  DSFramework
//
//  Created by DomSheldon on 15/12/24.
//  Copyright © 2015年 Derek. All rights reserved.
//

#import "DSLetterKeyboard.h"

@interface DSLetterKeyboard ()

@property (nonatomic, strong) NSArray *lowercases;
@property (nonatomic, strong) NSArray *uppercases;

@end

@implementation DSLetterKeyboard

- (NSArray *)lowercases {
    if (!_lowercases) {
        _lowercases = @[@"q", @"w", @"e", @"r", @"t", @"y", @"u", @"i", @"o", @"p", @"a", @"s", @"d", @"f", @"g", @"h", @"j", @"k", @"l", @"z", @"x", @"c", @"v", @"b", @"n", @"m", @"shift", @"删除", @"清空", @"完成"];
    }
    return _lowercases;
}

- (NSArray *)uppercases {
    if (!_uppercases) {
        _uppercases = @[@"Q", @"W", @"E", @"R", @"T", @"Y", @"U", @"I", @"O", @"P", @"A", @"S", @"D", @"F", @"G", @"H", @"J", @"K", @"L", @"Z", @"X", @"C", @"V", @"B", @"N", @"M", @"shift", @"删除", @"清空", @"完成"];
    }
    return _uppercases;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"DSLetterKeyboard" owner:nil options:nil] lastObject];
        self.frame = frame;
        self.backgroundColor = self.kbBackgroundColor;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    [self.lowercases enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = (UIButton *)[self viewWithTag:200 + idx];
        btn.backgroundColor = [UIColor whiteColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:kKeyboardButtonFont];
        btn.layer.cornerRadius = kButtonCornerRadius;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:self.kbButtonSelectedColor forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(letterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }];
    [self loadBtnTitleWithTitles:self.lowercases];
}

- (void)loadBtnTitleWithTitles:(NSArray *)titles {
    [titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = (UIButton *)[self viewWithTag:200 + idx];
        [btn setTitle:titles[idx] forState:UIControlStateNormal];
    }];
}

- (void)letterButtonClick:(UIButton *)btn {
    NSString *text = [NSString string];
    if ((200 <= btn.tag && btn.tag <= 225) || 228 == btn.tag) {
        text = btn.titleLabel.text;
    } else if (226 == btn.tag) {
        btn.selected = !btn.selected;
        [self loadBtnTitleWithTitles:btn.selected ? self.uppercases : self.lowercases];
    } else if (227 == btn.tag) {
        text = @"删除";
    } else if (229 == btn.tag) {
        text = @"完成";
    }
    if (226 != btn.tag) {
        if (self.kbInput) {
            self.kbInput(text);
        }
    }
}

- (void)getDSKeyboardInputWithInput:(DSKeyboardInput)kbInput {
    self.kbInput = kbInput;
}

@end
