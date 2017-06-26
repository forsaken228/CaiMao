//
//  CMRecordOfCharge.h
//  CaiMao
//
//  Created by MAC on 16/7/14.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLTabedSlideView.h"
@interface CMRecordOfCharge : UIViewController<DLTabedSlideViewDelegate>
@property (strong, nonatomic)  DLTabedSlideView *tabedSlideView;
@property (assign, nonatomic)   int selectIndex;
@end
