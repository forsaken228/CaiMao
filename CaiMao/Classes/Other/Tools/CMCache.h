//
//  CMCache.h
//  CaiMao
//
//  Created by MAC on 16/9/8.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMCache : NSObject


//设置缓存路径
+(NSString*)getFilePath:(NSString*)name;
//写入沙河
+(void)writeToFileWith:(NSString*)name and:(id)dict;

//设置网络缓存 缓存到Library文件
+(NSString*)getFileWebLoadPath:(NSString*)Filename;
//写入地址
+(void)writeToWebFileWith:(NSString*)name and:(id)fileStyle;


 @end