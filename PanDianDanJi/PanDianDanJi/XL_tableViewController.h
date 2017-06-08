//
//  XL_tableViewController.h
//  com.BeiGe.PanYouApp
//
//  Created by 小狼 on 2017/5/18.
//  Copyright © 2017年 BinXiaolang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XL_tableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UISegmentedControl *biaoqian;
@end
