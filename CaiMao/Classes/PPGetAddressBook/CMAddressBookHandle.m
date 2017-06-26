//
//  PPDataHandle.m
//  PPAddressBook
//
//  Created by AndyPang on 16/8/17.
//  Copyright © 2016年 AndyPang. All rights reserved.
//

#import "CMAddressBookHandle.h"


@interface CMAddressBookHandle ()

/** iOS9之前的通讯录对象*/
//@property (nonatomic) ABAddressBookRef addressBook;

#ifdef __IPHONE_9_0
/** iOS9之后的通讯录对象*/
//@property (nonatomic, strong) CNContactStore *contactStore;
#endif

@end

@implementation CMAddressBookHandle

CMSingletonM(CMAddressBookHandle)

- (void)requestAuthorizationWithSuccessBlock:(void (^)(void))success
{
    
    if(IOS9_LATER)
    {
//#ifdef __IPHONE_9_0
        // 1.判断是否授权成功,若授权成功直接return
        if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusAuthorized) return;
        // 2.创建通讯录
        CNContactStore *store = [[CNContactStore alloc] init];
        // 3.授权
        [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
               DLog(@"授权成功");
             
               [CMNSNotice postNotificationName:@"requestAccessSuccess" object:self];
             
                success();
                
            }else{
         
                DLog(@"-----授权失败");
//                NSArray *userArr=[CMUserDefaults objectForKey:@"userArr"];
//
//                [[NSFileManager defaultManager]removeItemAtPath: [CMCache getFilePath:[NSString stringWithFormat:@"%@Contanct.plist",[[userArr objectAtIndex:0] valueForKey:@"userID"]]] error:nil];
                
            }
        }];
//#endif
    }
    else
    {
        // 1.获取授权的状态
        ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
        // 2.判断授权状态,如果是未决定状态,才需要请求
        if (status == kABAuthorizationStatusNotDetermined) {
            // 3.创建通讯录进行授权
            ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                if (granted) {
                    [CMNSNotice postNotificationName:@"requestAccessSuccess" object:self];
                    //[CMUserDefaults setObject:[NSDate date] forKey:@"upLoadContanctData"];
                    //[CMUserDefaults synchronize];
                    DLog(@"授权成功");
                    success();
                } else {
                   // [CMNSNotice postNotificationName:@"requestAccessFailure" object:self];
    
                    DLog(@"授权失败");
                    
                }
            });
        }
        
    }
    
}


- (void)getAddressBookDataSource:(CMContanctBlock)personModel authorizationFailure:(AuthorizationFailure)failure
{
    
    if(IOS9_LATER)
{
        [self getDataSourceFrom_IOS9_Later:personModel authorizationFailure:failure];
   }
    else
   {
        [self getDataSourceFrom_IOS9_Ago:personModel authorizationFailure:failure];
    }
    
}

#pragma mark - IOS9之前获取通讯录的方法
- (void)getDataSourceFrom_IOS9_Ago:(CMContanctBlock)personModel authorizationFailure:(AuthorizationFailure)failure
{
    // 1.获取授权状态
    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
    
    // 2.如果没有授权,先执行授权失败的block后return
    if (status != kABAuthorizationStatusAuthorized/** 已经授权*/)
    {
        failure ? failure() : nil;
        return;
    }
    
    // 3.创建通信录对象
 ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    
    //4.按照排序规则从通信录对象中请求所有的联系人,并按姓名属性中的姓(LastName)来排序
    ABRecordRef recordRef = ABAddressBookCopyDefaultSource( addressBook);
     //CFRetain(recordRef);
  
    CFArrayRef allPeopleArray = ABAddressBookCopyArrayOfAllPeopleInSourceWithSortOrdering(addressBook,recordRef, kABPersonSortByLastName);
   
     // 5.遍历每个联系人的信息,并装入模型
    for(id personInfo in (__bridge  NSArray *)(allPeopleArray))
    {
        
        // 5.1获取到联系人
        ABRecordRef person = (__bridge ABRecordRef)(personInfo);
        
              // 5.4获取每个人所有的电话号码
        ABMultiValueRef phones = ABRecordCopyValue(person, kABPersonPhoneProperty);
                CFIndex phoneCount = ABMultiValueGetCount(phones);
        for (CFIndex i = 0; i < phoneCount; i++)
        {
            
         
            
            // 号码
            NSString *phoneValue = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(phones, i);
            NSString *mobile = [self removeSpecialSubString:phoneValue];
            if([CMRegularJudement checkTelNumber:mobile]){
            CMContanct *model = [CMContanct new];
                model.Tel=mobile.length > 0 ? mobile : @"" ;
            model.isSend=NO;
            model.isInvation=NO;
            // 5.2获取全名
            NSString *name = (__bridge_transfer NSString *)ABRecordCopyCompositeName(person);
            model.Name = name.length > 0 ? name : mobile ;
            
          //  int num=1+arc4random()%4;
           // UIImage *image1=[UIImage imageNamed:[NSString stringWithFormat:@"contanctHeadIcon_%d",num]];
            
            // 5.3获取头像数据
            NSData *imageData = (__bridge_transfer NSData *)ABPersonCopyImageDataWithFormat(person, kABPersonImageFormatThumbnail);
           // UIImage *image=[UIImage imageWithData:imageData];
            //NSData *data=UIImagePNGRepresentation(image);
          //  NSData *data1=UIImagePNGRepresentation(image1);
            model.headerImage = imageData==nil ? nil : imageData;
                model.headerbackColor=[self randomColor];
           // model.headerImage = ABPersonHasImageData(person) ? image:image1;
            

                      //[model.mobileArray addObject: mobile ? mobile : @"空号"];
            //5.5获取邮箱
            //读取邮箱多值
            ABMultiValueRef emails = ABRecordCopyValue(person, kABPersonEmailProperty);
            if (emails){ //如果有邮箱数据
                CFIndex emailCount = ABMultiValueGetCount(emails);
                for (CFIndex i = 0; i < emailCount; i++) {
                    //转化为多个邮箱数据为字符串
                    // NSString *label       = (__bridge NSString *)ABMultiValueCopyLabelAtIndex(emails, i);
                   // NSString* emailLabel = (__bridge NSString *)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(emails, i));
                    NSString *emailContent      = (__bridge NSString *)ABMultiValueCopyValueAtIndex(emails, i);
                    
                    // NSLog(@"email label (%@), number (%@)", label, value);
                    NSString *appendString=[NSString stringWithFormat:@"%@",emailContent];
                  //  [model.emailsArray addObject:appendString];
                     model.Email=appendString.length > 0 ? appendString : @"" ;
                    
                }
            }
            //释放内存，返回数据
            
            // 5.6将联系人模型回调出去
            personModel ? personModel(model) : nil;
            
            
           CFRelease(emails);
          }
        }
       CFRelease(phones);
    }
    
    // 释放不再使用的对象
  CFRelease(allPeopleArray);
   // CFRelease(self.addressBook);
   // CFRelease(recordRef);
    
}

#pragma mark - IOS9之后获取通讯录的方法
- (void)getDataSourceFrom_IOS9_Later:(CMContanctBlock)personModel authorizationFailure:(AuthorizationFailure)failure
{
//#ifdef __IPHONE_9_0
    // 1.获取授权状态
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    // 2.如果没有授权,先执行授权失败的block后return
    if (status != CNAuthorizationStatusAuthorized)
    {
        failure ? failure() : nil;
        return;
    }
    // 3.获取联系人
    // 3.1.创建联系人仓库
    CNContactStore *store = [[CNContactStore alloc] init];
    
    // 3.2.创建联系人的请求对象
    // keys决定能获取联系人哪些信息,例:姓名,电话,头像等
    NSArray *fetchKeys = @[[CNContactFormatter descriptorForRequiredKeysForStyle:CNContactFormatterStyleFullName],CNContactPhoneNumbersKey,CNContactThumbnailImageDataKey,CNContactEmailAddressesKey];
    CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:fetchKeys];
    
    // 3.3.请求联系人
    [store enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact,BOOL * _Nonnull stop) {
        
      // CMContanct *model = [CMContanct new];
        
        // 获取一个人的所有电话号码
        NSArray *phones = contact.phoneNumbers;
        
        for (CNLabeledValue *labelValue in phones)
        {
           
            CNPhoneNumber *phoneNumber = labelValue.value;
            NSString *mobile = [self removeSpecialSubString:phoneNumber.stringValue];
            
            if([CMRegularJudement checkTelNumber:mobile]){
             CMContanct *model = [CMContanct new];
            
            model.Tel=mobile.length > 0 ? mobile : @"" ;
          //  [model.mobileArray addObject: mobile ? mobile : @""];
            
            // 获取联系人全名
            NSString *name = [CNContactFormatter stringFromContact:contact style:CNContactFormatterStyleFullName];
            model.isSend=NO;
            //model.isInvation=NO;
            model.Name = name.length > 0 ? name : mobile ;
   
                
                model.isInvation=NO;
           
           // int num=1+arc4random()%4;
            //UIImage *image1=[UIImage imageNamed:[NSString stringWithFormat:@"contanctHeadIcon_%d",num]];
            UIImage *image=[UIImage imageWithData:contact.thumbnailImageData];
            // 联系人头像
            NSData *data=UIImagePNGRepresentation(image);
          //  NSData *data1=UIImagePNGRepresentation(image1);
            model.headerImage = data==nil ? nil : data;
          model.headerbackColor=[self randomColor];
                
            //将联系人模型回调出去
            NSArray *emails= contact.emailAddresses;
            for (CNLabeledValue *emailValue in emails)
            {
                
                
                NSString *email=emailValue.value;
                //DLog(@"手机===%@---邮箱---%@---email--%@",phones,emails,email);
                model.Email=email ? email : @"";
               // [model.emailsArray addObject:email ? email : @""];
            }
            
            personModel ? personModel(model) : nil;
}
        }
        
        
    }];
//endif
    
}

//过滤指定字符串(可自定义添加自己过滤的字符串)
- (NSString *)removeSpecialSubString: (NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"+86" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"-" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"(" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@")" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return string;
}

-(UIColor *) randomColor
{

    NSArray *colorArr=@[UIColorFromRGB(0x8355e4),UIColorFromRGB(0x4c79fc),UIColorFromRGB(0xfc793d),UIColorFromRGB(0xfc5e66)];
    
    return colorArr[arc4random()%4];
}

@end
