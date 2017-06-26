//
//  CMRegistSuccessController.h
//  CaiMao
//
//  Created by MAC on 16/8/29.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    isReZhengSuccess = 1,
    isZhuCeSuccess
    
}CMRegistSuccessType;
@interface CMRegistSuccessController : UIViewController
@property (nonatomic, assign) CMRegistSuccessType type;

@end
