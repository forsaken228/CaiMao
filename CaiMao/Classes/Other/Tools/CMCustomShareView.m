//
//  CMCustomShareView.m
//  CaiMao
//
//  Created by WangWei on 17/3/8.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import "CMCustomShareView.h"
@interface CMCustomShareView ()
@property (strong, nonatomic) UIView *bgView;//分享主view

@property (strong, nonatomic) UIView *shareView;//分享主view

@property (strong, nonatomic) UIButton *cancelBtn;//取消

@end
@implementation CMCustomShareView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addView];
    }
    return self;
}
-(void)addView{
    
    [self addSubview:self.bgView];
    [self addSubview:self.shareView];

    NSArray *titleArr=@[@"QQ好友",@"QQ空间",@"微信好友",@"朋友圈",@"新浪微博"];
    
    float intelval=(CMScreenW-5*f_i5real(60))/6.0;
    for (int i=0;i<titleArr.count; i++) {
        UIImage *image=[UIImage imageNamed:titleArr[i]];
        UIButton *platomBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        platomBtn.frame=CGRectMake(intelval+(i%5)*( f_i5real(60)+ intelval),10, f_i5real(60),  f_i5real(60));
        [platomBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        platomBtn.titleLabel.font= [UIFont systemFontOfSize:12.0];
        platomBtn.titleLabel.textAlignment= NSTextAlignmentCenter;
        [platomBtn setTitleColor:UIColorFromRGB(0x777777)
                        forState:UIControlStateNormal];
       [platomBtn setImageEdgeInsets:UIEdgeInsetsMake(0,f_i5real(10),f_i5real(20),f_i5real(10))];
        [platomBtn setTitleEdgeInsets:UIEdgeInsetsMake(f_i5real(35),-60,0,0)];
        
        
        platomBtn.tag=11+i;
        [platomBtn addTarget:self action:@selector(sharePlatformsClick:) forControlEvents:UIControlEventTouchUpInside];
        [platomBtn setImage:image forState:UIControlStateNormal];
        [self.shareView addSubview:platomBtn];
        
    }
    
    //取消
    [self.shareView addSubview:self.cancelBtn];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.shareView);
        make.bottom.equalTo(self.shareView.mas_bottom).offset(-15);
        make.height.equalTo(@40);
        
    }];
    
}

-(UIView*)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:self.frame];
        _bgView.userInteractionEnabled=YES;
        _bgView.backgroundColor=[UIColor blackColor];
        _bgView.alpha=0.52f;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(remove)];
        
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
    
    
}
//分享的主view
- (UIView *)shareView {
    if (!_shareView) {
        _shareView = [[UIView alloc] init];
        _shareView.backgroundColor =[UIColor whiteColor];
        _shareView.frame = CGRectMake(0, CMScreenH -150, CMScreenW,150);
    }
    return _shareView;
}
- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitleColor:RedButtonColor forState:UIControlStateNormal];
        
        _cancelBtn.titleLabel.font=[UIFont systemFontOfSize:15.0];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}


-(void)sharePlatformsClick:(UIButton*)sender{
    
    switch (sender.tag) {
        case 11:
            [self shareDetail:SSDKPlatformSubTypeQQFriend];
            [self removeFromSuperview];
            break;
        case 12:
           [self shareDetail:SSDKPlatformSubTypeQZone];
            [self removeFromSuperview];
            break;
        case 13:
         [self shareDetail:SSDKPlatformSubTypeWechatSession];
            [self removeFromSuperview];
            break;
        case 14:
            [self shareDetail:SSDKPlatformSubTypeWechatTimeline];
            [self removeFromSuperview];
            break;
        case 15:
            [self shareDetail:SSDKPlatformTypeSinaWeibo];
            [self removeFromSuperview];
            break;
            
        default:
            break;
    }
}



-(void)remove{
    
    [self removeFromSuperview];
}




-(void)shareDetail:(SSDKPlatformType)PlatformType{
    
 
            NSURL *url = [NSURL URLWithString:self.contentUrl];
            
            if (self.ShareImageName) {
                
                NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
                [shareParams SSDKSetupShareParamsByText:self.contentStr
                                                 images:self.ShareImageName
                                                    url:url
                                                  title:self.titleConten
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
                             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败" message:[NSString stringWithFormat:@"%@",[error.userInfo objectForKey:@"error_message"]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                             [alert show];
                             break;
                         }
                         default:
                             break;
                     }
                     
                     
                     
                     
                 }];
                
                
                
            }
    

    
    
}

@end
