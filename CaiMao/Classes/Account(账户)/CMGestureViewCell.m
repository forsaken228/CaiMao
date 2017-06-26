//
//  CMGestureViewCell.m
//  CaiMao
//
//  Created by MAC on 16/8/24.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMGestureViewCell.h"

@implementation CMGestureViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *title=[[UILabel alloc]init];
        //title.text=@"手势密码";
        self.GTitle=title;
        title.font=[UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.height.equalTo(@16);
            make.width.equalTo(@100);
            
        }];
        
        
        
        UISwitch *Swit=[[UISwitch alloc]init];
        //位置
        CGRect aFrame = Swit.frame;
        aFrame.origin.x = CMScreenW-60;
        aFrame.origin.y = 8;
        Swit.frame = aFrame;
        [Swit setOn:NO];
        self.gSwitch=Swit;
        Swit.hidden=YES;
        Swit.transform=CGAffineTransformMakeScale(0.8,0.8);
        [self.contentView addSubview:Swit];
//        [Swit mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.contentView.mas_right);
//            make.top.equalTo(title.mas_top);
//            make.width.equalTo(@100);
//             make.height.equalTo(@20);
//        }];
        
        
        UIImageView *list=[[UIImageView alloc]init];
        // list.frame=CGRectMake(295,16, 7,11);
        list.image=[UIImage imageNamed:@"listOpen.png"];
        [self addSubview:list];
        self.listOpen=list;
        list.hidden=YES;
        [list mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-15);
            make.top.equalTo(self.mas_top).offset(16);
            make.height.mas_equalTo(11);
            make.width.mas_equalTo(7);
            
        }];
        
    }
    return  self;
}

@end
