//
//  CMAccountDespositBottomView.m
//  CaiMao
//
//  Created by WangWei on 17/3/24.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import "CMAccountDespositBottomView.h"
#import "CMAccountDespositRedeemView.h"
#import "CMAccountDespositHoldView.h"

@interface CMAccountDespositBottomView ()
@property(nonatomic,strong)UIButton *selectBtn;
@property(nonatomic,strong)UIView *moveView;
@property(nonatomic,strong)CMAccountDespositHoldView *holdView;
@property(nonatomic,strong)CMAccountDespositRedeemView *RedeemView;

@end
@implementation CMAccountDespositBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        NSArray *TitleArr=@[@"持有",@"已赎回"];
        for (int i=0; i<TitleArr.count; i++) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(i%TitleArr.count*CMScreenW/2.0, 0, CMScreenW/2.0, 40);
            [btn setBackgroundColor:[UIColor whiteColor]];
            [btn setTitle:TitleArr[i] forState:UIControlStateNormal];
            [btn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
            btn.tag=i+10;
            [btn addTarget:self action:@selector(changeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.titleLabel.font=[UIFont systemFontOfSize:16];
            if (i==0) {
                self.selectBtn=btn;
                btn.selected=YES;
                [btn setTitleColor:RedButtonColor forState:UIControlStateNormal];
            }
            [self addSubview:btn];
            
        }

        self.moveView.frame=CGRectMake(0,38, CMScreenW/2.0, 2) ;
        [self addSubview:_moveView];
       [self addSubview:self.currentScrollView];
        self.currentScrollView.frame=CGRectMake(0, 40, CMScreenW, self.frame.size.height-40);
        self.currentScrollView.contentSize=CGSizeMake(CMScreenW*2, self.frame.size.height-40);
        
       self.holdView=[[CMAccountDespositHoldView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, self.currentScrollView.bounds.size.height)];
        [self.currentScrollView addSubview: self.holdView];
       self.RedeemView=[[CMAccountDespositRedeemView alloc]initWithFrame:CGRectMake(CMScreenW, 0, CMScreenW, self.currentScrollView.bounds.size.height)];
        [self.currentScrollView addSubview: self.RedeemView];
      
    }
    return self;
}

-(void)changeBtnClick:(UIButton*)btn{
    if (self.selectBtn==btn) {
        return;
    }
    self.selectBtn.selected=NO;
    [self.selectBtn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    //点击btn
    btn.selected=YES;
    [btn setTitleColor:RedButtonColor forState:UIControlStateSelected];
    self.selectBtn=btn;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.moveView.center=CGPointMake(btn.center.x, self.moveView.center.y);
    [UIView commitAnimations];
    
    CGRect rect = CGRectMake((btn.tag-10) *CGRectGetWidth(self.currentScrollView.frame), 0, CGRectGetWidth(self.currentScrollView.frame), CGRectGetHeight(self.currentScrollView.frame));
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        [self.currentScrollView scrollRectToVisible:rect animated:NO];
    } completion:^(BOOL finished) {
    }];
    
    
   
    
}
-(UIView*)moveView{
    
    if (!_moveView) {
        _moveView=[[UIView alloc]init];
        _moveView.backgroundColor=RedButtonColor;
        
    }
    return _moveView;
}
#pragma mark Lazy
-(UIScrollView*)currentScrollView{
    if (!_currentScrollView) {
        
        _currentScrollView=[[UIScrollView alloc]init];
        _currentScrollView.bounces=NO;
        _currentScrollView.showsVerticalScrollIndicator=NO;
        _currentScrollView.showsHorizontalScrollIndicator=NO;
        _currentScrollView.scrollEnabled=NO;
    }
    return _currentScrollView;
}

-(void)setReceiveConfirm:(BOOL)receiveConfirm{
    if (receiveConfirm) {
         
        UIButton *btn=[self viewWithTag:11];
        [self changeBtnClick:btn];
        self.holdView.receiveConfirm=YES;
        self.RedeemView.receiveConfirm=YES;
    }
}

@end
