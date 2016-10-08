//
//  XL_PanDianViewController.m
//  PanDianDanJi
//
//  Created by newmac on 16/9/14.
//  Copyright © 2016年 BinXiaolang. All rights reserved.
//

#import "XL_PanDianViewController.h"
#import "XL_ZhuJiMaViewController.h"
#import "XL_SearchViewController.h"
#import "XLHomeViewController.h"
#import "DSKyeboard.h"
#import "XL_Header.h"
#import "XL_FMDB.h"
#import "WarningBox.h"
#import "TextFlowView.h"
#import "Color+Hex.h"


@interface XL_PanDianViewController (){
    
    XL_FMDB *XL;
    FMDatabase *db;
    
    /*判断传值*/
    int chuanzhipanduan;
    int tianjiapanduan;
    
    int onepand;//判断找到1条数据数量的输入
    int searcpd;//判断是不是搜索条输入
    
    UILabel*oo;
    NSArray *arr;//下载表查找到的数组
    NSArray *scarr;//上传表查找到的数组
    NSDictionary*tianjiade;
    
    ///添加批号
    //新建界面
    UIView * dabeijing;
    UIView * jiemian;
    //界面中的数据
    UILabel *ming1;//名称
    UITextField *pi1;//批号
    UITextField *shu1;//数量
    UILabel *wei1;//货位
    UILabel *bian1;//编号
    UILabel *ge1;//规格
    
    
    //cell 复用
    NSMutableDictionary *buyaoFuyong;
    
    NSMutableArray *shularr;//存放tableview中的数量
    
    int tianpihao;
    
    
}

@end

@implementation XL_PanDianViewController

-(void)viewWillAppear:(BOOL)animated{
    onepand=1;
    [self firstResponderInSubView];
    if (chuanzhipanduan==1) {
        [self chazhao];
        chuanzhipanduan=0;
        
        
    }
    else if(tianjiapanduan==1){
       
        
        /*
         这里把传回来的数据显示
         因为只有一条，所有直接用view方法显示
         */
        arr=[[NSMutableArray alloc] initWithObjects:tianjiade, nil];
        NSLog(@"------   %@",arr);
        [self xianshi:arr];
        //[arr[0]setObject:@"" forKey:@"salePrice"];
        _onelabel.text=[arr[0] objectForKey:@"shuliang"];
        
        
        
        [self xztianjia:0];
        [self sccharu:0];
        
        
         tianjiapanduan=0;
        
    }else{
     
        }
    }
- (void)viewDidLoad {
    [super viewDidLoad];
    chuanzhipanduan=0;
    tianjiapanduan=0;
    buyaoFuyong=[[NSMutableDictionary alloc] init];
    shularr = [[NSMutableArray alloc]init];
    tianpihao=0;
    [self shujuku];
    [self tabledelegate];
    [self navigation];
    [self tianjiapihao];
    [self shoushi];
}
-(void)shoushi{
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)];
    [_ypgoods addGestureRecognizer:labelTapGestureRecognizer];
    _ypgoods.userInteractionEnabled = YES;
    _ypgoods.layer.borderWidth=1;
    _ypgoods.layer.borderColor=[[UIColor blackColor] CGColor];
    _ypgoods.layer.cornerRadius=5;
    _ypgoods.tag=1001;
    
    UITapGestureRecognizer *TapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shul:)];
    [_onelabel addGestureRecognizer:TapGestureRecognizer];
    _onelabel.userInteractionEnabled = YES;
    [_onelabel.layer setBorderWidth:1.0];
    [_onelabel.layer setCornerRadius:5.0];
    
    UITapGestureRecognizer *searTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shul:)];
    [_Search addGestureRecognizer:searTapGestureRecognizer];
    _Search.userInteractionEnabled = YES;
    _Search.tag=1000;
    _Search.textColor = [UIColor lightGrayColor];
    [_Search.layer setBorderWidth:1.5];
    [_Search.layer setCornerRadius:5.0];
    
    [self.view bringSubviewToFront:_oneview];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
//调用数据库
-(void)shujuku {
    XL = [XL_FMDB tool];
    [XL_FMDB allocWithZone:NULL];
    db = [XL getDBWithDBName:@"pandian.sqlite"];
}
//货位号点击方法
-(void)labelClick:(UITapGestureRecognizer *)lableField{
    onepand=2;
    [self firstResponderInSubView];
    UITextField *goodstxt = [[UITextField alloc]init];
    goodstxt.delegate = self;
    [self.view addSubview:goodstxt];
    UILabel*la =(UILabel *)lableField.self.view;
    [self setupCustomedKeyboard:goodstxt :la];
    [goodstxt becomeFirstResponder];
}
#pragma mark ---非tableview的点击事件
-(void)shul:(UITapGestureRecognizer*)lab{
    
    UILabel*la =(UILabel *)lab.self.view;
    if(la==_Search){
        onepand=1;
    }
    else if(la==_onelabel){
        onepand=3;
    }
    [self firstResponderInSubView];
}
#pragma mark  数字键盘
- (IBAction)zero:(id)sender {
    if(onepand==3){
        _onelabel.text = [_onelabel.text stringByAppendingString:@"0"];
    }
    else if (onepand==1){
        if ([_Search.text isEqualToString:@"🔍扫描或输入药品条形码"]){
            _Search.text = @"0";
        }else{
            _Search.text = [_Search.text stringByAppendingString:@"0"];
        }
    }else{
        [self lableFuzhi:@"0"];
    }
}
- (IBAction)one:(id)sender {
    if(onepand==3){
        _onelabel.text = [_onelabel.text stringByAppendingString:@"1"];
    }
    else if (onepand==1){
        if ([_Search.text isEqualToString:@"🔍扫描或输入药品条形码"]){
            _Search.text = @"1";
        }else{
            _Search.text = [_Search.text stringByAppendingString:@"1"];
        }
    }else{
        [self lableFuzhi:@"1"];
    }
}
- (IBAction)two:(id)sender {
    if(onepand==3){
        _onelabel.text = [_onelabel.text stringByAppendingString:@"2"];
    }
    else if (onepand==1){
        if ([_Search.text isEqualToString:@"🔍扫描或输入药品条形码"]){
            _Search.text = @"2";
        }else{
            _Search.text = [_Search.text stringByAppendingString:@"2"];
        }
    }else{
        [self lableFuzhi:@"2"];
    }
}
- (IBAction)three:(id)sender {
    
    if(onepand==3){
        _onelabel.text = [_onelabel.text stringByAppendingString:@"3"];
    }
    else if (onepand==1){
        if ([_Search.text isEqualToString:@"🔍扫描或输入药品条形码"]){
            _Search.text = @"3";
        }else{
            _Search.text = [_Search.text stringByAppendingString:@"3"];
        }
    }else{
        [self lableFuzhi:@"3"];
    }
}
- (IBAction)four:(id)sender {
    if(onepand==3){
        _onelabel.text = [_onelabel.text stringByAppendingString:@"4"];
    }
    else if (onepand==1){
        if ([_Search.text isEqualToString:@"🔍扫描或输入药品条形码"]){
            _Search.text = @"4";
        }else{
            _Search.text = [_Search.text stringByAppendingString:@"4"];
        }
    }else{
        [self lableFuzhi:@"4"];
    }
}
- (IBAction)five:(id)sender {
    if(onepand==3){
        _onelabel.text = [_onelabel.text stringByAppendingString:@"5"];
    }
    else if (onepand==1){
        if ([_Search.text isEqualToString:@"🔍扫描或输入药品条形码"]){
            _Search.text = @"5";
        }else{
            _Search.text = [_Search.text stringByAppendingString:@"5"];
        }
    }else{
        [self lableFuzhi:@"5"];
    }
}
- (IBAction)six:(id)sender {
    if(onepand==3){
        _onelabel.text = [_onelabel.text stringByAppendingString:@"6"];
    }
    else if (onepand==1){
        if ([_Search.text isEqualToString:@"🔍扫描或输入药品条形码"]){
            _Search.text = @"6";
        }else{
            _Search.text = [_Search.text stringByAppendingString:@"6"];
        }
    }else{
        [self lableFuzhi:@"6"];
    }
}
- (IBAction)seven:(id)sender {
    if(onepand==3){
        _onelabel.text = [_onelabel.text stringByAppendingString:@"7"];
    }
    else if (onepand==1){
        if ([_Search.text isEqualToString:@"🔍扫描或输入药品条形码"]){
            _Search.text = @"7";
        }else{
            _Search.text = [_Search.text stringByAppendingString:@"7"];
        }
    }else{
        [self lableFuzhi:@"7"];
    }
}
- (IBAction)eight:(id)sender {
    if(onepand==3){
        _onelabel.text = [_onelabel.text stringByAppendingString:@"8"];
    }
    else if (onepand==1){
        if ([_Search.text isEqualToString:@"🔍扫描或输入药品条形码"]){
            _Search.text = @"8";
        }else{
            _Search.text = [_Search.text stringByAppendingString:@"8"];
        }
    }else{
        [self lableFuzhi:@"8"];
    }
}
- (IBAction)nine:(id)sender {
    if(onepand==3){
        _onelabel.text = [_onelabel.text stringByAppendingString:@"9"];
    }
    else if (onepand==1){
        if ([_Search.text isEqualToString:@"🔍扫描或输入药品条形码"]){
            _Search.text = @"9";
        }else{
            _Search.text = [_Search.text stringByAppendingString:@"9"];
        }
    }else{
        [self lableFuzhi:@"9"];
    }
}
- (IBAction)houtui:(id)sender {
    if(onepand==3){
        if(_onelabel.text.length!=0)
            _onelabel.text= [_onelabel.text substringToIndex:[_onelabel.text length] - 1];
    }
    else if (onepand==1){
        if([_Search.text isEqualToString:@""]||[_Search.text isEqualToString:@"🔍扫描或输入药品条形码"]){
            _Search.text = @"🔍扫描或输入药品条形码";
        }else{
            if(_Search.text.length!=0)
                _Search.text= [_Search.text substringToIndex:[_Search.text length] - 1];
            if (_Search.text.length==0) {
                _Search.text = @"🔍扫描或输入药品条形码";
            }
        }
    }else{
        if (oo.text.length!=0) {
            oo.text= [oo.text substringToIndex:[oo.text length] - 1];
            [buyaoFuyong setObject:[NSString stringWithFormat:@"%@", oo.text ] forKey:[NSString stringWithFormat:@"%ld",(long)oo.tag]];
        }
    }
}
- (IBAction)clear:(id)sender {
    if(onepand==3){
        _onelabel.text= @"";
    }
    else if (onepand==1){
        _Search.text = @"🔍扫描或输入药品条形码";
    }else{
        oo.text= @"";
        [buyaoFuyong setObject:[NSString stringWithFormat:@"%@", oo.text ] forKey:[NSString stringWithFormat:@"%ld",(long)oo.tag]];
    }
}
-(void)lableFuzhi:(NSString*)ss{
    oo.text= [oo.text stringByAppendingString:[NSString stringWithFormat:@"%@",ss]];
    [buyaoFuyong setObject:[NSString stringWithFormat:@"%@", oo.text ] forKey:[NSString stringWithFormat:@"%ld",(long)oo.tag]];
}
#pragma mark -----助记码
- (IBAction)zhujima:(id)sender {
    
    XL_ZhuJiMaViewController *zhuji=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"zhujima"];
    [zhuji passValue:^(NSString *str) {
        _Search.text=str;
        chuanzhipanduan=1;
    }];
    [self.navigationController pushViewController:zhuji animated:YES];
}
//确定按钮
#pragma  mark ----查找及确定
- (IBAction)check:(id)sender {
    /*没写呢*/
    if ([_Search.text isEqualToString:@"🔍扫描或输入药品条形码"]){
        [WarningBox warningBoxModeText:@"请输入条码后进行查询" andView:self.view];
    }else{
        if(onepand==1){
            [self chazhao];
        }
        else{
            [self quedin];
        }
    }
}
//搜索
#pragma  mark -----搜索方法
-(void)chazhao{
    /*没写呢*/
    
    buyaoFuyong=[[NSMutableDictionary alloc] init];
    
    arr=[XL  DataBase:db selectKeyTypes:XiaZaiShiTiLei fromTable:XiaZaiBiaoMing whereCondition:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",_Search.text],@"barCode", nil]];
    
    
    for (int i=0; i<arr.count; i++) {
        if ([[arr[i] objectForKey:@"checkNum"] intValue]==0) {
            
        }else
            [buyaoFuyong setObject:[arr[i] objectForKey:@"checkNum"] forKey:[NSString stringWithFormat:@"%d",i+100]];
    }
    
    [self xianshi:arr];
}
-(void)qingkong{
    _oneview.hidden=NO;
    for (UIView *vv in [_oneview subviews]) {
        if (vv.tag==110){
            [vv removeFromSuperview];
        }
    }
    TextFlowView* techangview= [[TextFlowView alloc] initWithFrame:_gundview.frame Text:@"" textColor:[UIColor colorWithHexString:@"646464"] font:[UIFont boldSystemFontOfSize:16] backgroundColor:[UIColor clearColor] alignLeft:YES]; /*批号不明确是哪个*/
    techangview.tag =110;
    _table.hidden = YES;
    [_oneview addSubview:techangview];
    
    
    _table.hidden=YES;
    _onelabel.text=@"";
    _ypwenhao.text = @"";
    _ypetalon.text = @"";
    _ypgoods.text = @"";
    _ypnumber.text = @"";
    for (UIView *v in [_InfoView subviews]) {
        if (v.tag==101) {
            [v removeFromSuperview];
        }
    }

}
//显示（批号问题！）
-(void)xianshi:(NSArray *)aaa{
    UILabel *name = [[UILabel alloc]init];
    UILabel *chang = [[UILabel alloc]init];
    if (aaa==nil) {
        [self qingkong];
        
    }else{
        if(arr.count==0){
            tianpihao=0;
            [self tishi];
            
            [self qingkong];
        }
        else{
            tianpihao=1;
            name.text =[NSString stringWithFormat:@"%@",[arr[0]objectForKey:@"productName"]];
            chang.text =[NSString stringWithFormat:@"%@",[arr[0]objectForKey:@"manufacturer"]];
            for (UIView *v in [_InfoView subviews]) {
                if (v.tag==101) {
                    [v removeFromSuperview];
                }
            }
            TextFlowView *nameview =  [[TextFlowView alloc] initWithFrame:_ypname.frame Text:name.text textColor:[UIColor colorWithHexString:@"646464"] font:[UIFont boldSystemFontOfSize:18] backgroundColor:[UIColor clearColor] alignLeft:YES];
            TextFlowView *changview =  [[TextFlowView alloc] initWithFrame:_ypvender.frame Text:chang.text textColor:[UIColor colorWithHexString:@"646464"] font:[UIFont boldSystemFontOfSize:18] backgroundColor:[UIColor clearColor] alignLeft:YES];
            nameview.tag=101;
            changview.tag=101;
            [self.InfoView addSubview:nameview];
            [self.InfoView addSubview:changview];
            /*
             显示的所有信息都不是固定的 最后需要重新更改
             */
            _ypnumber.text =[NSString stringWithFormat:@"%@",[arr[0]objectForKey:@"productCode"]];//药品编号
            if (NULL==[arr[0]objectForKey:@"oldpos"]) {
                _ypgoods.text =@"";
            }else{
            _ypgoods.text =[NSString stringWithFormat:@"%@",[arr[0]objectForKey:@"oldpos"]];//货位
            }
            _ypwenhao.text = [NSString stringWithFormat:@"%@",[arr[0]objectForKey:@"pycode"]];//批准文号
            _ypetalon.text =[NSString stringWithFormat:@"%@",[arr[0]objectForKey:@"specification"]];//药品规格
            
            if(arr.count==1){
                _oneview.hidden=NO;
                for (UIView *vv in [_oneview subviews]) {
                    if (vv.tag==110){
                        [vv removeFromSuperview];
                    }
                }
                TextFlowView* techangview= [[TextFlowView alloc] initWithFrame:_gundview.frame Text:[NSString stringWithFormat:@"%@",[arr[0] objectForKey:@"prodBatchNo"]] textColor:[UIColor colorWithHexString:@"646464"] font:[UIFont boldSystemFontOfSize:16] backgroundColor:[UIColor clearColor] alignLeft:YES]; /*批号不明确是哪个*/
                techangview.tag =110;
                _table.hidden = YES;
                [_oneview addSubview:techangview];
                onepand=3;
                [self firstResponderInSubView];
                
            }
            else{
                
                onepand=4;
                
                [_table reloadData];
                _table.hidden=NO;
                _oneview.hidden = YES;
                oo=[[UILabel alloc] init];
                oo.tag=100;
                [self firstResponderInSubView];
            }
        }
    }
}

//确定方法
-(void)quedin{
    if (arr.count==0||NULL ==arr) {
        [WarningBox warningBoxModeText:@"请先查询药品!" andView:self.view];
    }else{
        tianpihao=0;
        [self czshangchuan];
        if(arr.count==1){
            /*status 不确定上传几*/
            shularr=[[NSMutableArray alloc] init];
            [shularr addObject:[NSString stringWithFormat:@"%@",_onelabel.text]];
            if(scarr.count==0){
                [self sccharu:0];
                
            }else{
                //修改上传表
                [self scxiugai:0];
            }
            //修改下载表
            [self xzxiugai:0];
            
        }
        else{
            //拿到列表中的数量 ，shularr 存放填写的数量
            shularr = [[NSMutableArray alloc]init];
            for (int i=0; i<[arr count]; i++) {
                if(NULL ==[buyaoFuyong objectForKey:[NSString stringWithFormat:@"%d",i+100]]){
                    [shularr addObject:@"0"];
                }
                else{
                    [ shularr addObject:[buyaoFuyong objectForKey:[NSString stringWithFormat:@"%d",i+100]]];
                }
            }
            for (int i=0; i<[arr count]; i++){
                if (scarr.count==0) {
                    //如果，没有
                    //所有信息插入上传表中
                    [self sccharu:i];
                }else{
                    //如果有
                    //修改上传表数量
                    [self scxiugai:i];
                }
                //修改下载表中的药品数量 （批号prodBatchNo）
                [self xzxiugai:i];
            }
        }
        
        [self xianshi:nil];
        _Search.text=@"🔍扫描或输入药品条形码";
        onepand=1;
        [self firstResponderInSubView];
    }
}
#pragma mark 数据库操作
-(void)xzxiugai:(int)i{
    if ([shularr[i] isEqual:@""]) {
        shularr[i]=@"0";
    }
  
    
    [XL DataBase:db updateTable:XiaZaiBiaoMing setKeyValues:[NSDictionary dictionaryWithObjectsAndKeys:shularr[i],@"checkNum",_ypgoods.text,@"oldpos", nil] whereCondition:[NSDictionary dictionaryWithObjectsAndKeys:[arr[i] objectForKey:@"prodBatchNo"],@"prodBatchNo", nil]];
    NSLog(@"%@--------%@",[arr[i] objectForKey:@"prodBatchNo"],shularr[i]);
    
}
-(void)xztianjia:(int)i{
    NSDictionary *dic;
    if (tianjiapanduan==1) {
      
     dic =[NSDictionary dictionaryWithObjectsAndKeys:[tianjiade objectForKey:@"approvalNumber"],@"approvalNumber",[tianjiade objectForKey:@"vipPrice"],@"vipPrice",@"",@"stockNum",[tianjiade objectForKey:@"specification"],@"specification",[tianjiade objectForKey:@"salePrice"],@"salePrice",[tianjiade objectForKey:@"pycode"],@"pycode",@"",@"purchaseBatchNo",[tianjiade objectForKey:@"productName"],@"productName",[tianjiade objectForKey:@"productCode"],@"productCode",[tianjiade objectForKey:@"manufacturer"],@"manufacturer",[tianjiade objectForKey:@"id"],@"id",[tianjiade objectForKey:@"costPrice"],@"costPrice",@"",@"checkId",[tianjiade objectForKey:@"barCode"],@"barCode",[tianjiade objectForKey:@"prodBatchNo"],@"prodBatchNo",@"",@"status",[tianjiade objectForKey:@"shuliang"],@"checkNum",[tianjiade objectForKey:@"oldpos"],@"oldpos", nil];
  
        
    }else{
    dic =[NSDictionary dictionaryWithObjectsAndKeys:[arr[i]objectForKey:@"approvalNumber"],@"approvalNumber",[arr[i]objectForKey:@"vipPrice"],@"vipPrice",[arr[i]objectForKey:@"stockNum"],@"stockNum",[arr[i]objectForKey:@"status"],@"status",[arr[i]objectForKey:@"specification"],@"specification",[arr[i]objectForKey:@"salePrice"],@"salePrice",[arr[i]objectForKey:@"pycode"],@"pycode",[arr[i]objectForKey:@"purchaseBatchNo"],@"purchaseBatchNo",[arr[i]objectForKey:@"productName"],@"productName",[arr[i]objectForKey:@"productCode"],@"productCode",[arr[i]objectForKey:@"oldpos"],@"oldpos",[arr[i]objectForKey:@"manufacturer"],@"manufacturer",[arr[i]objectForKey:@"id"],@"id",[arr[i]objectForKey:@"costPrice"],@"costPrice",[arr[i]objectForKey:@"checkId"],@"checkId",[arr[i]objectForKey:@"barCode"],@"barCode",pi1.text,@"prodBatchNo",shu1.text,@"checkNum", nil];
    }
    [XL DataBase:db insertKeyValues:dic intoTable:XiaZaiBiaoMing];
}
-(void)scxiugai:(int)i{
    if ([shularr[i] isEqual:@""]) {
        shularr[i]=@"0";
    }
    [XL DataBase:db updateTable:ShangChuanBiaoMing setKeyValues:[NSDictionary dictionaryWithObjectsAndKeys:shularr[i],@"checkNum",_ypgoods.text,@"newpos", nil] whereCondition:[NSDictionary dictionaryWithObjectsAndKeys:[arr[i] objectForKey:@"prodBatchNo"],@"prodBatchNo", nil]];
}
-(void)sccharu:(int)i{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    NSDictionary  *scdic;
    if (tianjiapanduan==1) {
     
        NSString *huoweihao;
        if (NULL == [tianjiade objectForKey:@"oldpos"]) {
            huoweihao=@"";
        }else
        huoweihao=[tianjiade objectForKey:@"oldpos"];
      scdic =[NSDictionary dictionaryWithObjectsAndKeys:@"",@"status",[tianjiade objectForKey:@"barCode"],@"barCode",@"",@"checkId",[tianjiade objectForKey:@"manufacturer"],@"manufacturer",[tianjiade objectForKey:@"pycode"],@"pycode",[tianjiade objectForKey:@"prodBatchNo"],@"prodBatchNo",@"",@"approvalNumber",[tianjiade objectForKey:@"productCode"],@"productCode",[tianjiade objectForKey:@"productName"],@"productName",@"",@"specification",huoweihao,@"newpos",dateString,@"checktime",_onelabel.text,@"checkNum", nil];
       
    }else
   scdic =[NSDictionary dictionaryWithObjectsAndKeys:[arr[i] objectForKey:@"status"],@"status",[arr[i] objectForKey:@"barCode"],@"barCode",[arr[i] objectForKey:@"checkId"],@"checkId",[arr[i] objectForKey:@"manufacturer"],@"manufacturer",[arr[i] objectForKey:@"pycode"],@"pycode",[arr[i] objectForKey:@"prodBatchNo"],@"prodBatchNo",[arr[i] objectForKey:@"approvalNumber"],@"approvalNumber",[arr[i] objectForKey:@"productCode"],@"productCode",[arr[i] objectForKey:@"productName"],@"productName",[arr[i]objectForKey:@"specification"],@"specification",_ypgoods.text,@"newpos",dateString,@"checktime",shularr[i],@"checkNum", nil];
    
    [XL DataBase:db insertKeyValues:scdic intoTable:ShangChuanBiaoMing];
    
}
//没写完呢
-(void)czshangchuan{
    scarr =  [XL  DataBase:db selectKeyTypes:ShangChuanShiTiLei fromTable:ShangChuanBiaoMing whereCondition:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",_Search.text],@"barCode", nil]];
       // NSLog(@"%@",scarr);
}
-(void)czxiazai{
 arr =  [XL  DataBase:db selectKeyTypes:ShangChuanShiTiLei fromTable:ShangChuanBiaoMing whereCondition:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",_Search.text],@"barCode", nil]];
}


#pragma mark --- tableview

-(void)tabledelegate{
    _table.delegate=self;
    _table.dataSource=self;
    //_table.hidden=YES;
    //去除多余分割线
    //_table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _table.backgroundColor = [UIColor clearColor];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [arr count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
#pragma  mark ---- tableview 界面显示
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *str=@"cell";
    UITableViewCell *cell;//=[tableView cellForRowAtIndexPath:indexPath];
    cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    for (UIView *v in [cell.contentView subviews]) {
        [v removeFromSuperview];
    }
    
    UILabel*lll;
    UIView *viewaa;
    UILabel * text;
    UILabel *shulianglab;
    TextFlowView *techangview;
    
    lll = [[UILabel alloc]initWithFrame:CGRectMake(10, 7, 50, 30)];
    viewaa = [[UIView alloc]initWithFrame:CGRectMake(lll.frame.size.width+10, 7, 90, 30)];
    text = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-120, 11, 95, 25)];
    shulianglab =[[UILabel alloc]initWithFrame:CGRectMake(text.frame.origin.x-55, 7, 50, 30)];
    text.tag = 100+indexPath.section;
    UITapGestureRecognizer *TapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shulClick:)];
    [text addGestureRecognizer:TapGestureRecognizer];
    text.userInteractionEnabled = YES;
    lll.text=@"批号:";
    
    techangview = [[TextFlowView alloc] initWithFrame:viewaa.frame Text:[NSString stringWithFormat:@"%@",[arr[indexPath.section] objectForKey:@"prodBatchNo"]] textColor:[UIColor colorWithHexString:@"646464"] font:[UIFont boldSystemFontOfSize:16] backgroundColor:[UIColor clearColor] alignLeft:YES];/*批号不明确是哪个*/
    shulianglab.text=@"数量:";
    
    lll.textColor=[UIColor colorWithHexString:@"545454"];
    lll.font=[UIFont boldSystemFontOfSize:16];
    
    text.font=[UIFont boldSystemFontOfSize:16];
    text.textColor=[UIColor colorWithHexString:@"34C083"];
    
    text.textAlignment =NSTextAlignmentCenter;
    
    if(NULL ==[buyaoFuyong objectForKey:[NSString stringWithFormat:@"%ld",indexPath.section+100]]){
        if ([[arr[indexPath.section] objectForKey:@"checkNum"] intValue]==0) {
            text.text=@"";
        }else
            text.text=[arr[indexPath.section] objectForKey:@"checkNum"];
    }else
        text.text=[buyaoFuyong objectForKey:[NSString stringWithFormat:@"%ld",indexPath.section+100]];
    [text.layer setBorderWidth:1];
    [text.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [text.layer setCornerRadius:5.0];
    [cell.contentView addSubview:text];
    [cell.contentView addSubview:lll];
    [cell.contentView addSubview:shulianglab];
    [cell.contentView addSubview:techangview];
    
    if((long)oo.tag==(long)text.tag){
        text.layer.borderColor=[[UIColor colorWithHexString:@"34C083"] CGColor];
    }
    
    
    //点击不变色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}








#pragma  mark ---- tableview中的点击事件
-(void)shulClick:(UITapGestureRecognizer *)lableField {
    onepand=4;
    [self.view endEditing:YES];
    UITableViewCell *cell=(UITableViewCell*)[[(UILabel*)lableField.self.view superview] superview ];
    NSIndexPath *index=[self.table indexPathForCell:cell];
    oo=[cell viewWithTag:index.section+100];
    [self firstResponderInSubView];
    
}

#pragma mark-- 自定义键盘
- (void)setupCustomedKeyboard:(UITextField*)tf :(UILabel *)ss {
    
    tf.inputView = [DSKyeboard keyboardWithTextField:tf];
    [(DSKyeboard *)tf.inputView dsKeyboardTextChangedOutputBlock:^(NSString *fakePassword) {
        tf.text = fakePassword;
        ss.text = tf.text;
        
    } loginBlock:^(NSString *password) {
        [tf resignFirstResponder];
    }];
}
#pragma  mark ----左上、右上的按钮
-(void)navigation{
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*left=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self  action:@selector(fanhui)];
    [self.navigationItem setLeftBarButtonItem:left];
    
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*right=[[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self  action:@selector(tjpihao)];
    [self.navigationItem setRightBarButtonItem:right];
    
}
#pragma  mark ----返回到主页面
-(void)fanhui{
  
    UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"退出提示" message:@"确定要结束本次盘点吗?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction*action1=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        XLHomeViewController*pan=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"home"];
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[pan class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
    }];
    UIAlertAction*action2=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
    
    
    
}
#pragma  mark ----边框变色
- (void)firstResponderInSubView{
    if (onepand==1) {
        
        [_surebtn setBackgroundImage:[UIImage imageNamed:@"jianpan_chaxun.png"] forState:UIControlStateNormal];
        [_surebtn setBackgroundImage:[UIImage imageNamed:@"jianpan_chaxun_press.png"] forState:UIControlStateHighlighted];
        
        _Search.layer.borderColor = [[UIColor colorWithHexString:@"34C083"] CGColor];
        _ypgoods.layer.borderColor = [[UIColor blackColor] CGColor];
        _onelabel.layer.borderColor = [[UIColor blackColor] CGColor];
        [self tableviewhide];
    }else if(onepand==2){
        [_surebtn setBackgroundImage:[UIImage imageNamed:@"jianpan_mr_27.png"] forState:UIControlStateNormal];
        [_surebtn setBackgroundImage:[UIImage imageNamed:@"jianpan_dk_04_10.png"] forState:UIControlStateHighlighted];
        _ypgoods.layer.borderColor = [[UIColor colorWithHexString:@"34C083"] CGColor];
        _Search.layer.borderColor = [[UIColor blackColor] CGColor];
        _onelabel.layer.borderColor = [[UIColor blackColor] CGColor];
        [self tableviewhide];
    }else if(onepand==3){
        [_surebtn setBackgroundImage:[UIImage imageNamed:@"jianpan_mr_27.png"] forState:UIControlStateNormal];
        [_surebtn setBackgroundImage:[UIImage imageNamed:@"jianpan_dk_04_10.png"] forState:UIControlStateHighlighted];
        _ypgoods.layer.borderColor = [[UIColor blackColor] CGColor];
        _Search.layer.borderColor = [[UIColor blackColor] CGColor];
        _onelabel.layer.borderColor = [[UIColor colorWithHexString:@"34C083"] CGColor];
        [self tableviewhide];
    }else{
        [_surebtn setBackgroundImage:[UIImage imageNamed:@"jianpan_mr_27.png"] forState:UIControlStateNormal];
        [_surebtn setBackgroundImage:[UIImage imageNamed:@"jianpan_dk_04_10.png"] forState:UIControlStateHighlighted];
        _Search.layer.borderColor = [[UIColor blackColor] CGColor];
        _ypgoods.layer.borderColor = [[UIColor blackColor] CGColor];
        _onelabel.layer.borderColor = [[UIColor blackColor] CGColor];
        for (UIView * vv in _table.visibleCells) {
            
            for (UIView* vv1 in vv.subviews) {
                
                for (UILabel*view in vv1.subviews) {
        
                    
                    if (view.tag==oo.tag) {
                        
                        view.layer.borderColor=[[UIColor colorWithHexString:@"34C083"] CGColor];
                    }
                    else{
                        view.layer.borderColor=[[UIColor blackColor] CGColor];
                    }
                }
            }
        }
    }
}
/*不要动*/
-(void)tableviewhide{
    for (UIView * vv in _table.visibleCells) {
        for (UIView* vv1 in vv.subviews) {
            for (UILabel*view in vv1.subviews) {
                view.layer.borderColor=[[UIColor blackColor] CGColor];
            }
        }
    }
}


#pragma  mark ----添加批号判断
-(void)tjpihao{
    if([_Search.text  isEqualToString:@"🔍扫描或输入药品条形码"]){
        [WarningBox warningBoxModeText:@"查询药品后才可进行新增批号" andView:self.view];
    }
    else{
        if (tianpihao==0) {
            [WarningBox warningBoxModeText:@"请先查询药品!" andView:self.view];
        }else{
            ming1.text =@"";
            NSString* aaa=[NSString stringWithFormat:@"%@",[arr[0]objectForKey:@"productName"]];
            TextFlowView *nameview =  [[TextFlowView alloc] initWithFrame:ming1.frame Text:aaa textColor:[UIColor colorWithHexString:@"646464"] font:[UIFont boldSystemFontOfSize:18] backgroundColor:[UIColor clearColor] alignLeft:YES];
            
            for (UIView *vv  in jiemian.subviews) {
                if(vv.tag==120){
                [vv removeFromSuperview];
                }
            }
            nameview.tag = 120;
            [jiemian addSubview:nameview];
            wei1.text =[NSString stringWithFormat:@"%@",[arr[0]objectForKey:@"oldpos"]];//货位
            bian1.text =[NSString stringWithFormat:@"%@",[arr[0]objectForKey:@"productCode"]];//药品编号
            ge1.text =[NSString stringWithFormat:@"%@",[arr[0]objectForKey:@"specification"]];//药品规格
            [self.view bringSubviewToFront:dabeijing];
            [self.view bringSubviewToFront:jiemian];
            
            if (arr.count==1&&[_onelabel.text isEqual:@""]){
            [WarningBox warningBoxModeText:@"请输入当前药品的数量" andView:self.view];
            }else{
            dabeijing.hidden = NO;
            jiemian.hidden = NO;
            }
        }
    }
    
    
    
}

#pragma  mark ----添加批号界面
-(void)tianjiapihao{
    float width = [[UIScreen mainScreen] bounds].size.width;
    float height= [[UIScreen mainScreen] bounds].size.height;
    //新加添加view
    dabeijing=[[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    dabeijing.backgroundColor=[UIColor blackColor];
    dabeijing.alpha=0.7;
    [self.view addSubview:dabeijing];
    dabeijing.hidden=YES;
    //信息展示
    jiemian=[[UIView alloc] initWithFrame:CGRectMake(5, 150, width-10, 350)];
    [jiemian.layer setCornerRadius:5];
    jiemian.backgroundColor=[UIColor whiteColor];
    jiemian.alpha=1;
    [self.view addSubview:jiemian];
    jiemian.hidden=YES;
    UILabel*xinxi=[[UILabel alloc] initWithFrame:CGRectMake(5, 2,200, 40)];
    xinxi.font=[UIFont systemFontOfSize:20 weight:1.5];
    UIView * xianhe=[[UIView alloc] initWithFrame:CGRectMake(0, 40, jiemian.bounds.size.width, 1)];
    xianhe.backgroundColor=[UIColor  blackColor];
    UILabel *ming=[[UILabel alloc] initWithFrame:CGRectMake(10, 43, 100, 40)];
    UILabel *pi=[[UILabel alloc] initWithFrame:CGRectMake(10, 84, 100, 40)];
    UILabel *shu=[[UILabel alloc] initWithFrame:CGRectMake(10, 125, 100, 40)];
    UILabel *wei=[[UILabel alloc] initWithFrame:CGRectMake(10, 166, 100, 40)];
    UILabel *bian=[[UILabel alloc] initWithFrame:CGRectMake(10, 207, 100, 40)];
    UILabel *ge=[[UILabel alloc] initWithFrame:CGRectMake(10, 248, 100, 40)];
    xinxi.text=@"新增药品信息";
    ming.text =@"药品名称:";
    pi.text   =@"药品批号:";
    shu.text  =@"药品数量:";
    wei.text  =@"货        位:";
    bian.text =@"药品编号:";
    ge.text   =@"药品规格:";
    UIView *baoqu=[[UIView alloc] initWithFrame:CGRectMake(20, 300, jiemian.bounds.size.width-40, 40)];
    UIButton *baocun=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, width/3, 30)];
    UIButton *quxiao=[[UIButton alloc] initWithFrame:CGRectMake(baoqu.bounds.size.width-width/3, 0, width/3, 30)];
    baocun.tintColor=[UIColor blackColor];
    baocun.backgroundColor=[UIColor colorWithHexString:@"34c083"];
    quxiao.backgroundColor=[UIColor colorWithHexString:@"34c083"];
    [baocun addTarget:self action:@selector(baobao) forControlEvents:UIControlEventTouchUpInside];
    [quxiao addTarget:self action:@selector(ququ) forControlEvents:UIControlEventTouchUpInside];
    [baocun setTitle:@"保存" forState:UIControlStateNormal];
    [quxiao setTitle:@"取消" forState:UIControlStateNormal];
    [baocun.layer setCornerRadius:5];
    [quxiao.layer setCornerRadius:5];
    [jiemian addSubview:xinxi];
    [jiemian addSubview:xianhe];
    [jiemian addSubview:ming];
    [jiemian addSubview:pi];
    [jiemian addSubview:shu];
    [jiemian addSubview:wei];
    [jiemian addSubview:bian];
    [jiemian addSubview:ge];
    [baoqu addSubview:baocun];
    [baoqu addSubview:quxiao];
    [jiemian addSubview:baoqu];
    ming1=[[UILabel alloc] initWithFrame:CGRectMake(110, 43, jiemian.bounds.size.width-110-20, 40)];
    pi1=[[UITextField alloc] initWithFrame:CGRectMake(110, 94, jiemian.bounds.size.width-110-20, 30)];
    pi1.delegate=self;
    pi1.layer.borderColor=[[UIColor grayColor] CGColor];
    [pi1.layer setBorderWidth:1];
    [pi1.layer setCornerRadius:5];
    shu1=[[UITextField alloc] initWithFrame:CGRectMake(110, 135, jiemian.bounds.size.width-110-20, 30)];
    shu1.delegate=self;
    shu1.layer.borderColor=[[UIColor grayColor] CGColor];
    [shu1.layer setBorderWidth:1];
    [shu1.layer setCornerRadius:5];
    wei1=[[UILabel alloc] initWithFrame:CGRectMake(110, 166, 100, 40)];
    bian1=[[UILabel alloc] initWithFrame:CGRectMake(110, 207, 100, 40)];
    ge1=[[UILabel alloc] initWithFrame:CGRectMake(110, 248, 200, 40)];
    shu1.keyboardType=UIKeyboardTypeNumberPad;
    [jiemian addSubview:ming1];
    [jiemian addSubview:pi1];
    [jiemian addSubview:shu1];
    [jiemian addSubview:bian1];
    [jiemian addSubview:ge1];
    [jiemian addSubview:wei1];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self setupCustomedKeyboard:textField :nil];

    return YES;
}

#pragma  mark ----批号的保存与取消
-(void)baobao{
    /*新增批号逻辑没写*/
    [self xztianjia:0];
    if(arr.count==1){
        shularr=[[NSMutableArray alloc] init];
        [shularr addObject:[NSString stringWithFormat:@"%@",_onelabel.text]];
        [self xzxiugai:0];
    }else{
        shularr = [[NSMutableArray alloc]init];
       for (int i=0; i<[arr count]; i++) {
        if(NULL ==[buyaoFuyong objectForKey:[NSString stringWithFormat:@"%d",i+100]]){
            [shularr addObject:@"0"];
        }
        else{
            [ shularr addObject:[buyaoFuyong objectForKey:[NSString stringWithFormat:@"%d",i+100]]];
        }
      }
      for (int i=0; i<arr.count; i++) {
        [self xzxiugai:i];
        
        }
    
    }
    [self chazhao];
    pi1.text = @"";
    shu1.text = @"";
    [self.view endEditing:YES];
    dabeijing.hidden=YES;
    jiemian.hidden=YES;
}
-(void)ququ{
    [self qingkong];
    [self.view endEditing:YES];
    dabeijing.hidden=YES;
    jiemian.hidden=YES;
}


#pragma  mark ---搜索提示
-(void)tishi{
    UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"提示:" message:@"没有查询到能匹配此条码的药品" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction*action1=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _Search.text=@"🔍扫描或输入药品条形码";
        
    }];
    UIAlertAction*action2=[UIAlertAction actionWithTitle:@"新增药品" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        XL_SearchViewController *search=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"search"];
        [search passdicValue:^(NSDictionary *dic) {
            tianjiapanduan=1;
            tianjiade=[NSDictionary dictionaryWithDictionary:dic];
        }];
        search.str=[NSString stringWithFormat:@"%@",_Search.text];
        [self.navigationController pushViewController:search animated:YES];
        
    }];
    UIAlertAction*action3=[UIAlertAction actionWithTitle:@"助记码查询" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self zhujima:self];
        
    }];
    [alert addAction:action2];
    [alert addAction:action3];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}



@end
