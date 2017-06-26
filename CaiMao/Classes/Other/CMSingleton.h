//
//  CMSingleton.h
//  CaiMao
//
//  Created by WangWei on 16/11/22.
//  Copyright © 2016年 58cm. All rights reserved.
//

#ifndef CMSingleton_h
#define CMSingleton_h


// .h文件
#define CMSingletonH(className) \
+ (className*)shared##className;

// .m文件
#define CMSingletonM(className) \
static className *_instance; \
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (className*)shared##className \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return _instance; \
}


#endif /* CMSingleton_h */
