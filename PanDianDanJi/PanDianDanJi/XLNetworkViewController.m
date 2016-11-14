//
//  XLNetworkViewController.m
//  PanDianDanJi
//
//  Created by 小狼 on 16/9/6.
//  Copyright © 2016年 BinXiaolang. All rights reserved.
//

#import "XLNetworkViewController.h"
#import "XLLogin_ViewController.h"
#import "XL_Header.h"
#import "WarningBox/WarningBox.h"

@interface XLNetworkViewController (){
    /*
     以下两个是判断键盘监听用的
     */
    float cha;
    int pan;
}

@end

@implementation XLNetworkViewController

-(void)viewWillAppear:(BOOL)animated{
    
    if (NULL != JuyuwangIP) {
        if ([JuyuwangIP rangeOfString:@"www."].location !=NSNotFound) {
            
        }else{
        NSArray*Fenge=[JuyuwangIP componentsSeparatedByString:@"."];
        NSArray*fe2=[[Fenge lastObject] componentsSeparatedByString:@":"];
        _NetText1.text=[NSString stringWithFormat:@"%@",Fenge[0]];
        _NetText2.text=[NSString stringWithFormat:@"%@",Fenge[1]];
        _NetText3.text=[NSString stringWithFormat:@"%@",Fenge[2]];
        _NetText4.text=[NSString stringWithFormat:@"%@",fe2[0]];
        _NetText5.text=[NSString stringWithFormat:@"%@",fe2[1]];
        }
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self delegate];
    [self registerForKeyboardNotifications];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)delegate{
    _NetText1.delegate=self;
    _NetText2.delegate=self;
    _NetText3.delegate=self;
    _NetText4.delegate=self;
    _NetText5.delegate=self;
    
    _NetText1.keyboardType=UIKeyboardTypeNumberPad;
    _NetText2.keyboardType=UIKeyboardTypeNumberPad;
    _NetText3.keyboardType=UIKeyboardTypeNumberPad;
    _NetText4.keyboardType=UIKeyboardTypeNumberPad;
    _NetText5.keyboardType=UIKeyboardTypeNumberPad;
    
    _NetText1.textAlignment=NSTextAlignmentRight;
    _NetText2.textAlignment=NSTextAlignmentRight;
    _NetText3.textAlignment=NSTextAlignmentRight;
    _NetText4.textAlignment=NSTextAlignmentRight;
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self huanhang:@"" :textField];
    
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (![string isEqualToString:@""]) {
        if (textField == _NetText5) {
            if (textField.text.length>=5) {
                return NO;
            }
        }else{
            if(textField.text.length>=3){
                
                [self huanhang:string :textField];
                return NO;
            }
        }
    }
    
    return YES;
}
-(void)huanhang:(NSString *)str :(UITextField*)textField{
    if (textField == _NetText1) {
        _NetText2.text =str;
        [_NetText2 becomeFirstResponder];
    }else if (textField == _NetText2) {
        _NetText3.text =str;
        [_NetText3 becomeFirstResponder];
    }else if (textField == _NetText3) {
        _NetText4.text =str;
        [_NetText4 becomeFirstResponder];
    }else if (textField == _NetText4) {
        _NetText5.text =str;
        [_NetText5 becomeFirstResponder];
    }else {
        [self SaveNetwork:nil];
    }
}
#pragma  mark ---注册监听通知
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
        CGRect rect = CGRectMake(_SaveNetOutlet.frame.origin.x, _SaveNetOutlet.frame.origin.y, _SaveNetOutlet.frame.size.width,_SaveNetOutlet.frame.size.height);
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
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (IBAction)SaveNetwork:(id)sender {
    if (_NetText5.text.length>0&&_NetText4.text.length>0&&_NetText3.text.length>0&&_NetText2.text.length>0&&_NetText1.text.length>0) {
        NSString*Pinjie=[NSString stringWithFormat:@"%@.%@.%@.%@:%@",_NetText1.text,_NetText2.text,_NetText3.text,_NetText4.text,_NetText5.text];
        NSUserDefaults *shuju=[NSUserDefaults standardUserDefaults];
        [shuju setObject:Pinjie forKey:@"JuYuWang"];
        [self NetBack:nil];
    }else{
        [WarningBox warningBoxModeText:@"请填写全部信息" andView:self.view];
    }
}
- (IBAction)NetBack:(id)sender {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popToRootViewControllerAnimated:YES];
    });
    
}

@end
