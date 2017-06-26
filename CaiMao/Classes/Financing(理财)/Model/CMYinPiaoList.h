//
//  CMYinPiaoList.h
//  CaiMao
//
//  Created by Fengpj on 15/12/18.
//  Copyright © 2015年 58cm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMYinPiaoList : NSObject

/** 银票通产品id */
@property (assign, nonatomic) int pid;

/** 银票通产品标题 */
@property (nonatomic, copy) NSString *title;

/** 银票通产品年收益 */
@property (assign, nonatomic) float nlv;

/** 银票通产品投资期限 */
@property (assign, nonatomic) int jkqx;

/** 银票通产品期限单位 */
@property (assign, nonatomic) int jkqx_dw;

/** 银票通产品起投金额 */
@property (assign, nonatomic) int cpfe;

/** 银票通产品总计份数 */
@property (assign, nonatomic) int zjfs;

/** 银票通产品参与人数 */
@property (assign, nonatomic) int jbcnt;

/** 银票通产品已拍份数 */
@property (assign, nonatomic) int jbfs;

/** 银票通产品到期时间 */
@property (nonatomic, copy) NSString *dqtime;

/** 银票通产品担保银行 */
@property (nonatomic, copy) NSString *tgjg;

@end
