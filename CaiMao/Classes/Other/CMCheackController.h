//
//  CMCheackController.h
//  CaiMao
//
//  Created by MAC on 16/10/25.
//  Copyright © 2016年 58cm. All rights reserved.
//

typedef enum{
    CheackTypeUpLoadSuccesse = 1,//上传成功
    CheackTypeISCheack,//正在审核
    CheackTypeCheackFailure,//修改邮箱
    
}CheackType;

#import <UIKit/UIKit.h>

@interface CMCheackController : UIViewController
@property(nonatomic,strong)UIImageView *statuesImage;
@property(nonatomic,strong)UILabel *statuesLabel;
@property(nonatomic,strong)UILabel *DetailLabel;
@property(nonatomic,strong)UILabel *PhoneLabel;
@property(nonatomic,strong)UIButton *clickBtn;
@property(nonatomic,assign)CheackType type;
@property(nonatomic,copy)NSString *message;
@property(nonatomic,strong)NSArray *bankListArry;
@end
