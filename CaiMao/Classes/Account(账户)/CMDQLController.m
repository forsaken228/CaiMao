//
//  CMDQLController.m
//  CaiMao
//
//  Created by MAC on 16/10/27.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMDQLController.h"
#import "CMHeadView.h"
#import "CMOrderListView.h"
#import "CMHoldListView.h"
#import "CMEvenUpListView.h"
@interface CMDQLController ()

@property(nonatomic,strong) CMHeadView  *head;
@property(strong,nonatomic)UIScrollView  *currentScrollView;
@end

@implementation CMDQLController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"定期理财";
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"资金记录" style:UIBarButtonItemStylePlain target:self action:@selector(enterIntoRecordOfTiXian)];

    [self.view addSubview:self.head];
   [self.view addSubview:self.currentScrollView];
    self.currentScrollView.contentSize=CGSizeMake(CMScreenW*3, self.currentScrollView.frame.size.height);

    CMHoldListView *holdListView=[[CMHoldListView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, self.currentScrollView.frame.size.height)];
    holdListView.receiveController=self;
    holdListView.receiveDataSuccess=^(){
        
        [self hiddenProgressHUD];
    };
    [self.currentScrollView addSubview:holdListView];
    
    CMOrderListView *OrderListView=[[CMOrderListView alloc]initWithFrame:CGRectMake(CMScreenW, 0, CMScreenW, self.currentScrollView.frame.size.height)];
    OrderListView.receiveController=self;
    [self.currentScrollView addSubview:OrderListView];
    
    CMEvenUpListView *EvenUpListView=[[CMEvenUpListView alloc]initWithFrame:CGRectMake(CMScreenW*2, 0, CMScreenW, self.currentScrollView.frame.size.height)];
  
    [self.currentScrollView addSubview:EvenUpListView];
    
    [self  bottomSuspendView];
    [self showDefaultProgressHUD];
 
}

-(UIScrollView*)currentScrollView{
    if (!_currentScrollView) {
        _currentScrollView=[[UIScrollView alloc]init];
        _currentScrollView.bounces=NO;
        _currentScrollView.showsVerticalScrollIndicator=NO;
        _currentScrollView.showsHorizontalScrollIndicator=NO;
        _currentScrollView.backgroundColor=ViewBackColor;
        _currentScrollView.scrollEnabled=NO;
        _currentScrollView.frame=CGRectMake(0, 287,CMScreenW, 287);
    }
    return _currentScrollView;
}




-(CMHeadView*)head{
    if (!_head) {
        _head=[[CMHeadView alloc]init];
        _head.LJTZLabel.text=@"0.00";
        _head.LJSYLabel.text=@"0.00";
        _head.DSTZLabel.text=[NSString stringWithFormat:@"本月投资到期:%@笔",@"0"];
        _head.DSSYLabel.text=[NSString stringWithFormat:@"收益:%@",@"0"];
        _head.BJLabel.text=[NSString stringWithFormat:@"本金:%@",@"0"];
        _head.CYLabel.text=@"0.00";
        _head.delegate=self;
        _head.frame=CGRectMake(0, 0, CMScreenW, 287);

    }
    return _head;
    
}

- (void)enterIntoRecordOfTiXian {
    
    CMRecordOfCharge *vc=[[CMRecordOfCharge alloc]init];
    vc.selectIndex=0;
    [self.navigationController pushViewController:vc animated:YES];


}
-(void)addTargetWith:(NSInteger)tag{
    
    CGRect rect = CGRectMake((tag-10) *CGRectGetWidth(self.currentScrollView.frame), 0, CGRectGetWidth(self.currentScrollView.frame), CGRectGetHeight(self.currentScrollView.frame));
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        [self.currentScrollView scrollRectToVisible:rect animated:NO];
    } completion:^(BOOL finished) {
    }];
    
    
    
 }

#pragma mark 底部悬浮
-(void)bottomSuspendView{
    
    UIView *bottomView = [[UIView alloc] init];
    
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [self.view bringSubviewToFront:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@50);
        make.left.right.bottom.equalTo(self.view);
        
    }];
    NSArray *bTitleArr=@[@"去投资",@"去充值"];
    NSArray *bImageTitle=@[@"GoTZ",@"GOCZ"];
    
    for (int i=0; i<bTitleArr.count; i++) {
        CMBottomXuanFu *xuanfu=[[CMBottomXuanFu alloc]init];
        xuanfu.backgroundColor=RedButtonColor;
        [xuanfu creatbuttonImage:bImageTitle[i] andTitle:bTitleArr[i]];
        xuanfu.frame=CGRectMake(i%2*CMScreenW/2.0, 0, CMScreenW/2.0-0.5, 50);
        xuanfu.tag=i+20;
        [bottomView addSubview:xuanfu];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        [xuanfu addGestureRecognizer:tap];
        
    }
    
    
    
}

-(void)tapClick:(UIGestureRecognizer*)gesture{
    
    
    switch (gesture.view.tag) {
        case 20:{
            //去投资
//          UIWindow *window=[UIApplication sharedApplication].windows.firstObject;
//            CMTabBarController *tab=(CMTabBarController*)window.rootViewController;
//            [tab selectTap:1];
            
            CMLiCaiViewController *lici=[[CMLiCaiViewController alloc]init];
            [self.navigationController pushViewController:lici animated:YES];
          }
        //[self viewDisappear];
            break;
        case 21:
        {
            //去充值
            if (self.bankList!=nil && ![self.bankList isKindOfClass:[NSNull class]] && self.bankList.count!=0){
                
                NSDictionary *dic=[self.bankList firstObject];
                
                NSDictionary  *bankData=[dic objectForKey:@"BankData"];
                if (bankData.count==0||bankData.allKeys.count==0) {
                    //银行卡认证
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您还没开通银行卡认证支付,请选择常用银行卡认证！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"认证", nil];
                    [alert show];
                    
                }
                
                else {
                   // 充值
                    CMRechargeViewController *productVc = [[CMRechargeViewController alloc] init];
                
                    [self.navigationController pushViewController:productVc animated:YES];
//                    CMProductDetailController *pro=[[CMProductDetailController alloc]init];
//                    pro.urlStr=[NSString stringWithFormat:@"%@/icm/acc/warecharge.aspx",OnLineCode];
//                    [self.navigationController pushViewController:pro animated:YES];
                    
                }
                
                
            }
   
            
        }
            break;
        default:
            break;
    }
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
if (buttonIndex==1) {
    

    CMUserTrueController *productVc = [[CMUserTrueController alloc] init];
    [self.navigationController pushViewController:productVc animated:YES];
    
//    CMProductDetailController *pro=[[CMProductDetailController alloc]init];
//    pro.urlStr=[NSString stringWithFormat:@"%@/icm/acc/addbankcard.aspx",OnLineCode];
//    [self.navigationController pushViewController:pro animated:YES];
}
}

checkNet

@end
