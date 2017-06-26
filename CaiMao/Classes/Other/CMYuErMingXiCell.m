//
//  CMYuErMingXiCell.m
//  CaiMao
//
//  Created by MAC on 16/9/2.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMYuErMingXiCell.h"

@implementation CMYuErMingXiCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //起息日
        UILabel *QI=[[UILabel alloc]init];
        self.QXDate=QI;
        QI.font=[UIFont systemFontOfSize:12.0];
        QI.textColor=UIColorFromRGB(0xbdbdbd);
        [self.contentView addSubview:QI];
        [QI mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@12);
            make.width.mas_equalTo(@150);
            make.top.equalTo(self.contentView.mas_top).offset(5);
            make.left.equalTo(self.contentView.mas_left).offset(8);
        }];
       //计息金额
        
        UILabel *JJinEr=[[UILabel alloc]init];
        self.JXMoney=JJinEr;
        JJinEr.font=[UIFont systemFontOfSize:12.0];
        JJinEr.textAlignment=NSTextAlignmentRight;
        JJinEr.textColor=UIColorFromRGB(0xbdbdbd);
        [self.contentView addSubview:JJinEr];
        [JJinEr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.top.equalTo(QI);
           make.right.equalTo(self.contentView.mas_right).offset(-8);
        }];
        
        //ID
        UILabel *JID=[[UILabel alloc]init];
        self.MXID=JID;
        JID.font=[UIFont systemFontOfSize:12.0];
        JID.textAlignment=NSTextAlignmentLeft;
        JID.textColor=UIColorFromRGB(0xbdbdbd);
        [self.contentView addSubview:JID];
        [JID mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.left.equalTo(QI);
            make.top.equalTo(QI.mas_bottom).offset(5);
        }];
        
        
    //当前年收益
    UILabel *CShouYi=[[UILabel alloc]init];
    self.CurrentSY=CShouYi;
    CShouYi.font=[UIFont systemFontOfSize:12.0];
    CShouYi.textAlignment=NSTextAlignmentRight;
    CShouYi.textColor=UIColorFromRGB(0xbdbdbd);
    [self.contentView addSubview:CShouYi];
    [CShouYi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.top.equalTo(JID);
        make.right.equalTo(JJinEr);
    }];
   // 转入金额
        
        UILabel *ZJinEr=[[UILabel alloc]init];
        self.ZRJinEr=ZJinEr;
        ZJinEr.font=[UIFont systemFontOfSize:12.0];
        ZJinEr.textAlignment=NSTextAlignmentLeft;
        ZJinEr.textColor=UIColorFromRGB(0xbdbdbd);
        [self.contentView addSubview:ZJinEr];
        [ZJinEr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.left.equalTo(QI);
            make.top.equalTo(JID.mas_bottom).offset(5);
        }];
    //转入日
        
        UILabel *zhuanDate=[[UILabel alloc]init];
        self.ZRDate=zhuanDate;
        zhuanDate.font=[UIFont systemFontOfSize:12.0];
        zhuanDate.textAlignment=NSTextAlignmentRight;
        zhuanDate.textColor=UIColorFromRGB(0xbdbdbd);
        [self.contentView addSubview:zhuanDate];
        [zhuanDate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.top.equalTo(ZJinEr);
            make.right.equalTo(JJinEr);
        
       }];
}

    return self;
}

@end
