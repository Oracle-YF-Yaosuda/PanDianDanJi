//
//  XLChangeViewController.m
//  PanDianDanJi
//
//  Created by newmac on 16/9/12.
//  Copyright © 2016年 BinXiaolang. All rights reserved.
//

#import "XLChangeViewController.h"
#import "WarningBox.h"
#import "XL_Header.h"
#import "XL_WangLuo.h"

@interface XLChangeViewController ()

@end

@implementation XLChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    //限制textField位数
    [self xianzhi];
    [self navigatio];
    [self delegate];
    // Do any additional setup after loading the view.
}
-(void)navigatio{
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*left=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self  action:@selector(fanhui)];
    [self.navigationItem setLeftBarButtonItem:left];
    
}
-(void)delegate{
    //按钮圆角
    self.QueRen_Button.layer.cornerRadius = 5.0;
    //textfield 代理
    _Oldpass_Field.delegate = self;
    _Newpass_Field.delegate = self;
    _Newpass_Field_2.delegate = self;
    _Newpass_Field.keyboardType = UIKeyboardTypeASCIICapable;
    _Oldpass_Field.keyboardType = UIKeyboardTypeASCIICapable;
    _Newpass_Field_2.keyboardType=UIKeyboardTypeASCIICapable;
    _Oldpass_Field.autocorrectionType = UITextAutocorrectionTypeNo;
    _Newpass_Field.autocorrectionType = UITextAutocorrectionTypeNo;
    _Newpass_Field_2.autocorrectionType = UITextAutocorrectionTypeNo;
}
-(void)fanhui{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - textfield方法

//光标下移
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == self.Oldpass_Field)
    {
        [self.Newpass_Field becomeFirstResponder];
    }
    else if (textField == self.Newpass_Field)
    {
        [self.Newpass_Field_2 becomeFirstResponder];
    }
    else
    {
        //结束编辑
        [self.view endEditing:YES];
        [self QueRen_Button:nil];
    }
    return YES;
}
#pragma mark - 限制textField位数
-(void)xianzhi
{
    [self.Oldpass_Field addTarget:self action:@selector(oldPass) forControlEvents:UIControlEventEditingChanged];
    [self.Newpass_Field addTarget:self action:@selector(newPass1) forControlEvents:UIControlEventEditingChanged];
    [self.Newpass_Field_2 addTarget:self action:@selector(newPass2) forControlEvents:UIControlEventEditingChanged];
}
-(void)oldPass
{
    int MaxLen = 14;
    NSString* szText = [_Oldpass_Field text];
    if ([_Oldpass_Field.text length]> MaxLen)
    {
        _Oldpass_Field.text = [szText substringToIndex:MaxLen];
    }
}
-(void)newPass1
{
    int MaxLen = 14;
    NSString* szText = [_Newpass_Field text];
    if ([_Newpass_Field.text length]> MaxLen)
    {
        _Newpass_Field.text = [szText substringToIndex:MaxLen];
    }
}
-(void)newPass2
{
    int MaxLen = 14;
    NSString* szText = [_Newpass_Field_2 text];
    if ([_Newpass_Field_2.text length]> MaxLen)
    {
        _Newpass_Field_2.text = [szText substringToIndex:MaxLen];
    }
}
#pragma mark - 判断长度
-(BOOL)newpass1:(NSString *)new1
{
    if (self.Newpass_Field.text.length < 5) {
        return NO;
    }
    return YES;
}

-(BOOL)newpass_Deng:(NSString *)deng
{
    if (![self.Newpass_Field_2.text isEqualToString: self.Newpass_Field.text]) {
        return NO;
    }
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
#pragma mark - 确认按钮
- (IBAction)QueRen_Button:(id)sender {
    [self.view endEditing:YES];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    if (self.Oldpass_Field.text.length > 0 && self.Newpass_Field.text.length > 0 && self.Newpass_Field_2.text.length > 0)
    {
        if(self.Oldpass_Field.text != [NSString stringWithFormat:@"%@",[defaults objectForKey:@"Password"]])
        {
            [WarningBox warningBoxModeText:@"原密码不正确" andView:self.view];
        }
        else if (![self newpass1:self.Newpass_Field.text])
        {
            [WarningBox warningBoxModeText:@"密码长度不够" andView:self.view];
        }
        else if (![self newpass_Deng:self.Newpass_Field_2.text])
        {
            [WarningBox warningBoxModeText:@"两次密码不一致，请重新输入" andView:self.view];
        }
        else
        {
            [WarningBox warningBoxModeIndeterminate:@"正在修改密码...." andView:self.view];
            NSString *fangshi=@"/sys/modpass";
            NSString * name=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"Name"]];
            NSDictionary*rucan=[NSDictionary dictionaryWithObjectsAndKeys:name,@"loginName",_Oldpass_Field.text,@"oldpassword", _Newpass_Field.text,@"newspassword",nil];
            //自己写的网络请求    请求外网地址
            [XL_WangLuo JuYuwangQingqiuwithBizMethod:fangshi Rucan:rucan type:Get success:^(id responseObject) {
                [WarningBox warningBoxHide:YES andView:self.view];
                @try {
                    NSLog(@"the xiugai\n\n\n%@\n\n\n",responseObject);
                        [WarningBox warningBoxModeText:[responseObject objectForKey:@"msg"] andView:self.navigationController.view];
                    if ([[responseObject objectForKey:@"code"]isEqualToString:@"0000"]) {
                        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"Password"];
                        [self.navigationController popToRootViewControllerAnimated:YES];
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
    }else{
        [WarningBox warningBoxModeText:@"密码不能为空" andView:self.view];
    }
}
@end
