//
//  CMHomeDingQiView.m
//  CaiMao
//
//  Created by WangWei on 16/12/1.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMHomeDingQiView.h"
#import "CMDingQiView.h"

@implementation CMHomeDingQiView


-(id)init{
    
    self=[super init];
    if (self) {
       
        
        self.backgroundColor=[UIColor whiteColor];
        UILabel *title=[UILabel new];
        //title.frame=CGRectMake(8, 3, 68, 34);
        title.text=@"定期宝";
        title.font=[UIFont systemFontOfSize:19.0];
        //title.textColor=CMColor(255, 134, 46);
        [self addSubview:title];
        
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mas_top).offset(10);
            make.left.equalTo(self.mas_left).offset(8);
            make.width.mas_equalTo(65);
            make.height.mas_equalTo(19);
        }];
        
        
        UIButton *right=[UIButton buttonWithType:UIButtonTypeSystem];
        // right.frame=CGRectMake(107, 3, 205, 34);
        right.titleLabel.font=[UIFont systemFontOfSize:14.0];
        [right setTitle:@"政府债 像银行一样安全 >" forState:UIControlStateNormal];
        [right setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        right.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
        [right addTarget:self action:@selector(goDingQiBao) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:right];
        
        [right mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(title);
            make.right.equalTo(self.mas_right).offset(-8);
            make.width.mas_equalTo(205);
            make.height.mas_equalTo(19);
        }];
        
        
        UIView *level=[UIView new];
        level.backgroundColor=separateLineColor;
        
        [self addSubview:level];
        
        [level mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(title.mas_bottom).offset(10);
            make.left.right.width.equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
        
        UIView *cLine=[UIView new];
        cLine.backgroundColor=UIColorFromRGB(0xb3b3b3);
        [self addSubview:cLine];
        [cLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.left.equalTo(title.mas_right);
            make.width.equalTo(@1);
            make.centerY.equalTo(title);
            
            
        }];
        
        
        UILabel *HQi=[UILabel new];
        HQi.textColor=UIColorFromRGB(0x626262);
        HQi.text=@"定期";
        HQi.font=[UIFont systemFontOfSize:15.0];
        [self addSubview:HQi];
        [HQi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@25);
            make.left.equalTo(cLine.mas_right).offset(8);
            make.width.equalTo(@50);
            make.centerY.equalTo(title);
            
            
        }];
        UIImageView *bao=[UIImageView new];
        bao.image=[UIImage imageNamed:@"pic_bao"];
        [self addSubview:bao];
        [bao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.with.mas_equalTo(22);
            make.top.equalTo(self.mas_top).offset(3);
            make.left.equalTo(HQi.mas_right).offset(-14);
        }];
        
        UIButton *dingQiLeftButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [dingQiLeftButton setBackgroundColor:[UIColor whiteColor]];
        [dingQiLeftButton setImage:[UIImage imageNamed:@"home_left_icon.png"] forState:UIControlStateNormal];

        [self addSubview:dingQiLeftButton];
        [dingQiLeftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@185);
            make.left.equalTo(self.mas_left);
            make.top.equalTo(level.mas_bottom);
            make.width.equalTo(@30);
        }];
        
        UIButton *dingQiRightButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [dingQiRightButton setBackgroundColor:[UIColor whiteColor]];
        [dingQiRightButton setImage:[UIImage imageNamed:@"home_right_icon.png"] forState:UIControlStateNormal];
        [self addSubview:dingQiRightButton];
        [dingQiRightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.top.equalTo(dingQiLeftButton);
            make.right.equalTo(self.mas_right);
            
        }];
        
        [dingQiLeftButton addTarget:self action:@selector(previousDingqiView:) forControlEvents:UIControlEventTouchUpInside];
        [dingQiRightButton addTarget:self action:@selector(nextDingqiView:) forControlEvents:UIControlEventTouchUpInside];
        
        self.dingQiScroller=[[UIScrollView alloc]init];
        self.dingQiScroller.backgroundColor=[UIColor whiteColor];
        [self addSubview:self.dingQiScroller];
        self.dingQiScroller.pagingEnabled = YES;
        self.dingQiScroller.showsHorizontalScrollIndicator = NO;
        self.dingQiScroller.delegate=self;
        [self.dingQiScroller mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(dingQiLeftButton.mas_right);
            make.right.equalTo(dingQiRightButton.mas_left);
            make.top.height.equalTo(dingQiLeftButton);
            
        }];
        
        UIView *bg=[UIView new];
        bg.backgroundColor=ViewBackColor;
        [self addSubview:bg];
        [bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
            make.width.left.equalTo(self);
           make.bottom.equalTo(self.mas_bottom);
        }];
        
        UIView *line=[[UIView alloc]init];
        line.backgroundColor=UIColorFromRGB(0xff7500);
        [bg addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.centerY.equalTo(bg);
            make.width.equalTo(@2);
            make.left.equalTo(bg.mas_left).offset(10);
        }];
        UILabel *RQTitle=[[UILabel alloc]init];
        RQTitle.text=@"精品推荐";
        RQTitle.font=[UIFont systemFontOfSize:15.0];
        RQTitle.textColor=UIColorFromRGB(0x818181);
        [bg addSubview:RQTitle];
        [RQTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@95);
            make.top.height.equalTo(line);
            make.left.equalTo(line.mas_left).offset(10);
        }];

        
        
        
        
    }
    
    
    return self;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 得到每页宽度
    CGFloat pageWidth = scrollView.frame.size.width;
    // 根据当前的x坐标和页宽度计算出当前页数
    _currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
}

// 上一个
- (void)previousDingqiView:(UIButton *)sender {
    
    _currentPage --;
    if (_currentPage < 0) {
        // return;
        _currentPage = _DingQiBaoList.count - 1;
    }
    [self.dingQiScroller setContentOffset:CGPointMake(_currentPage * self.dingQiScroller.frame.size.width, 0) animated:YES];
}

// 下一个
- (void)nextDingqiView:(UIButton *)sender {
    
    _currentPage ++;
    if (_currentPage >= _DingQiBaoList.count) {
        _currentPage = 0;
        
        
        //return;
    }
    [self.dingQiScroller setContentOffset:CGPointMake(_currentPage * self.dingQiScroller.frame.size.width, 0) animated:YES];
}
-(void)setDingQiBaoList:(NSArray *)DingQiBaoList{
    _DingQiBaoList=DingQiBaoList;
    self.dingQiScroller.contentSize = CGSizeMake(DingQiBaoList.count *self.dingQiScroller.frame.size.width, 0);
    
    for (int i = 1; i <= DingQiBaoList.count; i++) {
        
        CMDingQiView *dingView=[[CMDingQiView alloc]initWithFrame:CGRectMake((i - 1) * self.dingQiScroller.frame.size.width, 0, self.dingQiScroller.frame.size.width, 185)];
        dingView.tag = i * 100;
        
        [dingView.dingJoinBtn addTarget:self action:@selector(dingJoinBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        CMDingQiBaoList *list = [DingQiBaoList objectAtIndex:i - 1];
        
        dingView.DingQiBaoList=list;
        // dingView添加点击事件
        dingView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
        [dingView addGestureRecognizer:singleTap];
        
        [self.dingQiScroller addSubview:dingView];
        
    }
}
-(void)dingJoinBtnClick{
    if ([self.delegate respondsToSelector:@selector(DingQiBaoEnterPayControllerWithPageIndex:)]) {
        [self.delegate DingQiBaoEnterPayControllerWithPageIndex:_currentPage];
    }
    
}
-(void)handleSingleTap{
    if ([self.delegate respondsToSelector:@selector(DingQiBaoEnterProductDetailControllerWithPageIndex:)]) {
        [self.delegate DingQiBaoEnterProductDetailControllerWithPageIndex:_currentPage];
    }
    
}
-(void)goDingQiBao{
    if ([self.delegate respondsToSelector:@selector(enterDingQibaoProductController)]) {
        [self.delegate enterDingQibaoProductController];
    }
    
}
@end
