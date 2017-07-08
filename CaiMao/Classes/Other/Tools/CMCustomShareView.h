//
//  CMCustomShareView.h
//  CaiMao
//
//  Created by WangWei on 17/3/8.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMCustomShareView : UIView

@property (nonatomic,copy) NSString *contentUrl; //分享链接
@property (nonatomic,copy) NSString *titleConten; //标题
@property (nonatomic,copy) NSString *contentStr; //n内容
@property (nonatomic,strong) NSArray *ShareImageName; //n内容
- (void)remove;
-(void)showShareView;
@end
