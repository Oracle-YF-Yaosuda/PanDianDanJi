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
    NSArray *arr;//查找到的数组
    NSDictionary*tianjiade;
    
    //UILabel * text;
    
}

@end

@implementation XL_PanDianViewController

-(void)viewWillAppear:(BOOL)animated{
    if (chuanzhipanduan==1) {
        [self chazhao];
        chuanzhipanduan=0;
        
        
    }
    else if(tianjiapanduan==1){
        tianjiapanduan=0;
        /*
         这里把传回来的数据显示
         因为只有一条，所有直接用view方法显示
         */
        NSLog(@"%@",tianjiade);
        
    }else{
        
    }
    
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    chuanzhipanduan=0;
    tianjiapanduan=0;
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
    [_Search.layer setBorderWidth:1.0];
    [_Search.layer setCornerRadius:5.0];
    
    
    [self.view bringSubviewToFront:_oneview];
    
    [self shujuku];
    [self tabledelegate];
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
-(void)tishi{
    UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"提示:" message:@"没有查询到能匹配此条码的药品" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction*action1=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
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
        oo.text= [oo.text stringByAppendingString:@"0"];
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
        oo.text= [oo.text stringByAppendingString:@"1"];
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
        oo.text= [oo.text stringByAppendingString:@"2"];
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
        oo.text= [oo.text stringByAppendingString:@"3"];
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
        oo.text= [oo.text stringByAppendingString:@"4"];
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
        oo.text= [oo.text stringByAppendingString:@"5"];
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
        oo.text= [oo.text stringByAppendingString:@"6"];
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
        oo.text= [oo.text stringByAppendingString:@"7"];
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
        oo.text= [oo.text stringByAppendingString:@"8"];
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
        oo.text= [oo.text stringByAppendingString:@"9"];
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
        }
       
    }
    
    
}

- (IBAction)clear:(id)sender {
    if (onepand==1){
        
    }else if (searcpd==1){
        
    }
    
    if(onepand==3){
        _onelabel.text= @"";
    }
    else if (onepand==1){
        _Search.text = @"🔍扫描或输入药品条形码";
    }else{
        oo.text= @"";
    }
    
    
}
//助记码
- (IBAction)zhujima:(id)sender {
    
    XL_ZhuJiMaViewController *zhuji=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"zhujima"];
    [zhuji passValue:^(NSString *str) {
        _Search.text=str;
        chuanzhipanduan=1;
    }];
    
    [self.navigationController pushViewController:zhuji animated:YES];
    
}
//确定按钮
- (IBAction)check:(id)sender {
    // _oneview.hidden = YES;
    //[self.view bringSubviewToFront:_table];
    if ([_Search.text isEqualToString:@"🔍扫描或输入药品条形码"]){
        [WarningBox warningBoxModeText:@"请输入条码后进行查询" andView:self.view];
    }else{
        [self chazhao];
        
    }
    
}
//搜索
-(void)chazhao{
    arr=[XL  DataBase:db selectKeyTypes:XiaZaiShiTiLei fromTable:XiaZaiBiaoMing whereCondition:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",_Search.text],@"barCode", nil]];
    
    
    UILabel *name = [[UILabel alloc]init];
    UILabel *chang = [[UILabel alloc]init];
    
    if(arr.count==0){
        // NSArray  *aarr = [XL DataBase:db selectKeyTypes:XiaZaiShiTiLei fromTable:XiaZaiBiaoMing whereKey:@"barCode" containStr:@","];
        
        
        [self tishi];
        name.text  =@"";
        chang.text = @"";
        _ypwenhao.text = @"";
        _ypetalon.text = @"";
        _ypgoods.text = @"";
        _ypnumber.text = @"";
        for (UIView *v in [_InfoView subviews]) {
            if (v.tag==101) {
                [v removeFromSuperview];
            }}
        
    }
    else if(arr.count==1){
        _oneview.hidden=NO;
        TextFlowView* techangview = [[TextFlowView alloc] initWithFrame:_gundview.frame Text:[NSString stringWithFormat:@"%@",[arr[0] objectForKey:@"productCode"]] textColor:[UIColor colorWithHexString:@"646464"] font:[UIFont boldSystemFontOfSize:16] backgroundColor:[UIColor clearColor] alignLeft:YES];
        [_oneview addSubview:techangview];
        
        
    }else{
        
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
        _ypnumber.text =[NSString stringWithFormat:@"%@",[arr[0]objectForKey:@"purchaseBatchNo"]];//药品编号
        _ypgoods.text =[NSString stringWithFormat:@"%@",[arr[0]objectForKey:@"oldpos"]];//货位
        _ypwenhao.text = [NSString stringWithFormat:@"%@",[arr[0]objectForKey:@"pycode"]];//批准文号
        _ypetalon.text =[NSString stringWithFormat:@"%@",[arr[0]objectForKey:@"specification"]];//药品规格
        [_table reloadData];
        _table.hidden=NO;
        _oneview.hidden = YES;
    }
    
    
    
    
    
}

#pragma mark --- tableview

-(void)tabledelegate{
    _table.delegate=self;
    _table.dataSource=self;
    //_table.hidden=YES;
    //去除多余分割线
    self.table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _table.backgroundColor = [UIColor clearColor];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [arr count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    if ([arr count]==1){
    //    return 2;
    //    }else{
    //        return 1;
    //    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *str=@"cell";
    UITableViewCell *cell;//=[tableView cellForRowAtIndexPath:indexPath];
    cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell==nil) {
        
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        
    }
    for (UIView *v in [cell subviews]) {
        [v removeFromSuperview];
    }
    
    
    UILabel*lll;
    UIView *viewaa;
    UILabel * text;
    UILabel *shulianglab;
    TextFlowView *techangview;
    
    
    
    lll = [[UILabel alloc]initWithFrame:CGRectMake(10, 7, 50, 30)];
    viewaa = [[UIView alloc]initWithFrame:CGRectMake(lll.frame.size.width+10, 7, 90, 30)];
    shulianglab =[[UILabel alloc]initWithFrame:CGRectMake(viewaa.frame.origin.x+viewaa.frame.size.width+10, 7, 50, 30)];
    text = [[UILabel alloc]initWithFrame:CGRectMake(shulianglab.frame.origin.x+shulianglab.frame.size.width+10, 7, 80, 30)];
    text.text=@"";
    text.tag = 100+indexPath.section;
    UITapGestureRecognizer *TapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shulClick:)];
    [text addGestureRecognizer:TapGestureRecognizer];
    text.userInteractionEnabled = YES;
    
    
    lll.text=@"批号:";
    techangview = [[TextFlowView alloc] initWithFrame:viewaa.frame Text:[NSString stringWithFormat:@"%@",[arr[indexPath.section] objectForKey:@"productCode"]] textColor:[UIColor colorWithHexString:@"646464"] font:[UIFont boldSystemFontOfSize:16] backgroundColor:[UIColor clearColor] alignLeft:YES];
    
    shulianglab.text=@"数量:";
    lll.textColor=[UIColor colorWithHexString:@"545454"];
    lll.font=[UIFont boldSystemFontOfSize:16];
    text.textColor=[UIColor colorWithHexString:@"646464"];
    text.font=[UIFont boldSystemFontOfSize:16];
    
    
    [text.layer setBorderWidth:1];
    [text.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [text.layer setCornerRadius:3.0];
    
    [cell addSubview:text];
    [cell addSubview:lll];
    [cell addSubview:shulianglab];
    [cell addSubview:techangview];
    
    //点击不变色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
    NSIndexPath *index=[self.table indexPathForCell:cell];
    
    
}

-(void)shulClick:(UITapGestureRecognizer *)lableField {
    onepand=4;
    UITableViewCell *cell=(UITableViewCell*)[(UILabel*)lableField.self.view superview];
    
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
-(void)navigation{
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*left=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self  action:@selector(fanhui)];
    [self.navigationItem setLeftBarButtonItem:left];
}
-(void)fanhui{
    XLHomeViewController*pan=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"home"];
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[pan class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}

- (void)firstResponderInSubView{
    if (onepand==1) {
        _Search.layer.borderColor = [[UIColor greenColor] CGColor];
        _ypgoods.layer.borderColor = [[UIColor blackColor] CGColor];
        _onelabel.layer.borderColor = [[UIColor blackColor] CGColor];
        [self tableviewhide];
    }else if(onepand==2){
        _ypgoods.layer.borderColor = [[UIColor greenColor] CGColor];
        _Search.layer.borderColor = [[UIColor blackColor] CGColor];
        _onelabel.layer.borderColor = [[UIColor blackColor] CGColor];
        [self tableviewhide];
    }else if(onepand==3){
        _ypgoods.layer.borderColor = [[UIColor blackColor] CGColor];
        _Search.layer.borderColor = [[UIColor blackColor] CGColor];
        _onelabel.layer.borderColor = [[UIColor greenColor] CGColor];
        [self tableviewhide];
    }else{
        _Search.layer.borderColor = [[UIColor blackColor] CGColor];
        _ypgoods.layer.borderColor = [[UIColor blackColor] CGColor];
        _onelabel.layer.borderColor = [[UIColor blackColor] CGColor];
        for (UIView * vv in _table.visibleCells) {
            for (UILabel* view in vv.subviews) {
                if (view.tag==oo.tag) {
                    view.layer.borderColor=[[UIColor greenColor] CGColor];
                }
                else{
                    view.layer.borderColor=[[UIColor blackColor] CGColor];
                }
            }
        }
    }
}
-(void)tableviewhide{
    for (UIView * vv in _table.visibleCells) {
        for (UILabel* view in vv.subviews) {
        view.layer.borderColor=[[UIColor blackColor] CGColor];
        }
    }
}
@end
