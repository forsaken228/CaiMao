//
//  CMAccountDespoistController.m
//  CaiMao
//
//  Created by WangWei on 17/3/24.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import "CMAccountDespoistController.h"
#import "CMAccountDespositTopView.h"
#import "CMAccountDespositBottomView.h"
@interface CMAccountDespoistController ()
@property(nonatomic,strong)CMAccountDespositTopView *DespositTopView;
@property(nonatomic,strong)CMAccountDespositBottomView *DespositBottomView;
@end

@implementation CMAccountDespoistController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"随心存";
    self.view.backgroundColor=ViewBackColor;
     self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"资金记录" style:UIBarButtonItemStylePlain target:self action:@selector(enterIntoRecordOfTiXian)];
    [self.view addSubview:self.DespositTopView];
 
    [self.view addSubview:self.DespositBottomView];
    [self bottomSuspendView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [CMNSNotice addObserver:self selector:@selector(confirmButtonEvent) name:@"confirmButtonEvent" object:nil];
    
    
}
-(void)confirmButtonEvent{
    

    self.DespositBottomView.receiveConfirm=YES;
}
-(void)dealloc{
    [CMNSNotice removeObserver:self];
}
#pragma mark Lazy
-(CMAccountDespositTopView*)DespositTopView{
    if (!_DespositTopView) {
        _DespositTopView=[[CMAccountDespositTopView alloc]init];
        _DespositTopView.frame=CGRectMake(0, 0, CMScreenW, 200);
    }
    
    return _DespositTopView;
    
}
-(CMAccountDespositBottomView*)DespositBottomView{
    if (!_DespositBottomView) {
        _DespositBottomView=[[CMAccountDespositBottomView alloc]initWithFrame:
CGRectMake(0, 200, CMScreenW, CMScreenH-200)];
   
    }
    
    return _DespositBottomView;
    
}



#pragma mark 底部悬浮
-(void)bottomSuspendView{
    
    UIButton *bottomView = [UIButton buttonWithType:UIButtonTypeCustom];
    
    bottomView.backgroundColor =RedButtonColor;
    [bottomView setTitle:@"立即存入" forState:UIControlStateNormal];
    [bottomView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bottomView.titleLabel.font=[UIFont systemFontOfSize:15.0];
    [self.view addSubview:bottomView];
    [self.view bringSubviewToFront:bottomView];
    [bottomView addTarget:self action:@selector(bottomViewEvent) forControlEvents:UIControlEventTouchUpInside];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@50);
        make.left.right.bottom.equalTo(self.view);
        
    }];
 
    
    
}
#pragma mark 立即存入
-(void)bottomViewEvent{
    
    CMAsDepositController *vc=[[CMAsDepositController alloc]init];
    vc.realVaule=30;
    CMPush(vc);
}
- (void)enterIntoRecordOfTiXian {
    
    CMRecordOfCharge *vc=[[CMRecordOfCharge alloc]init];
    vc.selectIndex=0;
    [self.navigationController pushViewController:vc animated:YES];
    //    NSMutableArray  *arr=[[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    //    for (UIViewController *vc in arr) {
    //        if ([vc isKindOfClass:[self class]]) {
    //
    //            [arr removeObject:vc];
    //            break;
    //        }
    //
    //    }
    //
    //    self.navigationController.viewControllers=arr;
    
    
}

ReceiveMemoryWarning

@end
