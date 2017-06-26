//
//  CMCookie.m
//  CaiMao
//
//  Created by WangWei on 17/1/3.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import "CMCookie.h"

@implementation CMCookie


+(void)getAndSaveCookie{
    
    //获取cookie
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];

    NSHTTPCookie *cookie=cookies.firstObject;
    [CMUserDefaults setObject: cookie.name forKey: @"cookieName"];
    [CMUserDefaults setObject: cookie.value forKey: @"cookieVaule"];
    NSDictionary* requestFields=[NSHTTPCookie requestHeaderFieldsWithCookies:cookies];

    [CMUserDefaults setObject:[requestFields objectForKey:@"Cookie"] forKey:@"cookies"];
}


+(void)deleteCookie{
    
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    
    //删除cookie
    for (NSHTTPCookie *tempCookie in cookies) {
        [cookieStorage deleteCookie:tempCookie];
    }
    
    [CMUserDefaults  removeObjectForKey:@"cookieName"];
    [CMUserDefaults removeObjectForKey:@"cookieVaule"];
    [CMUserDefaults removeObjectForKey:@"cookies"];
}


+(void)setCoookieForHost:(NSString *)Host{
    
    NSString *name=[CMUserDefaults  objectForKey:@"cookieName"];
    NSString *Vaule=[CMUserDefaults objectForKey:@"cookieVaule"];
    if (name==nil&&Vaule==nil) {
        return ;
    }
    
    NSMutableDictionary *cookiePreperties = [NSMutableDictionary dictionary];
    [cookiePreperties setObject:Vaule forKey:NSHTTPCookieValue];
    if (name!=nil) {

    [cookiePreperties setObject:name forKey:NSHTTPCookieName];
        }
    [cookiePreperties setObject:Host forKey:NSHTTPCookieDomain];
    [cookiePreperties setObject:Host forKey:NSHTTPCookieOriginURL];
    [cookiePreperties setObject:@"/" forKey:NSHTTPCookiePath];
    [cookiePreperties setObject:@"0" forKey:NSHTTPCookieVersion];
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookiePreperties];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    
    NSArray * heardCookie = [NSHTTPCookie cookiesWithResponseHeaderFields:[NSDictionary
                                                                           dictionaryWithObject:[[NSString alloc]            initWithFormat:@"%@=%@", name,Vaule]
                                                                           forKey:@"Set-Cookie"]
                                                                   forURL:[NSURL URLWithString:[Host stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    [[NSHTTPCookieStorage sharedHTTPCookieStorage]setCookies:heardCookie forURL:[NSURL URLWithString:[Host stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] mainDocumentURL:nil];
    
}
@end
