//
//  CMHttpTool.m
//  CaiMao
//
//  Created by Fengpj on 15/1/13.
//  Copyright (c) 2015年 58cm. All rights reserved.
//

#import "CMHttpTool.h"

@implementation CMHttpTool
static  AFHTTPSessionManager *manager;
+(AFHTTPSessionManager*)shareClient{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
            
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.f;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        

        
    });
    return manager;
    
};
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
   
    // 1.获得请求管理者
//    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
//    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [mgr.requestSerializer willChangeValueForKey:@"timeoutInterval"];
//    mgr.requestSerializer.timeoutInterval = 30.f;
//    [mgr.requestSerializer didChangeValueForKey:@"timeoutInterval"];
  
    AFHTTPSessionManager *mgr = [self shareClient];
    // 2.发送GET请求
    [mgr GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            
            success(json);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
            DLog(@"AFHTTPRequestOperationError---   %@",error);
        }
        
        
    }];


}
/*
+ (void)getAndCookiesWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    

    
    // 1.获得请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    [mgr.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    mgr.requestSerializer.timeoutInterval = 30.f;
    [mgr.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [mgr.requestSerializer setValue:[CMUserDefaults objectForKey:@"cookies"] forHTTPHeaderField:@"cookie"];
    // 2.发送GET请求
    [mgr GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            
            success(json);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
            DLog(@"AFHTTPRequestOperationError---   %@",error);
        }
        
        
    }];
    
    
}


*/

+ (void)getRecordWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
 
//    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
//    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
//    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
//    [mgr.requestSerializer willChangeValueForKey:@"timeoutInterval"];
//    mgr.requestSerializer.timeoutInterval = 30.f;
//    [mgr.requestSerializer didChangeValueForKey:@"timeoutInterval"];
     AFHTTPSessionManager *mgr = [self shareClient];
    [ mgr.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain",@"text/html", nil];
    [mgr GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            
            success(json);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
            DLog(@"AFHTTPRequestOperationError---   %@",error);
        }
        
        
    }];
    
    
    
}


+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{

    
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    mgr.requestSerializer.timeoutInterval = 30.f;
    [mgr.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    response.removesKeysWithNullValues=YES;
    mgr.responseSerializer=response;
  //  mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    [mgr.requestSerializer setValue:@"application/json;encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    [mgr.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/javascript", @"text/plain", @"text/html",nil];
    

    [mgr POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            //          NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            //
            
            success(responseObject);
            //success(json);
        }

   
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            
            
            failure(error);
        }
    }];

    
    
    
}
+(void)postMessageURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure{
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    [mgr.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    mgr.requestSerializer.timeoutInterval = 30.f;
    [mgr.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    response.removesKeysWithNullValues=YES;
    mgr.responseSerializer=response;
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    [mgr POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            //NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            
            
            failure(error);
        }
    }];
    

    
}


+(BOOL)cheackNet{

    
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if(status==AFNetworkReachabilityStatusNotReachable){
            
            [CMUserDefaults setInteger:1 forKey:@"Reachable"];
            [CMUserDefaults synchronize];
            
        }else{
            [CMUserDefaults setInteger:0 forKey:@"Reachable"];
             [CMUserDefaults synchronize];
             
        }
            }];
    

   [manager startMonitoring];
    if ([[CMUserDefaults objectForKey:@"Reachable"]intValue]==1) {
        return YES;
    }else{
        return NO;
    }

}



@end
