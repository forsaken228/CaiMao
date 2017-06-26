//
//  CMShareView.h
//  CaiMao
//
//  Created by MAC on 16/10/10.
//  Copyright © 2016年 58cm. All rights reserved.
//
typedef NS_ENUM(NSInteger,CMShareViewType){
    CMShareViewTypeSms,//短信
    CMShareViewTypeQQ,//qq分享
    CMShareViewTypeQzone,//qq空间
    CMShareViewTypeWechat,//微信
    CMShareViewTypeFriends,//朋友圈
    CMShareViewTypeWebo,//微博
    CMShareViewTypeCancel //取消
};


#import <UIKit/UIKit.h>
@protocol CMShareViewDelegate <NSObject>

- (void)shareViewShareType:(CMShareViewType)type;

@end

@interface CMShareView : UIView

@property (nonatomic,assign) id<CMShareViewDelegate>delegate;

@end
