//
//  CMVIPProductCell.h
//  CaiMao
//
//  Created by MAC on 16/11/7.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMButtonTextView.h"
@interface CMVIPProductCell : UITableViewCell
@property(nonatomic,strong)UILabel *productTitle;
@property(nonatomic,strong)UILabel *ShouYILvZheng;
@property(nonatomic,strong)UILabel *ShouYILvXiao;
@property(nonatomic,strong)UILabel *QIShiShouYiLV;
@property(nonatomic,strong)UILabel *QIXian;
@property(nonatomic,strong)UILabel *ProductLeiXing;
//@property(nonatomic,strong)UIButton *AddBtn;
//@property(nonatomic,strong)UITextField *InPutField;

@property(nonatomic,strong)CMButtonTextView *buttonView;
//@property(nonatomic,strong)UIButton *reducebtn;
@property(nonatomic,strong)UILabel *productFenE;
@property(nonatomic,strong)UILabel *JiSuanShouYi;
@property(nonatomic,strong)UIButton *Bugbtn;
@property(nonatomic,weak) id delegate;

@property (strong, nonatomic) NSIndexPath *indexPath;
@end
@protocol CMVIPProductCellDelegate <NSObject>

- (void)contentDidChanged:(NSString *)text forIndexPath:(NSIndexPath *)indexPath;
- (void)addProductCountActionWithIndex:(NSIndexPath *)indexPath;
- (void)subProductCountActionWithIndex:(NSIndexPath *)indexPath;
- (void)BugProductCountActionWithIndex:(NSIndexPath *)indexPath;
- (void)IntoProductDetailPageActionWithIndex:(NSIndexPath *)indexPath;
@end
