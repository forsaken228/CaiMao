//
//  CMXinKeCell.h
//  CaiMao
//
//  Created by Fengpj on 16/1/6.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMXinKeCell : UITableViewCell

@property (strong, nonatomic)  UILabel *xinTitle;
@property (strong, nonatomic)  UILabel *xinShouZheng;
@property (strong, nonatomic)  UILabel *xinShouXiao;
@property (strong, nonatomic)  UILabel *xinQiShou;
@property (strong, nonatomic)  UILabel *xinQiXian;
@property (strong, nonatomic)  UILabel *xinQiTou;
@property (strong, nonatomic)  UIButton *xinPaiBtn;
@property(strong,nonatomic)    CMXinKeList *list;
@end
