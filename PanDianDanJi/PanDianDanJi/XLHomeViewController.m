//
//  XLHomeViewController.m
//  PanDianDanJi
//
//  Created by 小狼 on 16/9/8.
//  Copyright © 2016年 BinXiaolang. All rights reserved.
//

#import "XLHomeViewController.h"
#import "WarningBox.h"
#import "XLSettingViewController.h"
#import "XL_Header.h"
#import "XL_WangLuo.h"
@interface XLHomeViewController ()

@end

@implementation XLHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO];
    
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*left=[[UIBarButtonItem alloc] initWithTitle:@"盘点助手" style:UIBarButtonItemStyleDone target:nil action:nil];
    //[left setEnabled:NO];
    [self.navigationItem setLeftBarButtonItem:left];
 
    
//    UIButton  *right = [[UIButton alloc]initWithFrame:CGRectMake(0,0, 30, 30)];
//    [right setImage:[UIImage imageNamed:@"cehua_12.png"] forState:UIControlStateNormal];
//   // right.adjustsImageWhenHighlighted = NO;
//    [right addTarget:self action:@selector(set:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightben = [[UIBarButtonItem alloc]initWithCustomView:right];
//    self.navigationItem.rightBarButtonItem =rightben;
  
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cehua_12.png"] style:UIBarButtonItemStyleDone target:self action:@selector(set:)];
    
    [self.navigationItem setRightBarButtonItem:right];

    
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


//同步全部库存
- (IBAction)KuCun_Button:(id)sender {
    NSLog(@"2");
}

//同步异常数据
- (IBAction)ShuJu_Button:(id)sender {
     NSLog(@"3");
}
//提交盘点结果
- (IBAction)TiJian_Button:(id)sender {
    
     NSLog(@"1");
}
//盘点药品
- (IBAction)PanDian_Button:(id)sender {
     NSLog(@"4");
}

//跳转设置
-(void)set:(UIButton*)sender{
     XLSettingViewController *shezhi=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"set"];
    [self.navigationController pushViewController:shezhi animated:YES];
}

@end
