//
//  CMMoneyRecordModel.h
//  CaiMao
//
//  Created by WangWei on 17/3/27.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMMoneyRecordModel : NSObject

@property(nonatomic,copy)NSString *Title;
@property(nonatomic,assign)float  Amount;
@property(nonatomic,copy)NSString *CreateDateTime;
@property(nonatomic,copy)NSString *StateString;
@property(nonatomic,assign)float Balance;


@end
