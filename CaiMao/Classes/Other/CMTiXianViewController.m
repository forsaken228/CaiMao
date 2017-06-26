//
//  CMTiXianViewController.m
//  CaiMao
//
//  Created by MAC on 16/6/23.
//  Copyright © 2016年 58cm. All rights reserved.
//
#import "CMTiXianViewController.h"
#import "CMTIXianFootView.h"
#import "CMRecordViewController.h"

@interface CMTiXianViewController ()<UITableViewDelegate,UITableViewDataSource,tBankListDelegate,AddressListDelegate>
{

   
    UITextField *_tText;
    CMTiXianBank  *_tixian;
    UIImageView *_SureIcon;
    UILabel *_bankname;
    UIImageView *_icon;
    
    CMAddressList *_list;
    UIButton *_keTeMoney;

    
}


@property(nonatomic,copy)NSString *imageViewIcon;
@property(nonatomic,copy)NSString *bankNumAndName;
@property(nonatomic,strong)UITableView *testTable;
@property(nonatomic,strong)UIButton *currentBtn;



@property(nonatomic,strong)NSMutableArray *ProvinceIdArr;
@property(nonatomic,strong)NSMutableArray *ProvinceArr;
@property(nonatomic,strong)NSMutableArray *CityArr;
//@property(nonatomic,strong)NSMutableArray *BigArr;


@property(nonatomic,copy)NSString *SelectProvince;
@property(nonatomic,copy)NSString *SelectCity;

@property(nonatomic,strong)NSArray *NewArr;

@end

@implementation CMTiXianViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"提现";
    [self getProvince];
    //[self recordOfTiXian];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提现记录" style:UIBarButtonItemStylePlain target:self action:@selector(enterIntoRecordOfTiXian)];
   [self creatUiView];
    
   self.vipMsg=[CMUserDefaults  objectForKey:@"VipLevl"];
    
}

#pragma mark 提现记录

-(void)enterIntoRecordOfTiXian{
    CMRecordViewController *vc=[[CMRecordViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}


-(void)viewDidLayoutSubviews
{
    if ([self.testTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.testTable setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.testTable respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.testTable setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}
-(void)creatUiView{
    
      
 
    self.testTable.tableHeaderView=[self creatHeadView];
    CMTIXianFootView *footView=[CMTIXianFootView new];
    self.testTable.tableFooterView=[footView creatTiXianFootView];
    [footView.NextBtn addTarget:self action:@selector(NextBtnClick) forControlEvents:UIControlEventTouchUpInside];
 
    [self.view addSubview:self.testTable];
   
}

#pragma mark Lazy
-(UITableView*)testTable{
    if (!_testTable) {
        _testTable=[[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _testTable.delegate=self;
        _testTable.dataSource=self;
        _testTable.showsVerticalScrollIndicator=NO;
        _testTable.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin;
        _testTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    
        _testTable.rowHeight=50;
    }
    return _testTable;
}




#pragma mark tablView协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   static NSString *tCell=@"cell1";
//    CMTiXianViewCell *Choicecell=[tableView dequeueReusableCellWithIdentifier:tCell];
    CMTiXianViewCell *Choicecell=[tableView cellForRowAtIndexPath:indexPath];
    if (!Choicecell) {
        Choicecell=[[CMTiXianViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tCell];
        Choicecell.selectionStyle=UITableViewCellSelectionStyleNone;
        [Choicecell.choiceAddress addTarget:self action:@selector(choiceAddressBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [Choicecell.choiceAddress setTitle:@"请选择>" forState:UIControlStateNormal];
        self.currentBtn=Choicecell.choiceAddress;
        Choicecell.choiceAddress.tag=indexPath.row+1;
        Choicecell.choiceAddress.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
        [Choicecell.choiceAddress setTitleColor:CMColor(128, 128, 128) forState:UIControlStateNormal];
    }
    if (indexPath.row==0){
        Choicecell.BankName.text=@"开户行所在省";
    }else if(indexPath.row==1){
        Choicecell.BankName.text=@"开户行所在市";
        
    }else if (indexPath.row==2){
        Choicecell.BankName.text=@"开户支行";
        [Choicecell.choiceAddress removeFromSuperview];
        _tText=[[UITextField alloc]init];
        // tWithFrame:CGRectMake(Choicecell.bounds.size.width-150, 10, 160, 30)
        _tText.placeholder=@"请输入您的支行名称";
        _tText.font=[UIFont boldSystemFontOfSize:14];
        //_tText.borderStyle=UITextBorderStyleRoundedRect;
        
        [Choicecell addSubview:_tText];
        [_tText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.right.equalTo(Choicecell);
            make.width.mas_equalTo(160);
            make.top.mas_equalTo(Choicecell.mas_top).offset(10);
            
            
        }];
        
    }
    return Choicecell;
    
    
}
#pragma mark 选择开户行省份和市
-(void)choiceAddressBtnClick:(UIButton*)btn{
//省
    if(btn.tag==1){
        
        self.currentBtn=btn;

            NSMutableArray *provinceArr=[[NSMutableArray alloc]initWithCapacity:0];
            NSMutableArray *provinceIdArr=[[NSMutableArray alloc]initWithCapacity:0];
        
            for (NSDictionary *dict in self.NewArr) {
                NSString *province=[dict objectForKey:@"province"];
                NSString *provinceId=[dict objectForKey:@"provinceId"];

                [provinceArr addObject:province];
                [provinceIdArr addObject:provinceId];
            }
            self.ProvinceIdArr=provinceIdArr;
            self.ProvinceArr=provinceArr;
            _list=[[CMAddressList alloc]initWithAddressList:provinceArr];
            _list.tag=10;
            _list.delegate=self;
            [_list ShowAlert];
       
       
        
    }else if (btn.tag==2){
        
       self.currentBtn=btn;
        _list=[[CMAddressList alloc]initWithAddressList:self.CityArr];
        _list.delegate=self;
        _list.tag=11;
        [_list ShowAlert];
        
    }
    
    
    
}
-(void)tapDismissView{
    [_list dimissAlert];
}
-(void)alertViewShowAddressWithRow:(NSInteger)aRow{
    
    if (self.currentBtn.tag==1&&_list.tag==10) {
   
    if (aRow==0) {
        
     [self.currentBtn setTitle:@"请选择>" forState:UIControlStateNormal];
       // self.SelectProvince=self.currentBtn.currentTitle;
       UIButton *btn=(UIButton *)[self.view viewWithTag:2];
        [btn setTitle:@"请选择>" forState:UIControlStateNormal];
       
       // self.SelectCity=btn.currentTitle;

        [self.CityArr removeAllObjects];
   
    
    }else{
        
        [self.currentBtn  setTitle:self.ProvinceArr[aRow-1] forState:UIControlStateNormal];
        
        self.SelectProvince=self.currentBtn.currentTitle;
        
        NSString * url=[NSString stringWithFormat:@"%@/handler/app_interface.ashx?action=RegCity&ObjectVal=%@",OnLineCode,self.ProvinceIdArr[aRow-1]];
        __block typeof(self)weakSelf=self;

        [CMHttpTool getWithURL:url params:nil success:^(id responseObj) {
          //NSLog(@"responseObj==%@",responseObj);
            
            NSMutableArray *provinceArr=[[NSMutableArray alloc]initWithCapacity:0];
            NSMutableArray *provinceIdArr=[[NSMutableArray alloc]initWithCapacity:0];
            NSArray *result=[responseObj objectForKey:@"result"];
            for (NSDictionary *dict in result) {
                NSString *province=[dict objectForKey:@"city"];
                NSString *provinceId=[dict objectForKey:@"Cityid"];
                [provinceArr addObject:province];
                [provinceIdArr addObject:provinceId];
            }
              weakSelf.CityArr=provinceArr;
           
            
        } failure:^(NSError *error) {
            
            
        }];

    }
        
          [_list dimissAlert];
    }
   else if (self.currentBtn.tag==2&&_list.tag==11) {
        
        if (aRow==0) {
            
            [self.currentBtn setTitle:@"请选择>" forState:UIControlStateNormal];
            // self.SelectCity=self.currentBtn.currentTitle;
        }else{
            [self.currentBtn  setTitle:self.CityArr[aRow-1] forState:UIControlStateNormal];
            self.SelectCity=self.currentBtn.currentTitle;
    }

 [_list dimissAlert];

}
}



#pragma mark 创建表头

-(UIView*)creatHeadView
{
    
    NSDictionary *dic=[self.userArray firstObject];
    NSDictionary *sureArry=[ dic objectForKey:@"BankData"];
    NSArray *addArry=[ dic objectForKey:@"AddBankData"];
    if (self.isFromTiXian) {
        NSDictionary *addDict=addArry[self.bankIndex];
        NSString *numOne=[addDict objectForKey:@"BankNumber"];
        self.Bank_code=[addDict objectForKey:@"zid"];
        NSString *testBankOne=[numOne substringFromIndex:numOne.length-4];
        NSString *name=[addDict objectForKey:@"Bankname"];
        self.imageViewIcon=[addDict objectForKey:@"BankLogo"];
        self.bankNumAndName=[NSString stringWithFormat:@"%@(%@)",name,testBankOne];
       
        
    }else{
    NSString *numOne=[sureArry objectForKey:@"BankNumber"];
    self.Bank_code=[sureArry objectForKey:@"zid"];
    NSString *testBankOne;
      NSString *name=[sureArry objectForKey:@"Bankname"];
     testBankOne=[numOne substringFromIndex:numOne.length-4];
    self.imageViewIcon=[sureArry objectForKey:@"BankLogo"];
    self.bankNumAndName=[NSString stringWithFormat:@"%@(%@)",name,testBankOne];
  _SureIcon.image=[UIImage imageNamed:@"tixian_renzheng_icon"];
    }
    //背景View Frame:CGRectMake(0, 0, self.view.bounds.size.width, 80)]
   UIView *tView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];

    
    
    //银行图标
    //_icon=[[UIImageView alloc]initWithFrame:CGRectMake(8,14,110,40)];
    _icon=[[UIImageView alloc]init];
    [_icon sd_setImageWithURL:[NSURL URLWithString:self.imageViewIcon]];
    [tView addSubview:_icon];
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(tView.mas_left).offset(5);
        make.width.mas_equalTo(50);
        //make.height.mas_equalTo(40);
        make.top.equalTo(tView.mas_top).offset(10);
        make.bottom.equalTo(tView.mas_bottom).offset(-10);
        
    }];
    
    
    //银行名称
    //CGRectMake(125, 10, 160, 30)]
    _bankname=[[UILabel alloc]initWithFrame:CGRectMake(125, 10, 160, 30)];
    
    _bankname.font=[UIFont boldSystemFontOfSize:14];
    _bankname.textColor=CMColor(77, 77, 77);
    _bankname.text=self.bankNumAndName;
    [tView addSubview:_bankname];
    [_bankname mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_icon.mas_right).offset(5);
        make.top.equalTo(_icon.mas_top).offset(-5);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(120);
        
    }];
    
    //认证图标 、、CGRectMake(215, 17, 30, 15)
    _SureIcon=[[UIImageView alloc]init];
  
    [tView addSubview:_SureIcon];
    
    [_SureIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_bankname.mas_right);
        make.top.equalTo(_bankname.mas_top).offset(7);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(30);
    }];


    NSString *title=[NSString stringWithFormat:@"该卡可提金额%@元",[CMUserDefaults objectForKey:@"YuEr"]];
    UIImage *image=[UIImage imageNamed:@"detail_pressed"];
    //详情
    _keTeMoney=[UIButton buttonWithType:UIButtonTypeCustom];
    [_keTeMoney setImage:image forState:UIControlStateNormal];
    [_keTeMoney setTitle:title forState:UIControlStateNormal];
    [_keTeMoney addTarget:self action:@selector(detailBankBtnClick) forControlEvents:UIControlEventTouchUpInside];
    CGRect rect=[title boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil];
    _keTeMoney.titleLabel.font=[UIFont systemFontOfSize:13];
    [_keTeMoney setTitleColor:CMColor(153, 153, 153) forState:UIControlStateNormal];
    _keTeMoney.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [tView addSubview:_keTeMoney];
    [_keTeMoney setTitleEdgeInsets:UIEdgeInsetsMake(0,-_keTeMoney.imageView.frame.size.width-10, 0,_keTeMoney.imageView.frame.size.width)];
    [_keTeMoney setImageEdgeInsets:UIEdgeInsetsMake(0, rect.size.width+5 , 0, -rect.size.width)];
    
    [_keTeMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bankname.mas_bottom);
        make.left.equalTo(_bankname);
        make.width.mas_equalTo(rect.size.width+30);
        make.height.mas_equalTo(20);
        
    }];
    UIImageView *bankChange=[[UIImageView alloc]init];
    bankChange.image=[UIImage imageNamed:@"tixian_jiantou_icon"];
    [tView addSubview:bankChange];
    [bankChange mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(tView.mas_centerY);
        make.right.equalTo(tView.mas_right).offset(-10);
        make.height.mas_equalTo(10);
        make.width.mas_equalTo(15);
        
    }];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bankChangeBtnClick)];
    [tView addGestureRecognizer:tap];

    return tView;
    
}
#pragma mark 可提详情按钮
-(void)detailBankBtnClick{
    CMTiXianJInEr *alert=[[CMTiXianJInEr alloc]initWithCancleButtonTitle:@"知道了" WithDetailUp:@"什么是该卡可提金额？" WithDetaildown:@"   因手机支付要求同卡进出，故要求用户使用网站绑定的银行卡提现时，首选快捷支付卡，可提走全部金额。普通卡只能提走部分金额。"];
    [alert ShowAlert];
}


#pragma mark 换支付卡
-(void)bankChangeBtnClick{
  
    NSMutableArray *bigArr=[[NSMutableArray alloc]initWithCapacity:0];
    //已认证银行卡
    NSDictionary *dic=[self.userArray firstObject];
    NSDictionary *sureArry=[ dic objectForKey:@"BankData"];
    // NSDictionary *SureDetail=[sureArry firstObject];
    
    NSString *numOne=[sureArry objectForKey:@"BankNumber"];
    
    NSString *testBankOne=[numOne substringFromIndex:numOne.length-4];
    NSString *Surebank=[NSString stringWithFormat:@"%@(尾号:%@)(已认证)",[sureArry objectForKey:@"Bankname"],testBankOne];
    [bigArr addObject:Surebank];
    
    //添加的银行卡
    NSArray *addArry=[ dic objectForKey:@"AddBankData"];
   
    for ( NSDictionary *addDetail in addArry) {
        
        NSString *num=[addDetail objectForKey:@"BankNumber"];
        NSString *testBank=[num substringFromIndex:num.length-4];;
        NSString *bank=[NSString stringWithFormat:@"%@(尾号:%@)",[addDetail objectForKey:@"Bankname"],testBank];
        [bigArr addObject:bank];
        
    }
    
    _tixian=[[CMTiXianBank alloc]initWithBankList:bigArr];
    _tixian.delegate=self;
    [_tixian ShowAlert];
    
}
-(void)tapDimissView
{
    [_tixian dimissAlert];
}
-(void)alertViewShowWithRow:(NSInteger)aRow{
    self.imageViewIcon=nil;
    self.bankNumAndName=nil;
  //  NSMutableArray *bigArr=[[NSMutableArray alloc]initWithCapacity:0];
    NSDictionary *dic=[self.userArray firstObject];
    NSDictionary *dict=[dic objectForKey:@"BankData"];
 
    NSArray  *addArr=[dic objectForKey:@"AddBankData"];
    NSString *CZ=[dict objectForKey:@"cz_amount"];
    NSString *TX=[dict objectForKey:@"tx_amount"];
    
    if (aRow==0) {
        //认证
        if ([[dict objectForKey:@"BankCount"]intValue]>0) {
            CMTiXianDetailViewController *vc=[[CMTiXianDetailViewController alloc]init];
            vc.userDeatailArray=self.userArray;
            vc.vipMsg=self.vipMsg;
            [self.navigationController pushViewController:vc animated:NO];
            NSMutableArray  *arr=[[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
            for (UIViewController *vc in arr) {
                if ([vc isKindOfClass:[self class]]) {
                    
                    [arr removeObject:vc];
                    break;
                }
                
            }
            self.navigationController.viewControllers=arr;
            
        }else{
        _SureIcon.hidden=NO;
        NSString *num=[dict objectForKey:@"BankNumber"];
        self.Bank_code=[dict objectForKey:@"zid"];
         NSString *name=[dict objectForKey:@"Bankname"];
        NSString *testBank1;

    testBank1=[num substringFromIndex:num.length-4];
        [_icon sd_setImageWithURL:[NSURL URLWithString:[dict objectForKey:@"BankLogo"]]];

        _bankname.text=[NSString stringWithFormat:@"%@(%@)", name,testBank1];
       // _keTeMoney.text=[NSString stringWithFormat:@"该卡可提金额%@元",self.MoneyOut];
            [_keTeMoney setTitle:[NSString stringWithFormat:@"该卡可提金额%@元",[CMUserDefaults objectForKey:@"YuEr"]] forState:UIControlStateNormal];
       _SureIcon.image=[UIImage imageNamed:@"tixian_renzheng_icon"];
    }
    }else{
        _SureIcon.hidden=YES;
       
        NSDictionary *AddDic=addArr[aRow-1];

       
        NSString *num=[AddDic objectForKey:@"BankNumber"];
           NSString *name=[AddDic objectForKey:@"Bankname"];
        self.Bank_code=[AddDic objectForKey:@"zid"];
         NSString *testBank2;

        testBank2=[num substringFromIndex:num.length-4];
         [_icon sd_setImageWithURL:[NSURL URLWithString:[AddDic objectForKey:@"BankLogo"]]];
        _bankname.text=[NSString stringWithFormat:@"%@(%@)", name,testBank2];
       
        if([CZ floatValue]-[TX floatValue]>0){
//            _keTeMoney.text=[NSString stringWithFormat:@"该卡可提金额%.2f元",[self.MoneyOut floatValue]-([CZ floatValue]-[TX floatValue])];
            
              [_keTeMoney setTitle:[NSString stringWithFormat:@"该卡可提金额%.2f元",[[CMUserDefaults objectForKey:@"YuEr"] floatValue]-([CZ floatValue]-[TX floatValue])] forState:UIControlStateNormal];
//            self.passVaule=[NSString stringWithFormat:@"%.2f",[self.MoneyOut floatValue]-([CZ floatValue]-[TX floatValue])];
          
        }

        
        
    }
    
    [_tixian dimissAlert];
}

#pragma mark 进入下一页面
-(void)NextBtnClick{
                    if ([self.currentBtn.currentTitle isEqualToString:@"请选择>"]) {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入开户行所在省和市" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                    [alert show];
                    return;
                }
                if ([_tText.text  isEqualToString:@""]) {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入开户支行名称" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                    [alert show];
                    return;
                }
                NSLog(@"bcard==%@,Province==%@,City==%@,bankName_code==%@",self.Bank_code,self.SelectProvince,self.SelectCity,_tText.text);
                NSDictionary *data=@{@"bcard":self.Bank_code,@"Province":self.SelectProvince,@"City":self.SelectCity,@"bankName_code":_tText.text};
    //          NSString *url=@"       ";
    // NSString *url=[NSString stringWithFormat:@"%@/handler/app_interface.ashx?action=bankKHH&bcard=%@&Province=%@&City=%@&bankName_code=%@",OnLineCode,self.Bank_code,self.SelectProvince,self.SelectCity,_tText.text];
    NSString *url=[NSString stringWithFormat:@"%@/handler/app_interface.ashx?action=bankKHH",OnLineCode];
    [CMHttpTool getRecordWithURL:url params:data success:^(id responseObj) {
          NSLog(@"KKK=====%@===%@",responseObj ,[responseObj objectForKey:@"result"]);
    } failure:^(NSError *error) {
        
    }];
        /*
     NSString *url=[NSString stringWithFormat:@"%@/handler/app_interface.ashx?action=bankKHH",OnLineCode];

                [CMHttpTool postWithURL:url params:data success:^(id responseObj) {
                    
                    NSLog(@"KKK=====%@===%@",responseObj ,[responseObj objectForKey:@"result"]);
//                    NSString *state=[responseObj objectForKey:@"status"];
//                    if([state intValue]==200 ){
//                        [CMNSNotice postNotificationName:@"bankAddressInPutSuccess" object:self userInfo:nil ];
//                                               return ;
//                    }else{
//                       CMAlert([responseObj objectForKey:@"result"]);
//                    }
    
                } failure:^(NSError *error) {
  
                }];
 */
    CMTiXianDetailViewController *vc=[[CMTiXianDetailViewController alloc]init];
    vc.userDeatailArray=self.userArray;
    
    vc.vipMsg=self.vipMsg;
    [self.navigationController pushViewController:vc animated:YES];

   }

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(void)getProvince{
    
//    NSString *urLStr=@"http://m.58cm.com/handler/app_interface.ashx?action=province";
    NSString *urLStr= [NSString stringWithFormat:@"%@/handler/app_interface.ashx?action=province",OnLineCode];
    [CMHttpTool getWithURL:urLStr params:nil success:^(id responseObj) {
        //  NSLog(@"responseObj==%@",responseObj);
       
        self.NewArr=(NSArray*)[responseObj objectForKey:@"result"];
        
    } failure:^(NSError *error) {
        
        
    }];
    




}
//checkNet
@end
