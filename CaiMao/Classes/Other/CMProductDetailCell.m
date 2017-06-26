//
//  CMProductDetailCell.m
//  CaiMao
//
//  Created by MAC on 16/8/9.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMProductDetailCell.h"

@implementation CMProductDetailCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *leftLabel=[[UILabel alloc]init];
        self.productLeft=leftLabel;
        leftLabel.font=[UIFont systemFontOfSize:14.0];
        //leftLabel.textColor=[UIColor lightGrayColor];
        [self.contentView addSubview:leftLabel];
        [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.top.equalTo(self.contentView);
            make.width.equalTo(@80);
            make.left.equalTo(self.contentView.mas_left).offset(20);
        }];
        
        UIImageView *list=[[UIImageView alloc]init];
        // list.frame=CGRectMake(295,16, 7,11);
        list.image=[UIImage imageNamed:@"listOpen.png"];
        [self.contentView addSubview:list];
        
        [list mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            //make.top.equalTo(self.contentView.mas_top).offset(16);
            make.height.mas_equalTo(11);
            make.width.mas_equalTo(7);
            make.centerY.equalTo(self.contentView.mas_centerY);
            
        }];
        
        
        UILabel *rightLabel=[[UILabel alloc]init];
        rightLabel.hidden=YES;
        self.PeopleNum=rightLabel;
        rightLabel.font=[UIFont systemFontOfSize:13.0];
        rightLabel.textAlignment=NSTextAlignmentRight;
        rightLabel.textColor=[UIColor lightGrayColor];
        [self.contentView addSubview:rightLabel];
        [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.top.equalTo(leftLabel);
            make.width.equalTo(@80);
            make.right.equalTo(list.mas_left).offset(-10);
        }];
        
        UILabel *Vline=[[UILabel alloc]init];
        Vline.backgroundColor=separateLineColor;
        [self addSubview:Vline];
        [Vline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            make.bottom.width.left.equalTo(self);
        }];
    }
    return self;
}

@end
