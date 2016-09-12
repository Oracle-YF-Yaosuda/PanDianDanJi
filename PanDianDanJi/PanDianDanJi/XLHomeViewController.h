//
//  XLHomeViewController.h
//  PanDianDanJi
//
//  Created by 小狼 on 16/9/8.
//  Copyright © 2016年 BinXiaolang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLHomeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *TiJian_Button;
- (IBAction)TiJian_Button:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *KuCun_Button;
- (IBAction)KuCun_Button:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *ShuJu_Button;
- (IBAction)ShuJu_Button:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *PanDian_Button;
- (IBAction)PanDian_Button:(id)sender;

@end
