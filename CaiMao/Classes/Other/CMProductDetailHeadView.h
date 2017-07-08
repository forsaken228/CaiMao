//
//  CMProductDetailHeadView.h
//  CaiMao
//
//  Created by MAC on 16/8/9.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface CMProductDetailHeadView : UIView


@property(nonatomic,strong)UILabel *ShouYiZheng;
@property(nonatomic,strong)UILabel *ShouYiXiao;
@property(nonatomic,strong)UILabel *endTime;
@property(nonatomic,strong)UILabel *JinPaiPeopleNum;
@property(nonatomic,strong)UILabel *QIXian;
@property(nonatomic,strong)UILabel *QITouJinEr;
@property(nonatomic,strong)UILabel *SFenShu;
@property(nonatomic,strong)UILabel *ActiveDetail;
@property(nonatomic,strong)UIView *horneLine;
@property(nonatomic,strong)UILabel *shouYilab;

/** 聚嗨利起始收益率 */
@property (strong, nonatomic)  UILabel *juQiShilv;

@property (strong, nonatomic)  UILabel *juShou1;
@property (strong, nonatomic)  UILabel *juRen1;
@property (strong, nonatomic)  UILabel *juShou2;
@property (strong, nonatomic)  UILabel *juRen2;
@property (strong, nonatomic)  UILabel *juShou3;
@property (strong, nonatomic)  UILabel *juRen3;
@property (strong, nonatomic)  UILabel *juShou4;
@property (strong, nonatomic)  UILabel *juRen4;
@property (strong, nonatomic)  UILabel *HaiPeopleNum;

@property (strong, nonatomic)  UIImageView *juImage1;
@property (strong, nonatomic)  UIImageView *juImage2;
@property (strong, nonatomic)  UIImageView *juImage3;
@property (strong, nonatomic)  UIImageView *juImage4;
//@property (strong, nonatomic)  UIImageView *hubImage;
@property (strong, nonatomic)  UIImageView *smallSj;
@property (strong, nonatomic)  UIImageView *topBg;

@property(nonatomic,strong)NSDictionary *productDict;

@property(nonatomic,strong)CMLiCaiDetailController *LiCaiDeati;

@end
