//
//  CMDuiHuanRecordCell.m
//  CaiMao
//
//  Created by MAC on 16/9/6.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMDuiHuanRecordCell.h"

@implementation CMDuiHuanRecordCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *date=[[UILabel alloc]init];
        self.productDate=date;
        date.font=[UIFont systemFontOfSize:12.0];
        date.textColor=UIColorFromRGB(0xb3b3b3);
        [self.contentView addSubview:date];
        [date mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@12);
            make.width.equalTo(@100);
            make.top.equalTo(self.contentView.mas_top).offset(8);
            make.left.equalTo(self.contentView.mas_left).offset(8);
        }];
        UILabel *state=[[UILabel alloc]init];
        self.productState=state;
        state.textColor=UIColorFromRGB(0x189cfc);
        state.font=[UIFont systemFontOfSize:12.0];
        state.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:state];
        [state mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.top.equalTo(date);
            make.right.equalTo(self.contentView.mas_right).offset(-8);
        }];
        UILabel *line=[[UILabel alloc]init];
        line.backgroundColor=UIColorFromRGB(0xb3b3b3);
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            make.left.equalTo(self.contentView.mas_left).offset(8);
            make.right.equalTo(self.contentView.mas_right).offset(-8);
            make.top.equalTo(state.mas_bottom).offset(8);
        }];
       
        UIImageView *icon=[[UIImageView alloc]init];
        self.productImage=icon;
        icon.backgroundColor=[UIColor lightGrayColor];
        [self .contentView addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@45);
            make.width.equalTo(@60);
            make.top.equalTo(line.mas_bottom).offset(8);
            make.left.equalTo(date);
        }];
        
        UILabel *product=[[UILabel alloc]init];
        self.productName=product;
        product.textColor=UIColorFromRGB(0x1b1b1b);
        product.font=[UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:product];
        [product mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@13);
            make.width.equalTo(@200);
            make.bottom.equalTo(icon.mas_centerY).offset(-3);
            make.left.equalTo(icon.mas_right).offset(5);
        }];
        
        UILabel *productAddress=[[UILabel alloc]init];
        self.postAddress=productAddress;
        productAddress.textColor=UIColorFromRGB(0x939393);
        productAddress.font=[UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:productAddress];
        [productAddress mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.left.equalTo(product);
            make.width.equalTo(@200);
            make.top.equalTo(icon.mas_centerY).offset(3);
           
        }];

        UILabel *productIntegar=[[UILabel alloc]init];
        self.productIntegral=productIntegar;
        productIntegar.font=[UIFont systemFontOfSize:12.0];
        productAddress.textColor=UIColorFromRGB(0x939393);
        productIntegar.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:productIntegar];
        [productIntegar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.bottom.equalTo(product);
            make.width.equalTo(@100);
       
            make.right.equalTo(state);
        }];
        
        
        
    }
    return self;
}
@end
