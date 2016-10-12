//
//  XLRelationViewController.m
//  PanDianDanJi
//
//  Created by newmac on 16/9/12.
//  Copyright © 2016年 BinXiaolang. All rights reserved.
//

#import "XLRelationViewController.h"
#import "Color+Hex.h"

@interface XLRelationViewController ()

@end

@implementation XLRelationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self shezhi];
    // Do any additional setup after loading the view.
    [self navigatio];
}
-(void)navigatio{
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*left=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self  action:@selector(fanhui)];
    [self.navigationItem setLeftBarButtonItem:left];
    
}
-(void)fanhui{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)shezhi{
    //微信
    self.WeinXin_View.layer.cornerRadius = 5.0;
    self.WeinXin_View.layer.borderWidth = 1.0;
    self.WeinXin_View.layer.borderColor = [UIColor colorWithHexString:@"00dcb4" alpha:1].CGColor;
    //QQ
    self.QQ_View.layer.cornerRadius = 5.0;
    self.QQ_View.layer.borderWidth = 1.0;
    self.QQ_View.layer.borderColor = [UIColor colorWithHexString:@"00dcb4" alpha:1].CGColor;
    //电话
    self.DianHuan_View.layer.cornerRadius = 5.0;
    self.DianHuan_View.layer.borderWidth = 1.0;
    self.DianHuan_View.layer.borderColor = [UIColor colorWithHexString:@"00dcb4" alpha:1].CGColor;
    
}



- (IBAction)WeiXin_Button:(id)sender {
     NSLog(@"Wechat");
}
- (IBAction)QQ_Button:(id)sender {
     NSLog(@"QQ");
}
- (IBAction)DianHua_Button:(id)sender {
   // NSLog(@"这里要写一个判断   提示框");
    UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"确定要联系客服吗?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction*action1=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://18390907126"]];
        
    }];
    UIAlertAction*action2=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:^{
    }];

    
    
    
}
@end
