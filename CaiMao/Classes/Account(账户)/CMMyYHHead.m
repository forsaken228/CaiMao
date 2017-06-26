//
//  CMMyYHHead.m
//  CaiMao
//
//  Created by MAC on 16/11/1.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMMyYHHead.h"

@implementation CMMyYHHead

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        NSArray *titleArr=@[@"喵劵",@"提现劵",@"体验劵"];
        for (int i=0; i<titleArr.count; i++) {
            UIButton *topSelectButton=[UIButton buttonWithType:UIButtonTypeCustom];
            topSelectButton.frame=CGRectMake(i%titleArr.count*CMScreenW/3.0, 0, CMScreenW/3.0, self.bounds.size.height);
            [topSelectButton setTitle:titleArr[i] forState:UIControlStateNormal];
            [topSelectButton setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
            topSelectButton.titleLabel.font=[UIFont systemFontOfSize:14.0];
            topSelectButton.tag=i+10;
            [topSelectButton addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
      
            if (i==0) {
                self.selectBtn=topSelectButton;
                topSelectButton.selected=YES;
                [topSelectButton setTitleColor:RedButtonColor forState:UIControlStateSelected];
            }
            [self addSubview:topSelectButton];
            
        }
        
        self.moveView=[[UIView alloc]init];
        self.moveView.backgroundColor=RedButtonColor;
        self.moveView.frame=CGRectMake(0, self.bounds.size.height-2, CMScreenW/3.0, 2);
        [self addSubview:self.moveView];
        
        
    }
    return self;
    
}
-(void)clickBtn:(UIButton*)btn{
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
    //小红条
    self.moveView.center=CGPointMake(btn.center.x, self.moveView.center.y);
    //获得点击按钮的标题
    
    [UIView commitAnimations];


          if ([_delegate respondsToSelector:@selector(choiceViewWithButtonTage:)]) {
        [_delegate choiceViewWithButtonTage:btn.tag];
    }
}

@end
