//
//  CMPeoplePassword.h
//  CaiMao
//
//  Created by MAC on 16/10/20.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMPeoplePassword : NSObject<NSCoding>
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString*password;
@property(nonatomic,copy)NSString *GesturePass;
@end
