//
//  CMProductsRecommendedView.h
//  CaiMao
//
//  Created by WangWei on 2017/6/13.
//  Copyright © 2017年 58cm. All rights reserved.
//精品推荐

#import <UIKit/UIKit.h>

@interface CMProductsRecommendedView : UIView
@property(nonatomic,copy)void(^CMProductsRecommendedBlock)(NSInteger index);
@end
