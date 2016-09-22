//
//  XL_SearchViewController.h
//  PanDianDanJi
//
//  Created by newmac on 16/9/19.
//  Copyright © 2016年 BinXiaolang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void(^PassdicValueBlock)(NSDictionary *dic);
@interface XL_SearchViewController : UIViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong,nonatomic)NSString *str;


@property (nonatomic,copy) PassdicValueBlock passdicValueBlock;
//传值
-(void)passdicValue:(PassdicValueBlock)block;
@end
