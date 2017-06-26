//
//  CMMyIntegralController.m
//  CaiMao
//
//  Created by MAC on 16/9/6.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMMyIntegralController.h"
#import "CMMyIntegral.h"
#import "CMDuiHuanRecordView.h"
#import "CMIntegralMingXiView.h"
@interface CMMyIntegralController ()<CMMyIntegralDelegate>

@property(nonatomic,strong)CMMyIntegral *myIntegral;
@property(nonatomic,strong)UIScrollView *currentScrollView;

@end

@implementation CMMyIntegralController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"我的积分";
    
    self.view.backgroundColor=ViewBackColor;
    [self.view addSubview:self.myIntegral];
    [self.view addSubview:self.currentScrollView];
    
    self.currentScrollView.contentSize=CGSizeMake(CMScreenW*2,  self.currentScrollView.bounds.size.height);
    CMDuiHuanRecordView *DuiHuanRecordView=[[CMDuiHuanRecordView alloc]initWithFrame:CGRectMake(0, 0, self.currentScrollView.bounds.size.width, self.currentScrollView.bounds.size.height)];
    [self.currentScrollView addSubview:DuiHuanRecordView];
    
    CMIntegralMingXiView *MingXiView=[[CMIntegralMingXiView alloc]initWithFrame:CGRectMake(CMScreenW, 0, self.currentScrollView.bounds.size.width, self.currentScrollView.bounds.size.height)];
    [self.currentScrollView addSubview:MingXiView];
    
    
    
}

-(CMMyIntegral*)myIntegral{
    if (!_myIntegral) {
          _myIntegral=[[CMMyIntegral alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, f_i5real(165))];
        _myIntegral.MyIntegral.text=@"0";
        _myIntegral.delegate=self;
    }
    
    return _myIntegral;
}

-(UIScrollView*)currentScrollView{
    if (!_currentScrollView) {
        _currentScrollView=[[UIScrollView alloc]init];
        _currentScrollView.bounces=NO;
        _currentScrollView.showsVerticalScrollIndicator=NO;
        _currentScrollView.showsHorizontalScrollIndicator=NO;
        _currentScrollView.backgroundColor=ViewBackColor;
        _currentScrollView.scrollEnabled=NO;
        
        _currentScrollView.frame=CGRectMake(0, f_i5real(165), CMScreenW, CMScreenH-f_i5real(165));
    }
    return _currentScrollView;
}

-(void)tapClickEventWithIndex:(NSInteger)Index{
    
    CGRect rect = CGRectMake((Index-10) *CGRectGetWidth(self.currentScrollView.frame), 0, CGRectGetWidth(self.currentScrollView.frame), CGRectGetHeight(self.currentScrollView.frame));
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        [self.currentScrollView scrollRectToVisible:rect animated:NO];
    } completion:^(BOOL finished) {
    }];
    
    
    
}
@end
