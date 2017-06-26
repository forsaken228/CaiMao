//
//  CMHomeViewController.m
//  CaiMao
//
//  Created by Fengpj on 14-12-12.
//  Copyright (c) 2014年 58cm. All rights reserved.
//

#import "CMHomeViewController.h"
#import "CMCaiFuBaoView.h"
#import "CMOnlinePaySuccessController.h"
#import "CMProductsRecommendedView.h"
#import "CMMainProductView.h"
@interface CMHomeViewController ()<UIScrollViewDelegate,CMMainProductView,CMHomeDingQiViewDelegate,CMHomeNewActionViewDelegate>
{

    NSArray *dingArr;
}

/*******************财富宝View**************************/
@property (strong, nonatomic)  CMCaiFuBaoView *caifuView;
/*******************定期宝头部View**************************/
@property (strong, nonatomic)  CMHomeDingQiView *dingqiTopView;
/*******************产品View**************************/
@property (strong, nonatomic)  UIView *productView;
/*******************背部滑动scrollView**************************/
@property (strong, nonatomic)  UIScrollView *bgScrollView;
/*******************精品推荐View**************************/
@property(strong,nonatomic)CMProductsRecommendedView *RecommendedView;
/*******************动态View**************************/
@property (strong, nonatomic) CMHomeNewActionView *zuixinView;
/*******************四格View**************************/
@property (strong, nonatomic) CMMainProductView *MainProductView;
/*******************bar资源图片数组**************************/
@property (strong, nonatomic)  NSMutableArray *sourceArray;
/*******************bar资源链接数组**************************/
@property (strong, nonatomic)  NSMutableArray *bannerURLArray;

/*******************随心存**************************/
@property (strong, nonatomic)  CMAsDepositView *AsDepositView;


@end

@implementation CMHomeViewController

//
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self)
//    {
//        
//     //  [CMNSNotice addObserver:self selector:@selector(isfirstLaunce) name:@"isfirstLauce" object:nil];
//
//    }
//    return self;
//}


#pragma mark ViewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=ViewBackColor;

    if ([CMUserDefaults  objectForKey:@"isfirstLauce"]!=nil) {
        if (![CMRequestManager islogin]) {
             [self isfirstLaunce];
           
        }
     [CMUserDefaults removeObjectForKey:@"isfirstLauce"];
    }
  
    [self setUpNavigation];
    [CMNSNotice addObserver:self selector:@selector(backLoginVc) name:@"homeLoginVc" object:nil];
    [CMNSNotice addObserver:self selector:@selector(clickAD) name:@"clickAD" object:nil];
   
    self.bgScrollView=[[UIScrollView alloc]init];
    self.bgScrollView.frame=CGRectMake(0, 0, CMScreenW, CMScreenH);
    self.bgScrollView.backgroundColor=ViewBackColor;
    self.bgScrollView.showsVerticalScrollIndicator=NO;
    [self.view addSubview: self.bgScrollView];
    
   
    [self.bgScrollView addSubview:self.MainProductView];
    
    self.productView=[[UIView alloc]init];
    self.productView.backgroundColor=ViewBackColor;
    self.productView.frame = CGRectMake(0,CGRectGetMaxY(self.MainProductView.frame), CMScreenW,f_i5real(930+200));
    [self.bgScrollView addSubview:self.productView];
 
    [self setUpUI];
  //  [self loadData];
    self.bgScrollView.mj_header = [CMRefreshHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    
   

}


-(void)isfirstLaunce{
    
    CMLoginController *loginVc = [[CMLoginController alloc] init];
   // self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:loginVc animated:NO];
    //self.hidesBottomBarWhenPushed=NO;
  
}

-(void)loadData{
    
    [self loadBannerData];
    [self loadDingData];
    [self loadZuiXinDongTaiData];
    
    if ([CMRequestManager islogin]) {
        [self accountIsLostExpaire];
        [self getBankList];
    }
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
 
    [self loadData];
    self.AsDepositView.productSlider.realValue=30;

    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [CMNSNotice addObserver:self selector:@selector(showAccountMess) name:@"renzhengSuccess" object:nil];
    [CMNSNotice addObserver:self selector:@selector(refrestData) name:@"MesToHome" object:nil];
    
    if (CMScreenH<=568) {
        [self.bgScrollView setContentSize:CGSizeMake(CMScreenW,CGRectGetMaxY(self.MainProductView.frame)+f_i5real(1100+190))];
    } else {
        [self.bgScrollView setContentSize:CGSizeMake(CMScreenW,CGRectGetMaxY(self.MainProductView.frame)+f_i5real(930+190))];
    }
    
}


- (void)showAccountMess
{
    [self getBankList];
}

#pragma mark Lazy
-(NSArray*)NewBankArr{
    if (!_NewBankArr) {
        _NewBankArr=[NSArray array];
    }
    return _NewBankArr;
}

-(NSMutableArray*)sourceArray{
    if (!_sourceArray) {
        _sourceArray=[NSMutableArray arrayWithCapacity:0];
    }
    return _sourceArray;
}
-(NSMutableArray*)bannerURLArray{
    if (!_bannerURLArray) {
        _bannerURLArray=[NSMutableArray array];
    }
    return _bannerURLArray;
}


-(CMMainProductView*)MainProductView{
    if (!_MainProductView) {
        _MainProductView=[[CMMainProductView alloc]initWithFrame:CGRectMake(0, f_i5real(150), CMScreenW, f_i5real(150))];
        _MainProductView.delegate=self;
    }
    return _MainProductView;
}
#pragma mark 设置导航
-(void)setUpNavigation{
    
    self.title=@"";
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.navigationItem.hidesBackButton=YES;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"home_top_right" higlightedImage:nil target:self action:@selector(goAllService)];
    UIImage *image= [[UIImage imageNamed:@"home_top_logo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *left =[[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.leftBarButtonItem=left;
    
}

#pragma mark  点击了广告
-(void)clickAD{
 
    [CMGetAddressBook requestAddressBookAuthorization:^{
        
    }];
    CMContactViewController *proVc = [[CMContactViewController alloc] init];
    proVc.UserName=self.UserRealName;
    [self.navigationController pushViewController:proVc animated:YES];//请求用户获取通讯录权限
}
#pragma mark账户是否失效
-(void)accountIsLostExpaire{
 
        NSDate*expiresTime =[CMUserDefaults objectForKey:@"expires_in"];
    
        if (expiresTime) {
            NSDate*currentDate = [NSDate date];
            NSCalendar*calendar = [NSCalendar currentCalendar];
            
            //计算两个日期的差值
            
            NSDateComponents *cmps= [calendar components:NSCalendarUnitDay fromDate:expiresTime toDate:currentDate options:0];
            NSInteger date=[cmps day];
            if (date>=3) {
                [CMUserDefaults removeObjectForKey:@"password"];
                //isLoginStatus=NO;
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"财猫网提示" message:@"账户登录失效,请重新登录!"delegate:self  cancelButtonTitle:@"重新登录"                                                      otherButtonTitles:nil, nil];
                alert.tag=105;
                
                [alert show];
                
                
            }        }
    
   
//    NSDate *saveTime=[CMUserDefaults objectForKey:@"saveUserMessager"];
//    if (saveTime) {
//        NSDate*currentDate = [NSDate date];
//        NSCalendar*calendar = [NSCalendar currentCalendar];
//        
//        //计算两个日期的差值
//        
//        NSDateComponents *cmps= [calendar components:NSCalendarUnitDay fromDate:expiresTime toDate:currentDate options:0];
//        NSInteger date=[cmps day];
//        if (date>=10) {
//           [CMUserDefaults removeObjectForKey:@"password"];
//           [CMUserDefaults removeObjectForKey:@"gestureFinalSaveKey"];
//            [[NSFileManager defaultManager]removeItemAtPath:[CMCache getFilePath:[NSString stringWithFormat:@"%@passWord.plist",[CMUserDefaults objectForKey:@"name"]]] error:nil];
//            
//        }
//    }
    
}

-(void)backLoginVc{
        CMLoginController *loginVc = [[CMLoginController alloc] init];
        [self.navigationController pushViewController:loginVc animated:NO];
}


#pragma mark 更新UI
- (void)setUpUI
{
   
    //明星产品
    [self hotTuiJian];
    //随心存
    [self CreatAsDepositView];
    //财富宝
    [self CaiFuBaoView];
    // 定期宝View
    [self dingqiBaoTitleView];
    //人气
    [self renQiProduct];
    [self ZuXinView];
    [self bottomViewCreat];

    
}
#pragma mark 明星产品
-(void)hotTuiJian{
    
    UIView *hLine=[[UIView alloc]init];
    hLine.backgroundColor=UIColorFromRGB(0xff7500);
    [self.productView addSubview:hLine];
    [hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.width.equalTo(@2);
        make.left.equalTo(self.productView.mas_left).offset(10);
        make.top.equalTo(self.productView.mas_top).offset(10);
    }];
    UILabel *HTitle=[[UILabel alloc]init];
    HTitle.text=@"明星产品";
    HTitle.font=[UIFont systemFontOfSize:15.0];
    HTitle.textColor=UIColorFromRGB(0x818181);
    [self.productView addSubview:HTitle];
    [HTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.width.equalTo(@95);
        make.top.equalTo(self.productView.mas_top).offset(10);
        make.left.equalTo(hLine.mas_left).offset(10);
    }];
    
    
    
}
#pragma mark 随心存
-(void)CreatAsDepositView{
    
    self.AsDepositView=[[CMAsDepositView alloc]initWithFrame:CGRectMake(0, 40, CMScreenW, 200)];
    [self.AsDepositView.depositBtn addTarget:self action:@selector(depositBtnClickEvent) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(depositBtnClickEvent)];
    [self.AsDepositView addGestureRecognizer:tap];
    [self.productView addSubview:self.AsDepositView];
    
}
#pragma mark 财富宝
-(void)CaiFuBaoView{
    self.caifuView=[[CMCaiFuBaoView alloc]init];
    self.caifuView.frame=CGRectMake(0, CGRectGetMaxY(self.AsDepositView.frame)+10, CMScreenW, 135);
    self.caifuView.InPutText.delegate=self;
    [self.caifuView.caiFubaoDetailBtn addTarget:self action:@selector(goCaiFuBao) forControlEvents:UIControlEventTouchUpInside];
    [ self.caifuView.joinBtnClick addTarget:self action:@selector(caiFuBaoSaveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.productView addSubview:self.caifuView];
    
    
}
#pragma mark 随心存存入
-(void)depositBtnClickEvent{
   
    CMAsDepositController *vc=[[CMAsDepositController alloc]init];
    vc.realVaule=self.AsDepositView.selectVaule;
    CMPush(vc);
     
    
}

#pragma mark - 财富宝立即存入
- (void)caiFuBaoSaveBtnClick
{
  

    if (![CMRequestManager islogin]) {
        CMLoginController *loginVc = [[CMLoginController alloc] init];
        [self.navigationController pushViewController:loginVc animated:NO];
    } else {
        

        CMZhuangRuCFBController *loginVc = [[CMZhuangRuCFBController alloc] init];
        loginVc.isFromHome=YES;
        loginVc.productCount=[NSString stringWithFormat:@"%@",self.caifuView.InPutText.text];
        
        CMPush(loginVc);
        
    }
  

}

#pragma mark 财富宝进入
-(void)goCaiFuBao{
    
   
    
    CMCaiFuBaoController *cfVc = [[CMCaiFuBaoController alloc] init];
    [self.navigationController pushViewController:cfVc animated:YES];
}

#pragma mark 更多进入
-(void)goAllService{
    CMServiceController *serVc = [[CMServiceController alloc] init];
   
    [self.navigationController pushViewController:serVc animated:YES];
    
}
#pragma mark - 加载Banner数据
- (void)loadBannerData
{
    if (![self checkNetWork]) {
        [self.bgScrollView.mj_header endRefreshing];
        
    }
    [CMRequestHandle GetHomeBarImagesAdsSuccess:^(id responseObj) {
        [self.bgScrollView.mj_header endRefreshing];
        [self.sourceArray  removeAllObjects];
        [self.bannerURLArray removeAllObjects];
        NSArray *imgArr = [responseObj valueForKey:@"result"];
        //DLog(@"imgArr+++%@",imgArr);
        // 遍历数组取出图片的url地址
        for (NSString *adUrl in imgArr) {
            [self.sourceArray addObject:[adUrl valueForKey:@"adUrl"]];
        }
        // 遍历数组取出图片的链接url地址
        for (NSString *linkUrl in imgArr) {
            [self.bannerURLArray addObject:[linkUrl valueForKey:@"linkUrl"]];
        }
        [self addBannerImages];
        [self.bgScrollView.mj_header endRefreshing];
    } andFailure:^(id error) {
        
        [self.bgScrollView.mj_header endRefreshing];
        
    }];
    }

#pragma mark - 加载最新动态数据
- (void)loadZuiXinDongTaiData
{
    if (![self checkNetWork]) {
        [self.bgScrollView.mj_header endRefreshing];
        
    }
    [CMRequestHandle GetHomeNewActionsSuccess:^(id responseObj) {
        
        if ([[responseObj objectForKey:@"status"]intValue]==200) {
            
        [self.bgScrollView.mj_header endRefreshing];
   //     DLog(@"++++%@",responseObj);
        NSArray *dongArr = [responseObj valueForKey:@"result"];
            self.zuixinView.responseArr=dongArr;

        }
             
        
    }andFailure:^(id error) {
        
        [self.bgScrollView.mj_header endRefreshing];
        
    }];


}


#pragma mark banner广告
- (void)addBannerImages
{
    FFScrollView *scroll = [[FFScrollView alloc] initPageViewWithFrame:CGRectMake(0, 0, CMScreenW, f_i5real(140)) views:self.sourceArray];
    
   // scroll.pageViewDelegate = self;
    [self.bgScrollView addSubview:scroll];
    
    scroll.scrollViewDidClickedBlock=^(NSInteger  pageNumber){
        
        CMProductDetailController *proVc = [[CMProductDetailController alloc] init];
        
        proVc.urlStr = [self.bannerURLArray objectAtIndex:pageNumber];
        
        [self.navigationController pushViewController:proVc animated:YES];
  
    };
   
}


/*
#pragma mark - 取出用户名密码自动登陆
- (void)loginAuto
{
    // 取出账号、密码
    if (![self checkNetWork]) {
        [self.bgScrollView.mj_header endRefreshing];
        
    }
    NSString *name = [CMUserDefaults objectForKey:@"name"];
    NSString *password = [PassWordTool readPassWord];
    
    if (name&&password) {
        
        NSString *urlStr = [NSString stringWithFormat:@"%@/handler/AppInterface.ashx?action=login&mobile=%@&pwd=%@&type=%@&id=%@",OnLineCode,name,password,@"1",[JPUSHService registrationID]];
     
        [CMHttpTool getWithURL:urlStr params:nil success:^(id responseObj) {
          //  DLog(@"登录---%@",responseObj);
            
           
               [self.bgScrollView.mj_header endRefreshing];
            NSString *strStatus = [responseObj valueForKey:@"status"];
            
            //NSString *userID = [[[responseObj valueForKey:@"userMess"] objectAtIndex:0] valueForKey:@"userID"];
            
            if ([strStatus isEqualToString:@"200"]) {
                //isLoginStatus=YES;
                [CMCookie getAndSaveCookie];
            }
            
        } failure:^(NSError *error) {
            DLog(@"自动陆失败------%@",error);
            NSString *url=[NSString stringWithFormat:@"%@/handler/AppInterface.ashx?action=quit",OnLineCode];
            [PassWordTool deletePassWord];
            [CMHttpTool getWithURL:url params:nil success:^(id responseObj) {
                //isLoginStatus=NO;
                 [CMCookie deleteCookie];
            } failure:^(NSError *error) {
                [self.bgScrollView.mj_header endRefreshing];
                DLog(@"exitLoginAcconntError--%@",error);
            }];
            
        }];

            
       
        
    }
}
 */
-(void)refrestData{
    [self loadData];
 
}

#pragma mark 新客专享 邀请好友

-(void)collectViewDidSelect:(NSIndexPath *)indexpath{
    switch (indexpath.row) {
        case 0:
        {
            CMXinKeController *proVc = [[CMXinKeController alloc] init];
            [self.navigationController pushViewController:proVc animated:YES];
        }
            break;
        case 1:
        {
            [[CMProgressHud sharedCMProgressHud]LoadProgress:self.navigationController.view  WithMessage:@"正在努力加载中..." ];
            [CMGetAddressBook requestAddressBookAuthorization:^{
                
            }];
            CMContactViewController *proVc = [[CMContactViewController alloc] init];
            proVc.UserName=self.UserRealName;
            [self.navigationController pushViewController:proVc animated:YES];//请求用户获取通讯录权限
            [[CMProgressHud sharedCMProgressHud]removeProgressHUD];

        }
            break;
        case 2:
        {
            CMJuHaiLiController *juVc = [[CMJuHaiLiController alloc] init];
            [self.navigationController pushViewController:juVc animated:YES];

        }
            break;
        case 3:
        {
            
            if([CMRequestManager islogin]){ //判断是否登录
                [[CMProgressHud sharedCMProgressHud]LoadProgress:self.navigationController.view  WithMessage:@"正在努力加载中..." ];
                NSDictionary *dic=[self.NewBankArr firstObject];
                //DLog(@"renzheng===%@",self.NewBankArr);
                self.UserRealName=[dic objectForKey:@"name"];
                NSDictionary  *BankData=[dic objectForKey:@"BankData"];
                if (self.NewBankArr!=nil && ![self.NewBankArr isKindOfClass:[NSNull class]] && self.NewBankArr.count!=0){
                    
                    if (BankData.allValues.count==0&&BankData.allKeys.count==0) {
                        [[CMProgressHud sharedCMProgressHud]removeProgressHUD];
                        //银行卡认证
                        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您还没开通银行卡认证支付,请选择常用银行卡认证！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"认证", nil];
                        alert.tag=102;
                        [alert show];
                        
                    }else{
                        
                        
                        NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_EveryDayShare.ashx?Action=1",redpackageCode];
                        
                        NSDictionary *dict=@{@"HYID":[CMUserDefaults objectForKey:@"userID"]};
                        [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
                            // DLog(@"我的红包===%@==%@",responseObj,[responseObj objectForKey:@"Result"]);
                            if ([[responseObj objectForKey:@"Status"]intValue]==200) {
                                
                                [[CMProgressHud sharedCMProgressHud]removeProgressHUD];
                                CMEverydayRedController *juVc = [[CMEverydayRedController alloc] init];
                                juVc.redPackageDict=[responseObj objectForKey:@"t"];
                                juVc.UserName=self.UserRealName;
                                [self.navigationController pushViewController:juVc animated:YES];
                            }
                            
                            
                            
                        } failure:^(NSError *error) {
                            
                            [self.bgScrollView.mj_header endRefreshing];
                            
                        }];
                        
                        
                    }
                    
                    
                }
            }else{
                CMLoginController *LoginVc=[[CMLoginController alloc]init];
                [self.navigationController pushViewController:LoginVc animated:NO];
                
            }
            
            

            
        }
            break;
            
        default:
            break;
    }
    
}

#pragma mark 定期宝View
-(void)dingqiBaoTitleView{
    self.dingqiTopView=[[CMHomeDingQiView alloc]init];
    self.dingqiTopView.delegate=self;
    [self.productView addSubview:self.dingqiTopView];
     [self.dingqiTopView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(self.caifuView.mas_bottom).offset(10);
         make.width.left.equalTo(self.productView);
         make.height.equalTo(@265);
     }] ;

}

#pragma mark加载定期产品
-(void)loadDingData{
    if (![self checkNetWork]) {
        [self.bgScrollView.mj_header endRefreshing];
        
    }
    
    [CMRequestHandle GetDingQiBaoProductMsgSuccess:^(id responseObj) {
        [self.bgScrollView.mj_header endRefreshing];
        if ([[responseObj objectForKey:@"status"]intValue]==200) {
            dingArr = [[responseObj  valueForKey:@"data"] valueForKey:@"list"];
            self.dingqiTopView.DingQiBaoList=[CMDingQiBaoList objectArrayWithKeyValuesArray:dingArr];
        }
        
    }andFailure:^(id error) {
        
        [self.bgScrollView.mj_header endRefreshing];
        
    }];
   
    
    
}



#pragma mark 点击定期宝产品进入详情页
-(void)DingQiBaoEnterProductDetailControllerWithPageIndex:(NSInteger)pageIndex{
    CMLiCaiDetailController *vc=[[CMLiCaiDetailController alloc]init];
    
    vc.productListArr=[dingArr objectAtIndex:pageIndex];
    [self.navigationController pushViewController:vc animated:YES];

}
-(void)DingQiBaoEnterPayControllerWithPageIndex:(NSInteger)pageIndex{
    CMPayViewController *vc=[[CMPayViewController alloc]init];
    vc.ProuctListArr=[dingArr objectAtIndex:pageIndex];
    vc.countNum=1;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)enterDingQibaoProductController{
    CMDingQiDetailController *dqVc = [[CMDingQiDetailController alloc] init];
    [self.navigationController pushViewController:dqVc animated:YES];
    
}
#pragma mark 精品推荐
-(void)renQiProduct{
    self.RecommendedView=[[CMProductsRecommendedView alloc]init];
    [self.productView addSubview:self.RecommendedView];
    [self.RecommendedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@130);
        make.width.left.equalTo(self.productView);
        make.top.equalTo(self.dingqiTopView.mas_bottom);
        
    }];
    
    __weak typeof(self) weakSelf=self;
    self.RecommendedView.CMProductsRecommendedBlock = ^(NSInteger index) {
        switch (index) {
            case 20:
            {
                CMJuHaiLiController *juVc = [[CMJuHaiLiController alloc] init];
                [weakSelf.navigationController pushViewController:juVc animated:YES];
            }
                break;
            case 21:
            {
                CMMiaoShaController *miaoVc = [[CMMiaoShaController alloc] init];
                [weakSelf.navigationController pushViewController:miaoVc animated:YES];
                
            }
                break;
            case 22:
            {
                CMYueXiYingDetailController *yxyVc = [[CMYueXiYingDetailController alloc] init];
                [weakSelf.navigationController pushViewController:yxyVc animated:YES];
                
            }
                break;
            case 23:
                //        {
                //
                //       CMYinPiaoDetailController *yinVc = [[CMYinPiaoDetailController alloc] init];
                //    [self.navigationController pushViewController:yinVc animated:YES];
                //
                //        }
                //            break;
            {
         
                CMProductDetailController *proVc = [[CMProductDetailController alloc] init];
                
                proVc.urlStr = Miao18Action;
                
                [weakSelf.navigationController pushViewController:proVc animated:YES];
                
            }
                break;
            case 24:
                
            {
                CMProductDetailController *proVc = [[CMProductDetailController alloc] init];
                proVc.urlStr=[NSString stringWithFormat:@"%@/activity/queen/index.aspx",OnLineCode];
                [weakSelf.navigationController pushViewController:proVc animated:YES];
                
            }
                break;
                
            default:
                break;
        }

    };
 
}
#pragma mark bottomView
-(void)bottomViewCreat{
    CMHomeBottomView  *homeBottom=[[CMHomeBottomView  alloc]init];
    [self.productView addSubview:homeBottom];
    
    [homeBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@105);
        make.width.left.equalTo(self.productView);
        make.top.equalTo(self.zuixinView.mas_bottom).offset(10);
    }];
    
    homeBottom.bottomBlock=^(NSInteger tag){
        NSArray *urlArr=@[@"http://m.58cm.com/exten/Platform-2.aspx",@"http://m.58cm.com/exten/Platform-3.aspx",@"http://m.58cm.com/exten/Platform-4.aspx"];
        CMProductDetailController *proVc = [[CMProductDetailController alloc] init];
        proVc.urlStr=urlArr[tag-10];
        [self.navigationController pushViewController:proVc animated:YES];
    };
}
#pragma mark 最新动态
-(void)ZuXinView{
    self.zuixinView=[[CMHomeNewActionView alloc]init];
    self.zuixinView.delegate=self;
    [self.productView addSubview:self.zuixinView];
    [self.zuixinView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.productView);
        make.top.equalTo(self.RecommendedView.mas_bottom).offset(10);
        make.height.equalTo(@265);
    }];


    
}
#pragma mark 最新动态点击事件
-(void)enterNewActionController{
    
    CMNoticeViewController* vc=[[CMNoticeViewController alloc]init];
    CMPush(vc);
}
-(void)enterProductWebController:(NSString *)url{
    CMProductDetailController *proVc = [[CMProductDetailController alloc] init];
    
    proVc.urlStr = url;
    
    [self.navigationController pushViewController:proVc animated:YES];
}
-(void)PicActionEnterProductWebController:(NSString *)url{
    CMProductDetailController *proVc = [[CMProductDetailController alloc] init];
    
    proVc.urlStr = url;
    
    [self.navigationController pushViewController:proVc animated:YES];
}
checkNet
#pragma mark请求是否认证数据

-(void)getBankList{
   [CMRequestHandle requestBankListMsgsuccess:^(id responseObj) {
      // DLog(@"++++_____%@+++",responseObj);
       if ([[responseObj objectForKey:@"status"]intValue]==200) {
           
           self.NewBankArr=[responseObj objectForKey:@"result"];
           NSDictionary *dic=[self.NewBankArr firstObject];
           self.UserRealName=[dic objectForKey:@"name"];
           
       }
       
 
   } andFailure:^(id error) {
       [self.bgScrollView.mj_header endRefreshing];
   }];
  
 }
#pragma mark alertView协议方法
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag==102){
        if (buttonIndex==1) {
           CMUserTrueController *productVc = [[CMUserTrueController alloc] init];
          [self.navigationController pushViewController:productVc animated:YES];
          
        }
        
    }else if (alertView.tag==105){
        if (buttonIndex==0) {
            [self exitApp];
        }
    }
    
}
-(void)exitApp{
    
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppInterface.ashx?action=quit",OnLineCode];
    [PassWordTool deletePassWord];
    [CMCookie deleteCookie];
    [CMHttpTool getWithURL:url params:nil success:^(id responseObj) {
        [self.bgScrollView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.bgScrollView.mj_header endRefreshing];
        DLog(@"exitLoginAcconntError--%@",error);
    }];
    
    CMLoginController *loginVc = [[CMLoginController alloc] init];
    [self.navigationController pushViewController:loginVc animated:NO];
    
}
#pragma mark 只能输入整数
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
   
        return [NSString validateNumber:string];

    
}
- (void)dealloc
{
    
    [CMNSNotice removeObserver:self];
    
}


ReceiveMemoryWarning
@end
