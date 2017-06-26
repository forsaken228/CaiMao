//
//  CMDingQiBaoList.h
//  CaiMao
//
//  Created by Fengpj on 15/12/11.
//  Copyright © 2015年 58cm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMDingQiBaoList : NSObject

/** 定期宝产品id */
@property (assign, nonatomic) int pid;

/** 定期宝产品标题 */
@property (nonatomic, copy) NSString *title;

/** 定期宝产品年收益 */
@property (assign, nonatomic) float nlv;

/** 定期宝产品投资期限 */
@property (assign, nonatomic) int jkqx;

/** 定期宝产品期限单位 */
@property (assign, nonatomic) int jkqx_dw;

/** 定期宝产品起投金额 */
@property (assign, nonatomic) int cpfe;

/** 定期宝产品总计份数 */
@property (assign, nonatomic) int zjfs;

/** 定期宝产品参与人数 */
@property (assign, nonatomic) int jbcnt;

/** 定期宝产品已拍份数 */
@property (assign, nonatomic) int jbfs;

/** 定期宝产品到期时间 */
@property (nonatomic, copy) NSString *dqtime;



@end
