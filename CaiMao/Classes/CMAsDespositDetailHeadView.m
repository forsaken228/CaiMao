//
//  CMAsDespositDetailHeadView.m
//  CaiMao
//
//  Created by WangWei on 17/3/24.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import "CMAsDespositDetailHeadView.h"
@interface CMAsDespositDetailHeadView ()<CMScrollSliderDelegate>
{
    int realoff;
}

@end
@implementation CMAsDespositDetailHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        UIImage *topbg=[UIImage imageNamed:@"AsDespoitImage"];
        UIImageView *topBgImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, topbg.size.height)];
        topBgImageView.image=topbg;
        [self addSubview:topBgImageView];

        
        UILabel *QXian=[[UILabel alloc]init];
        QXian.text=@"期限自定";
        QXian.font=[UIFont systemFontOfSize:12.0];
        QXian.textAlignment=NSTextAlignmentLeft;
        QXian.textColor=[UIColor whiteColor];
        [topBgImageView addSubview:QXian];
        [QXian mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(topBgImageView.mas_bottom).offset(-37);
            make.left.equalTo(topBgImageView.mas_centerX);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(14.0);
            
            
        }];
        
        UILabel *CircleOne=[[UILabel alloc]init];
        CircleOne.layer.cornerRadius=3.0;
        CircleOne.clipsToBounds=YES;
        CircleOne.backgroundColor=UIColorFromRGB(0xffb3a5);
        [topBgImageView addSubview:CircleOne];
        [CircleOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(QXian.mas_left).offset(-3);
            make.centerY.equalTo(QXian.mas_centerY);
            make.height.width.equalTo(@6);
            
            
        }];
        
        
        UILabel *CircleSecond=[[UILabel alloc]init];
        CircleSecond.layer.cornerRadius=4.0;
        CircleSecond.clipsToBounds=YES;
        CircleSecond.backgroundColor=UIColorFromRGB(0xffb3a5);
        [topBgImageView addSubview:CircleSecond];
        [CircleSecond mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(topBgImageView.mas_left).offset(20);
            make.centerY.equalTo(QXian.mas_centerY);
            make.height.width.equalTo(CircleOne);
            
            
        }];
        
        
        UILabel *SHy=[[UILabel alloc]init];
        SHy.text=@"上市公司优良资产";
        SHy.font=[UIFont systemFontOfSize:12.0];
        SHy.textColor=[UIColor whiteColor];
        [topBgImageView addSubview:SHy];
        [SHy mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.height.equalTo(QXian);
            make.left.equalTo(CircleSecond.mas_right).offset(3);
            make.width.mas_equalTo(100);
            
            
            
        }];
        
   
        
     
        UILabel *DQJX=[[UILabel alloc]init];
        DQJX.text=@"到期仍计息";
        DQJX.font=[UIFont systemFontOfSize:12.0];
        DQJX.textColor=[UIColor whiteColor];
        [topBgImageView addSubview:DQJX];
        [DQJX mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.height.equalTo(QXian);
            make.right.equalTo(topBgImageView.mas_right).offset(-20);
            make.width.mas_equalTo(70);
  
        }];
        
      
        UILabel *CircleThird=[[UILabel alloc]init];
        CircleThird.layer.cornerRadius=4.0;
        CircleThird.clipsToBounds=YES;
        CircleThird.backgroundColor=UIColorFromRGB(0xffb3a5);
        [topBgImageView addSubview:CircleThird];
        [CircleThird mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(DQJX.mas_left).offset(-3);
            make.centerY.equalTo(QXian.mas_centerY);
            make.height.width.equalTo(CircleOne);
            
            
        }];
        
        
        
        
        [topBgImageView addSubview:self.integerLabel];
        [self.integerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(QXian.mas_top).offset(-20);
            make.right.equalTo(QXian.mas_left).offset(5);
            make.width.mas_equalTo(75);
            make.height.mas_equalTo(70);
        }];
        
        [topBgImageView addSubview:self.decimalsLabel];
        [self.decimalsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.integerLabel.mas_centerY).offset(-2);
            make.left.equalTo(self.integerLabel.mas_right).offset(2);
            make.width.mas_equalTo(65);
            make.height.mas_equalTo(21);
        }];
        
        UILabel *shouyi=[[UILabel alloc]init];
        shouyi.text=YuQiShouYi;
        shouyi.font=[UIFont systemFontOfSize:12.0];
        shouyi.textAlignment=NSTextAlignmentLeft;
        shouyi.textColor=[UIColor whiteColor];
        [topBgImageView addSubview:shouyi];
        [shouyi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.integerLabel.mas_centerY).offset(7);
            make.left.equalTo(self.decimalsLabel);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(18.0);
            
            
        }];
        
        UIView *sepLine=[UIView new];
        sepLine.backgroundColor=ViewBackColor;
        [self addSubview:sepLine];
        [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@10);
            make.top.equalTo(topBgImageView.mas_bottom);
            make.width.centerX.equalTo(self);
        }];
        
        
        _productSlider=[[CMScrollSlider alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(topBgImageView.frame)+30,CMScreenW,100) MinValue:0 MaxValue:60 Step:1];
        _productSlider.delegate=self;
        _productSlider.fromHome=NO;
        [self addSubview:_productSlider];
        
        realoff=0;
        
        
        
        
        
        [self addSubview:self.depositBtn];
        [self.depositBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(buttonHeight);
            make.bottom.equalTo(self.mas_bottom).offset(-15);
            make.left.equalTo(self.mas_left).offset(15);
            make.right.equalTo(self.mas_right).offset(-15);
        }];
        
        [self addSubview:self.InPutText];
        
        [self.InPutText mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(30);
            make.width.equalTo(@120);
            make.bottom.equalTo(self.depositBtn.mas_top).offset(-20);
            make.centerX.equalTo(self.depositBtn);
            
        }];
        
        
        UILabel *cunRu=[[UILabel alloc]init];
        // cunRu.frame=CGRectMake(169 , 22, 38, 20);
        cunRu.text=@"存入";
        cunRu.font=[UIFont systemFontOfSize:14.0];
        cunRu.textAlignment=NSTextAlignmentCenter;
        cunRu.textColor=UIColorFromRGB(0x808080);
        [self addSubview:cunRu];
        [cunRu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.InPutText);
            make.right.equalTo(self.InPutText.mas_left);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(35);
            
            
        }];
        
        UILabel *yuan=[[UILabel alloc]init];
    
        yuan.font=[UIFont systemFontOfSize:14.0];
        yuan.text=@"元";
        yuan.textAlignment=NSTextAlignmentCenter;
        yuan.textColor=UIColorFromRGB(0x808080);;
        [self addSubview:yuan];
        [yuan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.top.equalTo(cunRu);
            make.width.mas_equalTo(25);
            make.left.equalTo(self.InPutText.mas_right);
        }];

        
    }
    return self;
}
#pragma mark Lazy
-(UILabel*)integerLabel{
    if (!_integerLabel) {
        
        _integerLabel=[[UILabel alloc]init];
        _integerLabel.text=@"10";
        _integerLabel.font=[UIFont systemFontOfSize:65.0];
        _integerLabel.textAlignment=NSTextAlignmentRight;
        _integerLabel.textColor=[UIColor whiteColor];
        
    }
    
    return _integerLabel;
}
-(UILabel*)decimalsLabel{
    if (!_decimalsLabel) {
        
        _decimalsLabel=[[UILabel alloc]init];
        _decimalsLabel.text=@".80%";
        _decimalsLabel.font=[UIFont systemFontOfSize:20];
        _decimalsLabel.textAlignment=NSTextAlignmentLeft;
        _decimalsLabel.textColor=[UIColor whiteColor];
        
        
    }
    
    return _decimalsLabel;
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

-(UITextField*)InPutText{
    if (!_InPutText) {
        _InPutText=[[UITextField alloc]init];
        _InPutText.font=[UIFont systemFontOfSize:14];
        _InPutText.placeholder=@"1元起";
        _InPutText.borderStyle=UITextBorderStyleRoundedRect;
        _InPutText.keyboardType=UIKeyboardTypeNumberPad;
        _InPutText.textAlignment=NSTextAlignmentCenter;
        _InPutText.textColor=RedButtonColor;
        _InPutText.delegate=self;
    }
    
    return _InPutText;
}
#pragma mark 只能输入整数
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    return [NSString validateNumber:string];
    
    
}
#pragma mark CMScrollerSliderDelegate
-(void)CMScrollSlider:(CMScrollSlider *)slider ValueChange:(int)value andYield:(float)yield{
    
    self.selectVaule=value;
    
}
-(void)CMScrollSliderMove:(CMScrollSlider *)slider ValueChange:(int)value andYield:(float)yield{
    DLog(@"Vaule+++%d",value);
    int newYield=(int)yield;

    self.integerLabel.text=[NSString stringWithFormat:@"%d",newYield];
    self.decimalsLabel.text=[NSString stringWithFormat:@".%.f%%",(yield-(float)newYield)*100];
    
    self.selectVaule=value;
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

@end
