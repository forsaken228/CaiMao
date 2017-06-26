//
//  CMZhuanChuCell.m
//  CaiMao
//
//  Created by MAC on 16/9/2.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMZhuanChuCell.h"

@implementation CMZhuanChuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        //转出时间
        UILabel *JID=[[UILabel alloc]init];
        self.ZCRecordDate=JID;
        JID.font=[UIFont systemFontOfSize:12.0];
        JID.textAlignment=NSTextAlignmentLeft;
        JID.textColor=UIColorFromRGB(0xbdbdbd);
        [self.contentView addSubview:JID];
        [JID mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@12);
            make.width.mas_equalTo(@150);
            make.top.equalTo(self.contentView.mas_top).offset(5);
            make.left.equalTo(self.contentView.mas_left).offset(8);
            
        }];
        
        
        
        // 转出金额
        
        UILabel *ZState=[[UILabel alloc]init];
        self.ZCRecordMoney=ZState;
        ZState.font=[UIFont systemFontOfSize:12.0];
        ZState.textAlignment=NSTextAlignmentRight;
        ZState.textColor=UIColorFromRGB(0xfa3e19);
        [self.contentView addSubview:ZState];
        [ZState mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.top.equalTo(JID);
            make.right.equalTo(self.contentView.mas_right).offset(-8);
        }];
        //最终年收益率
        
        UILabel *zhuanDate=[[UILabel alloc]init];
        self.ZCShouYiLv=zhuanDate;
        zhuanDate.font=[UIFont systemFontOfSize:12.0];
        zhuanDate.textAlignment=NSTextAlignmentLeft;
        zhuanDate.textColor=UIColorFromRGB(0xbdbdbd);
        [self.contentView addSubview:zhuanDate];
        [zhuanDate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.left.equalTo(JID);
            make.top.equalTo(JID.mas_bottom).offset(8);
            
        }];
        //最终受益
        
        
        UILabel *zhuanJin=[[UILabel alloc]init];
        self.ZCShouYi=zhuanJin;
        
        zhuanJin.font=[UIFont systemFontOfSize:12.0];
        zhuanJin.textAlignment=NSTextAlignmentRight;
        zhuanJin.textColor=UIColorFromRGB(0xbdbdbd);
        [self.contentView addSubview:zhuanJin];
        [zhuanJin mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.top.equalTo(zhuanDate);
            make.right.equalTo(ZState);
            
        }];
        
        
    }
    
    return self;
}


@end
