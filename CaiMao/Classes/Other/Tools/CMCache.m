//
//  CMCache.m
//  CaiMao
//
//  Created by MAC on 16/9/8.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMCache.h"
@implementation CMCache

#pragma mark 缓存

+(NSString*)getFilePath:(NSString*)name{
    
  // NSFileManager *fileManager=[NSFileManager defaultManager];
   // if(![fileManager fileExistsAtPath:name]){
       NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
        return [doc stringByAppendingPathComponent:name];
   // }

    //return nil;
    
}
+(void)writeToFileWith:(NSString*)name and:(id)dict{
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    
    [dict writeToFile:[doc stringByAppendingPathComponent:name] atomically:YES];
    
}


+(NSString*)getFileWebLoadPath:(NSString*)Filename{
    
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];
    return [doc stringByAppendingPathComponent:Filename];

    
}
+(void)writeToWebFileWith:(NSString*)Filename and:(id)fileStyle{
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];
    
    [fileStyle writeToFile:[doc stringByAppendingPathComponent:Filename] atomically:YES];
    
}
//获取单个文件大小
+(float)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}
//获取目录大小
+(float)folderSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
  static  float folderSize;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            folderSize +=[CMCache fileSizeAtPath:absolutePath];
        }
        folderSize +=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        return folderSize;
    }
    return 0;
}
+(void)clearCache:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] cleanDisk];
}
@end
