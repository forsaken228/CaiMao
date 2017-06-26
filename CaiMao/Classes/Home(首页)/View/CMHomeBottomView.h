//
//  CMHomeBottomView.h
//  CaiMao
//
//  Created by WangWei on 16/12/3.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMHomeBottomView : UIView
@property(nonatomic,copy)void(^bottomBlock)(NSInteger tag);
@end
