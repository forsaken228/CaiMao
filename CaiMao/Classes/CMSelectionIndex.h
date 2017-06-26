//
//  CMSelectionIndex.h
//  CaiMao
//
//  Created by WangWei on 16/12/27.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMSelectionIndex : UIView


@property(nonatomic,strong)UIButton *keysButton;
@property(nonatomic,weak)id selectDelegate;
@property(nonatomic,copy)void(^selectIndex)(NSInteger index);
-(id)initWithKeys:(NSMutableArray*)keys;
@end


