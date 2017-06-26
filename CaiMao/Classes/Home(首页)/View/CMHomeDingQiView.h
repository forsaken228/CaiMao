//
//  CMHomeDingQiView.h
//  CaiMao
//
//  Created by WangWei on 16/12/1.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CMHomeDingQiViewDelegate <NSObject>

-(void)DingQiBaoEnterPayControllerWithPageIndex:(NSInteger)pageIndex;
-(void)DingQiBaoEnterProductDetailControllerWithPageIndex:(NSInteger)pageIndex;
-(void)enterDingQibaoProductController;

@end
@interface CMHomeDingQiView : UIView<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *dingQiScroller;
@property(nonatomic,assign)NSInteger currentPage;
@property(nonatomic,strong)NSArray *DingQiBaoList;

@property(nonatomic ,weak)id<CMHomeDingQiViewDelegate> delegate;

@end
