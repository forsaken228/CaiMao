//
//  CMMiaoShaList.h
//  CaiMao
//
//  Created by Fengpj on 15/12/23.
//  Copyright © 2015年 58cm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMMiaoShaList : NSObject

/** 喵杀惠产品id */
@property (assign, nonatomic) int pid;

/** 喵杀惠产品标题 */
@property (nonatomic, copy) NSString *title;

/** 喵杀惠产品起始年收益 */
@property (assign, nonatomic) float nlv;

/** 喵杀惠产品最大年收益 */
@property (assign, nonatomic) float nlv_max;

/** 喵杀惠产品投资期限 */
@property (assign, nonatomic) int jkqx;

/** 喵杀惠产品期限单位 */
@property (assign, nonatomic) int jkqx_dw;

/** 喵杀惠产品起投金额 */
@property (assign, nonatomic) int cpfe;

/** 喵杀惠产品到期时间 */
@property (nonatomic, copy) NSString *dqtime;

/** 喵杀惠产品总计份数 */
@property (assign, nonatomic) int zjfs;

/** 喵杀惠产品竞拍人数 */
@property (assign, nonatomic) int jbcnt;

/** 喵杀惠产品已拍份数 */
@property (assign, nonatomic) int jbfs;


@end
