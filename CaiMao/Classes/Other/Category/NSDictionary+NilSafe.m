//
//  NSDictionary+NilSafe.m
//  NSDictionary-NilSafe
//
//  Created by WangWei on 2017/6/2.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import <objc/runtime.h>
#import "NSDictionary+NilSafe.h"

@implementation NSObject (Swizzling)

+ (BOOL)gl_swizzleMethod:(SEL)origSel withMethod:(SEL)altSel {
    Method origMethod = class_getInstanceMethod(self, origSel);
    Method altMethod = class_getInstanceMethod(self, altSel);
    if (!origMethod || !altMethod) {
        return NO;
    }
    class_addMethod(self,
                    origSel,
                    class_getMethodImplementation(self, origSel),
                    method_getTypeEncoding(origMethod));
    class_addMethod(self,
                    altSel,
                    class_getMethodImplementation(self, altSel),
                    method_getTypeEncoding(altMethod));
    method_exchangeImplementations(class_getInstanceMethod(self, origSel),
                                   class_getInstanceMethod(self, altSel));
    return YES;
}

+ (BOOL)gl_swizzleClassMethod:(SEL)origSel withMethod:(SEL)altSel {
    return [object_getClass((id)self) gl_swizzleMethod:origSel withMethod:altSel];
}

@end

@implementation NSDictionary (NilSafe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self gl_swizzleMethod:@selector(initWithObjects:forKeys:count:) withMethod:@selector(gl_initWithObjects:forKeys:count:)];
        [self gl_swizzleClassMethod:@selector(dictionaryWithObjects:forKeys:count:) withMethod:@selector(gl_dictionaryWithObjects:forKeys:count:)];
    });
}

+ (instancetype)gl_dictionaryWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt {
    
    
    id instance = nil;
    
    @try {
        instance = [self gl_dictionaryWithObjects:objects forKeys:keys count:cnt];
    }
    @catch (NSException *exception) {
        
        //处理错误的数据，然后重新初始化一个字典
        NSUInteger index = 0;
        id  _Nonnull __unsafe_unretained newObjects[cnt];
        id  _Nonnull __unsafe_unretained newkeys[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i] && keys[i]) {
                newObjects[index] = objects[i];
                newkeys[index] = keys[i];
                index++;
            }
        }
        instance = [self gl_dictionaryWithObjects:objects forKeys:keys count:cnt];
    }
    @finally {
        return instance;
    }


   
}

- (instancetype)gl_initWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt {
    id instance = nil;
    
    @try {
        instance = [self gl_initWithObjects:objects forKeys:keys count:cnt];
    }
    @catch (NSException *exception) {
        
        //处理错误的数据，然后重新初始化一个字典
        NSUInteger index = 0;
        id  _Nonnull __unsafe_unretained newObjects[cnt];
        id  _Nonnull __unsafe_unretained newkeys[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i] && keys[i]) {
                newObjects[index] = objects[i];
                newkeys[index] = keys[i];
                index++;
            }
        }
        instance = [self gl_initWithObjects:objects forKeys:keys count:cnt];
    }
    @finally {
        return instance;
    }

}

@end

@implementation NSMutableDictionary (NilSafe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = NSClassFromString(@"__NSDictionaryM");
        [class gl_swizzleMethod:@selector(setObject:forKey:) withMethod:@selector(gl_setObject:forKey:)];
        [class gl_swizzleMethod:@selector(setObject:forKeyedSubscript:) withMethod:@selector(gl_setObject:forKeyedSubscript:)];
    });
}

- (void)gl_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (anObject == nil) {
        @try {
            [self gl_setObject:anObject forKey:aKey];
        }
        @catch (NSException *exception) {
            DLog(@"---------- %s Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
            DLog(@"%@", [exception callStackSymbols]);
            anObject = [NSString stringWithFormat:@""];
            [self gl_setObject:anObject forKey:aKey];
        }
        @finally {}
    }else {
       [self gl_setObject:anObject forKey:aKey];
    }
}

- (void)gl_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    if (obj == nil) {
        @try {
            [self gl_setObject:obj forKeyedSubscript:key];
        }
        @catch (NSException *exception) {
            DLog(@"---------- %s Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
            DLog(@"%@", [exception callStackSymbols]);
            obj = [NSString stringWithFormat:@""];
           [self gl_setObject:obj forKeyedSubscript:key];
        }
        @finally {}
    }else {
        [self gl_setObject:obj forKeyedSubscript:key];
    }
}

@end

@implementation NSNull (NilSafe)


+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self gl_swizzleMethod:@selector(methodSignatureForSelector:) withMethod:@selector(gl_methodSignatureForSelector:)];
        [self gl_swizzleMethod:@selector(forwardInvocation:) withMethod:@selector(gl_forwardInvocation:)];
    });
}

- (NSMethodSignature *)gl_methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *sig = [self gl_methodSignatureForSelector:aSelector];
    if (sig) {
        return sig;
    }
    return [NSMethodSignature signatureWithObjCTypes:@encode(void)];
}

- (void)gl_forwardInvocation:(NSInvocation *)anInvocation {
    NSUInteger returnLength = [[anInvocation methodSignature] methodReturnLength];
    if (!returnLength) {
        // nothing to do
        return;
    }

    // set return value to all zero bits
    char buffer[returnLength];
    memset(buffer, 0, returnLength);

    [anInvocation setReturnValue:buffer];
}

@end

