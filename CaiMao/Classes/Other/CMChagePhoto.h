//
//  CMChagePhoto.h
//  CaiMao
//
//  Created by MAC on 16/10/25.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMChagePhoto : UIView

-(id)initCMChangePhotoAlert;
-(void)ShowAlert;
@property(nonatomic,assign)id delegate;

@end
@protocol CMChagePhotoDelegate <NSObject>

-(void)ChangeSourceWithTag:(NSInteger)aTag;

@end
