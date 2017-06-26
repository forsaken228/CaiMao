//
//  CMJuHaiLiHeadView.h
//  CaiMao
//
//  Created by MAC on 16/7/7.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMJuHaiLiHeadView : UIView
@property(nonatomic,strong)UIButton *moringBtn;
@property(nonatomic,strong)UIButton *nightBtn;
@property(nonatomic,strong)UIView *redView;

-(UIView*)creatHeadViewWithTitle:(NSString*)aTitle WithDetailTitle:(NSString*)aDetail withMoringTitle:(NSString *)aMoring WithNight:(NSString *)aNight andDetailImage:(NSString *)aDetailImage;

@end
