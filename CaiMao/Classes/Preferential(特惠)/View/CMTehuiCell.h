//
//  CMTehuiCell.h
//  CaiMao
//
//  Created by Fengpj on 15/11/24.
//  Copyright © 2015年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import"CMTeHuiList.h"
@interface CMTehuiCell : UITableViewCell
/** 图片 */
@property (strong, nonatomic) UIImageView *teImageView;
/** 标题 */
@property (strong, nonatomic)  UILabel *teTitle;
/** 描述 */
@property (strong, nonatomic)  UILabel *teSubTitle;

@end
