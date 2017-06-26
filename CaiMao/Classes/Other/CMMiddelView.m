//
//  CMMiddelView.m
//  CaiMao
//
//  Created by MAC on 16/7/27.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMMiddelView.h"

@implementation CMMiddelView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        //self.frame=CGRectMake(0, 0, CMScreenW, 200);
        self.backgroundColor=[UIColor whiteColor];
      //  self.userInteractionEnabled=YES;
        [self becomeFirstResponder];
        [self creatView];
    }
    return self;
}

-(void)creatView{
    int height=((CMScreenH-150)/2.0-30)/4.0;
    
    [self addSubview:self.productTitle];
     [self.productTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        
         make.left.equalTo(self.mas_left).offset(8);
         make.top.equalTo(self.mas_top);
         make.height.mas_equalTo(height);
         make.width.mas_equalTo(CMScreenW);
     }];
    
      [self addSubview:self.productId];
    [self.productId mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset(-8);
        make.top.equalTo(self.productTitle);
        make.height.mas_equalTo(height);
        make.width.mas_equalTo(CMScreenW/2.0);
    }];
    UILabel *lineView=[UILabel new];
    lineView.backgroundColor=separateLineColor;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.productId.mas_bottom);
        make.height.mas_equalTo(0.5);
        make.width.left.equalTo(self);
    }];
    
    
 
    [self addSubview:self.productNum];
    [self.productNum mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(lineView.mas_bottom);
        make.height.mas_equalTo(height);
        make.width.left.equalTo(self);
    }];
    
   
  /*
    UITextField *midTextField=[[UITextField alloc]init];
   midTextField.userInteractionEnabled=NO;
   // midTextField.frame=CGRectMake(80, 70, 100, 25 );
    midTextField.keyboardType=UIKeyboardTypeNumberPad;
    midTextField.layer.borderColor=RedButtonColor.CGColor;
     midTextField.layer.borderWidth = 0.5f;
    self.productInputNum=midTextField;
    midTextField.textColor=UIColorFromRGB(0x333333);
    midTextField.textAlignment=NSTextAlignmentCenter;
    [self addSubview:midTextField];
    [midTextField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.height.mas_equalTo(height);
        make.width.mas_equalTo(120);
        make.centerX.equalTo(self);
        make.top.equalTo(pNum.mas_bottom);
    }];
    
    UIButton *jBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    
   jBtn.frame=CGRectMake(CMScreenW/2.0-60-60, height*2, 60, height);
   
  //  jBtn.frame=CGRectMake(midTextField.center.x-60, midTextField.frame.origin.y, 60, midTextField.bounds.size.height);
    [jBtn setTitle:@"-" forState:UIControlStateNormal];
    jBtn.titleLabel.font=[UIFont systemFontOfSize:40.0];
    jBtn.contentEdgeInsets = UIEdgeInsetsMake(0,0, 5, 0);
    [jBtn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
   
    [jBtn setBackgroundColor:separateLineColor];
    self.jianBtn=jBtn;
    [self addSubview:jBtn];

//    [jBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.height.top.equalTo(midTextField);
//        make.width.mas_equalTo(60);
//        make.right.equalTo(midTextField.mas_left);
//        
//        
//    }];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:jBtn.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft cornerRadii:CGSizeMake(5.0, 5.0)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = jBtn.bounds;
    maskLayer.path = maskPath.CGPath;
    jBtn.layer.mask = maskLayer;
  
    UIButton *AddBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    AddBtn.frame=CGRectMake(CMScreenW/2.0+60, height*2, 60, height);
   // AddBtn.frame=CGRectMake(50, 70, 30, 25);
    [AddBtn setTitle:@"+" forState:UIControlStateNormal];
    AddBtn.titleLabel.font=[UIFont systemFontOfSize:25.0];
    AddBtn.contentEdgeInsets = UIEdgeInsetsMake(0,0, 5, 0);
    [AddBtn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    [AddBtn setBackgroundColor:separateLineColor];
    self.jiaBtn=AddBtn;
    [self addSubview:AddBtn];
    
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:AddBtn.bounds byRoundingCorners:UIRectCornerBottomRight | UIRectCornerTopRight cornerRadii:CGSizeMake(5.0, 5.0)];
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.frame = AddBtn.bounds;
    maskLayer1.path = maskPath1.CGPath;
    AddBtn.layer.mask = maskLayer1;

//    [AddBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.height.top.equalTo(midTextField);
//        make.width.mas_equalTo(jBtn);
//        make.left.equalTo(midTextField.mas_right);
//        
//        
//    }];
   
   */
    
    self.ButtonTextView=[[CMButtonTextView alloc]initWithFrame:CGRectMake(CMScreenW/2.0-120, 2*height, 120+60+60, height)];
    [self addSubview:self.ButtonTextView];
    
    
    [self addSubview:self.JinPaiNum];
    [self.JinPaiNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(CMScreenW);
        make.top.equalTo(self.ButtonTextView.mas_bottom);
    }];
    

}
-(UILabel*)productTitle{
    if (!_productTitle) {
       _productTitle=[[UILabel alloc]init];
        
       _productTitle.font=[UIFont systemFontOfSize:13.0];
        
    
    }
    return _productTitle;
}
-(UILabel*)productId{
    
    if (!_productId) {
        _productId=[[UILabel alloc]init];
        
        _productId.textColor=RedButtonColor;
        _productId.textAlignment=NSTextAlignmentRight;
        _productId.font=[UIFont systemFontOfSize:12.0];
     

    }
    return _productId;
}
-(UILabel*)productNum{
    if (!_productNum) {
       _productNum=[[UILabel alloc]init];
        // pNum.frame=CGRectMake(70, 50, 200, 20);
        _productNum.textColor=CMColor(157, 157, 157);;
        _productNum.font=[UIFont systemFontOfSize:13.0];
        _productNum.textAlignment=NSTextAlignmentCenter;
        
    }
    return _productNum;
}
-(UILabel*)JinPaiNum{
    if (!_JinPaiNum) {
        _JinPaiNum=[[UILabel alloc]init];
        
        _JinPaiNum.font=[UIFont systemFontOfSize:13.0];
        _JinPaiNum.textAlignment=NSTextAlignmentCenter;
        _JinPaiNum.textColor=UIColorFromRGB(0x9b9a9a);
    }
    return _JinPaiNum;
}
@end
