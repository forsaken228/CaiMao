//
//  NSArray+CMArray.m
//  CaiMao
//
//  Created by MAC on 16/10/12.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "NSArray+CMArray.h"
#import <objc/runtime.h>
@implementation NSArray (CMArray)

-(id)objectAtIndexCheack:(NSUInteger)index{
    if (index >= [self count]) {
        return nil;
    }
    
    id value = [self objectAtIndex:index];
    if (value == [NSNull null]) {
        return nil;
    }
    return value;
    
}

@end
