//
//  CMTiXianDetailViewController.m
//  CaiMao
//
//  Created by MAC on 16/6/25.
//  Copyright © 2016年 58cm. All rights reserved.
//
#import <CommonCrypto/CommonDigest.h>
#import "CMTiXianDetailViewController.h"
#import "CMTiXianJuan.h"
#import "CMTIXianFootView.h"
#import "CMRecordViewController.h"
#import "CMTiXianDetailCell.h"
@interface CMTiXianDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,tTiXianJuanDelegate,NSURLSessionDataDelegate>
{

    UILabel *_detail;

    CMTiXianJuan *_tiXian;
    CMTiXianBank  *_tixian;
    UIImageView *_SureIcon;
    UIImageView *_icon;
    UILabel *_bankname;
    CMTIXianFootView *_footView;
    UIButton *_MoneyLabel;
    BOOL isUseYouHui;
   // NSDictionary *TiXianDict;
   

}

@property(nonatomic,copy)NSString *imageViewIcon;
@property(nonatomic,copy)NSString *bankNumAndName;
@property(nonatomic,copy)NSString *userName;

@property(nonatomic,strong)UILabel *shouxufei;
@property(nonatomic,strong)UILabel *VipShouXuFei;
@property(nonatomic,strong)UILabel *VipZheKou;
@property(nonatomic,strong)UILabel *realmoney;
@property(nonatomic,strong)UITextField *currentTextField;
@property(nonatomic,strong)UIButton *getCode;
@property(nonatomic,strong)UITableView *testTable;
@property(nonatomic,strong)UITextField *password;
@property(nonatomic,strong)UITextField *sureCode;

@property(nonatomic,strong)NSMutableArray *tiXianData;
@property(nonatomic,strong)UILabel *TiXianJuanLabel;



@property(nonatomic,strong)NSMutableArray *tixianIdArr;
@property(nonatomic,strong)NSMutableArray *youhuiMoneyArr;
@property(nonatomic,copy)NSString *tiXianID;
@property(nonatomic,copy)NSString *youhuiMoney;
@property(nonatomic,copy)NSString *userId;

@property(nonatomic,strong)UILabel *recordTiXiajuan;
@end

@implementation CMTiXianDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"提现";
 
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提现记录" style:UIBarButtonItemStylePlain target:self action:@selector(enterIntoRecordOfTiXian)];

    [self creatUiView];
    isUseYouHui=NO;
    for (NSDictionary *dict in self.userDeatailArray) {
        self.userName=[dict objectForKey:@"name"];
        
    }
    self.userId = [CMUserDefaults valueForKey:@"userID"];
    self.vipMsg=[CMUserDefaults  objectForKey:@"VipLevl"];
}


#pragma mark 提现记录

-(void)enterIntoRecordOfTiXian{
    CMRecordViewController *vc=[[CMRecordViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)creatUiView{
    
  _footView =[CMTIXianFootView new];
 self.testTable.tableHeaderView=[self creatHeadView];
 self.testTable.tableFooterView=[_footView creatTiXianDetailFootView];
[_footView.TiXianBtnClick addTarget:self action:@selector(LiJiTiXianBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: self.testTable];
    [self getTiXianJuan];

}
#pragma mark Lazy
-(UITableView*)testTable{
    if (!_testTable) {
        _testTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, CMScreenH) style:UITableViewStylePlain];
        
        _testTable.separatorStyle=UITableViewCellSeparatorStyleNone;
        _testTable.showsVerticalScrollIndicator=NO;
        _testTable.rowHeight=40;
        
        _testTable.delegate=self;
        _testTable.dataSource=self;
 
    }
    
    return _testTable;
}
-(NSArray*)tiXianArr{
    if (!_tiXianArr) {
        _tiXianArr=[NSArray array];
    }
    return _tiXianArr;
}

#pragma mark tableView代理协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 8;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *tcell=@"UITableViewCell";
    
   CMTiXianDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:tcell];
        if (cell==nil) {
        cell=[[CMTiXianDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tcell];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
     NSArray *arr=@[@"真实姓名",@"可提金额",@"提现金额",@"提现手续费",@"提现折扣劵",@"实际到账",@"交易密码",@"验证码"];
    cell.titlelabel.text=arr[indexPath.row];

    switch (indexPath.row) {
        case 0:
        {
            cell.nameLabel.text=self.userName;
            [cell.getCode removeFromSuperview];
            [cell.inputTextField removeFromSuperview];
            [cell.nShouLabel removeFromSuperview];
            [cell.ZheKouLabel removeFromSuperview];
        
        }
            break;
        case 1:
        {
            
            cell.nameLabel.text=[NSString stringWithFormat:@"%@元",[CMUserDefaults objectForKey:@"YuEr"]];
            [cell.getCode removeFromSuperview];
            [cell.inputTextField removeFromSuperview];
            [cell.nShouLabel removeFromSuperview];
            [cell.ZheKouLabel removeFromSuperview];
        }
            break;
        case 2:
        {
            [cell.nameLabel removeFromSuperview];
            [cell.getCode removeFromSuperview];
            [cell.nShouLabel removeFromSuperview];
            [cell.ZheKouLabel removeFromSuperview];
            cell.inputTextField.placeholder=@"请输入提现金额不能低于5元";
            [CMNSNotice addObserver:self selector:@selector(shouxufei:) name:UITextFieldTextDidChangeNotification object:nil];
            cell.inputTextField.delegate=self;
            self.currentTextField=cell.inputTextField;
            
        }

            break;
        case 3:
        {
            [cell.getCode removeFromSuperview];
            [cell.inputTextField removeFromSuperview];
            self.VipShouXuFei=cell.ZheKouLabel;
            self.VipZheKou=cell.nShouLabel;
            self.shouxufei=cell.nameLabel;
            [cell.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
             
                make.width.mas_equalTo(70);
                
            }];
        }
            break;
        case 4:
        {
          
            [cell.getCode removeFromSuperview];
            [cell.inputTextField removeFromSuperview];
            [cell.nShouLabel removeFromSuperview];
            [cell.ZheKouLabel removeFromSuperview];
            self.TiXianJuanLabel=cell.nameLabel;
            cell.nameLabel.textAlignment=NSTextAlignmentLeft;
            if (self.tiXianArr.count<=0) {
                cell.nameLabel.text=@"暂无提现劵可用";
            }else{
                 cell.nameLabel.text=@"不使用提现劵";
                
            }
           
            cell.nameLabel.textColor=CMColor(128, 128, 128);
            cell.nameLabel.font=[UIFont systemFontOfSize:14];
            [cell.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
               
                make.width.mas_equalTo(200);
                
            }];
            
        }
            
               break;
        case 5:{
            [cell.getCode removeFromSuperview];
            [cell.inputTextField removeFromSuperview];
            [cell.nShouLabel removeFromSuperview];
            [cell.ZheKouLabel removeFromSuperview];
             self.realmoney=cell.nameLabel;
           
        }
            
            break;
        case 6:{
            [cell.nameLabel removeFromSuperview];
            [cell.nShouLabel removeFromSuperview];
            [cell.ZheKouLabel removeFromSuperview];
            [cell.getCode removeFromSuperview];
            cell.inputTextField.secureTextEntry=YES;
            cell.inputTextField.placeholder=@"请输入交易密码";
            self.password=cell.inputTextField;
        }
            break;
        case 7:{
            [cell.nameLabel removeFromSuperview];
            [cell.nShouLabel removeFromSuperview];
            [cell.ZheKouLabel removeFromSuperview];
            self.getCode=cell.getCode;
            [cell.getCode addTarget:self action:@selector(getMagNumber) forControlEvents:UIControlEventTouchUpInside];
            cell.inputTextField.placeholder=@"请输入短信验证码";
            cell.inputTextField.keyboardType=UIKeyboardTypeNumberPad;
            //suremsg.frame=CGRectMake(230,0, 90,40);
            self.sureCode=cell.inputTextField;
            
            [cell.inputTextField mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.width.mas_equalTo(120);
                
            }];
            
        }
            break;
            
        default:
            break;
    }
  
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        if (indexPath.row==4&&[self.currentTextField.text intValue]>0) {
            
            NSMutableArray *arr=[[NSMutableArray alloc]initWithCapacity:0];
            
            NSMutableArray *money=[[NSMutableArray alloc]initWithCapacity:0];
            
            self.tiXianData=[[NSMutableArray alloc]initWithCapacity:0];
            for (NSDictionary *dict in self.tiXianArr) {
                NSString *name=[NSString stringWithFormat:@"%@元/%@(有效期)",[dict objectForKey:@"MNum"],[dict objectForKey:@"validity"]];
                
                //self.tiXianData=[NSMutableArray arrayWithObjects:name, nil];
                
                [arr addObject:[dict objectForKey:@"zid"]];
                [money addObject:[dict objectForKey:@"MNum"]];
                self.youhuiMoneyArr=money;
                self.tixianIdArr=arr;
                [self.tiXianData addObject:name];
                
        }
        //选择可用提现劵
        _tiXian=[[CMTiXianJuan alloc]initWithTiXianJuanList:self.tiXianData];
        _tiXian.delegate=self;
        [_tiXian ShowAlert];
        
    }
    
    
}

#pragma mark 提现劵
-(void)alertViewShowTiXianWithRow:(NSInteger)aRow{
    
    
    if (self.tiXianData.count<=0) {
        self.TiXianJuanLabel.text=@"暂无提现劵可用";
        self.realmoney.text=[NSString stringWithFormat:@"%.2f元",[self.currentTextField.text floatValue] -[self.VipShouXuFei.text floatValue]];
        self.youhuiMoney=@"0.00";
        if ([self.currentTextField.text floatValue]<3) {
            self.realmoney.text=@"0.00元";
        }
        
    }else{
        if (aRow==0) {
            //不使用提现劵
            isUseYouHui=NO;
            self.TiXianJuanLabel.text=@"不使用提现劵";
            self.realmoney.text=[NSString stringWithFormat:@"%.2f元",[self.currentTextField.text floatValue] -[self.VipShouXuFei.text floatValue]];
            self.youhuiMoney=@"0.00";
            self.tiXianID=@"";
            
            [self vipJian:[self.currentTextField.text floatValue]];
        }else{
            isUseYouHui=YES;
            self.TiXianJuanLabel.text=self.tiXianData[aRow-1];
            self.tiXianID=self.tixianIdArr[aRow-1];
            self.youhuiMoney=self.youhuiMoneyArr[aRow-1];
            NSLog(@"slef==%@",self.youhuiMoney);
            [self NoUserTiXianJuan];
        }
        
    }
    
    [_tiXian dimissAlert];
    
}
#pragma mark 立即提现
-(void)LiJiTiXianBtnClick{
    
  
  
    if (self.currentTextField.text.length<=0) {
        _footView.errorLabel.hidden=NO;
        _footView.errorLabel.text=@"*请输入提现金额";
        return;
    }
    if ([self.currentTextField.text intValue]<5) {
        
        _footView.errorLabel.hidden=NO;
        _footView.errorLabel.text=@"*提现金额不能小于5元";
        return;
    }
    if ([self.currentTextField.text intValue]>[[CMUserDefaults objectForKey:@"YuEr"] intValue]) {
          _footView.errorLabel.hidden=NO;
        _footView.errorLabel.text=@"*提现金额不能大于账户可提金额";
     return;
   }
    if (self.password.text.length<=0) {
        _footView.errorLabel.hidden=NO;
              _footView.errorLabel.text=@"请输入交易密码";
          return;
    }
    if (self.sureCode.text.length<=0) {
        _footView.errorLabel.hidden=NO;
        _footView.errorLabel.text=@"请输入短信验证码";
        return;
    }
    if (self.currentTextField.text.length>50000) {
        _footView.errorLabel.hidden=NO;
        _footView.errorLabel.text=@"单笔金额不能超过五万";
        return;
    }
    
 
 
    NSRange qiFromRang = [ _MoneyLabel.titleLabel.text rangeOfString:@"额"];
    NSRange qiToRang = [ _MoneyLabel.titleLabel.text rangeOfString:@"元"];
    NSString *money=[_MoneyLabel.titleLabel.text substringWithRange:NSMakeRange(qiFromRang.location + 1, qiToRang.location - qiFromRang.location-1)];
    

    if ([money floatValue]<[self.currentTextField.text floatValue]) {
        _footView.errorLabel.hidden=NO;
        _footView.errorLabel.text=@"*提现金额不能大于账户可提金额";
        return;
    }
    //实付手续费
   static NSString *sxfy;
   
    if([self.youhuiMoney floatValue]>0){
        if ([self.youhuiMoney floatValue]>[self.shouxufei.text floatValue]) {
            sxfy=@"0.00";
        }else {
            
            sxfy=[NSString stringWithFormat:@"%.2f",[self.shouxufei.text floatValue]-[self.youhuiMoney floatValue]];
            
        }
        
    }
    else{
        if ([self.youhuiMoney floatValue]>[self.VipShouXuFei.text floatValue]) {
            sxfy=@"0.00";
        }else {
            
            sxfy=[NSString stringWithFormat:@"%.2f",[self.VipShouXuFei.text floatValue]-[self.youhuiMoney floatValue]];
            
        }
  }
    
    
    
    //银行卡编号
    NSString *bcard=self.bank_code;
    
    //提现金额
    NSString *txje=self.currentTextField.text;
    //提现手续费
    NSString *sxfy_yf=[self.shouxufei.text substringToIndex:self.shouxufei.text.length-1];
    
    //交易密码
    NSString *zhmm=[NSString md5:self.password.text];
    
    //验证码
    NSString *smscode=self.sureCode.text;
    //优惠券ID
    static NSString *CouponseId;
    if (self.tiXianID ==nil) {
        
        CouponseId=@"0";
        
    }else{
        
        CouponseId= self.tiXianID;
        
    }
    
    
    DLog(@"BCardID--%@,TXAmount-%@,HandingFee--%@,TradePWD--%@,SMSCode--%@-CouponseId--%@,ActualFee--%@,HYID--%@",bcard,txje,sxfy,zhmm,smscode,CouponseId,sxfy_yf,self.userId);
    
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppInterfaceTX.ashx?Action=9",OnLineCode];
    NSDictionary *TiXianDict=@{@"BCardID":bcard,@"TXAmount":txje,@"HandingFee":sxfy,@"TradePWD":zhmm,@"SMSCode":smscode,@"CouponseID":CouponseId,@"ActualFee":sxfy_yf,@"HYID":self.userId};
    
    NSLog(@"----%@",TiXianDict);
    
    [CMHttpTool postWithURL:url params:TiXianDict success:^(id responseObj) {
        //NSString *result=[responseObj objectForKey:@"Result"];
        NSString *result=[responseObj objectForKey:@"Result"];
        
        NSString *status=[responseObj objectForKey:@"Status"];
        if (result.length<=0||[result isEqualToString:@""]||[status intValue]==200) {
            //                  self.MoneyOut=[NSString stringWithFormat:@"%.2f",[self.MoneyOut floatValue]-[txje floatValue]];
            //                  [self.testTable reloadData];
            [CMNSNotice postNotificationName:@"BeginRefresh" object:self];
            CMRecordViewController *record=[[CMRecordViewController alloc]init];
            [self.navigationController pushViewController:record animated:YES];
        }
        else{
            
            _footView.errorLabel.hidden=NO;
            _footView.errorLabel.text=result;
        }
        
        
        
    } failure:^(NSError *error) {
        
        DLog(@"-----%@",error);
        
    }];
    
    
    
}

#pragma mark 监听提现金额
-(void)shouxufei:(NSNotification*)notic{
    if (isUseYouHui==NO) {
        
    
        float  money=[self.currentTextField.text floatValue];
        if (money<=1000) {
            
            if ([self.vipMsg intValue]<1||[self.youhuiMoney intValue]>0) {
                self.realmoney.hidden=NO;
                self.shouxufei.hidden=NO;
                self.VipShouXuFei.hidden=YES;
                self.shouxufei.text=@"3.00元";
               self.VipShouXuFei.text=self.shouxufei.text;
            }else{
                
                [self vipJian:money];
            }
          
                
    
        }
        if (self.currentTextField.text.length<=0) {
            self.shouxufei.hidden=YES;
            self.TiXianJuanLabel.text=@"不使用提现劵";
            self.youhuiMoney=@"";
            self.realmoney.hidden=YES;
            self.VipShouXuFei.hidden=YES;
            self.VipZheKou.hidden=YES;
        }
        if (money>1000&&money<33333.4) {
//            self.realmoney.hidden=NO;
//            self.shouxufei.hidden=NO;
//            self.shouxufei.text=[NSString stringWithFormat:@"%.2f元",money*0.003];
            if ([self.vipMsg intValue]<1) {
                self.VipShouXuFei.hidden=YES;
                self.realmoney.hidden=NO;
                self.shouxufei.hidden=NO;
                self.shouxufei.text=[NSString stringWithFormat:@"%.2f元",money*0.003];
               self.VipShouXuFei.text=self.shouxufei.text;
            }else{
                
                [self vipJian:money];

                
            }

            
        }
        if (money>=33333.4) {
//            self.realmoney.hidden=NO;
//            self.shouxufei.hidden=NO;
//            self.shouxufei.text=@"100.00元";
            
            if ([self.vipMsg intValue]<1) {
                self.VipShouXuFei.hidden=YES;
                self.realmoney.hidden=NO;
                self.shouxufei.hidden=NO;
                self.shouxufei.text=@"100.00元";
                self.VipShouXuFei.text=self.shouxufei.text;
            }else{
                
                [self vipJian:money];
            }
            
        }
        if ([self.youhuiMoney floatValue]>[self.VipShouXuFei.text floatValue]||[self.vipMsg intValue]==5) {
            self.realmoney.text=[NSString stringWithFormat:@"%.2f元",[self.currentTextField.text floatValue]];
        }else{
            if (money<3) {
                 self.realmoney.text=@"0.00元";
            }else{
            self.realmoney.text=[NSString stringWithFormat:@"%.2f元",[self.currentTextField.text floatValue] -[self.VipShouXuFei.text floatValue]+[self.youhuiMoney floatValue]];
            }
        }
  
    }else{
        
        
        [self NoUserTiXianJuan];

    
    
    }
    
}
#pragma mark Vip价格计算
-(void)vipPriceZheKou:(NSString*)zhekou andNum:(float)aNum andInPutprice:(float)aPrice{
    self.realmoney.hidden=NO;
    self.shouxufei.hidden=NO;
    self.VipZheKou.hidden=NO;
    self.VipShouXuFei.hidden=NO;

    if (aPrice<=1000) {
        self.shouxufei.text=@"3.00元";

    }if (aPrice>=33333.4) {
        self.shouxufei.text=@"100.00元";
    }
    
    if(aPrice>1000&&aPrice<33333.4){
         self.shouxufei.text=[NSString stringWithFormat:@"%.2f元",aPrice*0.003];
    }
   
    NSString *oldPrice = self.shouxufei.text;
    NSUInteger length = [oldPrice length];
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, length)];
    [self.shouxufei setAttributedText:attri];
    self.VipZheKou.text=zhekou;
    self.VipShouXuFei.text=[NSString stringWithFormat:@"%.2f元",[oldPrice floatValue]*aNum];
    
    if ([self.youhuiMoney floatValue]>[self.VipShouXuFei.text floatValue]) {
        self.realmoney.text=[NSString stringWithFormat:@"%.2f元",[self.currentTextField.text floatValue]];
    }else{
        
        self.realmoney.text=[NSString stringWithFormat:@"%.2f元",[self.currentTextField.text floatValue] -[self.VipShouXuFei.text floatValue]+[self.youhuiMoney floatValue]];
    }


}
#pragma mark vip
-(void)vipJian:(float)amoney{
    if ([self.vipMsg intValue]==1) {
        
        [self vipPriceZheKou:@"9折" andNum:0.9 andInPutprice:amoney];
    }
    if ([self.vipMsg intValue]==2) {
        
        [self vipPriceZheKou:@"8.5折" andNum:0.85 andInPutprice:amoney];
    }
    if ([self.vipMsg intValue]==3) {
        
        [self vipPriceZheKou:@"7.5折" andNum:0.75 andInPutprice:amoney];
    }
    if ([self.vipMsg intValue]==4) {
        
        [self vipPriceZheKou:@"0.5折" andNum:0.5 andInPutprice:amoney];
    }if ([self.vipMsg intValue]==5) {
        self.realmoney.hidden=NO;
        self.shouxufei.hidden=NO;
       // self.shouxufei.text=@"0.00元";
        if (amoney<=1000) {
            self.shouxufei.text=@"3.00元";
            
        }if (amoney>=33333.4) {
            self.shouxufei.text=@"100.00元";
        }
        
        if(amoney>1000&&amoney<33333.4){
            self.shouxufei.text=[NSString stringWithFormat:@"%.2f元",amoney*0.003];
        }
        
        NSString *oldPrice = self.shouxufei.text;
        NSUInteger length = [oldPrice length];
        
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
        [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, length)];
        [self.shouxufei setAttributedText:attri];

        self.VipShouXuFei.text=@"免手续费";
        
        
    }

}
#pragma mark 没有用提现劵
-(void)NoUserTiXianJuan{
    
    self.VipShouXuFei.hidden=YES;
    self.VipZheKou.hidden=YES;
    float  money=[self.currentTextField.text floatValue];
    
    if (money<=1000) {
        self.realmoney.hidden=NO;
        self.shouxufei.hidden=NO;
        self.shouxufei.text=@"3.00元";
        
    }
    if (self.currentTextField.text.length<=0) {
        self.shouxufei.hidden=YES;
        self.TiXianJuanLabel.text=@"不使用提现劵";
        self.youhuiMoney=@"";
        self.realmoney.hidden=YES;
        self.VipShouXuFei.hidden=YES;
        self.VipZheKou.hidden=YES;
    }
    if (money>1000&&money<33333.4) {
        self.realmoney.hidden=NO;
        self.shouxufei.hidden=NO;
        self.shouxufei.text=[NSString stringWithFormat:@"%.2f元",money*0.003];
        
    }
    if (money>=33333.4) {
        self.realmoney.hidden=NO;
        self.shouxufei.hidden=NO;
        self.shouxufei.text=@"100.00元";
        
    }
    
    if ([self.youhuiMoney floatValue]>[self.shouxufei.text floatValue]) {
        self.realmoney.text=[NSString stringWithFormat:@"%.2f元",[self.currentTextField.text floatValue]];
    }else{
        
        self.realmoney.text=[NSString stringWithFormat:@"%.2f元",[self.currentTextField.text floatValue] -[self.shouxufei.text floatValue]+[self.youhuiMoney floatValue]];
    }
    

    
}

#pragma mark 获取验证码
-(void)getMagNumber{

    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSString *url=@"http://m.58cm.com/handler/app_interface.ashx?action=txSendSmsCode";
        NSString *url=[NSString stringWithFormat:@"%@/handler/app_interface.ashx?action=txSendSmsCode",OnLineCode];
        [CMHttpTool getWithURL:url params:nil success:^(id responseObj) {
            
            
            
            
        } failure:^(NSError *error) {
            
            DLog(@"-----%@",error);
        }];
    });
    
    self.getCode.userInteractionEnabled=NO;
    __block int timeout=100; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
               //[self.getCode setBackgroundColor:[UIColor lightGrayColor]];
                [self.getCode setTitle:@"重新发送验证码" forState:UIControlStateNormal];
                 self.getCode.userInteractionEnabled=YES;;
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
              //  _getCheckNUmlabel.textColor=[UIColor grayColor];
                [self.getCode setTitle:[NSString stringWithFormat:@"%d秒",timeout] forState:UIControlStateNormal];;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);



}

#pragma mark 创建表头
-(UIView*)creatHeadView
{
    
   
    NSDictionary *dic=[self.userDeatailArray firstObject];
    NSDictionary *sureArry=[ dic objectForKey:@"BankData"];
    NSString *bankName=[sureArry objectForKey:@"Bankname"];
    NSString *num=[sureArry objectForKey:@"BankNumber"];
                 NSString *testBank=[num substringFromIndex:num.length-4];
                 self.bank_code=[sureArry objectForKey:@"zid"];
                self.imageViewIcon=[sureArry objectForKey:@"BankLogo"];
                self.bankNumAndName=[NSString stringWithFormat:@"%@(%@)",bankName,testBank];
    UIView *tView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
    
    //银行图标
    _icon=[[UIImageView alloc]init];
    //Frame:CGRectMake(8,14,110,40)]
    [_icon sd_setImageWithURL:[NSURL URLWithString:self.imageViewIcon]];
    [tView addSubview:_icon];
    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(tView).offset(5);
        make.width.mas_equalTo(50);
        //make.height.mas_equalTo(40);
        make.top.equalTo(tView.mas_top).offset(10);
        make.bottom.equalTo(tView.mas_bottom).offset(-10);
        
    }];
    
    //银行名称
    _bankname=[[UILabel alloc]init];
    //WithFrame:CGRectMake(125, 10, 160, 30)
    _bankname.font=[UIFont boldSystemFontOfSize:15];
    _bankname.textColor=CMColor(77, 77, 77);
    _bankname.text=self.bankNumAndName;
    [tView addSubview:_bankname];
    [_bankname mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_icon.mas_top).offset(-5);
        make.left.equalTo(_icon.mas_right).offset(5);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(120);
        
    }];
    //认证图标
    _SureIcon=[[UIImageView alloc]init];
    //WithFrame:CGRectMake(215, 17, 30, 15)
    _SureIcon.image=[UIImage imageNamed:@"tixian_renzheng_icon"];
    _SureIcon.hidden=NO;
    
    [tView addSubview:_SureIcon];
    [_SureIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_bankname.mas_right);
        make.centerY.equalTo(_bankname);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(30);
    }];


    
     NSString *title=[NSString stringWithFormat:@"该卡可提金额%@元",[CMUserDefaults objectForKey:@"YuEr"]];
    UIImage *image=[UIImage imageNamed:@"detail_pressed"];
    //详情
   _MoneyLabel=[UIButton buttonWithType:UIButtonTypeCustom];
    [_MoneyLabel setImage:image forState:UIControlStateNormal];
    [_MoneyLabel setTitle:title forState:UIControlStateNormal];
    [_MoneyLabel addTarget:self action:@selector(detailBankBtnClick) forControlEvents:UIControlEventTouchUpInside];
     CGRect rect=[title boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil];
    _MoneyLabel.titleLabel.font=[UIFont systemFontOfSize:13];
    [_MoneyLabel setTitleColor:CMColor(153, 153, 153) forState:UIControlStateNormal];
    _MoneyLabel.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [tView addSubview:_MoneyLabel];
    [_MoneyLabel setTitleEdgeInsets:UIEdgeInsetsMake(0,-_MoneyLabel.imageView.frame.size.width-10, 0,_MoneyLabel.imageView.frame.size.width)];
    [_MoneyLabel setImageEdgeInsets:UIEdgeInsetsMake(0, rect.size.width+5 , 0, -rect.size.width)];

    [_MoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_bankname.mas_bottom);
                make.left.equalTo(_bankname);
                 make.width.mas_equalTo(rect.size.width+30);
                make.height.mas_equalTo(20);
        
         }];
    //换支付卡
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
     NSDictionary *dic=[self.userDeatailArray firstObject];
   
    NSDictionary *sureArry=[ dic objectForKey:@"BankData"];
    // NSDictionary *SureDetail=[sureArry firstObject];
    
   
    NSString *numOne=[sureArry objectForKey:@"BankNumber"];
    NSString *testBankOne;

    testBankOne=[numOne substringFromIndex:numOne.length-4];
    
    NSString *Surebank=[NSString stringWithFormat:@"%@(尾号:%@)(已认证)",[sureArry objectForKey:@"Bankname"],testBankOne];
    [bigArr addObject:Surebank];
    
    //添加的银行卡
    NSArray *addArry=[ dic objectForKey:@"AddBankData"];
    
    for ( NSDictionary *addDetail in addArry) {
        
        NSString *num=[addDetail objectForKey:@"BankNumber"];
    
        NSString *testBank=[num substringFromIndex:num.length-4];
        NSString *bank=[NSString stringWithFormat:@"%@(尾号:%@)",[addDetail objectForKey:@"Bankname"],testBank];
        [bigArr addObject:bank];
        
    }
    
    _tixian=[[CMTiXianBank alloc]initWithBankList:bigArr];
    _tixian.delegate=self;
    [_tixian ShowAlert];

    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
  
        NSMutableArray  *arr=[[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
        for (UIViewController *vc in arr) {
            if ([vc isKindOfClass:[self class]]) {
                
                [arr removeObject:vc];
                break;
            }
            
        }
        self.navigationController.viewControllers=arr;
    
    
}

-(void)alertViewShowWithRow:(NSInteger)aRow{
    self.imageViewIcon=nil;
    self.bankNumAndName=nil;
    NSDictionary *dic=[self.userDeatailArray firstObject];
   
    NSDictionary *dict=[dic objectForKey:@"BankData"];
    
 
    if (aRow==0) {
        //认证
        _SureIcon.hidden=NO;
        NSString *num=[dict objectForKey:@"BankNumber"];
        NSString *bankName=[dict objectForKey:@"Bankname"];
       
        self.bank_code=[dict objectForKey:@"zid"];
        
        NSString *testBank1=[num substringFromIndex:num.length-4];
        [_icon sd_setImageWithURL:[NSURL URLWithString:[dict objectForKey:@"BankLogo"]]];
        
        _bankname.text=[NSString stringWithFormat:@"%@(%@)", bankName,testBank1];
        //_MoneyLabel.text=[NSString stringWithFormat:@"该卡可提金额%@元",self.MoneyOut];
        [_MoneyLabel setTitle:[NSString stringWithFormat:@"该卡可提金额%@元",[CMUserDefaults objectForKey:@"YuEr"]] forState:UIControlStateNormal];
        
    }else{
        _SureIcon.hidden=YES;
        NSArray  *addArr=[dic objectForKey:@"AddBankData"];
        NSString *CZ=[dict objectForKey:@"cz_amount"];
        NSString *TX=[dict objectForKey:@"tx_amount"];
        NSDictionary *dic=addArr[aRow-1];
        if ([[dic objectForKey:@"BankCount"]intValue]==0) {//取现0次
            NSArray *bankNameArr=@[@"工商银行",@"农业银行",@"招商银行",@"浦发银行",@"光大银行",@"中国银行"];
            for(NSString *name in bankNameArr){
            
                if ([[dic objectForKey:@"Bankname"]isEqualToString:name]) {
                    
                    NSString *num=[dic objectForKey:@"BankNumber"];
                    NSString *bankName=[dic objectForKey:@"Bankname"];
                    
                    self.bank_code=[dic objectForKey:@"zid"];
                    
                    //  [_icon sd_setImageWithURL:[NSURL URLWithString:IconUrl]];
                    NSString *testBank2=[num substringFromIndex:num.length-4];
                    
                    _bankname.text=[NSString stringWithFormat:@"%@(%@)", bankName,testBank2];
                    [_icon sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"BankLogo"]]];
                    //判断非认证卡可提金额
                   // _MoneyLabel.text=[NSString stringWithFormat:@"该卡可提金额%.2f元",([CZ floatValue]-[TX floatValue]>0?[self.MoneyOut floatValue]-([CZ floatValue]-[TX floatValue]):[self.MoneyOut floatValue])];
                    [_MoneyLabel setTitle:[NSString stringWithFormat:@"该卡可提金额%.2f元",([CZ floatValue]-[TX floatValue]>0?[[CMUserDefaults objectForKey:@"YuEr"] floatValue]-([CZ floatValue]-[TX floatValue]):[[CMUserDefaults objectForKey:@"YuEr"] floatValue])] forState:UIControlStateNormal];
                     [_tixian dimissAlert];
                    return;
                    
                }
                if (![[dic objectForKey:@"Bankname"]isEqualToString:name])
                    
                {
                    CMTiXianViewController *vc=[[CMTiXianViewController alloc]init];
                    vc.userArray=self.userDeatailArray;
    
                    vc.vipMsg=self.vipMsg;
                    vc.isFromTiXian=YES;
                    vc.bankIndex=aRow-1;
                    [self.navigationController pushViewController:vc animated:NO];
                    [_tixian dimissAlert];
                       return;
                }
            }
        }else{
            
        NSString *num=[dic objectForKey:@"BankNumber"];
         NSString *bankName=[dic objectForKey:@"Bankname"];
    
                self.bank_code=[dic objectForKey:@"zid"];
               
                //  [_icon sd_setImageWithURL:[NSURL URLWithString:IconUrl]];
                NSString *testBank2=[num substringFromIndex:num.length-4];
              
                _bankname.text=[NSString stringWithFormat:@"%@(%@)", bankName,testBank2];
                 [_icon sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"BankLogo"]]];
                //判断非认证卡可提金额
               // _MoneyLabel.text=[NSString stringWithFormat:@"该卡可提金额%.2f元",([CZ floatValue]-[TX floatValue]>0?[self.MoneyOut floatValue]-([CZ floatValue]-[TX floatValue]):[self.MoneyOut floatValue])];
           
  
        } 
          }
    
    [_tixian dimissAlert];
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

#pragma mark 创建请求
-(void)getTiXianJuan{
//    NSString *url=@"http://m.58cm.com/handler/app_interface.ashx?action=txYhj";
    NSString *url=[NSString stringWithFormat:@"%@/handler/app_interface.ashx?action=txYhj",OnLineCode];
    [CMHttpTool getWithURL:url params:nil success:^(id responseObj) {
       
      //[self.testTable.mj_header endRefreshing];

        NSArray *resultArr=[responseObj objectForKey:@"result"];
        self.tiXianArr=resultArr;
            [self.testTable reloadData];

    } failure:^(NSError *error) {
     //[self.testTable.mj_header endRefreshing];
    }];
    
   

}
-(void)dealloc{
    
    [CMNSNotice removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}
//-(void)viewDidLayoutSubviews
//{
//    if ([self.testTable respondsToSelector:@selector(setSeparatorInset:)]) {
//        [self.testTable setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
//    }
//    
//    if ([self.testTable respondsToSelector:@selector(setLayoutMargins:)]) {
//        [self.testTable setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
//    }
//}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat sectionHeaderHeight = 10;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y> 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }else
        if(scrollView.contentOffset.y >= sectionHeaderHeight){
            
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
}


@end
