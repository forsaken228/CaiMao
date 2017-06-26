//
//  CMYueXiYingList.h
//  CaiMao
//
//  Created by Fengpj on 15/12/18.
//  Copyright © 2015年 58cm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMYueXiYingList : NSObject

/** 月息盈产品id */
@property (assign, nonatomic) int pid;

/** 月息盈产品标题 */
@property (nonatomic, copy) NSString *title;

/** 月息盈产品年收益 */
@property (assign, nonatomic) float nlv;

/** 月息盈产品投资期限 */
@property (assign, nonatomic) int jkqx;

/** 月息盈产品期限单位 */
@property (assign, nonatomic) int jkqx_dw;

/** 月息盈产品起投金额 */
@property (assign, nonatomic) int cpfe;

/** 月息盈产品总计份数 */
@property (assign, nonatomic) int zjfs;

/** 月息盈产品参与人数 */
@property (assign, nonatomic) int jbcnt;

/** 月息盈产品已拍份数 */
@property (assign, nonatomic) int jbfs;

/** 月息盈产品到期时间 */
@property (nonatomic, copy) NSString *dqtime;


@end
