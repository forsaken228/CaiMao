//
//  CMContactViewController.h
//  CaiMao
//
//  Created by MAC on 16/10/12.
//  Copyright © 2016年 58cm. All rights reserved.
//手机联系人

#import <UIKit/UIKit.h>
#import "CMGetAddressBook.h"
#import "CMHeadSectionView.h"
#import "CMContactCell.h"
#import "CMGetContactFail.h"
#import "CMContanctBottomView.h"
#import "NSArray+CMArray.h"
#import "CMSendMsgAlert.h"
#import "CMResultModel.h"
#import "CMEmailSearchView.h"
@interface CMContactViewController : UIViewController<CMContactCellDelegate>
@property(nonatomic,copy)NSString *UserName;
//@property(nonatomic,copy)NSString *UserID;
@end
