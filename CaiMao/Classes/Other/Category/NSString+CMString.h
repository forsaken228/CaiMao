//
//  NSString+CMString.h
//  CaiMao
//
//  Created by MAC on 16/10/13.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CMString)

+ (NSString *)getFirstLetterFromString:(NSString *)aString;
//+ (NSString *)getPinyin:(NSString *)chinese;
//+(NSString *)shortUrl:(NSString *)url;
+(void)LoneAttributedFontStringEndString:(NSString*)endStr FromLabel:(UILabel*)FromLabel;

+(void)LoneAttributedStringEndString:(NSString*)endStr FromLabel:(UILabel*)FromLabel;

+(void)DoubleAttributedStringFromString:(NSString*)FromStr andEndString:(NSString*)endStr FromLabel:(UILabel*)FromLabel;

+(NSString *)UIImageToBase64Str:(UIImage *)image;

+(void)DoubleStringChangeColer:(UILabel *)mainStr andFromStr:(NSString *)aFromStr ToStr:(NSString *)AToStr withColor:(UIColor*)color;

+(void)loneStringChangeColer:(UILabel *)mainStr andFromStr:(NSString *)aFromStr withString:(NSString*)toStr WithColor:(UIColor*)color;


+(NSString *)md5:(NSString *)str;

+(BOOL)validateNumber:(NSString*)number;

+(NSString*)currentDateFormatter:(NSString*)formatter;

//字典转字符串
+(NSString*)dictionaryToJson:(NSDictionary *)dic;
//json字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;


+(NSString*)encodeString:(NSString*)unencodedString;
/*********汉语转拼音***********/
+ (NSString *)transform:(NSString *)chinese;


//+(void)shareParamesByText:(NSString*)Content andImages:(id)images andUrl:(NSURL *)url andTitle:(NSString*)title;

@end
