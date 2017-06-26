//
//  CMTSafeGuardCell.m
//  CaiMao
//
//  Created by MAC on 16/8/11.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMTSafeGuardCell.h"

@implementation CMTSafeGuardCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        UILabel *title=[[UILabel alloc]init];
        self.sTitle=title;
        title.font=[UIFont systemFontOfSize:14.0];
        title.textColor=UIColorFromRGB(0x333333);
        [self.contentView addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.left.equalTo(self.contentView.mas_left).offset(8);
            make.width.equalTo(self.contentView);
            
        }];

        UILabel *Detail=[[UILabel alloc]init];
        self.sDetailTitle=Detail;
        Detail.font=[UIFont systemFontOfSize:12.0];
        Detail.numberOfLines=0;
        Detail.textColor=UIColorFromRGB(0x888888);
//        [Detail mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(@20);
//            make.top.equalTo(title.mas_bottom).offset(10);
//            make.left.equalTo(self.contentView.mas_left).offset(10);
//            make.right.equalTo(self.contentView.mas_right).offset(-10);
//            
//        }];
        [self.contentView addSubview:Detail];
        

        
    }
    
    return self;
}
@end
