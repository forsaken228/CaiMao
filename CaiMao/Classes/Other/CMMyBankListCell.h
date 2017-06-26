//
//  CMMyBankListCell.h
//  CaiMao
//
//  Created by MAC on 16/10/24.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMMyBankListCell : UITableViewCell
@property(nonatomic,strong)UIImageView *bankIcon;
@property(nonatomic,strong)UIImageView *RenZhengIcon;
@property(nonatomic,strong)UILabel *bankName;
@property(nonatomic,strong)UILabel *bankNum;
@property(nonatomic,strong)UILabel *TiXianCount;
@property(nonatomic,strong)UILabel *BDTime;
@end
