//
//  XL_PanDianViewController.m
//  PanDianDanJi
//
//  Created by newmac on 16/9/14.
//  Copyright © 2016年 BinXiaolang. All rights reserved.
//

#import "XL_PanDianViewController.h"

@interface XL_PanDianViewController ()

@end

@implementation XL_PanDianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick)];
    [_ypname addGestureRecognizer:labelTapGestureRecognizer];
    _ypname.userInteractionEnabled = YES;

    
    // Do any additional setup after loading the view.
}

-(void)labelClick{
    NSLog(@"1");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
