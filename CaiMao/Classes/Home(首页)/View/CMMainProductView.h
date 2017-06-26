//
//  CMMainProductView.h
//  CaiMao
//
//  Created by WangWei on 2017/6/5.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CMMainProductView <NSObject>

-(void)collectViewDidSelect:(NSIndexPath*)indexpath;

@end


@interface CMMainProductView : UIView

@property(nonatomic,weak) id<CMMainProductView>delegate;

@end

