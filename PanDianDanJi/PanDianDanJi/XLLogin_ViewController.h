//
//  XLLogin_ViewController.h
//  PanDianDanJi
//
//  Created by 小狼 on 16/9/6.
//  Copyright © 2016年 BinXiaolang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLLogin_ViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *LoginOutlet;
@property (weak, nonatomic) IBOutlet UITextField *Name;
@property (weak, nonatomic) IBOutlet UITextField *Password;
- (IBAction)Login:(UIButton *)sender;

@end
