//
//  CMLiCaiViewController.m
//  CaiMao
//
//  Created by Fengpj on 14-12-12.
//  Copyright (c) 2014年 58cm. All rights reserved.
//

#import "CMLiCaiViewController.h"

@interface CMLiCaiViewController ()

@end

@implementation CMLiCaiViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title=@"理财";
    self.view.backgroundColor=ViewBackColor;
    self.tabedSlideView.delegate=self;
    self.tabedSlideView.baseViewController = self;
    self.tabedSlideView.tabItemNormalColor = UIColorFromRGB(0x666666);
    self.tabedSlideView.tabItemSelectedColor = RedButtonColor;
    self.tabedSlideView.tabbarTrackColor = RedButtonColor;
    //self.tabedSlideView.tabbarBackgroundImage = [UIImage imageNamed:@"tabbarBk"];

    self.tabedSlideView.tabbarBottomSpacing = 0.0;
    
    DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"定期宝" image:nil selectedImage:nil];
    // DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"银票通" image:nil selectedImage:nil];
    DLTabedbarItem *item3 = [DLTabedbarItem itemWithTitle:@"月息盈" image:nil selectedImage:nil];
    // self.tabedSlideView.tabbarItems = @[item1,item2,item3];
    self.tabedSlideView.tabbarItems = @[item1,item3];
    [self.tabedSlideView buildTabbar];
    
    self.tabedSlideView.selectedIndex = 0;
    [CMNSNotice addObserver:self selector:@selector(mattersBackLoginVc) name:@"mattersLoginVc" object:nil];
    
}

-(void)dealloc{
    [CMNSNotice removeObserver:self name:@"mattersLoginVc" object:nil];
}

- (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender{
    return 2;
}
- (UIViewController *)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index{
    switch (index) {
        case 0:
        {
            CMDingQiBaoController *dingqi = [[CMDingQiBaoController alloc] init];
            return dingqi;
        }
//        case 1:
//        {
//            CMYinPiaoController *yinpiao = [[CMYinPiaoController alloc] init];
//            return yinpiao;
//        }
        case 1:
        {
            CMYueXiYingController *yuexi = [[CMYueXiYingController alloc] init];
            return yuexi;
        }
            
        default:
            return nil;
    }
}
#pragma mark - 
- (void)mattersBackLoginVc {
    
        CMLoginController *loginVc = [[CMLoginController alloc] init];
        [self.navigationController pushViewController:loginVc animated:NO];
   

}

ReceiveMemoryWarning
@end
