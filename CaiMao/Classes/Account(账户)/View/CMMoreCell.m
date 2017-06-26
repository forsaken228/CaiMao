//
//  CMMoreCell.m
//  CaiMao
//
//  Created by Fengpj on 16/1/15.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMMoreCell.h"

@implementation CMMoreCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        UIImageView *left=[[UIImageView alloc]init];
        self.leftImageView=left;
        [self addSubview:left];
        [left mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.equalTo(@18);
            make.left.equalTo(self.mas_left).offset(20);
            make.centerY.equalTo(self);
        }];
        UILabel *tTitle=[[UILabel alloc]init];
        //tTitle.frame=CGRectMake(8, 11,102, 21);
        tTitle.font=[UIFont systemFontOfSize:15];
        tTitle.textColor=UIColorFromRGB(0x333333);
        self.moreTitle=tTitle;
        [self addSubview:tTitle];
        [tTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(left.mas_right).offset(10);
            make.height.mas_equalTo(self);
            make.width.mas_equalTo(102);
            make.top.equalTo(self.mas_top);
        }];
      
        
        UIImageView *list=[[UIImageView alloc]init];
        //list.frame=CGRectMake(295,16, 7,11);
        list.image=[UIImage imageNamed:@"listOpen.png"];
        [self addSubview:list];
        [list mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-15);
            make.top.equalTo(self.mas_top).offset(16);
            make.height.mas_equalTo(11);
            make.width.mas_equalTo(7);
            
        }];
        
        UILabel *tSubTitle=[[UILabel alloc]init];
        //tSubTitle.frame=CGRectMake(139, 11,141, 21);
        tSubTitle.font=[UIFont systemFontOfSize:16];
        tSubTitle.textColor=[UIColor lightGrayColor];
        tSubTitle.textAlignment=NSTextAlignmentRight;
        self.moreSubTitle=tSubTitle;
        [self addSubview:tSubTitle];
        
        [tSubTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(list.mas_left).offset(-10);
            make.height.mas_equalTo(self);
            make.width.mas_equalTo(140);
            make.top.equalTo(self.mas_top);
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
