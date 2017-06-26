//
//  CMProductsRecommendedView.m
//  CaiMao
//
//  Created by WangWei on 2017/6/13.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import "CMProductsRecommendedView.h"
@interface CMProductsRecommendedView()

@end
@implementation CMProductsRecommendedView

-(id)init{
    self=[super init];
    if (self) {
    
        UIScrollView *renqiScrollView=[[UIScrollView alloc]init];
        renqiScrollView.backgroundColor=[UIColor whiteColor];
        renqiScrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:renqiScrollView];
        [renqiScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.mas_height);
            make.width.left.top.equalTo(self);

        }];
        NSArray *productBackArr=@[@"sy_rqcp_jhl",@"sy_rqcp_msh",@"sy_rqcp_yxy",@"sy_rqcp_18jie",@"sy_rqcp_Queen"];//,@"sy_rqcp_ypt"
        for (int i=0; i<productBackArr.count; i++) {
            UIImage *Image=[UIImage imageNamed:productBackArr[i]];
            UIButton *productBtn=[UIButton buttonWithType:UIButtonTypeSystem];
            productBtn.frame=CGRectMake((i%productBackArr.count)*(Image.size.width+10)+10, 10, Image.size.width, Image.size.height);
            // productBtn.backgroundColor=[UIColor redColor];
            [productBtn setBackgroundImage:Image forState:UIControlStateNormal];
            productBtn.tag=i+20;
            [productBtn addTarget:self action:@selector(moreProductClick:) forControlEvents:UIControlEventTouchUpInside];
            
           renqiScrollView.contentSize = CGSizeMake(productBackArr.count*(Image.size.width)+(productBackArr.count+1)*10, 0);
            [renqiScrollView addSubview:productBtn];
            
        }
        
        
        
    }
    return self;
}

-(void)moreProductClick:(UIButton*)button{
    self.CMProductsRecommendedBlock(button.tag);
}

@end
