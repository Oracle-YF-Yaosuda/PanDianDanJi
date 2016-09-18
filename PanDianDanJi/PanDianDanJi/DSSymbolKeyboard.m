//
//  DSSymbolKeyboard.m
//  DSFramework
//
//  Created by DomSheldon on 15/12/25.
//  Copyright © 2015年 Derek. All rights reserved.
//

#import "DSSymbolKeyboard.h"

@interface DSSymbolKeyboard ()

@property (nonatomic, strong) NSArray *symbols;

@end

@implementation DSSymbolKeyboard

- (NSArray *)symbols {
    if (!_symbols) {
        _symbols = @[@"[", @"]", @"{", @"}", @"#", @"%", @"^", @"*", @"+", @"=", @"_", @"-", @"/", @":", @";", @"(", @")", @"$", @"&", @"@", @".", @",", @"?", @"!", @"'", @"\\", @"|", @"~", @"`", @"<", @">", @"€", @"£", @"¥", @"\"", @"删除", @"完成"];
    }
    return _symbols;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"DSSymbolKeyboard" owner:nil options:nil] lastObject];
        self.frame = frame;
        self.backgroundColor = self.kbBackgroundColor;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    [self.symbols enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = (UIButton *)[self viewWithTag:230 + idx];
        btn.titleLabel.font = [UIFont systemFontOfSize:kKeyboardButtonFont];
        btn.backgroundColor = [UIColor whiteColor];
        btn.layer.cornerRadius = kButtonCornerRadius;
        [btn setTitle:self.symbols[idx] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:self.kbButtonSelectedColor forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(symbolBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }];
}

- (void)symbolBtnClick:(UIButton *)btn {
    NSString *text = [NSString string];
    if (230 <= btn.tag && btn.tag <= 264) {
        text = btn.titleLabel.text;
    } else if (265 == btn.tag) {
        text = @"删除";
    } else if (266 == btn.tag) {
        text = @"完成";
    }
    if (self.kbInput) {
        self.kbInput(text);
    }
}

- (void)getDSKeyboardInputWithInput:(DSKeyboardInput)kbInput {
    self.kbInput = kbInput;
}

@end
