//
//  XL_PanDianViewController.h
//  PanDianDanJi
//
//  Created by newmac on 16/9/14.
//  Copyright © 2016年 BinXiaolang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XL_PanDianViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *Search;


@property (weak, nonatomic) IBOutlet UIView *InfoView;



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
- (IBAction)clear:(id)sender;
- (IBAction)zhujima:(id)sender;
- (IBAction)check:(id)sender;
@end
