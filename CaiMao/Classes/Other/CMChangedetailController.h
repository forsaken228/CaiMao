//
//  CMChangedetailController.h
//  CaiMao
//
//  Created by MAC on 16/10/24.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMChangeDetailViewCell.h"
typedef enum{
    ChangeViewControllerTypePhoneAuthentication = 1,//手机认证
    ChangeViewControllerTypeEmailSetting,//邮箱设置
    ChangeViewControllerTypeEmailChange,//修改邮箱
    ChangeViewControllerTypeDealPasswordSetting,//交易密码设置
    ChangeViewControllerTypeDealPasswordChange,//修改交易密码
    ChangeViewControllerTypeLoginwordChange//修改登录密码
}ChangeViewControllerType;

@interface CMChangedetailController : UITableViewController
@property (nonatomic, assign) ChangeViewControllerType type;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, strong) UIButton *codeButton;
@end
