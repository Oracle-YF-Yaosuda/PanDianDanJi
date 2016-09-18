//
//  XLSettingViewController.m
//  PanDianDanJi
//
//  Created by newmac on 16/9/12.
//  Copyright © 2016年 BinXiaolang. All rights reserved.
//

#import "XLSettingViewController.h"

@interface XLSettingViewController ()

@end

@implementation XLSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self navigation];
}
-(void)navigation{
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

@end
