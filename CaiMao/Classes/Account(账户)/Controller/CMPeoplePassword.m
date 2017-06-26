//
//  CMPeoplePassword.m
//  CaiMao
//
//  Created by MAC on 16/10/20.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMPeoplePassword.h"

@implementation CMPeoplePassword
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    //将People类中相关属性进行编码
    //aCoder 编码器
    //当用序列化器 编码对象的时候该方法就会被调用
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_password forKey:@"password"];
    [aCoder encodeObject:_GesturePass forKey:@"GesturePass"];
  
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super init];
    if (self) {
        //解码出来重新赋值给属性
        self.name= [aDecoder decodeObjectForKey:@"name"];
        self.password=  [aDecoder  decodeObjectForKey:@"password"];
        self.GesturePass=  [aDecoder  decodeObjectForKey:@"GesturePass"];
        
    }
    
    return self;
}
@end
