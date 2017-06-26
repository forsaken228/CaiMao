//
//  CMPersonerMsg.h
//  CaiMao
//
//  Created by MAC on 16/10/25.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMPersonerMsg : UIView
@property(nonatomic,strong)UITextField *userName;
@property(nonatomic,strong)UITextField *personerID;
@property(nonatomic,strong)UITextField *bankID;
@property(nonatomic,strong)UITextField *UpLoadID;
@property(nonatomic,strong)UIImageView *backImageView;
@property(nonatomic,strong)UIImageView *FaceImageView;
@property(nonatomic,strong)UILabel *errorLabel;
@property(nonatomic,strong)UIButton *nextButton;
@property(nonatomic,assign)id delegate;
@end
@protocol CMPersonerMsgDelegate <NSObject>

-(void)goNextView;

@end