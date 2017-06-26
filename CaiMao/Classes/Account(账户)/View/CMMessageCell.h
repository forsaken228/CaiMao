//
//  CMMessageCell.h
//  CaiMao
//
//  Created by MAC on 16/6/7.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMMessageCell : UITableViewCell


@property(nonatomic,strong)UIButton *detailBtn;
@property(nonatomic,strong)UIImageView *headImageView;;
@property(nonatomic,strong)UIImageView *messageImageView;
@property(nonatomic,strong)UILabel *messageLabel;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *headRightRed;

@property(nonatomic,weak)id  delegate;
@property(nonatomic,strong)NSIndexPath *indexpath;
@end
@protocol CMMessageCellDelegate <NSObject>

-(void)detailButtonActionWithIndex:(NSIndexPath*)index;

@end