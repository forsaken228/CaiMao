//
//  CMZhuanChuFootView.h
//  CaiMao
//
//  Created by MAC on 16/11/10.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMZhuanChuFootView : UIView
@property(nonatomic,strong)UIButton *ZhuangChuBtn;
@property(nonatomic,strong)UILabel *DetailLabel;
-(instancetype)initWithButtonTitle:(NSString*)title;
@end
