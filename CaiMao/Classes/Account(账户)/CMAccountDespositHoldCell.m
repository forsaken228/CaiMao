//
//  CMAccountDespositHoldCell.m
//  CaiMao
//
//  Created by WangWei on 17/3/24.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import "CMAccountDespositHoldCell.h"

@implementation CMAccountDespositHoldCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.depositLabel];
        [self addSubview:self.endLabel];
        [self addSubview:self.radomLvLabel];
        [self addSubview:self.radomLabel];
        [self addSubview:self.redemptionbutton];
        
        [self.depositLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.top.equalTo(self.mas_top);
            make.height.equalTo(@25);
            make.width.equalTo(@150);
        }];
        [self.endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.bottom.equalTo(self.mas_bottom);
            make.height.equalTo(@25);
            make.width.equalTo(@100);
        }];
      
        [self.radomLvLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.endLabel.mas_right);
            make.top.height.equalTo(self.endLabel);
            make.width.mas_equalTo(100);
        }];
        [self.radomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-10);
            make.top.height.equalTo(self.depositLabel);
            make.width.mas_equalTo(120);
        }];
        
        [self.redemptionbutton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-10);
            make.top.width.equalTo(self.endLabel);
            make.width.equalTo(@150);
        }];
        
        
    }
    return self;
}
#pragma mark Lazy
-(UILabel*)depositLabel{
    
    if (!_depositLabel) {
        _depositLabel=[[UILabel alloc]init];
        _depositLabel.font=[UIFont systemFontOfSize:13.0];
        _depositLabel.textColor=UIColorFromRGB(0x5a5657);
    }
    
    return _depositLabel;
}
-(UILabel*)endLabel{
    
    if (!_endLabel) {
        _endLabel=[[UILabel alloc]init];
        _endLabel.font=[UIFont systemFontOfSize:13.0];
        _endLabel.textColor=RedButtonColor;
    }
    
    return _endLabel;
}

-(UILabel*)radomLvLabel{
    
    if (!_radomLvLabel) {
        _radomLvLabel=[[UILabel alloc]init];
        _radomLvLabel.font=[UIFont systemFontOfSize:13.0];
        _radomLvLabel.textColor=RedButtonColor;
        _radomLvLabel.textAlignment=NSTextAlignmentLeft;
    }
    
    return _radomLvLabel;
}
-(UILabel*)radomLabel{
    
    if (!_radomLabel) {
        _radomLabel=[[UILabel alloc]init];
        _radomLabel.font=[UIFont systemFontOfSize:13.0];
        _radomLabel.textColor=RedButtonColor;
        _radomLabel.textAlignment=NSTextAlignmentRight;
    }
    
    return _radomLabel;
}

-(UIButton*)redemptionbutton{
    
    if (!_redemptionbutton) {
        _redemptionbutton=[UIButton buttonWithType:UIButtonTypeSystem];
        _redemptionbutton.titleLabel.font=[UIFont systemFontOfSize:13.0];
        [_redemptionbutton setTitleColor:UIColorFromRGB(0x00b2ed) forState:UIControlStateNormal];
        _redemptionbutton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    }
    
    return _redemptionbutton;
}

@end
