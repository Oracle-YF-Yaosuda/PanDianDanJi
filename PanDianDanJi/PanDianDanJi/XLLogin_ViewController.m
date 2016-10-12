//
//  XLLogin_ViewController.m
//  PanDianDanJi
//
//  Created by 小狼 on 16/9/6.
//  Copyright © 2016年 BinXiaolang. All rights reserved.
//

#import "XLLogin_ViewController.h"
#import "WarningBox.h"
#import "XL_Header.h"
#import "XL_WangLuo.h"
#import "XLHomeViewController.h"

@interface XLLogin_ViewController (){
    CGFloat cha;
    int pan;
}
@end

@implementation XLLogin_ViewController
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    if (NULL != JuyuwangIP) {
        [WarningBox warningBoxModeText:@"局域网已设置" andView:self.view];
    }
    if (NULL !=[[NSUserDefaults standardUserDefaults] objectForKey:@"Name"]) {
        _Name.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"Name"];
        _Password.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"Password"];
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(qkeyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(qkeyboardWasHidden:) name:UIKeyboardWillHideNotification object:nil];
}
#pragma mark ----通知实现
- (void) qkeyboardWasShown:(NSNotification *) notif
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
- (void) qkeyboardWasHidden:(NSNotification *) notif
{
    pan=0;
    [self animateTextField:cha up:NO];
}
#pragma mark ----textFieldDelegate
-(void)delegate{
    _Name.delegate=self;
    _Password.delegate=self;
    _Name.keyboardType=UIKeyboardTypeASCIICapable;
    _Name.autocorrectionType = UITextAutocorrectionTypeNo;
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
        [self.view endEditing:YES];
        [self Login:nil];
    }
    return YES;
}

#pragma mark ----Login_Action
- (IBAction)Login:(UIButton *)sender {
    if ([_Name.text isEqual:@""]||[_Password.text isEqual:@""]) {
        [WarningBox warningBoxModeText:@"请填写好账号信息哟~" andView:self.view];
    }else if (NULL ==JuyuwangIP){
        [WarningBox warningBoxModeText:@"请先设置网络连接" andView:self.view];
    }else{
       
        [WarningBox warningBoxModeIndeterminate:@"登录中..." andView:self.view];
        NSString *fangshi=@"/sys/login";
        NSDictionary*rucan=[NSDictionary dictionaryWithObjectsAndKeys:_Name.text,@"loginName",_Password.text,@"password", nil];
//自己写的网络请求    请求外网地址
        [XL_WangLuo WaiwangQingqiuwithBizMethod:fangshi Rucan:rucan type:Post success:^(id responseObject) {
            [WarningBox warningBoxHide:YES andView:self.view];
            @try {
                if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
                    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
                    [user setObject:[NSString stringWithFormat:@"%@",_Name.text] forKey:@"Name"];
                    [user setObject:[NSString stringWithFormat:@"%@",_Password.text] forKey:@"Password"];
                    [user setObject:[NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"data" ] objectForKey:@"accessToken"]] forKey:@"accessToken"];
                    [user setObject:[NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"data"] objectForKey:@"mac"]] forKey:@"Mac"];
                    [user setObject:[NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"data"] objectForKey:@"userId"]] forKey:@"UserID"];
                    
                   [self jumpHome];
                }
                else{
                    [WarningBox warningBoxModeText:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]] andView:self.view];
                }
            } @catch (NSException *exception) {
                [WarningBox warningBoxModeText:@"请仔细检查您的网络" andView:self.view];
            }
        } failure:^(NSError *error) {
            [WarningBox warningBoxHide:YES andView:self.view];
            [WarningBox warningBoxModeText:@"网络请求失败" andView:self.view];
            NSLog(@"%@",error);
        }];
   }
}
//拖拽  传值方法
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"tuozhuai"/*与拖拽出来的线的定义*/]) {
        [self.view endEditing:YES];
    }
}

-(void)jumpHome{
    XLHomeViewController *home=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"home"];
    [self.navigationController pushViewController:home animated:YES];
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
