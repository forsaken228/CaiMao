//
//  CMIntegralMingXiCell.m
//  CaiMao
//
//  Created by MAC on 16/9/6.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMIntegralMingXiCell.h"

@implementation CMIntegralMingXiCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *state=[[UILabel alloc]init];
        self.productdetail=state;
        state.textColor=UIColorFromRGB(0x333333);
        state.font=[UIFont systemFontOfSize:14.0];
        state.textAlignment=NSTextAlignmentLeft;
        [self.contentView addSubview:state];
        [state mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.width.equalTo(@200);
            make.top.equalTo(self.contentView.mas_top).offset(8);
            make.left.equalTo(self.contentView.mas_left).offset(8);
        }];
        UILabel *date=[[UILabel alloc]init];
        self.productdetailTime=date;
        date.font=[UIFont systemFontOfSize:12.0];
        date.textColor=UIColorFromRGB(0xb3b3b3);
        [self.contentView addSubview:date];
        [date mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@12);
            make.width.left.equalTo(state);
            make.top.equalTo(state.mas_bottom).offset(8);
            
        }];
       
        
        
        UILabel *productIntegar=[[UILabel alloc]init];
        self.productIntegralNum=productIntegar;
        productIntegar.font=[UIFont systemFontOfSize:20.0];
        productIntegar.textColor=UIColorFromRGB(0xfb3e1b);
        productIntegar.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:productIntegar];
        [productIntegar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.width.equalTo(@100);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.right.equalTo(self.contentView).mas_offset(-8);
        }];
        
        
        
    }
    return self;
}
@end
