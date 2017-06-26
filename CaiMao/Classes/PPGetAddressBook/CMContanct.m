//
//  CMContanct.m
//  CaiMao
//
//  Created by MAC on 16/10/12.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMContanct.h"

@implementation CMContanct

- (NSMutableArray *)mobileArray
{
    if(!_mobileArray)
    {
        _mobileArray = [NSMutableArray array];
    }
    return _mobileArray;
}
//- (NSMutableArray *)emailsArray
//{
//    if(!_emailsArray)
//    {
//        _emailsArray = [NSMutableArray array];
//    }
//    return _emailsArray;
//}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_Name forKey:@"name"];
    [aCoder encodeObject:_mobileArray forKey:@"mobileArray"];
    [aCoder encodeObject:_Tel forKey:@"phone"];
    [aCoder encodeObject:_headerImage forKey:@"headerImage"];
    [aCoder encodeObject:_Email forKey:@"emailsArray"];
   // [aCoder encodeBool:_isSend forKey:@"isSend"];
    [aCoder encodeBool:_isInvation forKey:@"isInvation"];
    [aCoder encodeObject:_headerbackColor forKey:@"headerbackColor"];
    
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super init];
    if (self)
    {
        self.Name=[aDecoder  decodeObjectForKey:@"name"];
        self.mobileArray=[aDecoder  decodeObjectForKey:@"mobileArray"];
        self.Tel=[aDecoder  decodeObjectForKey:@"phone"];
        self.headerImage=[aDecoder  decodeObjectForKey:@"headerImage"];
        self.Email=[aDecoder  decodeObjectForKey:@"emailsArray"];
       // self.isSend=[aDecoder decodeBoolForKey:@"isSend"];
        self.isInvation=[aDecoder decodeBoolForKey:@"isInvation"];
        self.headerbackColor=[aDecoder decodeObjectForKey:@"headerbackColor"];
    }
    
    return self;
    
}

@end
