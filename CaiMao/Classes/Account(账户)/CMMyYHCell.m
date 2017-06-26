//
//  CMMyYHCell.m
//  CaiMao
//
//  Created by MAC on 16/11/1.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMMyYHCell.h"

@implementation CMMyYHCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor=ViewBackColor;
        UIImageView *bgImage=[[UIImageView alloc]init];
        bgImage.image=[UIImage imageNamed:@"YHBg"];
        [self addSubview:bgImage];
        [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.top.equalTo(self);
            make.left.equalTo(self.mas_left).offset(10);
             make.right.equalTo(self.mas_right).offset(-10);
        }];
        
        [bgImage addSubview:self.MiaZhi];
        [bgImage addSubview:self.YouXiaoTime];
        [bgImage addSubview:self.YHState];
       // [self addSubview:self.KTXM];
        [bgImage addSubview:self.FromSource];
        
//        UILabel *circle=[[UILabel alloc]init];
//        circle.backgroundColor=ViewBackColor;
//        circle.clipsToBounds=YES;
//        circle.layer.cornerRadius=7.5;
//        [self addSubview:circle];
//        [circle mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(self);
//            make.centerY.equalTo(self.mas_top);
//            make.height.width.equalTo(@15);
//        }];
//        UILabel *circle1=[[UILabel alloc]init];
//        circle1.backgroundColor=ViewBackColor;
//        circle1.clipsToBounds=YES;
//        circle1.layer.cornerRadius=7.5;
//        [self addSubview:circle1];
//        [circle1 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(self);
//            make.centerY.equalTo(self.mas_bottom);
//            make.height.width.equalTo(@15);
//        }];
        
        [self.MiaZhi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@32);
            make.width.equalTo(@150);
            make.top.equalTo(bgImage.mas_top).offset(15);
            make.left.equalTo(bgImage.mas_left).offset(15);
        }];
        [self.YouXiaoTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.width.equalTo(@200);
            make.bottom.equalTo(bgImage.mas_bottom).offset(-3);
            make.left.equalTo(bgImage.mas_left).offset(8);
        }];
        [self.YHState mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@18);
            make.width.equalTo(@100);
            make.top.equalTo(self.MiaZhi.mas_top);
            make.right.equalTo(bgImage.mas_right).offset(-20);
        }];
//        [self.KTXM mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.right.equalTo(self.YHState);
//            make.width.equalTo(@250);
//            make.centerY.equalTo(self.mas_centerY);
//            
//        }];
        [self.FromSource mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.YHState);
            make.height.equalTo(self.YouXiaoTime);
            make.width.equalTo(@150);
            make.bottom.equalTo(self.YouXiaoTime);
            
        }];
        
    }
    return self;
}


#pragma mark 
-(UILabel*)MiaZhi{
    if (!_MiaZhi) {
        _MiaZhi=[[UILabel alloc]init];
        _MiaZhi.font=[UIFont boldSystemFontOfSize:30];
        _MiaZhi.textColor=RedButtonColor;
        
    }
    return _MiaZhi;
    
}
-(UILabel*)YouXiaoTime{
    if (!_YouXiaoTime) {
        _YouXiaoTime=[[UILabel alloc]init];
        _YouXiaoTime.font=[UIFont boldSystemFontOfSize:12];
        _YouXiaoTime.textColor=UIColorFromRGB(0xbbbbbb);
        
    }
    return _YouXiaoTime;
    
}
-(UILabel*)YHState{
    if (!_YHState) {
        _YHState=[[UILabel alloc]init];
        _YHState.font=[UIFont boldSystemFontOfSize:14];
        _YHState.textColor=UIColorFromRGB(0x2edf73);
        _YHState.textAlignment=NSTextAlignmentRight;
    }
    return _YHState;
    
}
//-(UILabel*)KTXM{
//    if (!_KTXM) {
//        _KTXM=[[UILabel alloc]init];
//        _KTXM.font=[UIFont systemFontOfSize:14];
//        _KTXM.textColor=UIColorFromRGB(0x8e8d93);
//        _KTXM.textAlignment=NSTextAlignmentRight;
//        
//    }
//    return _KTXM;
//    
//}
-(UILabel*)FromSource{
    if (!_FromSource) {
        _FromSource=[[UILabel alloc]init];
        _FromSource.font=[UIFont boldSystemFontOfSize:12];
        _FromSource.textColor=UIColorFromRGB(0xbbbbbb);
        _FromSource.textAlignment=NSTextAlignmentRight;
    }
    return _FromSource;
    
}
@end
