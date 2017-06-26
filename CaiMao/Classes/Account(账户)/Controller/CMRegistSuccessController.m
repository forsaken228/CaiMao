//
//  CMRegistSuccessController.m
//  CaiMao
//
//  Created by MAC on 16/8/29.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMRegistSuccessController.h"

@interface CMRegistSuccessController ()

@end

@implementation CMRegistSuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=ViewBackColor;
    

    [self creatNewView];
    self.navigationItem.hidesBackButton=YES;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"nav_back_btn" higlightedImage:nil target:self action:@selector(backBtnClick)];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.type==isReZhengSuccess) {
        self.title=@"认证成功";
    }else{
        self.title=@"注册成功";
        
    }
    
}
-(void)backBtnClick{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)creatNewView{
    
        switch (self.type) {
        case isZhuCeSuccess:
        { //注册成功
                NSArray *imageArr=@[@"zfcg_ljrz_icon",@"zfcg_xkfl_icon",@"zfcg_ljgd_icon"];
                NSArray *buttontitleArr=@[@"立即认证 >>",@"新手福利 >>",@"了解更多 >>"];
                NSArray *buttontitleColorArr=@[UIColorFromRGB(0x42cb7d),UIColorFromRGB(0xfea346),UIColorFromRGB(0x6291e9)];
            [self creatDetailViewWithTitle:@"恭喜您,注册成功!" andDetail:@"您已获得588元大礼包,欢迎加入财猫网,祝您投资愉快！" addImageArr:imageArr andBtnTitleArr:buttontitleArr andBtnTitleColorArr:buttontitleColorArr bottomImageViewHide:NO bottomImageName:@"zfcg_touzi"];
            
        }
            break;
        case isReZhengSuccess:
        {//认证成功
           
            NSArray *imageArr=@[@"zfcg_qutouzi_icon",@"zfcg_xkfl_icon",@"zfcg_ljgd_icon"];
            NSArray *buttontitleArr=@[@"继续投资 >>",@"新手福利 >>",@"了解更多 >>"];
            NSArray *buttontitleColorArr=@[UIColorFromRGB(0xff4804),UIColorFromRGB(0xfea346),UIColorFromRGB(0x6291e9)];
            [self creatDetailViewWithTitle:@"恭喜您,认证成功!" andDetail:@"认证成功后，您在财猫网赚钱变的更加安全了" addImageArr:imageArr andBtnTitleArr:buttontitleArr andBtnTitleColorArr:buttontitleColorArr bottomImageViewHide:NO bottomImageName:@"zfcg_dqb"];
            
            
        }
            break;
    
        default:
            break;
    }
    
    
    
    
}

-(void)creatDetailViewWithTitle:(NSString*)title andDetail:(NSString*)aDetailTitle addImageArr:(NSArray*)aImageArr andBtnTitleArr:(NSArray*)aBtnArr andBtnTitleColorArr:(NSArray*)aColorArr bottomImageViewHide:(BOOL)aHide bottomImageName:(NSString*)aName{
    UIView *bgView=[[UIView alloc]init];
    bgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(10);
        make.height.equalTo(@220);
        
    }];
    
    UILabel *success=[[UILabel alloc]init];
    success.text=title;
    success.font=[UIFont systemFontOfSize:20];
    success.textColor=UIColorFromRGB(0xff4804);
    [bgView addSubview:success];
    [success mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.width.equalTo(@200);
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
    detai.text=aDetailTitle;
    detai.font=[UIFont systemFontOfSize:14.0];
    detai.numberOfLines=0;
    detai.textAlignment=NSTextAlignmentCenter;
    detai.textColor=UIColorFromRGB(0xe5a858);
    [bgView addSubview:detai];
    [detai mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@35);
        make.centerX.equalTo(bgView.mas_centerX);
        make.left.equalTo(bgView.mas_left).offset(10);
        make.right.equalTo(bgView.mas_right).offset(-10);
        make.top.equalTo(RightImage.mas_bottom).offset(10);
    }];
    

    for (int i=0; i<aImageArr.count; i++) {
        UIImage *TImage=[UIImage imageNamed:aImageArr[i]];
        
        UIImageView *imageView=[[UIImageView alloc]init];
        imageView.image=TImage;
        imageView.frame=CGRectMake(i%aImageArr.count*(TImage.size.width+CMScreenW/6.5)+CMScreenW/6.5,120, TImage.size.width, TImage.size.height);
        imageView.layer.cornerRadius=TImage.size.height/2.0
        ;
        imageView.clipsToBounds=YES;
        [bgView addSubview:imageView];
        
        
        UIButton *backTeHuiPage=[UIButton buttonWithType:UIButtonTypeSystem];
        [backTeHuiPage setTitle:aBtnArr[i] forState:UIControlStateNormal];
        [backTeHuiPage setTitleColor:aColorArr[i] forState:UIControlStateNormal];
        backTeHuiPage.tag=i+10;
        backTeHuiPage.titleLabel.font=[UIFont systemFontOfSize:14.0];
        backTeHuiPage.frame=CGRectMake(0,0, TImage.size.width+50,30);
        CGRect rect;
        rect=backTeHuiPage.frame;
        rect.origin.x=imageView.frame.origin.x-TImage.size.width/2.0;
        rect.origin.y=imageView.frame.origin.y+TImage.size.height+10;
        backTeHuiPage.frame=rect;
        [backTeHuiPage addTarget:self action:@selector(goProductBtnClick:)forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:backTeHuiPage];
        
        
    }
    
    UIImage *iconImage=[UIImage imageNamed:aName];
    UIImageView *iconImageView=[[UIImageView alloc]init];
    iconImageView.hidden=aHide;
    iconImageView.image=iconImage;
    iconImageView.userInteractionEnabled=YES;
    [self.view addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.equalTo(self.view);
        make.top.equalTo(bgView.mas_bottom).offset(20);
        make.height.mas_equalTo(iconImage.size.height+10);
    }];
    UITapGestureRecognizer  *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goBuySomething)];
    [iconImageView addGestureRecognizer:tap];
    
    
}
#pragma clang diagnostic ignored"-Wunused-variable"
-(void)goProductBtnClick:(UIButton*)btn{
  
    switch (btn.tag) {
        case 10:
        {
            if (self.type==isReZhengSuccess) {
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

                
            }else{//注册成功
                
            }
            CMLoginController*loginVc = [[CMLoginController alloc] init];
            loginVc.FromRenZheng=YES;
            
           [self.navigationController presentViewController:loginVc animated:YES completion:nil];
            NSMutableArray  *arr=[[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
            for (UIViewController *vc in arr) {
                [arr removeObjectsInRange:NSMakeRange(1, arr.count - 2)];
                break;
                
            }
            
            self.navigationController.viewControllers=arr;

            
            
        }
            break;
         case 11:
        {
            CMXinKeController*serVc = [[CMXinKeController alloc] init];
            
            
            [self.navigationController pushViewController:serVc animated:YES];
            NSMutableArray  *arr=[[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
            for (UIViewController *vc in arr) {
                [arr removeObjectsInRange:NSMakeRange(1, arr.count - 2)];
                break;
                
            }
           
            self.navigationController.viewControllers=arr;
            
        }break;
        case 12:{
            CMServiceController *serVc = [[CMServiceController alloc] init];
            
            [self.navigationController pushViewController:serVc animated:YES];
            NSMutableArray  *arr=[[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
            for (UIViewController *vc in arr) {
                [arr removeObjectsInRange:NSMakeRange(1, arr.count - 2)];
                break;
                
            }
            
            
            self.navigationController.viewControllers=arr;

        }break;
        default:
            break;
    }
    
    
}
-(void)goBuySomething{
    if (self.type==isReZhengSuccess) {
        CMDingQiDetailController*serVc = [[CMDingQiDetailController alloc] init];
        
        
        [self.navigationController pushViewController:serVc animated:YES];
        
    }else{
     CMXinKeController*serVc = [[CMXinKeController alloc] init];
    
    
    [self.navigationController pushViewController:serVc animated:YES];
    }
    NSMutableArray  *arr=[[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    
    
    
    for (UIViewController *vc in arr) {
        [arr removeObjectsInRange:NSMakeRange(1, arr.count- 2)];
        break;
    }
    self.navigationController.viewControllers=arr;

}

@end
