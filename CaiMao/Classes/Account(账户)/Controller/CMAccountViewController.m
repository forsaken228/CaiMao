//
//  CMAccountViewController.m
//  CaiMao
//
//  Created by Fengpj on 14-12-12.
//  Copyright (c) 2014年 58cm. All rights reserved.
//

#import "CMAccountViewController.h"
 #import "CMRecordViewController.h"
#import "CMRecordOfCharge.h"
#import "CMRequestManager.h"
@interface CMAccountViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
    NSArray *_ImageArr;
}

@property (copy, nonatomic)  NSString *cfbYuEr;
@property (copy, nonatomic)  NSString *DingQiLiCai;
@property(nonatomic,copy)NSArray *NewArr;
@property(nonatomic,copy)NSArray *NewBankArr;
@property(nonatomic,strong)CMAccountTopView *accountTopView;
@property(nonatomic,strong)UITableView *accountTableView;
@property(nonatomic,strong)CMAsDespositEarnModel *EarnModel;
@end

@implementation CMAccountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // 监听通知 （登录成功 刷新表格 显示账户信息）
     
      
      //  [CMNSNotice addObserver:self selector:@selector(refreshAccountTable:) name:@"MesToAccount" object:nil];
        [CMNSNotice addObserver:self selector:@selector(renzhengSuccess) name:@"renzhengSuccess" object:nil];
       
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [CMNSNotice addObserver:self selector:@selector(rechargeSuccess) name:@"BeginRefresh" object:nil];
    [CMNSNotice addObserver:self selector:@selector(rechargeSuccess) name:@"confirmButtonEvent" object:nil];
}

- (void)dealloc{
  [CMNSNotice removeObserver:self];
    
}

-(void)rechargeSuccess{
    
 //  [self.accountTableView.mj_header beginRefreshing];
   [self loadData];
}
-(void)renzhengSuccess{
  
    [CMRequestHandle requestRenZhengMsgsuccess:^(id responseObj) {
        if ([[responseObj objectForKey:@"status"]intValue]==200) {
          
            self.NewArr=[responseObj objectForKey:@"result"];
           [self.accountTableView.mj_header endRefreshing];
        }
    } andFailure:^(id error) {
       [self.accountTableView.mj_header endRefreshing];

    }];
    
    [CMRequestHandle requestBankListMsgsuccess:^(id responseObj) {
        
        if ([[responseObj objectForKey:@"status"]intValue]==200) {
           
            self.NewBankArr=[responseObj objectForKey:@"result"];
            [self.accountTableView.mj_header endRefreshing];
                    }
    } andFailure:^(id error) {
        [self.accountTableView.mj_header endRefreshing];

    }];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.navigationController.navigationBar.translucent = NO;
    self.title=@"账户";
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.view.backgroundColor=ViewBackColor;
    [self setUpUI];
    [self titleData];
    [self showDefaultProgressHUD];
 self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"安全退出" style:UIBarButtonItemStylePlain target:self action:@selector(exitLoginAcconnt)];
    

}
#pragma mark 标题数据
-(void)titleData{
    
    
    _titleArr = [NSArray arrayWithObjects:
                 [NSArray arrayWithObjects:@"财富宝",@"随心存",@"定期理财",@"我的优惠券",@"我的M币",nil],
                 [NSArray arrayWithObjects:@"我的喵友",@"邀请记录", nil],
                 //                [NSArray arrayWithObjects:@"手势管理",@"安全认证",@"我的资料", nil],
                 [NSArray arrayWithObjects:@"手势管理",@"安全认证",@"我的资料",@"我的积分",@"我的地址",nil],
                 [NSArray arrayWithObjects:@"我的消息",@"更多", nil],nil];
    
    _ImageArr=[NSArray arrayWithObjects:
               [NSArray arrayWithObjects:@"财富宝a",@"定期理财",@"随心存a",@"我的优惠劵Image",@"我的M币",nil],
               [NSArray arrayWithObjects:@"邀请好友",@"邀请记录", nil],
               //                [NSArray arrayWithObjects:@"手势管理",@"安全认证",@"我的资料", nil],
               [NSArray arrayWithObjects:@"手势管理",@"安全认证",@"我的资料",@"我的积分",@"我的地址",nil],
               [NSArray arrayWithObjects:@"我的消息",@"更多", nil],nil];
    

}


- (void)vipMessage
{
    if (![self checkNetWork]) {
        [self.accountTableView.mj_header endRefreshing];
    }
    [CMRequestHandle GetVipMsgWithHYID:[CMUserDefaults objectForKey:@"userID"] andSuccess:^(id responseObj) {
        NSString *statusStr = [responseObj valueForKey:@"status"];
        if ([statusStr isEqualToString:@"200"]) {
            //DLog(@"+++%@",responseObj);
            NSString *vip = [[[responseObj valueForKey:@"result"] objectAtIndex:0] valueForKey:@"VipLevl"];
            [CMUserDefaults setObject:vip forKey:@"VipLevl"];
            [CMUserDefaults synchronize];
            switch ([vip integerValue]) {
                case 0:
                    [self.accountTopView.vipBtn setBackgroundImage:[UIImage imageNamed:@"vip_putong"] forState:UIControlStateNormal];
                    break;
                case 1:
                    [self.accountTopView.vipBtn setBackgroundImage:[UIImage imageNamed:@"vip1"] forState:UIControlStateNormal];
                    break;
                case 2:
                    [self.accountTopView.vipBtn setBackgroundImage:[UIImage imageNamed:@"vip2"] forState:UIControlStateNormal];
                    break;
                case 3:
                    [self.accountTopView.vipBtn setBackgroundImage:[UIImage imageNamed:@"vip3"] forState:UIControlStateNormal];
                    break;
                case 4:
                    [self.accountTopView.vipBtn setBackgroundImage:[UIImage imageNamed:@"vip4"] forState:UIControlStateNormal];
                    break;
                case 5:
                    [self.accountTopView.vipBtn setBackgroundImage:[UIImage imageNamed:@"vip5"] forState:UIControlStateNormal];
                    break;
                    
                    
                default:
                    break;
            }
        }
    }];
    }

#pragma mark - 点击Vip等级

- (void)vipBtnClick
{

    CMVipQIanDaoViewController *productVc = [[CMVipQIanDaoViewController alloc] init];
    [self.navigationController pushViewController:productVc animated:YES];

}
#pragma mark充值
- (void)chongZhiBtnClick:(id)sender {
    
  
    if (self.NewBankArr!=nil && ![self.NewBankArr isKindOfClass:[NSNull class]] && self.NewBankArr.count!=0){
        
        NSDictionary *dic=[self.NewBankArr firstObject];
        NSDictionary  *bankData=[dic objectForKey:@"BankData"];
        if (bankData.count==0||bankData.allKeys.count==0) {
            //银行卡认证
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您还没开通银行卡认证支付,请选择常用银行卡认证！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"认证", nil];
            alert.tag=101;
            [alert show];
            
        }
    
        else {
            
           
            // 充值
            CMRechargeViewController *productVc = [[CMRechargeViewController alloc] init];
           
          //  productVc.userDict= self.NewArr;
           // productVc.bank_code=[bankData objectForKey:@"zid"];
            [self.navigationController pushViewController:productVc animated:YES];
     /*
            //测试
            CMProductDetailController *pro=[[CMProductDetailController alloc]init];
            pro.urlStr=[NSString stringWithFormat:@"%@/icm/acc/warecharge.aspx",OnLineCode];
            [self.navigationController pushViewController:pro animated:YES];
               */
             
             
        }
        
        
    }


}


#pragma mark 提现
- (void)tiXianBtnClick:(id)sender {
    
   
 
// NSLog(@"self.----%@self.---%@",self.NewArr,self.NewBankArr);
    if (self.NewBankArr!=nil && ![self.NewBankArr isKindOfClass:[NSNull class]] && self.NewBankArr.count!=0){

        NSDictionary *dic=[self.NewBankArr firstObject];
        NSDictionary *bankData=[ dic objectForKey:@"BankData"];
        NSString *userBankName=[bankData objectForKey:@"Bankname"];
        
        NSArray *bankNameArr=@[@"工商银行",@"农业银行",@"招商银行",@"浦发银行",@"光大银行",@"中国银行"];
        for (NSString *name in bankNameArr) {
            if ([userBankName isEqualToString:name]) {
                
                CMTiXianDetailViewController *vc=[[CMTiXianDetailViewController alloc]init];
                vc.userDeatailArray=self.NewBankArr;

                [self.navigationController pushViewController:vc animated:YES];
                
//                CMProductDetailController *pro=[[CMProductDetailController alloc]init];
//                pro.urlStr=[NSString stringWithFormat:@"%@/icm/acc/withdrawals.aspx",OnLineCode];
//                [self.navigationController pushViewController:pro animated:YES];
                return;
            }
        }
        
        if (bankData.count==0||bankData.allKeys.count==0) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您还没开通银行卡认证支付,请选择常用银行卡认证！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"认证", nil];
            alert.tag=101;
            [alert show];
        }else{
            
            
            if ([[bankData objectForKey:@"BankCount"]integerValue]>0) {
                
                
                CMTiXianDetailViewController *vc=[[CMTiXianDetailViewController alloc]init];
                vc.userDeatailArray=self.NewBankArr;
    
                [self.navigationController pushViewController:vc animated:YES];
//                CMProductDetailController *pro=[[CMProductDetailController alloc]init];
//                pro.urlStr=[NSString stringWithFormat:@"%@/icm/acc/withdrawals.aspx",OnLineCode];
//                [self.navigationController pushViewController:pro animated:YES];
                
                
            }else{
                
                
                CMTiXianViewController *vc=[[CMTiXianViewController alloc]init];
                vc.userArray=self.NewBankArr;
        
                [self.navigationController pushViewController:vc animated:YES];
                
            }
            
        }
        
        
    }
}


#pragma mark - 设置UI
- (void)setUpUI
{
    [self.view addSubview:self.accountTableView];
    
    
    [self refreshDate];
 
    NSString *str = [NSString stringWithFormat:@"您好：%@",[CMUserDefaults objectForKey:@"name"]];

    self.accountTopView.userLabl.text = [str stringByReplacingCharactersInRange:NSMakeRange(6, 4) withString:@"****"];

    self.accountTableView.tableHeaderView =self.accountTopView;
    
   
   
}
#pragma mark  刷新数据
-(void)refreshDate{
    [self loadData];
    self.accountTableView.mj_header = [CMRefreshHeader headerWithRefreshingBlock:^{
        //[self loginAuto];
        [self loadData];
    }];
    
  // [self.accountTableView.mj_header beginRefreshing];
}
-(void)loadData{
    [self renzhengSuccess];
    [self loadAccountMes];
    [self vipMessage];
    [self LoadAsEarnData];
    
}

#pragma mark Lazy
-(CMAccountTopView*)accountTopView{
    if (!_accountTopView) {
        _accountTopView=[[CMAccountTopView alloc]init];
        _accountTopView.userInteractionEnabled=YES;
        [_accountTopView.vipBtn addTarget:self action:@selector(vipBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_accountTopView.ZongZiBtn addTarget:self action:@selector(goZijinrecord) forControlEvents:UIControlEventTouchUpInside];
        
        [_accountTopView.chongzhiBtn addTarget:self action:@selector(chongZhiBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_accountTopView.tiXianBtn addTarget:self action:@selector(tiXianBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _accountTopView;
}

-(UITableView*)accountTableView{
    if (!_accountTableView) {
        _accountTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, CMScreenH) style:UITableViewStyleGrouped];
        _accountTableView.showsVerticalScrollIndicator=NO;
        _accountTableView.showsHorizontalScrollIndicator=NO;
        _accountTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 100)];
        _accountTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _accountTableView.dataSource = self;
        _accountTableView.delegate = self;
    }
    return _accountTableView;
}
//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    // 马上进入刷新状态
//    [self loginAuto];
//}
-(void)goZijinrecord{
    
    CMRecordOfCharge *vc=[[CMRecordOfCharge alloc]init];
    vc.selectIndex=0;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)loadAccountMes
{
  
    if (![self checkNetWork]) {
         [self.accountTableView.mj_header endRefreshing];
    }
   [CMRequestHandle GetAccountMsgWithHYID:[CMUserDefaults objectForKey:@"userID"] andSuccess:^(id responseObj) {
       NSString *statusStr = [responseObj valueForKey:@"status"];
       NSString *resultStr = [responseObj valueForKey:@"result"];
    if ([statusStr isEqualToString:@"200"]) {
        [self hiddenProgressHUD];
        [self.accountTableView.mj_header endRefreshing];
        
           NSString *jinriStr = [[[responseObj valueForKey:@"result"] valueForKey:@"today_ShouYi_Amount"] objectAtIndex:0]; // 今日收益
           NSString *leijiStr = [[[responseObj valueForKey:@"result"] valueForKey:@"leiji_shouyi_Amount"] objectAtIndex:0]; // 累计收益
           NSString *yueStr = [[[responseObj valueForKey:@"result"] valueForKey:@"ky_amount"] objectAtIndex:0]; // 账户余额
           NSString *zongStr = [[[responseObj valueForKey:@"result"] valueForKey:@"total_Amount"] objectAtIndex:0]; // 总资产
           NSString *cfb = [[[responseObj valueForKey:@"result"] valueForKey:@"cfb_xianzhi_Amount"] objectAtIndex:0];
           NSString *Dinqi = [[[responseObj valueForKey:@"result"] valueForKey:@"cy_Amount"] objectAtIndex:0];
           //NSString *dongjie = [[[responseObj valueForKey:@"result"] valueForKey:@"ky_amount_dj"] objectAtIndex:0];
           self.DingQiLiCai=Dinqi;
           self.accountTopView.jinShouYiLab.text = jinriStr;
           self.accountTopView.leijiShouyiLab.text  = leijiStr;
           self.accountTopView.zhangYuLab.text =[NSString stringWithFormat:@"%.2f", [yueStr floatValue]];
           self.accountTopView.zongZiLab.text = zongStr;
           self.cfbYuEr=cfb;
        
           CGSize size=[ self.accountTopView.zongZiLab.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 40) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:30.0]} context:nil].size;
           [self.accountTopView.zongZiLab mas_updateConstraints:^(MASConstraintMaker *make) {
               make.width.mas_equalTo(size.width+2);
           }];

    
           self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"安全退出" style:UIBarButtonItemStylePlain target:self action:@selector(exitLoginAcconnt)];
           
           [CMUserDefaults setObject:yueStr forKey:@"YuEr"];
           [CMUserDefaults synchronize];
       
           [self.accountTableView reloadData];
           
       }
       
       if ([statusStr isEqualToString:@"400"]) {
           UIAlertView *alertMes = [[UIAlertView alloc] initWithTitle:@"提示" message:resultStr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
           alertMes.tag=100;
           [alertMes show];
       }
   
   }];
   
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _titleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_titleArr[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"acountCell";
    CMAccountCell *cell = [tableView cellForRowAtIndexPath:indexPath];
   
    if (!cell) {
        cell = [[CMAccountCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    cell.redMessage.hidden=YES;
    cell.title.text = _titleArr[indexPath.section][indexPath.row];
    cell.icon.image = [UIImage imageNamed:_ImageArr[indexPath.section][indexPath.row]];
    CGRect rect=[cell.title.text  boundingRectWithSize:CGSizeMake(200,cell.bounds.size.height) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil];
    [cell.title mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.icon.mas_right).offset(10);
        make.centerY.equalTo(cell.mas_centerY);
        make.height.mas_equalTo(rect.size.height);
        make.width.mas_equalTo(rect.size.width+3);
        
    }];

 
    //cell.actionTitle.layer.cornerRadius=15/2.0;
    

    if (indexPath.section==3) {
     
        if (indexPath.row==0) {
            if ([[NSFileManager defaultManager]fileExistsAtPath:[CMDataMessage getFilePath]]) {
                
            if ([CMMessageDao selectCount].count>0) {
                
                
                cell.redMessage.hidden=NO;
                cell.redMessage.text=[NSString stringWithFormat:@"%d",[CMMessageDao selectCount].count];
                //显示
                [self.tabBarController.tabBar showBadgeOnItemIndex:3];

            }else{
                
                 [self.tabBarController.tabBar hideBadgeOnItemIndex:3];
            }
            }
       }
        
        
    }
 
 
    if(indexPath.section==0){
        
            if (indexPath.row==0) {
               // UIImage *image=[UIImage imageNamed:@"huoQiImage"];
              //  cell.IconImage.hidden=NO;
               // cell.IconImage.image=image;
                cell.CellYuEr.hidden=NO;
                cell.CellYuEr.text=self.cfbYuEr;
//                [cell.IconImage  mas_updateConstraints:^(MASConstraintMaker *make) {
//                    make.height.mas_equalTo(image.size.height);
//                    make.width.mas_equalTo(image.size.width);
//                }];
                cell.actionTitle.hidden=NO;
                cell.actionTitle.text=@"活期";
                CGRect rect_1=[cell.actionTitle.text  boundingRectWithSize:CGSizeMake(50,15) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0]} context:nil];
                [cell.actionTitle mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(rect_1.size.width+10);
                    
                }];
               
            }
       else if (indexPath.row==1) {
            cell.CellYuEr.hidden=NO;
           // UIImage *image=[UIImage imageNamed:@"CustomMadeImage"];
            //cell.IconImage.hidden=NO;
//            cell.IconImage.image=image;
//            [cell.IconImage  mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(image.size.height);
//                make.width.mas_equalTo(image.size.width);
//                make.centerY.equalTo(cell);
//                make.left.equalTo(cell.title.mas_right);
//            }];
            cell.CellYuEr.text=[NSString stringWithFormat:@"%.2f",_EarnModel.Amount_ChiYou];
           cell.actionTitle.hidden=NO;
           cell.actionTitle.text=@"个性定制";
           CGRect rect_1=[cell.actionTitle.text  boundingRectWithSize:CGSizeMake(50,15) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0]} context:nil];
           [cell.actionTitle mas_updateConstraints:^(MASConstraintMaker *make) {
               make.width.mas_equalTo(rect_1.size.width+10);
               
           }];
          
        }
       else if (indexPath.row==2) {
            cell.CellYuEr.hidden=NO;
           
           cell.CellYuEr.text=self.DingQiLiCai;
        }
        
    }
    //[CMUserDefaults  setBool:NO forKey:@"invition"];
    //[CMUserDefaults  setBool:NO forKey:@"gesture"];
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            if ([CMUserDefaults boolForKey:@"invition"]==NO) {
                
//                cell.IconImage.hidden=NO;
//                cell.IconImage.image=[UIImage imageNamed:@"new"];
                cell.actionTitle.text=@"NEW";
                 cell.actionTitle.hidden=NO;
                CGRect rect_1=[cell.actionTitle.text  boundingRectWithSize:CGSizeMake(50,15) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0]} context:nil];
                [cell.actionTitle mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(rect_1.size.width+10);
                    
                }];
                
            }else{
               // cell.IconImage.hidden=YES;
                cell.actionTitle.hidden=YES;
                
            }
           
            cell.CellYuEr.hidden=NO;
            cell.CellYuEr.font=[UIFont systemFontOfSize:13.0];
            cell.CellYuEr.text=@"看看我的朋友,谁在财猫";
            cell.CellYuEr.textColor=UIColorFromRGB(0x7c7c7c);

            
        }

    }
    if (indexPath.section==2) {
        if (indexPath.row==0) {
            if ([CMUserDefaults boolForKey:@"gesture"]==NO) {
              
//                cell.IconImage.hidden=NO;
//                cell.IconImage.image=[UIImage imageNamed:@"new"];
                cell.actionTitle.text=@"NEW";
                 cell.actionTitle.hidden=NO;
                CGRect rect_1=[cell.actionTitle.text  boundingRectWithSize:CGSizeMake(50,15) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0]} context:nil];
                [cell.actionTitle mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(rect_1.size.width+10);
                    
                }];

            }else{
                //cell.IconImage.hidden=YES;
                cell.actionTitle.hidden=YES;
                
            }
            
        }
    }
    
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
        if (indexPath.section == 0 ) {
            if (indexPath.row==0) {
                
                CMCFBBackGroundController *productVc = [[CMCFBBackGroundController alloc] init];
               
                [self.navigationController pushViewController:productVc animated:YES];
//                
//                CMAllChiYouController  *allvc=[[CMAllChiYouController alloc]init];
//                CMPush(allvc);
//
            }
            else if (indexPath.row==1) {
                //随心存
                CMAccountDespoistController *productVc = [[CMAccountDespoistController alloc] init];

                [self.navigationController pushViewController:productVc animated:YES];
            }
            
            else if (indexPath.row==2) {
                //定期理财
                CMDQLController *productVc = [[CMDQLController alloc] init];
                
                productVc.YuEr=self.accountTopView.zhangYuLab.text;
                productVc.bankList=self.NewBankArr;
                productVc.bankDataList=self.NewArr;
                [self.navigationController pushViewController:productVc animated:YES];
            }
            
            else if (indexPath.row==3) {
                //我的优惠券
                CMMyCouponsController *productVc = [[CMMyCouponsController alloc] init];
                CMPush(productVc);
            }

            else if (indexPath.row==4) {
                //我的M币
                CMMyMBinController *productVc = [[CMMyMBinController alloc] init];
               //e productVc.UserID=_userID;
                [self.navigationController pushViewController:productVc animated:YES];
            }

//            else{
//            CMProductDetailController *productVc = [[CMProductDetailController alloc] init];
//            productVc.urlStr = _accountMenuArr[indexPath.section][indexPath.row];
//            
//            [self.navigationController pushViewController:productVc animated:YES];
//            }
//            
        }else if ( indexPath.section == 2){
            if (indexPath.row ==0) {
    
                CMGestureMangerController *productVc = [[CMGestureMangerController alloc] init];
                productVc.block=^{
                    
                    [CMUserDefaults  setBool:YES forKey:@"gesture"];
                    [self.accountTableView reloadData];
                };
                [self.navigationController pushViewController:productVc animated:YES];
                
            }
            else if (indexPath.row==2){
                //我的资料
                CMMyInformationController *productVc = [[CMMyInformationController alloc] init];
                
                [self.navigationController pushViewController:productVc animated:YES];
            }
            else if (indexPath.row==3){
                
                CMMyIntegralController *productVc = [[CMMyIntegralController alloc] init];
                
                [self.navigationController pushViewController:productVc animated:YES];
            }
            else if (indexPath.row==4){
                //我的地址
                
                CMMyAddressController *productVc = [[CMMyAddressController alloc] init];
                productVc.UserBankListArr=self.NewBankArr;
                [self.navigationController pushViewController:productVc animated:YES];
            }
            else if (indexPath.row==1){
                //安全认证
                CMSafeController *productVc = [[CMSafeController alloc] init];
                productVc.UserBankListArr=self.NewBankArr;
                [self.navigationController pushViewController:productVc animated:YES];

            }
//            else{
//            CMProductDetailController *productVc = [[CMProductDetailController alloc] init];
//            productVc.urlStr = _accountMenuArr[1][indexPath.row-1];
//            
//            [self.navigationController pushViewController:productVc animated:YES];
            //}
        }else if (indexPath.section == 1){
            if (indexPath.row ==0) {
//                CMInviteFreindViewController *FriendVc = [[CMInviteFreindViewController alloc] init];
//                FriendVc.isLogin=isLoginStatus;
//                FriendVc.fromAutton=YES;
//                FriendVc.userID=_userID;
//                FriendVc.name=self.userDetaiName;
//                [self.navigationController pushViewController:FriendVc animated:YES];
                [CMGetAddressBook requestAddressBookAuthorization:^{
                    
                }];
        
                [[CMProgressHud sharedCMProgressHud]loadData:self.navigationController.view completion:^{
                    
                    CMContactViewController *proVc = [[CMContactViewController alloc] init];
                    proVc.UserName=[self.NewBankArr.firstObject objectForKey:@"name"];
                    [self.navigationController pushViewController:proVc animated:YES];//请求用户获取通讯录权限
                    [CMUserDefaults  setBool:YES forKey:@"invition"];
                    [self.accountTableView reloadData];
                }];
                
                
                
            } else {
                CMInviteRecordController *InviteRecord = [[CMInviteRecordController alloc] init];
                InviteRecord.realName=[self.NewBankArr.firstObject objectForKey:@"name"];
                [self.navigationController pushViewController:InviteRecord animated:YES];
            }
 
            
        }
        else {
            
            if (indexPath.row ==0) {
                CMMesViewController *mesVc = [[CMMesViewController alloc] init];
                mesVc.block=^{
                    
                    [_accountTableView reloadData];
                    
                };
                [self.navigationController pushViewController:mesVc animated:YES];
            } else {
                CMMoreDetailController *moreVc = [[CMMoreDetailController alloc] init];
                [self.navigationController pushViewController:moreVc animated:YES];
            }
        }
    
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 45;
    }
    return 0.01;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        
        CMTestWealthView  *TestView=[[CMTestWealthView alloc]init];
        TestView.testBlockClick=^{
            CMProductDetailController *productVc = [[CMProductDetailController alloc] init];
            productVc.urlStr=[NSString stringWithFormat:@"%@/Questionnaire/index.aspx",OnLineCode];
            [self.navigationController pushViewController:productVc animated:YES];
        };
        
        return TestView;
        
    }else{
    return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

#pragma mark - 退出登陆
- (void)exitLoginAcconnt
{
     UIAlertView *alertExit = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要退出当前账户吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertExit.tag=99;
    [alertExit show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
        
  
    if (alertView.tag == 100) {
        if (buttonIndex == 0) {
        } else {
            // 结束刷新状态
            [self.accountTableView.mj_header endRefreshing];
        }
        
    }
    if (alertView.tag==99)
    {
        
        if (buttonIndex == 0) { // 点击取消
            
        } else {

//            [CMUserDefaults removeObjectForKey:@"switNo"];
//            [PCCircleViewConst removeGesture:gestureOneSaveKey];
//            [PCCircleViewConst removeGesture:gestureFinalSaveKey];            // 移除密码
           
            [PassWordTool deletePassWord];

            [CMUserDefaults removeObjectForKey:@"YuEr"];
            [CMUserDefaults synchronize];
            
            [CMCookie deleteCookie];
            //self.loginBut.enabled = YES;
            self.accountTopView.userLabl.hidden = YES;
            self.accountTopView.jinShouYiLab.text = @"0.00";
            self.accountTopView.leijiShouyiLab.text  = @"0.00";
            self.accountTopView.zhangYuLab.text = @"0.00";
            self.accountTopView.zongZiLab.text = @"0.00";
            self.accountTopView.vipBtn.hidden = YES;
            
            //退出登录进入首页
           UIWindow *window= [UIApplication sharedApplication].delegate.window;
           window.rootViewController=[[CMTabBarController alloc]init];
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStyleDone target:self action:nil];
            // 清除缓存
            NSString *url=[NSString stringWithFormat:@"%@/handler/AppInterface.ashx?action=quit",OnLineCode];
            [CMHttpTool getWithURL:url params:nil success:^(id responseObj) {
                
            } failure:^(NSError *error) {
                DLog(@"exitLoginAcconntError--%@",error);
            }];
        }
    }
    
    
    if (alertView.tag==101) {
        if (buttonIndex==1) {
        
            CMUserTrueController *productVc = [[CMUserTrueController alloc] init];
            [self.navigationController pushViewController:productVc animated:YES];
            
//            CMProductDetailController *pro=[[CMProductDetailController alloc]init];
//            pro.urlStr=[NSString stringWithFormat:@"%@/icm/acc/addbankcard.aspx",OnLineCode];
//            [self.navigationController pushViewController:pro animated:YES];
        }
    
    
    
    }
}

/*
#pragma mark - 取出用户名密码自动登陆
- (void)loginAuto
{
    // 取出账号、密码
  
    NSString *name = [CMUserDefaults objectForKey:@"name"];
    NSString *password =[PassWordTool readPassWord];
    
    if (name&&password) {
        NSString *urlStr = [NSString stringWithFormat:@"%@/handler/AppInterface.ashx?action=login&mobile=%@&pwd=%@&type=%@&id=%@",OnLineCode,name,password,@"1",[JPUSHService registrationID]];
      //  NSString *urlStr = [NSString stringWithFormat:@"%@/handler/AppInterface.ashx?action=login&mobile=%@&pwd=%@",OnLineCode,name,password];
        [CMHttpTool getWithURL:urlStr params:nil success:^(id responseObj) {
            
            
            NSString *strStatus = [responseObj valueForKey:@"status"];
            
            if ([strStatus isEqualToString:@"200"]) {
                 NSString *userID = [[[responseObj valueForKey:@"userMess"] objectAtIndex:0] valueForKey:@"userID"];
                [CMUserDefaults setObject:userID forKey:@"userID"];
                [CMUserDefaults synchronize];
                [CMCookie getAndSaveCookie];
            }
            
        } failure:^(NSError *error) {
            DLog(@"自动陆失败------%@",error);
        }];
        
    }
}

*/
-(void)LoadAsEarnData{
   
   
    [CMRequestHandle getAsDepositTotalearningsSuccess:^(id responseObj) {
        
        
        if ([[responseObj objectForKey:@"Status"]intValue]==200) {
            
           _EarnModel=[CMAsDespositEarnModel objectWithKeyValues:[responseObj objectForKey:@"t"]];
          
            [self.accountTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            
            
        }
    }];
    
   
    
}

checkNet

@end
