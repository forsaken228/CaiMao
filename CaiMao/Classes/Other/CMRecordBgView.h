//
//  CMRecordBgView.h
//  CaiMao
//
//  Created by MAC on 16/9/1.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMRecordBgView : UIView
{
    
    UIImageView *imageView;
    UILabel *label1;
}
-(void)creatHeadImage:(NSString*)ahedImage andTitle:(NSString*)aTitle;
-(void)cleanNsstring;
@end
