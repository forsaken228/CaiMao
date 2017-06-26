//
//  CMJuHaiLiList.h
//  CaiMao
//
//  Created by Fengpj on 15/12/22.
//  Copyright © 2015年 58cm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMJuHaiLiList : NSObject

/** 聚嗨利产品id */
@property (assign, nonatomic) int pid;

/** 聚嗨利产品标题 */
@property (nonatomic, copy) NSString *title;

/** 聚嗨利产品起始年收益 */
@property (assign, nonatomic) float nlv;

/** 聚嗨利产品最大年收益 */
@property (assign, nonatomic) float nlv_max;

/** 聚嗨利产品投资期限 */
@property (assign, nonatomic) int jkqx;

/** 聚嗨利产品期限单位 */
@property (assign, nonatomic) int jkqx_dw;

/** 聚嗨利产品起投金额 */
@property (assign, nonatomic) int cpfe;

/** 聚嗨利产品到期时间 */
@property (nonatomic, copy) NSString *dqtime;

/** 聚嗨利产品总计份数 */
@property (assign, nonatomic) int zjfs;

/** 聚嗨利产品参与人数 */
@property (assign, nonatomic) int jpRenShu;

/** 聚嗨利产品已拍份数 */
@property (assign, nonatomic) int jbfs;

/** 聚嗨利产品阶段收益率 */
@property (copy, nonatomic) NSArray *ShouYiLv;

@end
