//
//  CMHomeBottomView.m
//  CaiMao
//
//  Created by WangWei on 16/12/3.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMHomeBottomView.h"

@implementation CMHomeBottomView
-(instancetype)init{
    self=[super init];
    if (self) {
        
        NSArray *midTitle=@[@"银行资产保安全",@"银行托管保安全",@"劣后资金保安全"];
        NSArray *bottomTitle=@[@"基础资产是政府债",@"资金银行监管",@"历史交易全部兑现"];
        NSArray *bottomTitle1=@[@"来源于银行",@"专款专户专用",@"无逾期"];
        for (int i=0; i<midTitle.count; i++) {
            
            UIImage *image=[UIImage imageNamed:[NSString stringWithFormat:@"bottom_0%d",i+1]];
            CMCustomBottomView *footerView=[[CMCustomBottomView alloc]init];
            footerView.frame=CGRectMake(i%midTitle.count*CMScreenW/3.0, 0, CMScreenW/3.0, 105);
            footerView.backgroundColor=[UIColor whiteColor];
            footerView.topImageView.image=image;
            footerView.bottomLabel.text=bottomTitle[i];
            footerView.bottomLabel1.text=bottomTitle1[i];
            footerView.midLaebel.text=midTitle[i];
            footerView.tag=i+10;
            if (i==2) {
                [footerView.VerLine removeFromSuperview];
                
            }
            [self addSubview:footerView];
            [footerView.topImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(f_i5real(image.size.height));
                make.width.mas_equalTo(f_i5real(image.size.width));
            }];
            UITapGestureRecognizer  *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(safetyBtnClick:)];
            [footerView addGestureRecognizer:tap];
            
        }
 
        
        
    }
    return self;
}
- (void)safetyBtnClick:(UITapGestureRecognizer *)tap
{
    self.bottomBlock(tap.view.tag);
        
        
    }

@end
