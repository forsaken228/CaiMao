//
//  NSString+CMString.m
//  CaiMao
//
//  Created by MAC on 16/10/13.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "NSString+CMString.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
@implementation NSString (CMString)



#pragma mark - 获取联系人姓名首字母(传入汉字字符串, 返回大写拼音首字母)
+ (NSString *)getFirstLetterFromString:(NSString *)aString
{
    
    NSMutableString *mutableString = [NSMutableString stringWithString:aString];
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    NSString *pinyinString = [mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    
    // 将拼音首字母装换成大写
    //NSString *strPinYin = [pinyinString capitalizedString];
    NSString *strPinYin = [[self polyphoneStringHandle:aString pinyinString:pinyinString] uppercaseString];
    // 截取大写首字母
    NSString *firstString = [strPinYin substringToIndex:1];
    // 判断姓名首位是否为大写字母
    NSString * regexA = @"^[A-Z]$";
    NSPredicate *predA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexA];
    // 获取并返回首字母
    return [predA evaluateWithObject:firstString] ? firstString : @"#";
    
}
/**
 多音字处理
 */
+ (NSString *)polyphoneStringHandle:(NSString *)aString pinyinString:(NSString *)pinyinString
{
    if ([aString hasPrefix:@"长"]) { return @"chang";}
    if ([aString hasPrefix:@"沈"]) { return @"shen"; }
    if ([aString hasPrefix:@"厦"]) { return @"xia";  }
    if ([aString hasPrefix:@"地"]) { return @"di";   }
    if ([aString hasPrefix:@"重"]) { return @"chong";}
    return pinyinString;
}

+(void)LoneAttributedFontStringEndString:(NSString*)endStr FromLabel:(UILabel*)FromLabel{
    
    NSMutableAttributedString *qixianStr = [[NSMutableAttributedString alloc] initWithString:FromLabel.text];
    
    NSRange qiToRang = [FromLabel.text rangeOfString:endStr];
    [qixianStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17.0] range:NSMakeRange(0, qiToRang.location)];
    
    FromLabel.attributedText = qixianStr;
    
}

+(void)LoneAttributedStringEndString:(NSString*)endStr FromLabel:(UILabel*)FromLabel{
    
    NSMutableAttributedString *qixianStr = [[NSMutableAttributedString alloc] initWithString:FromLabel.text];
    
    NSRange qiToRang = [FromLabel.text rangeOfString:endStr];
    [qixianStr addAttribute:NSForegroundColorAttributeName value:RedButtonColor range:NSMakeRange(0, qiToRang.location)];
    
    FromLabel.attributedText = qixianStr;
    
}
+(void)DoubleAttributedStringFromString:(NSString*)FromStr andEndString:(NSString*)endStr FromLabel:(UILabel*)FromLabel{
    
    NSMutableAttributedString *qixianStr = [[NSMutableAttributedString alloc] initWithString:FromLabel.text];
    NSRange qiFromRang = [FromLabel.text rangeOfString:FromStr];
    NSRange qiToRang = [FromLabel.text rangeOfString:endStr];
    [qixianStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xfa3e19) range:NSMakeRange(qiFromRang.location + 1, qiToRang.location - qiFromRang.location - 1)];
    [qixianStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17.0] range:NSMakeRange(qiFromRang.location + 1, qiToRang.location - qiFromRang.location - 1)];
    FromLabel.attributedText = qixianStr;
    
}

/*
- (NSString *) md5HexDigest
{
    const char *original_str = [self UTF8String];
    unsigned char result[32];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++){
         [hash appendFormat:@"%02x", result[i]];
    }
    return [hash lowercaseString];
}

*/

+(NSString *)UIImageToBase64Str:(UIImage *)image
{
    NSData *data = UIImageJPEGRepresentation(image,0.6f);

    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodedImageStr;
}
+(void)DoubleStringChangeColer:(UILabel *)mainStr andFromStr:(NSString *)aFromStr ToStr:(NSString *)AToStr withColor:(UIColor*)color{
    
    NSMutableAttributedString *Pay=[[NSMutableAttributedString alloc]initWithString: mainStr.text];
    NSRange PayFromRang1 = [mainStr.text rangeOfString:aFromStr];
    NSRange PayToRang1 = [ mainStr.text rangeOfString:AToStr];
    [Pay addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(PayFromRang1.location+1, PayToRang1.location-PayFromRang1.location-1)];
    mainStr.attributedText = Pay;
    
}


+(void)loneStringChangeColer:(UILabel *)mainStr andFromStr:(NSString *)aFromStr withString:(NSString*)toStr WithColor:(UIColor*)color{
    //UIColorFromRGB(0xfa3e19)
    NSMutableAttributedString *Pay=[[NSMutableAttributedString alloc]initWithString: mainStr.text];
    NSRange PayFromRang1 = [mainStr.text rangeOfString:aFromStr];
    
    [Pay addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(PayFromRang1.location+1,toStr.length)];
    mainStr.attributedText = Pay;
    
}
+(NSString *)md5:(NSString *)str {
    const char *original_str = [str UTF8String];
    unsigned char result[32];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);//调用md5
    
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++){
        [hash appendFormat:@"%02x", result[i]];
    }
    
    return hash;
    
}
+ (BOOL)validateNumber:(NSString*)number{
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

+(NSString*)currentDateFormatter:(NSString *)formatter{
    
    NSDate *date=[NSDate date];
    NSDateFormatter *matter =[[NSDateFormatter alloc]init];
    [matter setDateFormat:formatter];
    NSString *Datestr = [matter stringFromDate:date];
 
    return Datestr;
}


+(NSString*)dictionaryToJson:(NSDictionary *)dic

{
    /*
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
  */
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
       DLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
//    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
//    
//    NSRange range = {0,jsonString.length};
//    
//    //去掉字符串中的空格
//    
//    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
//    
//    NSRange range2 = {0,mutStr.length};
//    
//    //去掉字符串中的换行符
//    
//    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return jsonString;
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
      options:NSJSONReadingMutableContainers    error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}

+(NSString*)encodeString:(NSString*)unencodedString{
    
    NSString*encodedString=(NSString*)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
    (CFStringRef)unencodedString,                                                             NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]",                   kCFStringEncodingUTF8));
    
    return encodedString;
    
}

+ (NSString *)transform:(NSString *)chinese{
    
    NSMutableString *mutableString =[chinese mutableCopy];
    CFStringTransform((CFMutableStringRef)mutableString,NULL,kCFStringTransformToLatin,false);
    mutableString=(NSMutableString*)[mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch
    locale:[NSLocale currentLocale]];
    return mutableString;

}

/*
+(void)shareParamesByText:(NSString*)Content andImages:(id)images andUrl:(NSURL *)url andTitle:(NSString*)title{
    
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:Content
                                     images:images
                                        url:url
                                      title:title
                                       type:SSDKContentTypeAuto];
    [SSUIShareActionSheetStyle setCancelButtonLabelColor:RedButtonColor ];
    [SSUIShareActionSheetStyle setShareActionSheetStyle:ShareActionSheetStyleSimple];
    [SSUIShareActionSheetStyle  isCancelButtomHidden:NO];
    [ShareSDK showShareActionSheet:nil
                             items:@[@(SSDKPlatformTypeQQ),
                                     @(SSDKPlatformSubTypeWechatSession),
                                     @(SSDKPlatformSubTypeWechatTimeline),
                                     @(SSDKPlatformTypeSinaWeibo),                                         ]
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   
                   switch (state) {
                       case SSDKResponseStateSuccess:
                       {
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       case SSDKResponseStateFail:
                       {
                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败" message:[NSString stringWithFormat:@"%@",error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                           [alert show];
                           break;
                       }
                       default:
                           break;
                   }
                   
               }];

}
 */

@end
