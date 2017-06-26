//
//  CMChiYouModel.h
//  CaiMao
//
//  Created by WangWei on 16/12/2.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMChiYouModel : NSObject
/**本金***/
@property(nonatomic,copy)NSString *amountbj;
/**利息***/
@property(nonatomic,copy)NSString *amountlx;
/**日期***/
@property(nonatomic,copy)NSString *dzrq;
@property(nonatomic,assign)int pid;
@property(nonatomic,assign)int piid;
@property(nonatomic,assign)int qibie;
@property(nonatomic,assign)int qishu;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,assign)int zid;
@property(nonatomic,assign)int pageCount;
@end
