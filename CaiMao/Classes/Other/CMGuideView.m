//
//  CMGuideView.m
//  CaiMao
//
//  Created by MAC on 16/11/18.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMGuideView.h"

@implementation CMGuideView
- (instancetype)init:(NSArray *)imageArray {
    self = [super init];
    if(self) [self initThisView:imageArray];
    return self;
}

- (void)initThisView:(NSArray *)imageArray {
    _imageArray = imageArray;
    self.frame = CGRectMake(0, 0, CMScreenW, CMScreenH);
   self.scrollView.contentSize=CGSizeMake(CMScreenW * _imageArray.count, CMScreenH);
    self.PageControl.numberOfPages = imageArray.count;
    
    
    for (int i = 0; i < imageArray.count; i++) {
        UIImage *image=[UIImage imageNamed:imageArray[i]];
        CGRect frame = CGRectMake(i * CMScreenW, 0, CMScreenW, CMScreenH);
        UIImageView *img=[[UIImageView alloc] initWithFrame:frame];
        img.userInteractionEnabled=YES;
        img.image=image;
        [self.scrollView addSubview:img];
        [img addSubview:self.loginButton];
        [img addSubview:self.PassButton];
        [self.PassButton  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(img.mas_right).offset(-50);
            make.left.equalTo(img.mas_centerX).offset(5);
            make.bottom.equalTo(img.mas_bottom).offset(-30);
            make.height.equalTo(@40);
        }];
        [self.loginButton  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(img.mas_left).offset(50);
            make.right.equalTo(img.mas_centerX).offset(-5);
            make.height.bottom.equalTo(self.PassButton);
        }];
    
    }
    
    
    

    [self addSubview:self.scrollView];
    [self addSubview:self.PageControl];
    
    [self.PageControl  mas_makeConstraints:^(MASConstraintMaker *make) {
       // WithFrame:CGRectMake(CMScreenW/2.0-50, CMScreenH-100, 100, 20)
        make.height.equalTo(@20);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(CMScreenW);
        make.bottom.equalTo(self.PassButton.mas_top).offset(-10);
        
    }];
   
}

#pragma mark scrollView的代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //if (scrollView.contentOffset.x >= 4 * CMScreenW) //[self dismissGuideView];
    CGFloat width = self.scrollView.frame.size.width;
    int currentPage = self.scrollView.contentOffset.x/width;
    self.PageControl.currentPage = currentPage;
    

}

-(void)pageControlClick:(UIPageControl*)pageControl{
    
    
   
    
    [self.scrollView setContentOffset:CGPointMake(self.PageControl.currentPage*CMScreenW, 0) animated:YES];
    

    
    
}

-(void)dismissGuideView:(UIButton*)btn {
    if ([self.delegate respondsToSelector:@selector(enterAppMainControllerWithIndex:)]) {
        [self.delegate  enterAppMainControllerWithIndex:btn.tag];
    }
    
    
}


#pragma mark Lazy
-(UIScrollView*)scrollView{
    if (!_scrollView) {

        _scrollView=[[UIScrollView alloc] initWithFrame:self.frame];
        _scrollView.pagingEnabled=YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.tag=7000;
        _scrollView.delegate = self;
    }
    
    return _scrollView;
}
-(UIPageControl*)PageControl{
    if (!_PageControl) {
        _PageControl=[[UIPageControl alloc]init];
        _PageControl.currentPage = 0;
        _PageControl.enabled = YES;
        [_PageControl addTarget:self action:@selector(pageControlClick:) forControlEvents:UIControlEventValueChanged];
  
    }
    
    return _PageControl;
}

-(UIButton*)PassButton{
    if (!_PassButton) {
      
        _PassButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        // passbtn.frame= CGRectMake(CMScreenW/2.0-80, CMScreenH-80, 80, 40);
        [_PassButton addTarget:self action:@selector(dismissGuideView:) forControlEvents:(UIControlEventTouchUpInside)];
        _PassButton.layer.borderColor=[UIColor whiteColor].CGColor;
        _PassButton.layer.borderWidth=0.5;
        //passbtn.layer.cornerRadius=5.0;
        // passbtn.layer.masksToBounds=YES;
        // passbtn.alpha=0.5;
        [_PassButton setBackgroundColor:[UIColor clearColor]];
        [_PassButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_PassButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _PassButton.tag=11;
        [_PassButton setTitle:@"立即体验" forState:(UIControlStateNormal)];
        
        
    }
    
    return _PassButton;
}
-(UIButton*)loginButton{
    if (!_loginButton) {
        
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        // passbtn.frame= CGRectMake(CMScreenW/2.0-80, CMScreenH-80, 80, 40);
        [_loginButton addTarget:self action:@selector(dismissGuideView:) forControlEvents:(UIControlEventTouchUpInside)];
        _loginButton.layer.borderColor=[UIColor whiteColor].CGColor;
        _loginButton.layer.borderWidth=0.5;
        //passbtn.layer.cornerRadius=5.0;
        // passbtn.layer.masksToBounds=YES;
        // passbtn.alpha=0.5;
        [_loginButton setBackgroundColor:[UIColor clearColor]];
        [_loginButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginButton.tag=10;
        [_loginButton setTitle:@"登录注册" forState:(UIControlStateNormal)];
        
        
    }
    
    return _loginButton;
}

@end
