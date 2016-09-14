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
    NSLog(@"Tel");
     //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://18390907126"]];
}
@end