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

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(objectAtIndex:);
        SEL swizzledSelector = @selector(em_objectAtIndex:);
        
        Method originalMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), originalSelector);
        Method swizzledMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(objc_getClass("__NSArrayI"),
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(objc_getClass("__NSArrayI"),
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }

    });
    
   
}

- (void)em_objectAtIndex:(NSUInteger)index {
    if (self.count - 1 < index) {
        @try {
            return[self em_objectAtIndex:index];
        }
        @catch (NSException *exception) {
            DLog(@"-------- %s Crash Because Method %s -------\n",class_getName(self.class),__func__);
            DLog(@"%@", [exception callStackSymbols]);
        }
        @finally {
            
        }
    }else {
        return [self em_objectAtIndex:index];
    }
}
@end
@implementation NSMutableArray (CMMutableArray)
+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(objectAtIndex:);
        SEL swizzledSelector = @selector(em_objectAtIndex:);
        
        Method originalMethod = class_getInstanceMethod(objc_getClass("__NSArrayM"), originalSelector);
        Method swizzledMethod = class_getInstanceMethod(objc_getClass("__NSArrayM"), swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(objc_getClass("__NSArrayM"),
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(objc_getClass("__NSArrayM"),
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
    });
    
    
}

- (void)em_objectAtIndex:(NSUInteger)index {
    if (self.count - 1 < index) {
        @try {
            return[self em_objectAtIndex:index];
        }
        @catch (NSException *exception) {
            DLog(@"-------- %s Crash Because Method %s -------\n",class_getName(self.class),__func__);
            DLog(@"%@", [exception callStackSymbols]);
        }
        @finally {
            
        }
    }else {
        return [self em_objectAtIndex:index];
    }
}

@end
