//
//  CMTIXianFootView.h
//  CaiMao
//
//  Created by MAC on 16/7/5.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMTIXianFootView : UIView

@property(nonatomic,strong)UIButton *NextBtn;

@property(nonatomic,strong)UIButton  *TiXianBtnClick;
@property(nonatomic,strong)UILabel  *errorLabel;
-(UIView*)creatTiXianFootView;
-(UIView*)creatTiXianDetailFootView;
@end
