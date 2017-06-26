//
//  CMVIPModel.h
//  CaiMao
//
//  Created by MAC on 16/11/8.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMVIPModel : NSObject

/** VIPid */
@property (assign, nonatomic) int pid;

/** VIP产品标题 */
@property (nonatomic, copy) NSString *title;

/**VIP产品最低年收益 */
@property (assign, nonatomic) float nlv;

/**VIP产品最高年收益 */
@property (copy, nonatomic) NSString *nlv_max;
/** VIP产品投资期限 */
@property (assign, nonatomic) int jkqx;

/** VIP产品类型 */
@property (assign, nonatomic) int hkfs;
/** VIP收益类型 */
@property (assign, nonatomic) int sylx;
/** VIP产品期限单位 */
@property (copy, nonatomic) NSString *jkqx_dw;

/** VIP产品起投金额 */
@property (assign, nonatomic) int cpfe;
/** VIP产品起投金额 */
@property (assign, nonatomic) float Lixi;
/** VIP产品产品总计份数 */
@property (copy, nonatomic) NSString *zjfs;
@property (assign, nonatomic) int zrsh;
@property (assign, nonatomic) int zrys;
@property (assign, nonatomic) int jedw;
@property (copy, nonatomic) NSString *jyfs;
@property (copy, nonatomic) NSString *Amount;
@property (copy, nonatomic) NSString *cplb;
/** VIP产品参与人数 */
@property (assign, nonatomic) int jbcnt;

/**VIP产品已拍份数 */
@property (assign, nonatomic) int jbfs;

/** VIP产品到期时间 */
@property (nonatomic, copy) NSString *dqtime;

/** VIP产品个数 */
@property (nonatomic, assign) int productCount;

@end
