//
//  CMAsDespositDetailHeadView.h
//  CaiMao
//
//  Created by WangWei on 17/3/24.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMAsDespositDetailHeadView : UIView<UITextFieldDelegate>
@property(nonatomic,strong)UILabel *integerLabel;
@property(nonatomic,strong)UILabel *decimalsLabel;
@property(nonatomic,strong)UIButton *depositBtn;
@property(nonatomic,strong)UITextField *InPutText;
@property(nonatomic,strong) CMScrollSlider *productSlider;
@property(nonatomic,assign)int selectVaule;
@end
