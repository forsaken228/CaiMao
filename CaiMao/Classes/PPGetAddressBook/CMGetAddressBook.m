//
//  PPAddressBook.m
//  PPAddressBook
//
//  Created by AndyPang on 16/8/17.
//  Copyright © 2016年 AndyPang. All rights reserved.
//

#import "CMGetAddressBook.h"

#define kCMAddressBookHandle   [CMAddressBookHandle sharedCMAddressBookHandle]

@implementation CMGetAddressBook

+ (void)requestAddressBookAuthorization:(void (^)(void))failure
{
    [kCMAddressBookHandle requestAuthorizationWithSuccessBlock:^{
        //[self getOrderAddressBook:nil authorizationFailure:nil];
       [self getOriginalAddressBook:nil authorizationFailure:^{
          failure();
       }];
//        [self getOrderAddressBook:nil andAddressBook:nil authorizationFailure:^{
//             failure();
//        }];
    }];
  
   
}

+ (void)initialize
{
    //[self getOrderAddressBook:nil authorizationFailure:nil];
    //[self getOrderAddressBook:nil andAddressBook:nil authorizationFailure:nil];
    [self getOriginalAddressBook:nil authorizationFailure:nil];
}

#pragma mark - 获取原始顺序所有联系人
+ (void)getOriginalAddressBook:(AddressBookArrayBlock)addressBookArray authorizationFailure:(AuthorizationFailure)failure
{
    // 将耗时操作放到子线程
    dispatch_queue_t queue = dispatch_queue_create("addressBook.array", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        
        NSMutableArray *array = [NSMutableArray array];
        
        [kCMAddressBookHandle getAddressBookDataSource:^(CMContanct *model) {
            
 
 //去重
           __block BOOL isExist = NO;
           [array enumerateObjectsUsingBlock:^(CMContanct * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               if ([obj.Tel isEqualToString:model.Tel]) {//数组中已经存在该对象
                   *stop = YES;
                   isExist = YES;
               }
           }];
           if (!isExist) {//如果不存在就添加进去
               [array addObject:model];
           }
           
       
            
                
          
            
        } authorizationFailure:^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                failure ? failure() : nil;
            });
        }];
        
        // 将联系人数组回调到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            addressBookArray ? addressBookArray(array) : nil ;
        });
    });
    
}

#pragma mark - 获取按A~Z顺序排列的所有联系人
+ (void)getOrderAddressBook:(AddressBookDictBlock)addressBookInfo andAddressBook:(AddressBookArrayBlock)addressBookArray  authorizationFailure:(AuthorizationFailure)failure
{
    
    // 将耗时操作放到子线程
    dispatch_queue_t queue = dispatch_queue_create("addressBook.infoDict", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        NSMutableDictionary *addressBookDict = [NSMutableDictionary dictionary];
        [kCMAddressBookHandle getAddressBookDataSource:^(CMContanct *model) {
            [array addObject:model];
            //获取到姓名的大写首字母
            NSString *firstLetterString = [NSString getFirstLetterFromString:model.Name];
            //如果该字母对应的联系人模型不为空,则将此联系人模型添加到此数组中
            if (addressBookDict[firstLetterString])
            {
                [addressBookDict[firstLetterString] addObject:model];
            }
            //没有出现过该首字母，则在字典中新增一组key-value
            else
            {
                //创建新发可变数组存储该首字母对应的联系人模型
                NSMutableArray *arrGroupNames = [NSMutableArray arrayWithObject:model];
                //将首字母-姓名数组作为key-value加入到字典中
                [addressBookDict setObject:arrGroupNames forKey:firstLetterString];
            }
        } authorizationFailure:^{
            
                    }];
        
        // 将addressBookDict字典中的所有Key值进行排序: A~Z
        NSArray *nameKeys = [[addressBookDict allKeys] sortedArrayUsingSelector:@selector(compare:)];
        
        // 将排序好的通讯录数据回调到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            
            addressBookInfo ? addressBookInfo(addressBookDict,nameKeys) : nil;
            addressBookArray ? addressBookArray(array) : nil ;

        });
        
       
        
    });
    
}



@end
