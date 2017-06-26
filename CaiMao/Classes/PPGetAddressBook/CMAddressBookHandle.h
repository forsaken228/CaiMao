

#import <Foundation/Foundation.h>
#import <Contacts/Contacts.h>
#import <AddressBook/AddressBook.h>

#import "CMContanct.h"
#import "CMSingleton.h"
/** 一个联系人的相关信息*/
typedef void(^CMContanctBlock)(CMContanct *model);
/** 授权失败的Block*/
typedef void(^AuthorizationFailure)(void);
@interface CMAddressBookHandle : NSObject

CMSingletonH(CMAddressBookHandle)


/**
 请求用户通讯录授权

 @param success 授权成功的回调
 */
- (void)requestAuthorizationWithSuccessBlock:(void(^)(void))success;

/**
 *  返回每个联系人的模型
 *
 *  @param personModel 单个联系人模型
 *  @param failure     授权失败的Block
 */
- (void)getAddressBookDataSource:(CMContanctBlock)personModel authorizationFailure:(AuthorizationFailure)failure;

@end
