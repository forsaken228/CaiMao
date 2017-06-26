//
//  CMSafeGuardHead.m
//  CaiMao
//
//  Created by MAC on 16/8/10.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMSafeGuardHead.h"

@implementation CMSafeGuardHead

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        UILabel *product=[[UILabel alloc]init];
        self.proudctName=product;
        product.font=[UIFont systemFontOfSize:14.0];
        [self addSubview:product];
        [product mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(8);
            make.top.equalTo(self.mas_top).offset(8);
            make.height.equalTo(@20);
            make.width.equalTo(@220);
        }];
       
        UILabel *ID=[[UILabel alloc]init];
        self.proudctID=ID;
        ID.textAlignment=NSTextAlignmentRight;
        ID.font=[UIFont systemFontOfSize:14.0];
        [self addSubview:ID];
        [ID mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-8);
            make.top.equalTo(self.mas_top).offset(8);
            make.height.equalTo(@20);
            make.width.equalTo(@80);
        }];
        
        UILabel *lineLabel=[UILabel new];
        lineLabel.backgroundColor=RedButtonColor;
        [self addSubview:lineLabel];
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            make.width.left.equalTo(self);
            make.top.equalTo(product.mas_bottom).offset(10);
        }];
        
        UILabel *safe=[[UILabel alloc]init];
        safe.text=@"投资安全保障";
        safe.font=[UIFont systemFontOfSize:14.0];
        [self addSubview:safe];
        [safe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.height.width.equalTo(product);
            make.top.equalTo(lineLabel.mas_bottom).offset(6);
         
        }];
        
        
    }
    return self;
}
@end
