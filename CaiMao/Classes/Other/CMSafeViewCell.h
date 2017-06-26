//
//  CMSafeViewCell.h
//  CaiMao
//
//  Created by MAC on 16/10/24.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMSafeViewCell : UITableViewCell
@property (strong, nonatomic)  UIImageView *icon;
@property (strong, nonatomic)  UIImageView *list;
@property (strong, nonatomic)  UILabel *tTitle;
@property (strong, nonatomic) UILabel *nameMessage;
@property (strong, nonatomic)  UILabel *deatilContent;
@end
