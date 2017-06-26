//
//  CMUserSureViewCell.m
//  CaiMao
//
//  Created by MAC on 16/6/15.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMUserSureViewCell.h"

@implementation CMUserSureViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //分割线
        
        UIView *line=[[UIView alloc]init];
        self.lineView=line;
        //line.frame=CGRectMake(150, 21, 1, 30);
        line.backgroundColor=separateLineColor;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX).offset(-30);
            make.top.equalTo(self.mas_top).offset(20);
            make.height.equalTo(@30);
            make.width.equalTo(@0.5);
            
        }];
        
        //银行卡标志
        UIImageView *bankIcon=[[UIImageView alloc]init];
        //bankIcon.frame=CGRectMake(14,16, 123,36);
        self.BankBg=bankIcon;
        [self addSubview:bankIcon];
        [bankIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(16);
            make.height.equalTo(@36);
            make.width.equalTo(@123);
            make.right.equalTo(line.mas_left).offset(-5);
            
        }];
        
        //银行名
        UILabel *tBankName=[[UILabel alloc]init];
       // tBankName.frame=CGRectMake(160 , 19 , 73,33 );
        tBankName.font=[UIFont systemFontOfSize:14];
        self.bankNum=tBankName;
        [self addSubview:tBankName];
        [tBankName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(19);
            make.height.equalTo(@33);
            make.width.equalTo(@73);
            make.left.equalTo(line.mas_right).offset(5);
            
        }];
        //
        UILabel *tTopLabel=[[UILabel alloc]init];
       // tTopLabel.frame=CGRectMake(14, 19,174, 30);
        tTopLabel.font=[UIFont systemFontOfSize:17];
        self.useNewBank=tTopLabel;
        [self addSubview:tTopLabel];
        
        [tTopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(19);
            make.height.equalTo(@30);
            make.width.equalTo(@173);
            make.left.equalTo(self.mas_left).offset(15);
            
        }];
        
        UIButton *CancleBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        //CancleBtn.frame=CGRectMake(257, 19, 46, 30);
        CancleBtn.titleLabel.font=[UIFont systemFontOfSize:14];
        [CancleBtn setTitleColor:RedButtonColor forState:UIControlStateNormal];
        
        CancleBtn.backgroundColor=[UIColor whiteColor];
        self.changeBank=CancleBtn;
        [CancleBtn setTitle:@"更换>" forState:UIControlStateNormal];
        [self addSubview:CancleBtn];
        
        [CancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(19);
            make.height.equalTo(@30);
            make.width.equalTo(@46);
            make.right.equalTo(self.mas_right).offset(-15);
            
        }];
        
    }
    return self;
}

@end
