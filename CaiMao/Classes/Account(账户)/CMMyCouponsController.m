//
//  CMMyYouHuiController.m
//  CaiMao
//
//  Created by MAC on 16/11/1.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMMyCouponsController.h"
#import "CMMyYHCell.h"
#import "CMMyYHHead.h"
#import "CMMiaoSecuritiesView.h"
#import "CMTiXianSecuritiesView.h"
#import "CMExperienceSecuritiesView.h"
@interface CMMyCouponsController ()<CMMyYHHeadDelegate>


@property(nonatomic,strong)UIScrollView *currentScrollView;
@property(nonatomic,strong)CMMyYHHead *headView;
@end

@implementation CMMyCouponsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的优惠劵";
    self.view.backgroundColor=ViewBackColor;
   
    [self.view addSubview:self.headView];
    
    [self.view addSubview:self.currentScrollView];
    
    self.currentScrollView.contentSize=CGSizeMake(CMScreenW*3, self.view.frame.size.height-45);
    
    
    CMMiaoSecuritiesView *MiaoSecuritiesView=[[CMMiaoSecuritiesView alloc]initWithFrame:CGRectMake(0, 0, self.currentScrollView.bounds.size.width, self.currentScrollView.bounds.size.height)];
    [self.currentScrollView addSubview:MiaoSecuritiesView];
    
    CMTiXianSecuritiesView *TiXianSecuritiesView=[[CMTiXianSecuritiesView alloc]initWithFrame:CGRectMake(CMScreenW, 0, self.currentScrollView.bounds.size.width, self.currentScrollView.bounds.size.height)];
    [self.currentScrollView addSubview:TiXianSecuritiesView];
    
    CMExperienceSecuritiesView *ExperienceSecuritiesView=[[CMExperienceSecuritiesView alloc]initWithFrame:CGRectMake(CMScreenW*2, 0, self.currentScrollView.bounds.size.width, self.currentScrollView.bounds.size.height)];
    [self.currentScrollView addSubview:ExperienceSecuritiesView];
    

    
    
}

#pragma mark Lazy
-(UIScrollView*)currentScrollView{
    if (!_currentScrollView) {
        _currentScrollView=[[UIScrollView alloc]init];
        _currentScrollView.bounces=NO;
        _currentScrollView.showsVerticalScrollIndicator=NO;
        _currentScrollView.showsHorizontalScrollIndicator=NO;
        _currentScrollView.backgroundColor=ViewBackColor;
        _currentScrollView.scrollEnabled=NO;

       _currentScrollView.frame=CGRectMake(0, 45, CMScreenW, self.view.frame.size.height-45);
    }
    return _currentScrollView;
}
-(CMMyYHHead*)headView{
    if (!_headView) {
        _headView=[[CMMyYHHead alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 45)];
        _headView.delegate=self;
    }
    return _headView;
}
#pragma mark  CMMyYHHeadDelegate
-(void)choiceViewWithButtonTage:(NSInteger)aTag{
    
    CGRect rect = CGRectMake((aTag-10) *CGRectGetWidth(self.currentScrollView.frame), 0, CGRectGetWidth(self.currentScrollView.frame), CGRectGetHeight(self.currentScrollView.frame));
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        [self.currentScrollView scrollRectToVisible:rect animated:NO];
    } completion:^(BOOL finished) {
    }];
    
    
}

@end
