//
//  DSKyeboard.m
//  DSFramework
//
//  Created by DomSheldon on 15/12/23.
//  Copyright © 2015年 Derek. All rights reserved.
//

#import "DSKyeboard.h"
#import "DSNumberKeyboard.h"
#import "DSLetterKeyboard.h"
#import "DSSymbolKeyboard.h"

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kIsIPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define kIsIPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

@interface DSKyeboard ()
{
    UIButton *_selectedBtn;
}
@property (nonatomic, strong) UITextField *tf;
@property(nonatomic,strong)UISearchBar *sb;
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) DSNumberKeyboard *numberKB;
@property (nonatomic, strong) DSLetterKeyboard *letterKB;
@property (nonatomic, strong) DSSymbolKeyboard *symbolKB;
@property (nonatomic, copy) NSString *output;

@end

@implementation DSKyeboard

CGFloat _dsKeyboardH;
CGFloat _dsKeyboardToolH;

#pragma mark - lazy loading
- (UIToolbar *)toolBar {
    if (!_toolBar) {
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, _dsKeyboardToolH)];
        _toolBar.barTintColor = [UIColor colorWithRed:235 / 255.0 green:237 / 255.0 blue:239 / 255.0 alpha:1.0];
        NSMutableArray *items = [NSMutableArray array];
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [items addObject:space];
        
        NSArray *btnTitles = @[ @"数字", @"字母"];
        for (int i = 0; i < btnTitles.count; i++) {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, 0, i ? 40.0 : 130.0, _dsKeyboardToolH);
            btn.tag = 100 + i;
            [btn setTitle:btnTitles[i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(switchToSystemKeyboard:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
            if (i == 1) {
                [self switchToSystemKeyboard:btn];
            }
            
            UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
            [items addObject:buttonItem];
            [items addObject:space];
        }
        [_toolBar setItems:items animated:YES];
    }
    return  _toolBar;
}

- (UIView *)numberKB {
    if (!_numberKB) {
        _numberKB = [[DSNumberKeyboard alloc] initWithFrame:CGRectMake(0, _dsKeyboardToolH, kScreenWidth, self.frame.size.height - _dsKeyboardToolH)];
        _numberKB.tag = 110;
        [self addSubview:_numberKB];
    }
    return _numberKB;
}

- (UIView *)letterKB {
    if (!_letterKB) {
        _letterKB = [[DSLetterKeyboard alloc] initWithFrame:self.numberKB.frame];
        _letterKB.tag = 111;
        [self addSubview:_letterKB];
    }
    return _letterKB;
}

//- (UIView *)symbolKB {
//    if (!_symbolKB) {
//        _symbolKB = [[DSSymbolKeyboard alloc] initWithFrame:self.numberKB.frame];
//        _symbolKB.tag = 113;
//        [self addSubview:_symbolKB];
//    }
//    return _symbolKB;
//}

- (NSString *)output {
    if (!_output) {
        _output = [NSString string];
    }
    return _output;
}

#pragma mark - initialize
+ (void)initialize {
    if (self == [DSKyeboard class]) {
        if (kIsIPhone6P) {
            _dsKeyboardH = 271.0;
            _dsKeyboardToolH = 45.0;
        } else if (kIsIPhone6) {
            _dsKeyboardH = 258.0;
            _dsKeyboardToolH = 42.0;
        } else {
            _dsKeyboardH = 253.0;
            _dsKeyboardToolH = 38.0;
        }
    }
}

+ (instancetype)keyboardWithTextField:(UITextField *)tf {
    return [[self alloc] initWithTextField:tf];
}

- (instancetype)initWithTextField:(UITextField *)tf {
    if (self = [super init]) {
        self.tf = tf;
        self.frame = CGRectMake(0, 0, kScreenWidth, _dsKeyboardH);
        [self editingData];
    }
    return self;
}

+(instancetype)keyboardWithSearchBar:(UISearchBar *)sb{
    return [[self alloc]initWithSearchBar:sb];
}

-(instancetype)initWithSearchBar:(UISearchBar *)sb{
    if (self=[super init]) {
        self.sb=sb;
        self.frame=CGRectMake(0, 0, kScreenWidth, _dsKeyboardH);
        [self editingData];
    }
    return self;
}

- (void)editingData {
    __weak typeof(self) weakSelf = self;
    [(DSNumberKeyboard *)self.numberKB getDSKeyboardInputWithInput:^(NSString *text){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf outputByText:text];
    }];
    [(DSLetterKeyboard *)self.letterKB getDSKeyboardInputWithInput:^(NSString *text){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf outputByText:text];
    }];
    [(DSSymbolKeyboard *)self.symbolKB getDSKeyboardInputWithInput:^(NSString *text){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf outputByText:text];
    }];
    [self addSubview:self.toolBar];
}

- (void)outputByText:(NSString *)text {
    if ([text isEqualToString:@"完成"]) {
        if (self.loginBlock) {
            self.loginBlock(self.output);
        }
        [self.tf resignFirstResponder];
    } else {
        if ([text isEqualToString:@"删除"]) {
            if (self.output.length >= 2) {
                self.output = [self.output substringToIndex:self.tf.text.length - 1];
            } else {
                self.output = nil;
            }
        } else if ([text isEqualToString:@"清空"]) {
            self.output=nil;
        } else {
            self.output = [self.output stringByAppendingString:text];
        }
        if (self.outputBlock) {
            NSString *fakePassword = [self fakePasswordWithOutput:self.output];
            
            self.outputBlock(fakePassword);
        }
    }
}

- (NSString *)fakePasswordWithOutput:(NSString *)output {
    if (output.length) {
        NSString *fakePassword = [NSString string];
//        for (int i = 0; i < output.length; i++) {
//            fakePassword = [fakePassword stringByAppendingString:@"•"];
//        }
        fakePassword=output;
        
        return fakePassword;
    }
    return nil;
}

#pragma mark - target action
- (void)switchToSystemKeyboard:(UIButton *)btn {
    _selectedBtn.selected = NO;
    _selectedBtn = btn;
    _selectedBtn.selected = YES;
    
//    if (99 == btn.tag) {
//        [self.tf resignFirstResponder];
//        self.tf.inputView = nil;
//        self.tf.text = nil;
//        [self.tf becomeFirstResponder];
//    } else {
        UIView *aView = [self viewWithTag:(btn.tag + 10)];
        [self bringSubviewToFront:aView];
//    }
}

- (void)dsKeyboardTextChangedOutputBlock:(DSKeyboardOutput)output loginBlock:(DSKeyboardLogin)login {
    self.outputBlock = output;
    self.loginBlock = login;
}

- (void)clear {
    self.output = nil;
}

- (void)dealloc {
    self.output = nil;
}

@end
