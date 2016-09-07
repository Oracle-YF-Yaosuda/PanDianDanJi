//
//  XLLogin_ViewController.m
//  PanDianDanJi
//
//  Created by 小狼 on 16/9/6.
//  Copyright © 2016年 BinXiaolang. All rights reserved.
//

#import "XLLogin_ViewController.h"
#import "WarningBox.h"

@interface XLLogin_ViewController (){
    CGFloat cha;
    int pan;
}

@end

@implementation XLLogin_ViewController
-(void)viewWillAppear:(BOOL)animated{
    if (NULL != [[NSUserDefaults standardUserDefaults] objectForKey:@"JuYuWang"]) {
        [WarningBox warningBoxModeText:@"局域网已设置" andView:self.view];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self delegate];
    [self registerForKeyboardNotifications];
}
#pragma  mark ---注册通知
- (void) registerForKeyboardNotifications
{
    cha=0.0;
    pan=0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardWillHideNotification object:nil];
}
#pragma mark ----通知实现
- (void) keyboardWasShown:(NSNotification *) notif
{
    if (pan==0) {
        NSDictionary *info = [notif userInfo];
        NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
        CGSize keyboardSize = [value CGRectValue].size;
        CGRect rect = CGRectMake(_LoginOutlet.frame.origin.x, _LoginOutlet.frame.origin.y, _LoginOutlet.frame.size.width,_LoginOutlet.frame.size.height);
        CGFloat kongjian=rect.origin.y+rect.size.height;
        CGFloat viewK=[UIScreen mainScreen].bounds.size.height;
        CGFloat jianpan=keyboardSize.height;
        if (viewK > kongjian+ jianpan) {
            cha=0;
        }else{
            cha=viewK-kongjian-jianpan;
        }
        pan=1;
        [self animateTextField:cha  up: YES];
    }
}
- (void) keyboardWasHidden:(NSNotification *) notif
{
    pan=0;
    [self animateTextField:cha up:NO];
}
#pragma mark ----textFieldDelegate
-(void)delegate{
    _Name.delegate=self;
    _Password.delegate=self;
    [_Name setClearButtonMode:UITextFieldViewModeWhileEditing];
    [_Password setClearButtonMode:UITextFieldViewModeWhileEditing];
    [_Password setSecureTextEntry:YES];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if ( textField != _Name) {
        _Password.keyboardType=UIKeyboardTypeNamePhonePad;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField ==_Name) {
        [_Name resignFirstResponder];
        [_Password becomeFirstResponder];
    }else{
        [self Login:nil];
    }
    return YES;
}

#pragma mark ----Login_Action
- (IBAction)Login:(UIButton *)sender {
    
    
    
    NSLog(@"hehe ");
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
//视图上移的方法
- (void) animateTextField: (CGFloat) textField up: (BOOL) up
{
    
    //设置视图上移的距离，单位像素
    const int movementDistance = textField; // tweak as needed
    //三目运算，判定是否需要上移视图或者不变
    int movement = (up ? movementDistance : -movementDistance);
    //设置动画的名字
    [UIView beginAnimations: @"Animation" context: nil];
    //设置动画的开始移动位置
    [UIView setAnimationBeginsFromCurrentState: YES];
    //设置动画的间隔时间
    [UIView setAnimationDuration: 0.20];
    //设置视图移动的位移
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    //设置动画结束
    [UIView commitAnimations];
    
}

@end
