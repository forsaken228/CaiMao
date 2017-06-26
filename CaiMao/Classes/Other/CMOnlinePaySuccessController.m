//
//  CMOnlinePaySuccessController.m
//  CaiMao
//
//  Created by MAC on 16/8/3.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMOnlinePaySuccessController.h"

@interface CMOnlinePaySuccessController ()

@end

@implementation CMOnlinePaySuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=ViewBackColor;
    //self.title=@"支付成功";
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"我的账户" style:UIBarButtonItemStylePlain target:self action:@selector(enterIntoMyAccount)];
   
  //  DLog( @"self.ProuctListArr==%@",self.ProuctListArr);
   // self.juHili=[self.ProuctListArr objectForKey:@"jyfs"];
    //self.pid=[self.ProuctListArr objectForKey:@"pid"];
    
  [self creatNewView];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.hidesBackButton=YES;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"home_top_right" higlightedImage:nil target:self action:@selector(backController)];
    
    if (self.type==isChongZhiPaySuccess) {
        self.title=@"充值成功";
self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"充值记录" style:UIBarButtonItemStylePlain target:self action:@selector(enterIntoMyAccount)];
    }else{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"我的账户" style:UIBarButtonItemStylePlain target:self action:@selector(enterIntoMyAccount)];
        self.title=@"支付成功";
        
    }
    
}
-(void)backController{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark 资金记录
-(void)enterIntoMyAccount{
    if (self.type==isChongZhiPaySuccess) {
    CMRecordOfCharge *vc=[[CMRecordOfCharge alloc]init];
     vc.selectIndex=1;
    [self.navigationController pushViewController:vc animated:YES];
    }else{
        
        UIWindow *window=[UIApplication sharedApplication].windows.firstObject;
        CMTabBarController *tab=(CMTabBarController*)window.rootViewController;
            [tab selectTap:3];
        
        NSMutableArray  *arr=[[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
        
    
        [arr removeObjectsInRange:NSMakeRange(1, arr.count - 1)];
        self.navigationController.viewControllers=arr;

    }
    
}
-(void)creatNewView{
   
    switch (self.type) {
        case isProductPaySuccess:
        { //产品支付成功
            
            [self creatDetailViewWithTitle:@"支付成功" andTitleImagehide:NO bottomImageViewHide:NO DetailLabelHide:NO];
            [self statisticalPage:[NSString stringWithFormat:@"%@+%@",self.prTitle,self.title]];
        }
            break;
        case isChongZhiPaySuccess:
        {//充值成功
        
            [self creatDetailViewWithTitle:@"充值成功" andTitleImagehide:YES bottomImageViewHide:NO DetailLabelHide:NO];
            
        }
            break;
        case isSuiXinCunSuccess:
        {//充值成功
            
            [self creatDetailViewWithTitle:@"支付成功" andTitleImagehide:NO bottomImageViewHide:YES DetailLabelHide:YES];
            [self statisticalPage:[NSString stringWithFormat:@"%@+%@",self.prTitle,self.title]];
        }
            break;
            
        default:
            break;
    }
    

    
}
-(void)creatDetailViewWithTitle:(NSString*)title andTitleImagehide:(BOOL)hide bottomImageViewHide:(BOOL)aHide DetailLabelHide:(BOOL)kHide{
    
    CMZhuanTopView *topView=[[CMZhuanTopView alloc]initWithImage:@"转出成功"];
    topView.frame=CGRectMake(0, 8, CMScreenW, 30);
    topView.hidden=hide;
    [self.view addSubview:topView];
    
    UIView *bgView=[[UIView alloc]init];
    bgView.backgroundColor=[UIColor whiteColor];
    bgView.userInteractionEnabled=YES;
    [self.view addSubview:bgView];
    if (self.type==isChongZhiPaySuccess) {
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.left.equalTo(self.view);
            make.top.equalTo(self.view.mas_top).offset(10);
            make.height.equalTo(@250);
            
        }];
    }else{
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.equalTo(self.view);
        make.top.equalTo(topView.mas_bottom).offset(8);
        make.height.equalTo(@250);
        
    }];
    }

    UILabel *success=[[UILabel alloc]init];
    success.text=title;
    success.font=[UIFont systemFontOfSize:20];
    success.textColor=UIColorFromRGB(0xff4804);
    [bgView addSubview:success];
    [success mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.width.equalTo(@100);
        make.top.equalTo(bgView.mas_top).offset(30);
        make.centerX.equalTo(bgView.mas_centerX).offset(20);
    }];
    UIImageView *RightImage=[[UIImageView alloc]init];
    RightImage.image=[UIImage imageNamed:@"zfcg_chengong_icon"];
    RightImage.clipsToBounds=YES;
    RightImage.layer.cornerRadius=24/2.0;
    [bgView addSubview:RightImage];
    [RightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@24);
        
        make.top.equalTo(success.mas_top).offset(-2);
        make.right.equalTo(success.mas_left).offset(-5);
    }];
    
    UILabel *detai=[[UILabel alloc]init];
    detai.text=@"财小猫祝您财源滚滚来";
    detai.font=[UIFont systemFontOfSize:14.0];
    detai.textAlignment=NSTextAlignmentCenter;
    detai.textColor=UIColorFromRGB(0xe5a858);
    [bgView addSubview:detai];
    [detai mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@15);
        make.centerX.equalTo(bgView.mas_centerX);
        make.width.equalTo(bgView.mas_width);
        make.top.equalTo(RightImage.mas_bottom).offset(10);
    }];
    
    
    UILabel *detailLabel=[UILabel new];
    detailLabel.text=@"预定或竞拍成功后,财富账号中的预定或竞拍金额将被冻结。交易成功后自动划转;交易失败,该资金自动解冻。";
    detailLabel.hidden=kHide;
    detailLabel.numberOfLines=0;
    detailLabel.textAlignment=NSTextAlignmentCenter;
    detailLabel.textColor=UIColorFromRGB(0xb2b2b2);
    detailLabel.font=[UIFont systemFontOfSize:14.0];
    [bgView addSubview:detailLabel];
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(detai.mas_bottom).offset(10);
        make.left.equalTo(bgView.mas_left).offset(10);
        make.right.equalTo(bgView.mas_right).offset(-10);
        make.height.equalTo(@40);
    }];
    
    NSArray *imageArr=@[@"zfcg_jxtzi_icon",@"zfcg_cyhd_icon",@"zfcg_ckzh_icon"];
    NSArray *buttontitleArr=@[@"继续投资 >>",@"参与活动>>",@"查看账户>>"];
    NSArray *buttontitleColorArr=@[UIColorFromRGB(0x42cb7d),UIColorFromRGB(0xfea346),UIColorFromRGB(0x6291e9)];
    for (int i=0; i<imageArr.count; i++) {
        UIImage *TImage=[UIImage imageNamed:imageArr[i]];

        float interal =(CMScreenW-(TImage.size.width+50)*3)/4.0;
        UIButton *backTeHuiPage=[UIButton buttonWithType:UIButtonTypeCustom];
        backTeHuiPage.frame=CGRectMake(i%imageArr.count*(TImage.size.width+interal+50)+interal,150, TImage.size.width+50, TImage.size.height+10);
        [backTeHuiPage setTitle:buttontitleArr[i] forState:UIControlStateNormal];
        [backTeHuiPage setTitleColor:buttontitleColorArr[i] forState:UIControlStateNormal];
        
        [backTeHuiPage setImage:TImage forState:UIControlStateNormal];
        backTeHuiPage.tag=i+10;
        backTeHuiPage.titleLabel.font=[UIFont systemFontOfSize:14.0];
        backTeHuiPage.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
        [backTeHuiPage setTitleEdgeInsets:UIEdgeInsetsMake(backTeHuiPage.imageView.frame.size.height+15 ,-backTeHuiPage.imageView.frame.size.width+10, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
        
        [backTeHuiPage setImageEdgeInsets:UIEdgeInsetsMake(-10,20.0,0.0, 0.0)];//图片距离右边框距离减少图片的宽度，其它不边
        [backTeHuiPage addTarget:self action:@selector(backToProductBtnClick:)forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:backTeHuiPage];
        
        
    }
    static  UIImage *iconImage;
    if (self.type==isChongZhiPaySuccess) {
    
        iconImage=[UIImage imageNamed:@"zfcg_cfb"];
        
    }else{
    if ([self.juHili intValue]==1) {
        iconImage=[UIImage imageNamed:@"zfcg_juhaili"];
    }else{
        if ([self.pid intValue]==64590||[self.pid intValue]==64591) {
            
            iconImage=[UIImage imageNamed:@"zfcg_dqbjd"];
        }else{
            iconImage=[UIImage imageNamed:@"zfcg_viphy"];
        }
    }
    }
    UIImageView *iconImageView=[[UIImageView alloc]init];
    iconImageView.image=iconImage;
    iconImageView.hidden=aHide;
    iconImageView.userInteractionEnabled=YES;
    [self.view addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.equalTo(self.view);
        make.top.equalTo(bgView.mas_bottom).offset(20);
        make.height.mas_equalTo(iconImage.size.height+5);
    }];
    
    UITapGestureRecognizer  *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goBuySomething)];
    [iconImageView addGestureRecognizer:tap];
 
    
}
#pragma clang diagnostic ignored"-Wunused-variable"
-(void)backToProductBtnClick:(UIButton*)btn{
    switch (btn.tag) {
        case 10:
        {
            
            UIWindow *window=[UIApplication sharedApplication].windows.firstObject;
            CMTabBarController *tab=(CMTabBarController*)window.rootViewController;
            // tab.selectedIndex=3;
            if (tab.selectedIndex==1) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else{
                

            [tab selectTap:1];
            }
    
            NSMutableArray  *arr=[[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
            for (UIViewController *vc in arr) {
                [arr removeObjectsInRange:NSMakeRange(1, arr.count - 1)];
                break;
            }
            self.navigationController.viewControllers=arr;
        }
            break;
        case 11:
        {
            
            CMProductDetailController *proVc = [[CMProductDetailController alloc] init];
            proVc.urlStr =  Miao18Action;
            [self.navigationController pushViewController:proVc animated:YES];
            
            NSMutableArray  *arr=[[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
            for (UIViewController *vc in arr) {
                [arr removeObjectsInRange:NSMakeRange(1, arr.count -2)];
                break;
            }
            self.navigationController.viewControllers=arr;
        }
            break;
        case 12:{
            if (self.type==isChongZhiPaySuccess) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else{
            UIWindow *window=[UIApplication sharedApplication].windows.firstObject;
            CMTabBarController *tab=(CMTabBarController*)window.rootViewController;

            [tab selectTap:3];
            }
            NSMutableArray  *arr=[[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
            
            
            
            for (UIViewController *vc in arr) {
                [arr removeObjectsInRange:NSMakeRange(1, arr.count - 1)];
                break;
            }
            [CMNSNotice postNotificationName:@"BeginRefresh" object:self];
            
            self.navigationController.viewControllers=arr;
        }
            break;
        default:
            break;
    }

    
}
-(void)dealloc{
    [CMNSNotice removeObserver:self];
}

-(void)goBuySomething{
    if (self.type==isChongZhiPaySuccess) {
        
        CMCaiFuBaoController *proVc = [[CMCaiFuBaoController alloc] init];
      
        [self.navigationController pushViewController:proVc animated:YES];
          NSMutableArray  *arr=[[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
        
        for (UIViewController *vc in arr) {
            [arr removeObjectsInRange:NSMakeRange(1, arr.count -2)];
            break;
        }
        self.navigationController.viewControllers=arr;
        
    }else{
    //if ([self.juHili intValue]==1) {
      //  [self sharkClick];
   // }else{
        
        
        if ([self.pid intValue]==64590||[self.pid intValue]==64591) {
         
            CMDingQiDetailController *proVc = [[CMDingQiDetailController alloc] init];
       
            [self.navigationController pushViewController:proVc animated:YES];
        
            
        }else{
            CMChengzhangController *proVc = [[CMChengzhangController alloc] init];
           // proVc.urlStr = @"http://m.58cm.com/vip/vip_tx.aspx";
            [self.navigationController pushViewController:proVc animated:YES];
           
        }
        NSMutableArray  *arr=[[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
        
        
        
        for (UIViewController *vc in arr) {
            [arr removeObjectsInRange:NSMakeRange(1, arr.count -2)];
            break;
        }
        self.navigationController.viewControllers=arr;
 
   // }
    }
    
}
/*
- (void)sharkClick
{
    
    
    UIWindow *window = [UIApplication  sharedApplication].keyWindow;
    CMCustomShareView   *shareView=[[CMCustomShareView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, CMScreenH)];
    
    [window addSubview:shareView];
    
    
   
    [CMRequestHandle shortUrl:[NSString stringWithFormat:@"%@/tz/lcshow_%@.aspx",OnLineCode,[self.ProuctListArr objectForKey:@"pid"]] andSuccess:^(id responseObj) {
        for (NSDictionary *dict in responseObj) {
            
            
            shareView.contentUrl=[dict objectForKey:@"url_short"];
            
            shareView.titleConten = [self.ProuctListArr objectForKey:@"title"];
            
            shareView.contentStr =[NSString stringWithFormat:@"%@ 年化收益：%@ %%；起点金额：%@元； 特大型担保公司本息担保；基于银行平台的高收益快乐理财！%@",[self.ProuctListArr objectForKey:@"title"],[self.ProuctListArr objectForKey:@"nlv_max"],[self.ProuctListArr objectForKey:@"cpfe"],shareView.contentUrl];
            shareView.ShareImageName= @[[UIImage imageNamed:@"cmshare"]];
            
            
            
           
        }
        
        
    }];

}
*/
@end
