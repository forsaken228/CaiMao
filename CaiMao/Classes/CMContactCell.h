//
//  CMContactCell.h
//  CaiMao
//
//  Created by MAC on 16/10/11.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMContactCell : UITableViewCell

@property(nonatomic,strong)UILabel *phoneName;
@property(nonatomic,strong)UILabel *PhoneNum;
@property(nonatomic,strong)UIButton *InvatieBtn;
@property(nonatomic,strong)UIButton *headIcon;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,weak) id Contanctdelegate;
@end
@protocol CMContactCellDelegate <NSObject>

-(void)invationBtnClickWith:(NSIndexPath*)index;

@end
