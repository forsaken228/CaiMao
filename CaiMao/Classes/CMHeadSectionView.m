//
//  CMHeadSectionView.m
//  CaiMao
//
//  Created by MAC on 16/10/11.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMHeadSectionView.h"

@implementation CMHeadSectionView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame=CGRectMake(0, 0, CMScreenW, 20);
        self.contentView.backgroundColor=ViewBackColor;
//        UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.bounds.size.width-10, self.bounds.size.height)];
//        self.SetionTitle=title;
//        title.font=[UIFont systemFontOfSize:12.0];
//        title.textColor=UIColorFromRGB(0x8e8d93);
//        title.backgroundColor=ViewBackColor;
        self.SetionTitle.frame=CGRectMake(10, 0, self.bounds.size.width-10, self.bounds.size.height);
        [self addSubview:self.SetionTitle];
        
    
    }
    return self;
}
-(UILabel*)SetionTitle{
    if (!_SetionTitle) {
        _SetionTitle=[[UILabel alloc]init];
        _SetionTitle.font=[UIFont systemFontOfSize:12.0];
        _SetionTitle.textColor=UIColorFromRGB(0x8e8d93);
        _SetionTitle.backgroundColor=ViewBackColor;
        
    }
    return _SetionTitle;
}
@end
