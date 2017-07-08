//
//  CMEverydayRedController.m
//  CaiMao
//
//  Created by MAC on 16/9/10.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMEverydayRedController.h"

@interface CMEverydayRedController ()
{
    NSTimer *timer;

}
@end

@implementation CMEverydayRedController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    self.title=@"天天红包";
 
 
    self.PackageID=[self.redPackageDict objectForKey:@"ID"];
    self.shareMoney=[[self.redPackageDict objectForKey:@"Cash"]intValue]+[[self.redPackageDict objectForKey:@"Ticket"]intValue];
     self.tableView.tableHeaderView=[self TabelHeadView];
    if (!timer) {
        [timer invalidate];
    }
timer = [NSTimer scheduledTimerWithTimeInterval:0.01                                             target: self
                                       selector: @selector(handleTimer)
                                       userInfo: nil
                                        repeats: YES];
    //DLog(@"----我的红包数据--%@---%d",self.redPackageDict,self.shareMoney);
    
    

}

-(void)handleTimer{
    UIImage *image=[UIImage imageNamed:@"ttfx_hongbao"];
    CGRect rect;
    rect=self.MyRedPackage.frame;
    
    rect.origin.y +=7;
   self.MyRedPackage.frame=rect;
    if (rect.origin.y>=35) {
       self.MyRedPackage.frame=CGRectMake(30, 35, CMScreenW-60, image.size.height+60);
        [timer invalidate];
        
    }
    
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}
#pragma mark 界面
-(UIView*)TabelHeadView{
    
    UIImage *BImage=[UIImage imageNamed:@"ttfx_beijingtu"];
    UIImageView *bgmageView=[[UIImageView alloc]init];
    if (CMScreenH==568) {
        bgmageView.frame=CGRectMake(0, 0, CMScreenW, CMScreenH*2);
    }else if(CMScreenH>568){
        
        bgmageView.frame=CGRectMake(0, 0, CMScreenW, CMScreenH*1.7);
        
    }else{
         bgmageView.frame=CGRectMake(0, 0, CMScreenW, CMScreenH*2.5);
        
    }
    
    bgmageView.userInteractionEnabled=YES;
    bgmageView.image=BImage;
    UIImage *image=[UIImage imageNamed:@"ttfx_hongbao"];
    CMRedPackage *package=[[CMRedPackage alloc]init];
    self.MyRedPackage=package;
    package.redMoney.text=[NSString stringWithFormat:@"%d",self.shareMoney];
    CGRect size=[package.redMoney.text boundingRectWithSize:CGSizeMake(130, 45.0) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:45.0]} context:nil];
    package.frame=CGRectMake(30,-500, CMScreenW-60, image.size.height+60);
    [bgmageView addSubview:package];
    [package.redMoney mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(size.size.width+6);
    }];

    
    UIImage *weChatImage=[UIImage imageNamed:@"ttfx_anniu_pengyquan"];
    UIButton *WeChatFriendCircles=[UIButton buttonWithType:UIButtonTypeCustom];
    [WeChatFriendCircles setBackgroundImage:weChatImage forState:UIControlStateNormal];
    WeChatFriendCircles.tag=10;
    [WeChatFriendCircles addTarget:self action:@selector(shareMyRedPackets:) forControlEvents:UIControlEventTouchUpInside];
    
    [bgmageView addSubview:WeChatFriendCircles];
    [WeChatFriendCircles mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weChatImage.size.height+11);
        make.left.equalTo(package.mas_left).offset(-10);
        make.right.equalTo(package.mas_right).offset(10);
        //make.centerX.equalTo(bgmageView);
        make.top.equalTo(bgmageView.mas_top).offset(420);
    }];
    
    
    UIImage *weChatFriendImage=[UIImage imageNamed:@"ttfx_anniu_haoyou"];
    UIButton *WeChatFriend=[UIButton buttonWithType:UIButtonTypeCustom];
    WeChatFriend.tag=11;
    
    [WeChatFriend setBackgroundImage:weChatFriendImage forState:UIControlStateNormal];
    [WeChatFriend addTarget:self action:@selector(shareMyRedPackets:) forControlEvents:UIControlEventTouchUpInside];
    
    [bgmageView addSubview:WeChatFriend];
    
    [WeChatFriend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(WeChatFriendCircles);
        make.top.equalTo(WeChatFriendCircles.mas_bottom).offset(10);
    }];
    
    
    UIImage *JinajieImage=[UIImage imageNamed:@"ttfx_hdgz"];
    UIImageView *jian=[[UIImageView alloc]init];
    jian.image=JinajieImage;
    [bgmageView addSubview:jian];
    [jian mas_makeConstraints:^(MASConstraintMaker *make) {
       make.height.mas_equalTo(JinajieImage.size.height+50);
        make.left.equalTo(WeChatFriend.mas_left).offset(-5);
        make.right.equalTo(WeChatFriend.mas_right).offset(5);
        make.top.equalTo(WeChatFriend.mas_bottom).offset(18);
    }];
    
    return bgmageView;
}

-(void)shareMyRedPackets:(UIButton*)btn{
//self.UserName=@"王伟";
    
    
    
    static NSString *name;
    if (self.UserName.length==2) {
        name=[self.UserName stringByReplacingCharactersInRange:NSMakeRange(0, self.UserName.length-1) withString:@"*"];
    }else if (self.UserName.length==3){
        name=[self.UserName stringByReplacingCharactersInRange:NSMakeRange(0, self.UserName.length-1) withString:@"**"];
        
    }else{
        
        name=[self.UserName stringByReplacingCharactersInRange:NSMakeRange(0, self.UserName.length-1) withString:@"***"];
    }
    
    NSString *titleStr=[NSString stringWithFormat:@"%@给你发了%d元的大礼包,赶紧来抢吧！",name,self.shareMoney];
    
    NSString *contentStr = @"打开即可领取,7日内有效";
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/handler/AppService_EveryDayShare.ashx?Action=3&giftID=%@",redpackageCode,self.PackageID]];
    NSArray *imageArr=@[[UIImage imageNamed:@"redShare"]];

    if (imageArr) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        //分享内容
       [shareParams SSDKSetupShareParamsByText:contentStr  images:imageArr url:url title:titleStr type:SSDKContentTypeAuto];
        
        if (btn.tag==10) { //朋友圈
            DLog(@"//朋友圈");
            
            [ShareSDK share:SSDKPlatformSubTypeWechatTimeline              parameters:shareParams
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
                         DLog(@"---%ld",error.code);
                         if (error.code==208) {
                             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败" message:@"尚未安装微信客户端" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                             [alert show];
                         }else{
                             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败" message:[NSString stringWithFormat:@"%@",error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                             [alert show];
                         }
                         break;
                     }
                     default:
                         break;
                 }
                 
                 
                 
                 
             }];
            
        }else{
             DLog(@"//好友");
                  [ShareSDK share:SSDKPlatformSubTypeWechatSession              parameters:shareParams
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
                         if (error.code==208) {
                             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败" message:@"尚未安装微信客户端" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                             [alert show];
                         }else{
                             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败" message:[NSString stringWithFormat:@"%@",error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                             [alert show];
                         }
                         break;
                     }
                     default:
                         break;
                 }
             }];
                 }
    }
}
//-(void)UpdateToLineAboutMsg{
//   
//    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_CFB.ashx?Action=3",OnLineCode];
//    
//   // NSDictionary *dict=@{@"HYID":self.,@"PageIndex":page};
// 
//    [CMHttpTool postWithURL:url params:nil success:^(id responseObj) {
//        NSLog(@"转出记录==%@",responseObj);
//       
//     
//              } failure:^(NSError *error) {
//        
//            }];
//    
//   
//    
//}

@end
