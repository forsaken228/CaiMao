//
//  CMChargeRecordModel.h
//  CaiMao
//
//  Created by WangWei on 17/3/27.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMChargeRecordModel : NSObject

@property(nonatomic,copy)NSString *ReChangeDateTime;
@property(nonatomic,assign)float  ReChangeAmount;
@property(nonatomic,copy)NSString *RecordID;
@property(nonatomic,copy)NSString *Source;
@property(nonatomic,assign)int State;
@property(nonatomic,assign)int Status;

@end
