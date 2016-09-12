//
//  XLChangeViewController.h
//  PanDianDanJi
//
//  Created by newmac on 16/9/12.
//  Copyright © 2016年 BinXiaolang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLChangeViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *Oldpass_Field;
@property (weak, nonatomic) IBOutlet UITextField *Newpass_Field;
@property (weak, nonatomic) IBOutlet UITextField *Newpass_Field_2;
@property (weak, nonatomic) IBOutlet UIButton *QueRen_Button;
- (IBAction)QueRen_Button:(id)sender;

@end
