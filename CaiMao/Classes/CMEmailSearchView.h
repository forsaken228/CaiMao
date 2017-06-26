//
//  CMEmailSearchView.h
//  CaiMao
//  Created by WangWei on 16/12/26.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMEmailSearchView : UIView
@property(nonatomic,strong)UIImageView *EmailImageView;
@property(nonatomic,strong)UIView *JoinView;
@property(nonatomic,strong)UIImageView *speakView;
@property(nonatomic,strong)UILabel *JoinPeopleLabel;
@property(nonatomic,copy)void(^QQEmailLogin)(void);
@end

