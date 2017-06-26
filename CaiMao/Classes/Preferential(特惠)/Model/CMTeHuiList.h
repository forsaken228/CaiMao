//
//  CMTeHuiList.h
//  CaiMao
//
//  Created by Fengpj on 16/1/5.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMTeHuiList : NSObject

/** 特惠id */
@property (nonatomic, copy) NSString *adID;

/** 特惠产品标题 */
@property (nonatomic, copy) NSString *title;

/** 特惠内容 */
@property (nonatomic, copy) NSString *content;

/** 特惠图片url */
@property (nonatomic, copy) NSString *adUrl;

/** 特惠链接url */
@property (nonatomic, copy) NSString *linkUrl;

/** 特惠链接type */
@property (nonatomic, assign) int  type;

@end
