//
//  CMAllChiYouDetail.m
//  CaiMao
//
//  Created by WangWei on 16/12/1.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMAllChiYouDetail.h"

@implementation CMAllChiYouDetail
-(id)init{
    self=[super init];
    if (self) {
        
        UIImage  *image=[UIImage imageNamed:@"cheackAll"];
        UIImageView *imageView=[[UIImageView alloc]init];
        imageView.image=image;
        [self addSubview:imageView];
        [imageView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(image.size.height);
            make.width.mas_equalTo(image.size.width);
            make.centerY.equalTo(self);
            make.left.equalTo(self.mas_left).offset(15);
        }];
        
        UILabel *label=[UILabel new];
        label.text=@"查看所有持有产品收益报告";
        label.textColor=UIColorFromRGB(0x939198);
        label.font=[UIFont systemFontOfSize:13.0];
        [self addSubview:label];
        [label  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.height.equalTo(self);
            make.centerY.equalTo(self);
            make.left.equalTo(imageView.mas_right).offset(5);
        }];
        
        UIImageView *list=[[UIImageView alloc]init];
        // list.frame=CGRectMake(295,16, 7,11);
        list.image=[UIImage imageNamed:@"listOpen.png"];
        [self addSubview:list];
        
        [list mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-15);
            make.centerY.equalTo(self);
            make.height.mas_equalTo(11);
            make.width.mas_equalTo(7);
            
        }];
        
    }
    return self;
}
@end
