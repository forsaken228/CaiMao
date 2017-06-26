//
//  CMCfbTopView.h
//  CaiMao
//
//  Created by MAC on 16/9/1.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMCfbTopView : UIView

{
    
UIView *redView;
}
@property(nonatomic,strong)UILabel *CFBYE;
@property(nonatomic,strong)UILabel *yesterdayGain;
@property(nonatomic,strong)UILabel *totalGain;
@property(nonatomic,strong)UIButton *detaibtn;


@property(nonatomic,strong)UIButton *myBtn;
@property(nonatomic,copy)void (^ CfbBlock)(NSInteger tag);
@end
