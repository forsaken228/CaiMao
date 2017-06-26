//
//  CMHomeNewActionView.h
//  CaiMao
//
//  Created by WangWei on 16/12/3.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CMHomeNewActionViewDelegate <NSObject>

-(void)enterNewActionController;//进入公告页面
-(void)enterProductWebController:(NSString*)url;
-(void)PicActionEnterProductWebController:(NSString*)url;
@end
@interface CMHomeNewActionView : UIView
@property (strong, nonatomic)  UIButton *dongBtn1;
@property (strong, nonatomic)  UIButton *dongBtn2;

@property (strong, nonatomic)  UIImageView *dongtaiImageView;
@property (strong, nonatomic)  UILabel *dongTitleLab;

/*******************动态标题数组**************************/
@property (strong, nonatomic)  NSMutableArray *dongTitleArr;
/*******************动态广告图片链接数组**************************/
@property (strong, nonatomic)  NSMutableArray *dongAdUrlArr;
/*******************动态广告链接详情数组**************************/
@property (strong, nonatomic)  NSMutableArray *dongLinkUrlArr;
@property(nonatomic,strong)NSArray *responseArr;
@property(nonatomic,weak)id <CMHomeNewActionViewDelegate>delegate;


@end
