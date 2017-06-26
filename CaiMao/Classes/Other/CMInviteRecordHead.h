//
//  CMInviteRecordHead.h
//  CaiMao
//
//  Created by MAC on 16/8/12.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMInviteRecordHead : UIView
@property(nonatomic,strong)UILabel *jLJE;
@property(nonatomic,strong)UIButton *QYQing;
@property(nonatomic,strong)UILabel *ZCRS;
@property(nonatomic,strong)UILabel *TZRS;

@property(nonatomic,strong)UIView *redView;
@property(nonatomic,strong)UIButton *selectButton;
@property(nonatomic,weak)id delegate;
@end
@protocol CMInviteRecordHeadDelegate <NSObject>

-(void)inviteFriendListWithIndex:(NSInteger)index;

@end
