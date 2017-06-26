//
//  CMXinKeList.h
//  CaiMao
//
//  Created by Fengpj on 16/1/6.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMXinKeList : NSObject

/** 新客产品id */
@property (assign, nonatomic) int pid;

/** 新客产品标题 */
@property (nonatomic, copy) NSString *title;

/** 新客产品最大年收益 */
@property (assign, nonatomic) float nlv_max;

/** 新客产品年收益 */
@property (assign, nonatomic) float nlv;

/** 新客产品投资期限 */
@property (assign, nonatomic) int jkqx;

/** 新客产品期限单位 */
@property (assign, nonatomic) int jkqx_dw;

/** 新客产品起投金额 */
@property (assign, nonatomic) int cpfe;


@end
