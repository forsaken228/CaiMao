//
//  CMQQEmailCell.h
//  CaiMao
//
//  Created by WangWei on 16/12/26.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMQQEmailCell : UITableViewCell
/** QQ联系人头像*/
@property(nonatomic,strong)UIButton *headIcon;
/** QQ联系人昵称*/
@property(nonatomic,strong)UILabel *NinCheng;
/** QQ联系人邮箱号*/
@property(nonatomic,strong)UILabel *EmailNum;
/** QQ联系人发送邀请*/
@property(nonatomic,strong)UIButton *sendEmailBtn;
/** QQ联系人代理*/
@property(nonatomic,weak) id CMQQEmaildelegate;
/** QQ联系人 NSIndex*/
@property(nonatomic,strong)NSIndexPath *indexPath;
@end

@protocol CMQQEmailDelegate <NSObject>

-(void)invationBtnClickWith:(NSIndexPath*)index;

@end
