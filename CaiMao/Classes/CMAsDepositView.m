//
//  CMAsDepositView.m
//  CaiMao
//
//  Created by WangWei on 17/3/23.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import "CMAsDepositView.h"

@interface CMAsDepositView()<CMScrollSliderDelegate>
{
    int realoff;
}

@end

@implementation CMAsDepositView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        
        UILabel *title=[UILabel new];
        title.text=@"随心存";
        title.font=[UIFont systemFontOfSize:19.0];
        [self addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self).offset(10);
            make.left.equalTo(self.mas_left).offset(8);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(20);
        }];
        
        
        UIView *level=[UIView new];
        level.backgroundColor=separateLineColor;
        
        [self addSubview:level];
        
        [level mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(title.mas_bottom).offset(10);
            make.left.width.equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
        
        UIImage *image=[UIImage imageNamed:@"new"];
        UIImageView *new=[[UIImageView alloc]init];
        new.image=image;
        [self addSubview:new];
        [new mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(title.mas_right).offset(3);
            make.centerY.equalTo(title);
            make.height.mas_equalTo(image.size.height);
            make.width.mas_equalTo(image.size.width);
            
        }];
        
        UILabel *rightLabel=[UILabel new];
        rightLabel.text=@"期限自定,到期仍计息";
        rightLabel.font=[UIFont systemFontOfSize:14.0];
        rightLabel.textColor=[UIColor lightGrayColor];
        rightLabel.textAlignment=NSTextAlignmentRight;
        [self addSubview:rightLabel];
        [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self.mas_right).offset(-10);
            make.centerY.equalTo(title);
            make.height.mas_equalTo(15.0);
            make.width.mas_equalTo(220);
        }];
        
        [self addSubview:self.depositBtn];
        [self.depositBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.height.mas_equalTo(buttonHeight);
            make.bottom.equalTo(self.mas_bottom).offset(-15);
            make.left.equalTo(self.mas_left).offset(15);
            make.right.equalTo(self.mas_right).offset(-15);
        }];
        
        
    
        [self addSubview:self.decimalsLabel];
        [self.decimalsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_centerY).offset(-2);
            make.right.equalTo(self.depositBtn.mas_right);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(21);
        }];
        
        UILabel *shouyi=[[UILabel alloc]init];
        shouyi.text=YuQiShouYi;
        shouyi.font=[UIFont systemFontOfSize:12.0];
        shouyi.textAlignment=NSTextAlignmentLeft;
        shouyi.textColor=[UIColor lightGrayColor];
        [self addSubview:shouyi];
        [shouyi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_centerY).offset(7);
            make.right.equalTo(self.decimalsLabel);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(18.0);
            
            
        }];
        [self addSubview:self.integerLabel];
        [self.integerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.decimalsLabel.mas_left).offset(-2);
            make.width.mas_equalTo(75);
            make.height.mas_equalTo(70);
        }];
        
        
        
        _productSlider=[[CMScrollSlider alloc]initWithFrame:CGRectMake(0,50,200,90) MinValue:0 MaxValue:60 Step:1];
        _productSlider.delegate=self;
        _productSlider.realValue=30;
        _productSlider.fromHome=YES;
        [self addSubview:_productSlider];
        
        realoff=0;
        
        
        
        
    }
    
    return self;
}
-(void)CMScrollSlider:(CMScrollSlider *)slider ValueChange:(int)value andYield:(float)yield{
    
    
}
-(void)CMScrollSliderMove:(CMScrollSlider *)slider ValueChange:(int)value andYield:(float)yield{

    self.selectVaule=value;
    int newYield=(int)yield;

    self.integerLabel.text=[NSString stringWithFormat:@"%d",newYield];
    self.decimalsLabel.text=[[NSString stringWithFormat:@".%.f%",(yield-(float)newYield)*100]stringByAppendingString:@"%"];
   
    if (value<=9) {
        realoff=10;
        _productSlider.collectionView.scrollEnabled=NO;
        [_productSlider.collectionView setContentOffset:CGPointMake(realoff*6, 0) animated:NO];
        _productSlider.collectionView.scrollEnabled=YES;
        return;
    }
    else if (value>=11&&value<15) {
        
        realoff=20;
        _productSlider.collectionView.scrollEnabled=NO;
        [_productSlider.collectionView setContentOffset:CGPointMake(realoff*6, 0) animated:NO];
        _productSlider.collectionView.scrollEnabled=YES;
        return;

    }
    else if (value>15&&value<=19){
        realoff=10;
        _productSlider.collectionView.scrollEnabled=NO;
        [_productSlider.collectionView setContentOffset:CGPointMake(realoff*6, 0) animated:NO];
        _productSlider.collectionView.scrollEnabled=YES;
        return;
    }
   
    else if (value>=21&&value<25) {
        realoff=30;
        _productSlider.collectionView.scrollEnabled=NO;
        [_productSlider.collectionView setContentOffset:CGPointMake(realoff*6, 0) animated:NO];
        _productSlider.collectionView.scrollEnabled=YES;
        return;
    }
    else if (value>=25&&value<=29) {
        realoff=20;
        _productSlider.collectionView.scrollEnabled=NO;
        [_productSlider.collectionView setContentOffset:CGPointMake(realoff*6, 0) animated:NO];
        _productSlider.collectionView.scrollEnabled=YES;        return;
    }
    else if (value>=31&&value<35){
        realoff=40;
        _productSlider.collectionView.scrollEnabled=NO;
        [_productSlider.collectionView setContentOffset:CGPointMake(realoff*6, 0) animated:NO];
        _productSlider.collectionView.scrollEnabled=YES;
        return;
    }
    else if (value>=35&&value<=39){
        realoff=30;
        _productSlider.collectionView.scrollEnabled=NO;
        [_productSlider.collectionView setContentOffset:CGPointMake(realoff*6, 0) animated:NO];
        _productSlider.collectionView.scrollEnabled=YES;
        return;
    }
    else if (value>=41&&value<45){
        realoff=50;
        _productSlider.collectionView.scrollEnabled=NO;
        [_productSlider.collectionView setContentOffset:CGPointMake(realoff*6, 0) animated:NO];
        _productSlider.collectionView.scrollEnabled=YES;        return;
    }
    else if (value>=45&&value<49){
        realoff=40;
        _productSlider.collectionView.scrollEnabled=NO;
        [_productSlider.collectionView setContentOffset:CGPointMake(realoff*6, 0) animated:NO];
        _productSlider.collectionView.scrollEnabled=YES;
        return;
    }
    else if (value==49||value==98){
        realoff=40;
        _productSlider.collectionView.scrollEnabled=NO;
        [_productSlider.collectionView setContentOffset:CGPointMake(realoff*6, 0) animated:NO];
        _productSlider.collectionView.scrollEnabled=YES;
        return;
    }

    else if (value>=51&&value<55){
        realoff=60;
        _productSlider.collectionView.scrollEnabled=NO;
        [_productSlider.collectionView setContentOffset:CGPointMake(realoff*6, 0) animated:NO];
        _productSlider.collectionView.scrollEnabled=YES;
        return;
    }
    else if (value>=55&&value<58){
        realoff=50;
        _productSlider.collectionView.scrollEnabled=NO;
        [_productSlider.collectionView setContentOffset:CGPointMake(realoff*6, 0) animated:NO];
        _productSlider.collectionView.scrollEnabled=YES;
        return;
    }else if (value==59||value==180){
        realoff=50;
        _productSlider.collectionView.scrollEnabled=NO;
           [_productSlider.collectionView setContentOffset:CGPointMake(realoff*6, 0) animated:NO];
        _productSlider.collectionView.scrollEnabled=YES;
        
        return;
    }
       else{

        return;
    }
    
 
    
    
  
}

-(UIButton*)depositBtn{
    if (!_depositBtn) {
        
        _depositBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        _depositBtn.titleLabel.font=[UIFont systemFontOfSize:15.0];
        [_depositBtn setTitle:@"存入" forState:UIControlStateNormal];
        [_depositBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _depositBtn.backgroundColor=RedButtonColor;
        _depositBtn.layer.cornerRadius=5.0;
        _depositBtn.clipsToBounds=YES;
        
    }
    return _depositBtn;
}
-(UILabel*)integerLabel{
    if (!_integerLabel) {
        
       _integerLabel=[[UILabel alloc]init];
        _integerLabel.text=@"10";
        _integerLabel.font=[UIFont systemFontOfSize:60.0];
        _integerLabel.textAlignment=NSTextAlignmentRight;
        _integerLabel.textColor=RedButtonColor;
        
    }
    
    return _integerLabel;
}
-(UILabel*)decimalsLabel{
    if (!_decimalsLabel) {
        
        _decimalsLabel=[[UILabel alloc]init];
        _decimalsLabel.text=@".80%";
        _decimalsLabel.font=[UIFont systemFontOfSize:20];
        _decimalsLabel.textAlignment=NSTextAlignmentLeft;
        _decimalsLabel.textColor=RedButtonColor;

        
    }
    
    return _decimalsLabel;
}


@end
