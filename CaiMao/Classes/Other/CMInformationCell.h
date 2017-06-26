//
//  CMInformationCell.h
//  CaiMao
//
//  Created by MAC on 16/10/26.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMInformationCell : UITableViewCell
@property(nonatomic,strong)UILabel *DetailTitle;
@property(nonatomic,strong)UITextField *detailField;
@property(nonatomic,strong)UIButton *manBtn;
@property(nonatomic,strong)UIButton *WomanBtn;

@property(nonatomic,strong)NSIndexPath *IndexPath;
@property(nonatomic,weak)id delegate;
@end

@protocol CMInformationCellDelegate <NSObject>

-(void)clickChangeWithButtonTag:(NSInteger)Tag andIndex:(NSIndexPath*)index;

@end
