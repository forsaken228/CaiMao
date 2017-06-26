//
//  CMJuHaiPercentView.m
//  CaiMao
//
//  Created by WangWei on 16/11/23.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMJuHaiPercentView.h"

@implementation CMJuHaiPercentView

-(instancetype)init{
    self=[super init];
    if (self) {
        
        self.image=[UIImage imageNamed:@"jhl_product_yuanquan"];
        [self addSubview:self.personer];
        [self addSubview:self.perecent];
        
        [self.personer mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.equalTo(self);
            make.bottom.equalTo(self.mas_bottom).offset(-5);
            make.height.mas_equalTo(15);
            
            
        }];
        
        [self.perecent mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.equalTo(self);
            make.top.equalTo(self.mas_top).offset(5);
            make.height.mas_equalTo(21);
            
        }];
        
    }
    return self;
}



#pragma mark Lazy

-(UILabel*)perecent{
    if (!_perecent) {
        
        _perecent=[[UILabel alloc]init];
        _perecent.font=[UIFont systemFontOfSize:12.0];
        _perecent.textAlignment=NSTextAlignmentCenter;
        _perecent.textColor=[UIColor lightGrayColor];
    }
    
    return _perecent;
}

-(UILabel*)personer{
    if (!_personer) {
        
        _personer=[[UILabel alloc]init];
        _personer.font=[UIFont systemFontOfSize:12.0];
        _personer.textAlignment=NSTextAlignmentCenter;
        _personer.textColor=[UIColor lightGrayColor];
    }
    
    return _personer;
}
@end
