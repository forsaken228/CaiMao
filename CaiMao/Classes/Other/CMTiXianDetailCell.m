//
//  CMTiXianDetailCell.m
//  CaiMao
//
//  Created by MAC on 16/7/30.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMTiXianDetailCell.h"

@implementation CMTiXianDetailCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      
        
        UILabel *titleLabel=[[UILabel alloc]init];
        //initWithFrame:CGRectMake(8, 0, 80, 40)
        self.titlelabel=titleLabel;
        titleLabel.font=[UIFont systemFontOfSize:14];
        titleLabel.textColor=CMColor(89, 89, 89);
        [self.contentView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(8);
            make.top.height.equalTo(self.contentView);
            make.width.mas_equalTo(80);
        }];
     
        UILabel *nameLabel=[[UILabel alloc]init];
        //nameLabel.frame=CGRectMake(270, 0, 80, 40);
        //nameLabel.text=arr[indexPath.row];
        nameLabel.textColor=RedButtonColor;
        nameLabel.font=[UIFont systemFontOfSize:14];
        nameLabel.textAlignment=NSTextAlignmentLeft;
        self.nameLabel=nameLabel;
        [self.contentView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(90);
            make.bottom.equalTo(self.contentView);
            make.height.equalTo(self.contentView);
            make.width.mas_equalTo(100);
            
        }];
        
        UIButton *suremsg=[UIButton buttonWithType:UIButtonTypeCustom];
        
        [suremsg setBackgroundColor:RedButtonColor];
        suremsg.titleLabel.font=[UIFont systemFontOfSize:14];
        [suremsg setTitle:@"获取验证码" forState:UIControlStateNormal];
        [suremsg setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.getCode=suremsg;
        [self.contentView addSubview:suremsg];
        [suremsg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right);
            make.top.equalTo(self.contentView.mas_top);
            make.height.equalTo(self.contentView);
            make.width.mas_equalTo(100);
            
        }];
        
        UITextField *tiXianJinEr=[[UITextField alloc]init];
        
     // tiXianJinEr.borderStyle=UITextBorderStyleRoundedRect;
        tiXianJinEr.font=[UIFont systemFontOfSize:14];
        tiXianJinEr.textColor=CMColor(204, 204, 204);
        tiXianJinEr.borderStyle=UITextBorderStyleNone;
        self.inputTextField=tiXianJinEr;
        // tiXianJinEr.keyboardType=UIKeyboardTypeNumberPad;
        [self.contentView addSubview:tiXianJinEr];
        [tiXianJinEr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(90);
            make.top.equalTo(self.contentView.mas_top).offset(5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(200);
            
        }];
        UILabel *old=[[UILabel alloc]init];
        old.textColor=RedButtonColor;
        old.font=[UIFont systemFontOfSize:14];
        old.textAlignment=NSTextAlignmentLeft;
        self.ZheKouLabel=old;
       
        UILabel *zheKou=[[UILabel alloc]init];
        zheKou.textColor=[UIColor lightGrayColor];
        zheKou.font=[UIFont systemFontOfSize:13];
        zheKou.textAlignment=NSTextAlignmentLeft;
        self.nShouLabel=zheKou;
        [self.contentView addSubview:old];
        [self.contentView addSubview:zheKou];
        [zheKou mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nameLabel.mas_right).offset(5);
            make.height.equalTo(@20);
            make.top.equalTo(self.contentView);
            make.width.mas_equalTo(40);
            
        }];

        [old mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(zheKou.mas_right);
            make.height.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
            make.width.mas_equalTo(80);
            
        }];
        
        UILabel *Vline=[[UILabel alloc]init];
        Vline.backgroundColor=separateLineColor;
        [self addSubview:Vline];
        [Vline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            make.bottom.width.left.equalTo(self);
        }];
        
    }
    
    return  self;
    
}
//- (void)drawRect:(CGRect)rect
//{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
//    CGContextFillRect(context, rect);
//    
//    //上分割线，
//    CGContextSetStrokeColorWithColor(context, UIColorFromRGB(0xffffff).CGColor);
//    CGContextStrokeRect(context, CGRectMake(5, -1, rect.size.width - 10, 1));
//    
//    //下分割线
//    CGContextSetStrokeColorWithColor(context, UIColorFromRGB(0xe2e2e2).CGColor);
//    CGContextStrokeRect(context, CGRectMake(5, rect.size.height, rect.size.width - 10, 1));
//}
@end
