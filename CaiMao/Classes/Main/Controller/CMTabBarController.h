//
//  CMTabBarController.h
//  CaiMao
//
//  Created by Fengpj on 14-12-12.
//  Copyright (c) 2014年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMTabBarController : UITabBarController<UITabBarControllerDelegate>
-(void)selectTap:(NSInteger)index;
@end