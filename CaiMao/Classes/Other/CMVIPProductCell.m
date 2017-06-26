//
//  CMVIPProductCell.m
//  CaiMao
//
//  Created by MAC on 16/11/7.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMVIPProductCell.h"

@implementation CMVIPProductCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.productTitle];
        [self addSubview:self.ShouYILvZheng];
        [self addSubview:self.ShouYILvXiao];
        [self addSubview:self.QIShiShouYiLV];
        [self addSubview:self.QIXian];
        [self addSubview:self.ProductLeiXing];
        [self addSubview:self.Bugbtn];
        [self addSubview:self.productFenE];
        [self addSubview:self.JiSuanShouYi];
        [self.productTitle  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.left.equalTo(self.mas_left).offset(10);
            make.width.mas_equalTo(CMScreenW-20);
            make.top.equalTo(self.mas_top).offset(18);
        }];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClik:)];
        [self.productTitle addGestureRecognizer:tap];
        [self.ShouYILvZheng  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@65);
            make.left.equalTo(self.mas_left).offset(10);
            make.width.mas_equalTo(70);
            make.top.equalTo(self.productTitle.mas_bottom).offset(20);
        }];
        [self.ShouYILvXiao  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@21);
            make.left.equalTo(self.ShouYILvZheng.mas_right);
            make.width.mas_equalTo(50);
            make.bottom.equalTo(self.ShouYILvZheng.mas_centerY).offset(-2);
        }];
        
        [self.QIShiShouYiLV  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.left.equalTo(self.ShouYILvXiao.mas_right);
            make.width.mas_equalTo(60);
            make.bottom.equalTo(self.ShouYILvXiao);
        }];
        
        
        UILabel  *Yu=[[UILabel alloc]init];
        Yu.text=YuQiShouYi;
        Yu.font=[UIFont systemFontOfSize:14];
        Yu.textColor=UIColorFromRGB(0x8e8e8e);
        [self addSubview:Yu];
        [Yu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.left.equalTo(self.ShouYILvXiao);
            make.width.mas_equalTo(100);
            make.top.equalTo(self.ShouYILvZheng.mas_centerY).offset(2);
        }];
        //[UIImage imageNamed:@"btnUnselected.png"]
        [self.QIXian mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.right.equalTo(self.mas_right).offset(-10);
            make.bottom.equalTo(self.QIShiShouYiLV);
            make.width.equalTo(@100);
        }];
        
        [self.ProductLeiXing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.left.equalTo(self.QIXian);
            make.bottom.equalTo(Yu);
            make.width.equalTo(@120);
        }];
        UIImageView  *leftImage=[[UIImageView alloc]init];
        leftImage.image=[UIImage imageNamed:@"VipCellImage"]
        ;
        [self addSubview:leftImage];
        UIImageView  *leftImage1=[[UIImageView alloc]init];
        leftImage1.image=[UIImage imageNamed:@"VipCellImage"]
        ;
        [self addSubview:leftImage1];
        [leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.equalTo(@15);
            make.bottom.equalTo(self.QIXian);
            make.right.equalTo(self.QIXian.mas_left).offset(-5);
        }];
        
        [leftImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.left.equalTo(leftImage);
            make.bottom.equalTo(self.ProductLeiXing);
            
        }];
        
        [self.Bugbtn  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(buttonHeight);
            make.left.equalTo(self.mas_left).offset(15);
            make.right.equalTo(self.mas_right).offset(-15);
            make.bottom.equalTo(self.mas_bottom).offset(-20);
        }];
        [self.JiSuanShouYi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.right.equalTo(self.mas_right).offset(-10);
            make.width.equalTo(@100);
            make.bottom.equalTo(self.Bugbtn.mas_top).offset(-14);

            
        }];
        [self.productFenE mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.right.equalTo(self.JiSuanShouYi.mas_left);
            make.width.equalTo(@100);
            make.bottom.equalTo(self.Bugbtn.mas_top).offset(-14);
        }];
        
        self.buttonView=[[CMButtonTextView alloc]initWithFrame:CGRectMake(10, 125, 140, 32)];

        [self addSubview:self.buttonView];
        
        
//        [self addSubview:self.reducebtn];
//        [self.reducebtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.width.equalTo(@27);
//            make.left.equalTo(self.Bugbtn);
//            make.bottom.equalTo(self.Bugbtn.mas_top).offset(-14);
//        }];
//        [self addSubview:self.InPutField];
//        [self.InPutField mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.bottom.equalTo(self.reducebtn);
//            make.left.equalTo(self.reducebtn.mas_right);
//            make.width.equalTo(@80);
//        }];
//        
//        [self addSubview:self.AddBtn];
//        [self.AddBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.bottom.width.equalTo(self.reducebtn);
//            make.left.equalTo(self.InPutField.mas_right);
//          
//        }];
        
        
         [self.buttonView.textField addTarget:self action:@selector(contentDidChanged:) forControlEvents:UIControlEventEditingChanged];
         [self.buttonView.increaseBtn addTarget:self action:@selector(addProductCountAction:) forControlEvents:UIControlEventTouchUpInside];
         [self.buttonView.decreaseBtn addTarget:self action:@selector(subProductCountAction:) forControlEvents:UIControlEventTouchUpInside];
         [self.Bugbtn addTarget:self action:@selector(BugProducttAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
    
    
}
- (void)contentDidChanged:(id)sender {
  
    if (self.delegate && [self.delegate respondsToSelector:@selector(contentDidChanged:forIndexPath:)]) {
        [self.delegate contentDidChanged:self.buttonView.textField.text forIndexPath:self.indexPath];
    }
}


- (void)addProductCountAction:(id)sender {
    if (self.delegate&&[self.delegate respondsToSelector:@selector(addProductCountActionWithIndex:)]) {
        [self.delegate addProductCountActionWithIndex:self.indexPath];
    }
}

- (void)subProductCountAction:(id)sender {
    if (self.delegate&&[self.delegate respondsToSelector:@selector(subProductCountActionWithIndex:)]) {
        [self.delegate subProductCountActionWithIndex:self.indexPath];
    }
}

- (void)BugProducttAction:(id)sender {
    if (self.delegate&&[self.delegate respondsToSelector:@selector(BugProductCountActionWithIndex:)]) {
        [self.delegate BugProductCountActionWithIndex:self.indexPath];
    }
}
-(void)tapClik:(UIGestureRecognizer*)gesture{
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(IntoProductDetailPageActionWithIndex:)]) {
        [self.delegate IntoProductDetailPageActionWithIndex:self.indexPath];
    }
}
#pragma mark lazy
-(UILabel*)productTitle{
    if (!_productTitle) {
        _productTitle=[[UILabel alloc]init];
        _productTitle.font=[UIFont systemFontOfSize:15.0];
        _productTitle.textColor=UIColorFromRGB(0x3333333);
        _productTitle.userInteractionEnabled=YES;
    
    }
    return _productTitle;
}
-(UILabel*)ShouYILvZheng{
    if (!_ShouYILvZheng) {
        _ShouYILvZheng=[[UILabel alloc]init];
        _ShouYILvZheng.font=[UIFont systemFontOfSize:60.0];
        _ShouYILvZheng.textColor=RedButtonColor;
        
    }
    return _ShouYILvZheng;
}

-(UILabel*)ShouYILvXiao{
    if (!_ShouYILvXiao) {
        _ShouYILvXiao=[[UILabel alloc]init];
        _ShouYILvXiao.font=[UIFont systemFontOfSize:20.0];
        _ShouYILvXiao.textColor=RedButtonColor;
        
    }
    return _ShouYILvXiao;
}
-(UILabel*)QIShiShouYiLV{
    if (!_QIShiShouYiLV) {
        _QIShiShouYiLV=[[UILabel alloc]init];
        _QIShiShouYiLV.font=[UIFont systemFontOfSize:13.0];
        _QIShiShouYiLV.textColor=UIColorFromRGB(0xb3b3b3);
        
    }
    return _QIShiShouYiLV;
}
-(UILabel*)QIXian{
    if (!_QIXian) {
        _QIXian=[[UILabel alloc]init];
        _QIXian.font=[UIFont systemFontOfSize:13.0];
        _QIXian.textColor=UIColorFromRGB(0x8e8e8e);
        
    }
    return _QIXian;
}

-(UILabel*)ProductLeiXing{
    if (!_ProductLeiXing) {
        _ProductLeiXing=[[UILabel alloc]init];
        _ProductLeiXing.font=[UIFont systemFontOfSize:13.0];
        _ProductLeiXing.textColor=UIColorFromRGB(0x8e8e8e);
        
    }
    return _ProductLeiXing;
}
//-(UIButton*)AddBtn{
//    if (!_AddBtn) {
//        _AddBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//        _AddBtn.titleLabel.font=[UIFont systemFontOfSize:20];
//        [_AddBtn setBackgroundColor:[UIColor whiteColor]];
//        [_AddBtn setTitle:@"+" forState:UIControlStateNormal];
//         [_AddBtn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
//        _AddBtn.layer.borderColor=separateLineColor.CGColor;
//        _AddBtn.layer.borderWidth=0.8;
//        [_AddBtn addTarget:self action:@selector(addProductCountAction:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _AddBtn;
//}
//
//-(UIButton*)reducebtn{
//    if (!_reducebtn) {
//        _reducebtn=[UIButton buttonWithType:UIButtonTypeCustom];
//        _reducebtn.titleLabel.font=[UIFont systemFontOfSize:20];
//        [_reducebtn setBackgroundColor:[UIColor whiteColor]];
//        [_reducebtn setTitle:@"-" forState:UIControlStateNormal];
//        [_reducebtn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
//        [_reducebtn setTitleEdgeInsets:UIEdgeInsetsMake(-5, 0, 0, 0)];
//        _reducebtn.layer.borderColor=separateLineColor.CGColor;
//        _reducebtn.layer.borderWidth=0.8;
//        
//          [_reducebtn addTarget:self action:@selector(subProductCountAction:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _reducebtn;
//}
//-(UITextField*)InPutField{
//    if (!_InPutField) {
//        _InPutField=[[UITextField alloc]init];
//        _InPutField.textAlignment=NSTextAlignmentCenter;
//        _InPutField.textColor=UIColorFromRGB(0x333333);
//        _InPutField.keyboardType=UIKeyboardTypeNumberPad;
//        _InPutField.font=[UIFont systemFontOfSize:20];
//        _InPutField.layer.borderColor=separateLineColor.CGColor;
//        _InPutField.layer.borderWidth=0.8;
//        
//    }
//    return _InPutField;
//}
-(UILabel*)productFenE{
    if (!_productFenE) {
        _productFenE=[[UILabel alloc]init];
        _productFenE.font=[UIFont systemFontOfSize:13.0];
        _productFenE.textColor=UIColorFromRGB(0x4d4d4d);
       
    }
    return _productFenE;
}
-(UILabel*)JiSuanShouYi{
    if (!_JiSuanShouYi) {
        _JiSuanShouYi=[[UILabel alloc]init];
        _JiSuanShouYi.font=[UIFont systemFontOfSize:13.0];
        _JiSuanShouYi.textColor=RedButtonColor;
        
    }
    return _JiSuanShouYi;
}
-(UIButton*)Bugbtn{
    if (!_Bugbtn) {
        _Bugbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _Bugbtn.titleLabel.font=[UIFont systemFontOfSize:20];
        [_Bugbtn setBackgroundColor:RedButtonColor];
        [_Bugbtn setTitle:@"立即抢购" forState:UIControlStateNormal];
        [_Bugbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _Bugbtn.layer.cornerRadius=5.0;
        _Bugbtn.layer.masksToBounds=YES;
       
    }
    return _Bugbtn;
}
@end
