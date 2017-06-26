//
//  CMSelectionIndex.m
//  CaiMao
//
//  Created by WangWei on 16/12/27.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMSelectionIndex.h"

@implementation CMSelectionIndex

-(id)initWithKeys:(NSMutableArray*)keys{
    self=[super init];
    if (self) {
        
        for (int i=0; i<keys.count; i++) {
            
            self.keysButton=[UIButton buttonWithType:UIButtonTypeCustom];
            [ self.keysButton setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
             self.keysButton.titleLabel.font=[UIFont systemFontOfSize:12.0];
            [self addSubview:self.keysButton];
            [self.keysButton setTitle:keys[i] forState:UIControlStateNormal];
            self.keysButton.tag=i;
            self.keysButton.frame=CGRectMake(5, i*15, 20, 15);
            [self.keysButton addTarget:self action:@selector(selectIndex:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
    }
    
    return self;
    
    
}
-(void)selectIndex:(UIButton*)button{
    if (self.selectIndex) {
      self.selectIndex(button.tag);
    }
    
    
    
}

@end
