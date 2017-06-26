//
//  CMProductBottomview.m
//  CaiMao
//
//  Created by WangWei on 17/1/10.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import "CMProductBottomview.h"

@implementation CMProductBottomview

-(instancetype)init{
    self=[super init];
    if (self) {
        
//        self.increaseBtn=[UIButton buttonWithType:UIButtonTypeSystem];
//        self.increaseBtn.frame=CGRectMake(8, 8, 40,36);
//        [self.increaseBtn setTitle:@"+" forState:UIControlStateNormal];
//        [self.increaseBtn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
//        self.increaseBtn.contentEdgeInsets = UIEdgeInsetsMake(0,0, 5, 0);
//        [self.increaseBtn setBackgroundColor:separateLineColor];
//        self.increaseBtn.titleLabel.font=[UIFont systemFontOfSize:20];
//        [self addSubview:self.increaseBtn];
//        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.increaseBtn.bounds      byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft    cornerRadii:CGSizeMake(4, 4)];
//        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//        maskLayer.frame = self.increaseBtn.bounds;
//        maskLayer.path = maskPath.CGPath;
//        self.increaseBtn.layer.mask = maskLayer;
//      
//        self.inPutText=[[UITextField alloc]init];
//        self.inPutText.keyboardType=UIKeyboardTypeNumberPad;
//        self.inPutText.backgroundColor=[UIColor whiteColor];
//        // mid.borderStyle=UITextBorderStyleLine;
//        self.inPutText.layer.borderColor=RedButtonColor.CGColor;
//        self.inPutText.layer.borderWidth=0.5;
//        self.inPutText.textAlignment=NSTextAlignmentCenter;
//        self.inPutText.textColor=UIColorFromRGB(0x333333);
//        [self addSubview:self.inPutText];
//        [self.inPutText mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.top.equalTo(self.increaseBtn);
//            make.left.equalTo(self.increaseBtn.mas_right).offset(0.5);
//            make.width.equalTo(@85);
//            
//        }];
//        
//        self.reduceBtn=[UIButton buttonWithType:UIButtonTypeSystem];
//        self.reduceBtn.frame=CGRectMake(8+40+85+0.5,8, 40, 36);
//        [self.reduceBtn setTitle:@"-" forState:UIControlStateNormal];
//        [self.reduceBtn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
//        
//        [self.reduceBtn setBackgroundColor:separateLineColor];
//        self.reduceBtn.titleLabel.font=[UIFont systemFontOfSize:30];
//        self.reduceBtn.contentEdgeInsets = UIEdgeInsetsMake(0,0, 5, 0);
//        [self addSubview:self.reduceBtn];
//        UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:self.reduceBtn.bounds      byRoundingCorners:UIRectCornerBottomRight | UIRectCornerTopRight    cornerRadii:CGSizeMake(4, 4)];
//        CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
//        maskLayer1.frame = self.reduceBtn.bounds;
//        maskLayer1.path = maskPath1.CGPath;
//        self.reduceBtn.layer.mask = maskLayer1;
//        //    [jia mas_makeConstraints:^(MASConstraintMaker *make) {
//        //        make.width.height.top.equalTo(jian);
//        //        make.left.equalTo(mid.mas_right);
//        //
//        //    }];
//        
       self.ButtonText=[[CMButtonTextView alloc]initWithFrame:CGRectMake(10, 8, 160, 36)];
        [self addSubview:self.ButtonText];
        
        self.jiPaiView=[[CMJipaiView alloc]init];

        [self addSubview:self.jiPaiView];
        [self.jiPaiView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.right.top.equalTo(self);
            make.left.equalTo(self.ButtonText.mas_right).offset(10);
        }];
        
  
        
    }
    return self;
}

@end
