//
//  XLRelationViewController.h
//  PanDianDanJi
//
//  Created by newmac on 16/9/12.
//  Copyright © 2016年 BinXiaolang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLRelationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *WeinXin_View;
@property (weak, nonatomic) IBOutlet UIButton *WeiXin_Button;
- (IBAction)WeiXin_Button:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *QQ_View;
@property (weak, nonatomic) IBOutlet UIButton *QQ_Button;
- (IBAction)QQ_Button:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *DianHuan_View;
@property (weak, nonatomic) IBOutlet UIButton *DianHua_Button;
- (IBAction)DianHua_Button:(id)sender;

@end
