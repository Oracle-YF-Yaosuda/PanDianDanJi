//
//  XL_ZhuJiMaViewController.h
//  PanDianDanJi
//
//  Created by newmac on 16/9/14.
//  Copyright © 2016年 BinXiaolang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  void(^PassValueBlock)(NSString *str);

@interface XL_ZhuJiMaViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *mytf;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic,copy) PassValueBlock passValueBlock;
//传值
-(void)passValue:(PassValueBlock)block;

@end
