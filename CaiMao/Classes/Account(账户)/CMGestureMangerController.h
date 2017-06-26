//
//  CMGestureMangerController.h
//  CaiMao
//
//  Created by MAC on 16/8/24.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMGestureMangerController : UITableViewController
@property(nonatomic,copy)void(^block)(void);
@end
