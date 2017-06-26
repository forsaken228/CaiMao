//
//  CMTiXianRecordModel.h
//  CaiMao
//
//  Created by WangWei on 2017/3/31.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMTiXianRecordModel : NSObject

@property(assign,nonatomic)float ActualAmount;
@property(assign,nonatomic)float Amount;
@property(strong,nonatomic)NSString *ApplyDateString;
@property(assign,nonatomic)float Commission;
@property(assign,nonatomic)int State;
@property(assign,nonatomic)int ProcessBatch;
@property(strong,nonatomic)NSString *ZID;

@end
