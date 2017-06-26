//
//  CMAccountCell.m
//  CaiMao
//
//  Created by Fengpj on 16/1/8.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMAccountCell.h"

@implementation CMAccountCell



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //标志
        
        [self addSubview:self.icon];
        [self addSubview:self.title];
        //[self addSubview: self.IconImage];
        [self addSubview:self.actionTitle];
        [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(12);
            make.top.equalTo(self.mas_top).offset(10);
            make.width.height.mas_equalTo(22);
            
        }];
    
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.icon.mas_right).offset(10);
            make.centerY.equalTo(self.mas_centerY);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(200);
            
        }];
        [self.actionTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.title.mas_right).offset(5);
            make.centerY.equalTo(self.mas_centerY);
            make.height.mas_equalTo(15);
            make.width.mas_equalTo(50);
        }];
        
//       
//        [ self.IconImage mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.title.mas_right).offset(3);
//            make.top.equalTo(self.title.mas_top).offset(-5);
//            make.height.mas_equalTo( self.IconImage.image.size.height);
//            make.width.mas_equalTo( self.IconImage.image.size.width);
//            
//        }];
        
        
        UIImageView *list=[[UIImageView alloc]init];
        list.image=[UIImage imageNamed:@"listOpen.png"];
        [self addSubview:list];
        [list mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-15);
            make.top.equalTo(self.mas_top).offset(16);
            make.height.mas_equalTo(11);
            make.width.mas_equalTo(7);
            
        }];
        
        
       
        [self addSubview:self.CellYuEr];
        
        [self.CellYuEr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(list.mas_left).offset(-8);
            make.centerY.equalTo(self.mas_centerY);
            make.height.mas_equalTo(20);
            make.width.equalTo(@150);
            
        }];
        

        
        [self addSubview:self.redMessage];
        
        [self.redMessage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(list.mas_left).offset(-5);
            make.centerY.equalTo(self.mas_centerY);
            make.height.width.mas_equalTo(20);
            
            
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
    }
    return _icon;
    
}
-(UILabel*)title{
    if (!_title) {
        _title=[[UILabel alloc]init];
        _title.font=[UIFont systemFontOfSize:14.0];
        _title.textColor=UIColorFromRGB(0x333333);
    }
    
    return _title;
}
//-(UIImageView*)IconImage{
//    if (!_IconImage) {
//        _IconImage=[[UIImageView alloc]init];
//        _IconImage.image=[UIImage imageNamed:@"new"];
//        _IconImage.hidden=YES;
//    }
//    return _IconImage;
//}
-(UILabel*)CellYuEr{
    if (!_CellYuEr) {
        _CellYuEr=[[UILabel alloc]init];
        _CellYuEr.hidden=YES;
        _CellYuEr.font=[UIFont systemFontOfSize:14.0];
        _CellYuEr.textColor=RedButtonColor;
        _CellYuEr.textAlignment=NSTextAlignmentRight;
    }
    return _CellYuEr;
}
-(UILabel*)redMessage{
    if (!_redMessage) {
        _redMessage=[[UILabel alloc]init];
        _redMessage.hidden=YES;
        _redMessage.font=[UIFont systemFontOfSize:10.0];
        _redMessage.backgroundColor=RedButtonColor;
        _redMessage.textColor=[UIColor whiteColor];
        _redMessage.clipsToBounds=YES;
        _redMessage.textAlignment=NSTextAlignmentCenter;
        _redMessage.layer.cornerRadius=10;

    }
    return _redMessage;
}

-(UILabel*)actionTitle{
    if (!_actionTitle) {
        _actionTitle=[[UILabel alloc]init];
        _actionTitle.font=[UIFont systemFontOfSize:10.0];
        _actionTitle.textColor=[UIColor whiteColor];
        _actionTitle.backgroundColor=RedButtonColor;
        _actionTitle.textAlignment=NSTextAlignmentCenter;
        _actionTitle.hidden=YES;
        _actionTitle.clipsToBounds=YES;
        _actionTitle.layer.cornerRadius=7.5;
    }
    return _actionTitle;
}

@end
