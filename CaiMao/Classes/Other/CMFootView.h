//
//  CMFootView.h
//  CaiMao
//
//  Created by MAC on 16/11/7.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMVIPCustomImage.h"
@interface CMFootView : UIView
@property(nonatomic,weak)id   delegate;
@end
@protocol CMVIPFootDelegate <NSObject>

-(void)GoChengzhangZhi;

@end