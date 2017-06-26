//
//  CMProductBottomview.h
//  CaiMao
//
//  Created by WangWei on 17/1/10.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMJipaiView.h"

#import "CMButtonTextView.h"

@interface CMProductBottomview : UIView

////减少
//@property(nonatomic,strong)UIButton *reduceBtn;
////增加
//@property(nonatomic,strong)UIButton *increaseBtn;
////输入
//@property(nonatomic,strong)UITextField *inPutText;

@property(nonatomic,strong)CMButtonTextView *ButtonText;
@property(nonatomic,strong)CMJipaiView *jiPaiView;
@end
