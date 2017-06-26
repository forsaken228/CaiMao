//
//  CMUserMsgCell.h
//  CaiMao
//
//  Created by MAC on 16/6/15.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMUserMsgCell : UITableViewCell

@property (strong, nonatomic)  UIButton *NameDetail;
@property (strong, nonatomic)  UIButton *bankDetail;
@property (strong, nonatomic)  UIButton *joinMakeSure;
@property (strong, nonatomic)  UIButton *supportBank;
@property (strong, nonatomic)  UILabel *errorLabel;
@property (strong, nonatomic)  UITextField *realName;
@property (strong, nonatomic)  UITextField *realNameId;
@property (strong, nonatomic)  UITextField *tBankNum;


@end
