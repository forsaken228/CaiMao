//
//  CMSafeViewCell.m
//  CaiMao
//
//  Created by MAC on 16/10/24.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMSafeViewCell.h"

@implementation CMSafeViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //标志
        
        [self addSubview:self.icon];
        [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(20);
            make.centerY.equalTo(self);
            make.width.height.mas_equalTo(32);
            
        }];
        
        
        [self addSubview:self.tTitle];
        
        [self.tTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.icon.mas_right).offset(11);
            make.centerY.equalTo(self.icon);
            make.height.mas_equalTo(13);
            make.width.mas_equalTo(100);
            
        }];
        
        
        
        [self addSubview:self.list];
        [self.list mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-20);
            make.centerY.equalTo(self);
            make.height.mas_equalTo(11);
            make.width.mas_equalTo(7);
            
        }];
        
        
        
        [self addSubview:self.nameMessage];
        [self.nameMessage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.list.mas_left).offset(-10);
            make.top.equalTo(self.mas_top).offset(5);
            make.height.mas_equalTo(12);
            make.width.equalTo(@100);
            
        }];
        
        
        
        [self addSubview:self.deatilContent];
        
        [self.deatilContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.list.mas_left).offset(-10);
            make.centerY.equalTo(self);
            make.height.mas_equalTo(15);
            make.width.mas_equalTo(200);
            
            
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
#pragma mark lazy
-(UIImageView*)icon{
    if (!_icon) {
    _icon=[[UIImageView alloc]init];
    _icon.image=[UIImage imageNamed:@"财富账户.png"];
    }
    return _icon;
}
-(UILabel*)tTitle{
    if (!_tTitle) {
        _tTitle=[[UILabel alloc]init];
        _tTitle.font=[UIFont systemFontOfSize:14.0];
        _tTitle.textColor=UIColorFromRGB(0x333333);
        
        
    }
    return _tTitle;
}
-(UIImageView*)list{
    if (!_list) {
        _list=[[UIImageView alloc]init];
        _list.image=[UIImage imageNamed:@"listOpen.png"];
    }
    return _list;
}
-(UILabel*)nameMessage{
    if (!_nameMessage) {
       _nameMessage=[[UILabel alloc]init];
        _nameMessage.hidden=YES;
        _nameMessage.font=[UIFont systemFontOfSize:12.0];
        _nameMessage.textColor=UIColorFromRGB(0x8e8e93);
        _nameMessage.textAlignment=NSTextAlignmentRight;
        
    }
    return _nameMessage;
}
-(UILabel*)deatilContent{
    if (!_deatilContent) {
        
        _deatilContent=[[UILabel alloc]init];
        _deatilContent.font=[UIFont systemFontOfSize:14.0];
        _deatilContent.textColor=UIColorFromRGB(0x8e8e93);
        _deatilContent.textAlignment=NSTextAlignmentRight;
       

    }
    return _deatilContent;
}
@end
