//
//  CMInviteFreindViewController.m
//  CaiMao
//
//  Created by MAC on 16/8/12.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMInviteFreindViewController.h"
#import "CMShareView.h"
@interface CMInviteFreindViewController ()<CMShareViewDelegate>
{
    UIButton *CancleBtn;
    CMShareView *shareView;
}
@end

@implementation CMInviteFreindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"邀请有礼";
    
     //   self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"tehui_top_fenxiang" higlightedImage:nil target:self action:@selector(goshareClick)];
    
    // Do any additional setup after loading the view.
    UIScrollView *bgScrollView=[[UIScrollView alloc]init];
    bgScrollView.frame=CGRectMake(0, 0, CMScreenW, CMScreenH);
    
    //bgScrollView.contentSize=CGSizeMake(CMScreenW, CMScreenH);
    bgScrollView.showsVerticalScrollIndicator=NO;
    bgScrollView.showsHorizontalScrollIndicator=NO;
    
    [self.view addSubview:bgScrollView];
    
    UIImage *BImage=[UIImage imageNamed:@"YaoQingFriend.jpg"];
    UIImageView *bgmageView=[[UIImageView alloc]initWithFrame:bgScrollView.frame];
    bgmageView.userInteractionEnabled=YES;
    bgmageView.image=BImage;
    [bgScrollView addSubview:bgmageView];
    bgScrollView.contentSize=CGSizeMake(CMScreenW,CMScreenH+50);
    CancleBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    [CancleBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [CancleBtn setBackgroundColor:[UIColor clearColor]];
    [bgmageView addSubview:CancleBtn];
    [CancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.height.equalTo(@45);
                    make.left.equalTo(bgmageView.mas_left);
                    make.right.equalTo(bgmageView.mas_right);
                    make.centerY.equalTo(bgmageView.mas_centerY).offset(-60);
        
                }];
    
    
//    self.navigationItem.hidesBackButton=YES;
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"nav_back_btn" higlightedImage:nil target:self action:@selector(backBtnClick)];
//    
}

-(void)goshareClick{
    
    if ([CMRequestManager islogin]) {
        
       // [self sharkClick ];
    }else{
        
        CMLoginController *vc=[[CMLoginController alloc]init];
        [self.navigationController pushViewController:vc animated:NO];
    }
}
-(void)btnClick{
    DLog(@"---点击");
    /*
    if ([CMRequestManager islogin]) {
        
        [self yaoqingFriend ];
    }else{
        
        CMLoginController *vc=[[CMLoginController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
   */
//    if ([CMRequestManager islogin]) {
    
         [self initshareView];
        
//            }else{
//        
//        CMLoginController *vc=[[CMLoginController alloc]init];
//        [self.navigationController pushViewController:vc animated:NO];
//    }
//    
   
}
-(void)initshareView{
    UIWindow *window = [UIApplication  sharedApplication].keyWindow;
    shareView=[[CMShareView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, CMScreenH)];
    shareView.delegate=self;
    [window addSubview:shareView];

}

-(void)shareViewShareType:(CMShareViewType)type{
    switch (type) {
        case CMShareViewTypeSms:{
            //去通讯录
            [CMGetAddressBook requestAddressBookAuthorization:^{
            
            }];
            [shareView removeFromSuperview];
            [[CMProgressHud sharedCMProgressHud]loadData:self.
             navigationController.view completion:^{
                CMContactViewController *proVc = [[CMContactViewController alloc] init];
                proVc.UserName=self.name;
                [self.navigationController pushViewController:proVc animated:YES];//请求用户获取通讯录权限
                
            }];

        }
            break;
        case CMShareViewTypeQQ:
            //去QQ
            [self shareDetail:SSDKPlatformSubTypeQQFriend];
            break;
        case CMShareViewTypeQzone:
            //去QQ空间
            [self shareDetail:SSDKPlatformSubTypeQZone];
            break;
        case CMShareViewTypeWechat:
            //去微信好友
            [self shareDetail:SSDKPlatformSubTypeWechatSession];
            break;
        case CMShareViewTypeFriends:
            //去朋友圈
            [self shareDetail:SSDKPlatformSubTypeWechatTimeline];
            break;
        case CMShareViewTypeWebo:
            //去微博
            [self shareDetail:SSDKPlatformTypeSinaWeibo];
            break;
            
        default:
            break;
    }
    
    
}

-(void)shareDetail:(SSDKPlatformType)PlatformType{
   
    [CMRequestHandle shortUrl:[NSString stringWithFormat:@"%@//FriendRegist-@.aspx",OnLineCode,[CMUserDefaults objectForKey:@"userID"]] andSuccess:^(id responseObj) {
        for (NSDictionary *dict in responseObj) {
            NSString *shortUrl=[dict objectForKey:@"url_short"];
            NSString *title=@"送你80元现金,不领就过期了【财猫网】";
            NSURL *url = [NSURL URLWithString:shortUrl];
            
            NSString *contentStr =[NSString stringWithFormat:@"朋友送你80元现金,有便宜不占,天理不容的赔本儿买卖啊！%@",url];
            NSArray *imageArray = @[[UIImage imageNamed:@"cmshare"]];
            if (imageArray) {
                NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
                [shareParams SSDKSetupShareParamsByText:contentStr
                                                 images:imageArray
                                                    url:url
                                                  title:title
                                                   type:SSDKContentTypeAuto];
                [ShareSDK share:PlatformType parameters:shareParams
                 onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                     
                     switch (state) {
                         case SSDKResponseStateSuccess:
                         {
                             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                             [alertView show];
                             break;
                         }
                         case SSDKResponseStateFail:
                         {
                                                    
                             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败" message:[NSString stringWithFormat:@"%@",error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                             [alert show];
                             break;
                         }
                         default:
                             break;
                     }
                     
                     
                     
                     
                 }];
                
                
                
            }
        }
    }];
  
    
}

/*
-(void)yaoqingFriend{
    NSString *title=@"送你80元现金红包，不领就过期了_财猫网";
     NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://dwz.cn/4kXulc%@.aspx",self.userID]];
    NSString *contentStr =[NSString stringWithFormat:@"朋友送你80元现金红包，有便宜不占，天理不容的赔本儿买卖啊！%@",url];
    [self shareSdkTitie:title andContentTitle:contentStr andUrl:url];

    
   }
 
#pragma mark - 分享
- (void)sharkClick
{
    
    NSString *titleStr =[NSString stringWithFormat: @"邀请好友来赚钱【财猫网】"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/invite/InvitationWithPolite.aspx",OnLineCode]];
     NSString *contentStr =[NSString stringWithFormat:@"邀请好友返现金,实时到账,杜绝磨叽!%@",url];
    //创建分享参数
    NSArray *imageArray = @[[UIImage imageNamed:@"cmshare"]];
    if (imageArray) {
        
 
//[NSString shareParamesByText:contentStr andImages:imageArray andUrl:url andTitle:titleStr];
      }
    
 }

*/


@end
