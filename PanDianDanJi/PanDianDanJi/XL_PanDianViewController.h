//
//  XL_PanDianViewController.h
//  PanDianDanJi
//
//  Created by newmac on 16/9/14.
//  Copyright © 2016年 BinXiaolang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XL_PanDianViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *onelabel;//一条数据的药品数量
@property (weak, nonatomic) IBOutlet UIView *oneview;//一条数据的view

@property (weak, nonatomic) IBOutlet UIView *gundview;//一条数据的批号
@property (weak, nonatomic) IBOutlet UILabel *Search;//搜索框


@property (weak, nonatomic) IBOutlet UITableView *table;

@property (weak, nonatomic) IBOutlet UIView *InfoView;

@property (weak, nonatomic) IBOutlet UIButton *surebtn;
@property (weak, nonatomic) IBOutlet UIButton *canbtn;



@property (weak, nonatomic) IBOutlet UIView *ypname;
@property (weak, nonatomic) IBOutlet UILabel *ypnumber;
@property (weak, nonatomic) IBOutlet UILabel *ypgoods;
@property (weak, nonatomic) IBOutlet UILabel *ypwenhao;
@property (weak, nonatomic) IBOutlet UIView *ypvender;
@property (weak, nonatomic) IBOutlet UILabel *ypetalon;
- (IBAction)zero:(id)sender;
- (IBAction)one:(id)sender;
- (IBAction)two:(id)sender;
- (IBAction)three:(id)sender;
- (IBAction)four:(id)sender;
- (IBAction)five:(id)sender;
- (IBAction)six:(id)sender;
- (IBAction)seven:(id)sender;
- (IBAction)eight:(id)sender;
- (IBAction)nine:(id)sender;
- (IBAction)houtui:(id)sender;
- (IBAction)zhujima:(id)sender;
- (IBAction)check:(id)sender;
- (IBAction)dian:(id)sender;
- (IBAction)lastone:(id)sender;


@end
