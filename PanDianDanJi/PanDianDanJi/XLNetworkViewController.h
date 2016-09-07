//
//  XLNetworkViewController.h
//  PanDianDanJi
//
//  Created by 小狼 on 16/9/6.
//  Copyright © 2016年 BinXiaolang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLNetworkViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *NetText1;
@property (weak, nonatomic) IBOutlet UITextField *NetText2;
@property (weak, nonatomic) IBOutlet UITextField *NetText3;
@property (weak, nonatomic) IBOutlet UITextField *NetText4;
@property (weak, nonatomic) IBOutlet UITextField *NetText5;
@property (weak, nonatomic) IBOutlet UIButton *SaveNetOutlet;

- (IBAction)SaveNetwork:(id)sender;
- (IBAction)NetBack:(id)sender;

@end
