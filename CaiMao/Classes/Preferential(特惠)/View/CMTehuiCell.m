//
//  CMTehuiCell.m
//  CaiMao
//
//  Created by Fengpj on 15/11/24.
//  Copyright © 2015年 58cm. All rights reserved.
//

#import "CMTehuiCell.h"

@implementation CMTehuiCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 255);
        
     //图片
        UIImageView *titieImageView=[[UIImageView alloc]init];
       // titieImageView.frame=CGRectMake(10, 8, 300,130 );

    //titieImageView.image=[UIImage imageNamed:@"Default.png"];
       
        self.teImageView=titieImageView;
        [self addSubview:titieImageView];
        [titieImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(15);
            make.left.equalTo(self.mas_left).offset(10);
            make.right.equalTo(self.mas_right).offset(-10);
            make.height.mas_equalTo(130);
            
        }];
        UIImage *imageMark=[UIImage imageNamed:@"title_mark_icon"];
        UIImageView *zhiShi=[[UIImageView alloc]init];
        zhiShi.image=imageMark;
        [self addSubview:zhiShi];
        [zhiShi mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(imageMark.size.height);
            make.width.mas_equalTo(imageMark.size.width);
            make.top.equalTo(titieImageView.mas_bottom).offset(9);
            make.left.equalTo(titieImageView.mas_left).offset(-5);
            
        }];
        //标题
        
        UILabel *tTitle =[[UILabel alloc]init];//WithFrame:CGRectMake(8,143, 211, 24)
        tTitle.text=@"VIP专享";
        self.teTitle=tTitle;
        tTitle.numberOfLines=1;
        tTitle.textColor=UIColorFromRGB(0x333333);
        tTitle.font=[UIFont boldSystemFontOfSize:16];
       // tTitle.textColor=CMColor(77, 77, 77);
        [self addSubview:tTitle];
        [tTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(zhiShi);
            make.width.mas_equalTo(211);
            make.left.equalTo(zhiShi.mas_right);
            make.height.mas_equalTo(20);
            
        }];
        
        
        //right
        UILabel *tRight =[[UILabel alloc]init];//WithFrame:CGRectMake(210,143, 93, 24)
        tRight.text=@"立即查看>";
        tRight.numberOfLines=1;
        tRight.font=[UIFont boldSystemFontOfSize:14.0];
        tRight.textAlignment=NSTextAlignmentRight;
        tRight.textColor=RedButtonColor;
        [self addSubview:tRight];
        
        [tRight mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(tTitle);
            make.width.mas_equalTo(93);
            make.right.equalTo(self.mas_right).offset(-8);
            make.height.mas_equalTo(20);
            
        }];
        
        
        UILabel *tBottom =[[UILabel alloc]init];
        tBottom.numberOfLines=0;
        
        self.teSubTitle=tBottom;
        
      tBottom.font=[UIFont systemFontOfSize:14.0];
        tBottom.textColor=[UIColor lightGrayColor];
        [self addSubview:tBottom];
        
        [tBottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(tRight.mas_bottom).offset(3);
            make.right.equalTo(self.mas_right).offset(-8);
            make.left.equalTo(self.mas_left).offset(8);

            make.height.mas_equalTo(84);
            
        }];
    }
    
    return self;
    
}

@end
