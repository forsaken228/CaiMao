//
//  CMCFBZhuangRuOneCell.m
//  CaiMao
//
//  Created by MAC on 16/11/9.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMCFBZhuangRuOneCell.h"

@implementation CMCFBZhuangRuOneCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self  addSubview:self.BalanceAmountBtn];
        [self.BalanceAmountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.left.equalTo(self.mas_left).offset(20);
            make.centerY.equalTo(self);
            make.width.equalTo(@150);
        }];
        
        [self  addSubview:self.ZhanRuAmountLabel];
        [self.ZhanRuAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.right.equalTo(self.mas_right).offset(-10);
            make.centerY.equalTo(self);
            make.width.equalTo(@150);
        }];
        
    }
    
    return self;
    
}
-(CMCustomYuEButton*)BalanceAmountBtn{
    if (!_BalanceAmountBtn) {
        _BalanceAmountBtn=[[CMCustomYuEButton alloc]init];
        _BalanceAmountBtn.LeftimageView.image=[UIImage imageNamed:@"zhifu_xziocn.png"];
        
    }
    
    return _BalanceAmountBtn;
}

-(UILabel*)ZhanRuAmountLabel{
    
    if (!_ZhanRuAmountLabel) {
        _ZhanRuAmountLabel=[[UILabel alloc]init];
        _ZhanRuAmountLabel.font=[UIFont systemFontOfSize:13.0];
        _ZhanRuAmountLabel.textAlignment=NSTextAlignmentRight;
        _ZhanRuAmountLabel.textColor=UIColorFromRGB(0x4d4d4d);
    }
    return _ZhanRuAmountLabel;
}


@end
