//
//  CMRecordOfCharge.m
//  CaiMao
//
//  Created by MAC on 16/7/14.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMRecordOfCharge.h"
#import "CMZiJinRecordController.h"
#import "CMChargeRecordController.h"
@interface CMRecordOfCharge ()

@end

@implementation CMRecordOfCharge

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.tabedSlideView=[[DLTabedSlideView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, CMScreenH)];
    
    self.tabedSlideView.delegate=self;
    self.tabedSlideView.baseViewController = self;
    self.tabedSlideView.tabItemNormalColor = UIColorFromRGB(0x666666);
    self.tabedSlideView.tabItemSelectedColor = RedButtonColor;
    self.tabedSlideView.tabbarTrackColor = RedButtonColor;
    self.tabedSlideView.tabbarBackgroundImage = [UIImage imageNamed:@"tabbarBk"];
    self.tabedSlideView.tabbarBottomSpacing = 0.0;
    
    DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"资金记录" image:nil selectedImage:nil];
    DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"充值记录" image:nil selectedImage:nil];
    // self.tabedSlideView.tabbarItems = @[item1,item2,item3];
    self.tabedSlideView.tabbarItems = @[item1,item2];
    [self.tabedSlideView buildTabbar];
    
    self.tabedSlideView.selectedIndex =self.selectIndex;
    [self.view addSubview:self.tabedSlideView];
      
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(self.selectIndex==0){
       self.title=@"资金记录";
        
    }else{
       self.title=@"充值记录";
        
    }
    
}
- (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender{
    return 2;
}
- (UIViewController *)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index{
    switch (index) {
        case 0:
        {
          
            CMZiJinRecordController *ziJin = [[CMZiJinRecordController alloc] init];
            return ziJin;
        }
            
        case 1:
        {
            
            CMChargeRecordController *charge = [[CMChargeRecordController alloc] init];
            return charge;
        }
            
        default:
            return nil;
    }
}
- (void)DLTabedSlideView:(DLTabedSlideView *)sender didSelectedAt:(NSInteger)index;{
    switch (index) {
        case 0:
        {
        self.title=@"资金记录";
           
        }
            break;
        case 1:
        {
          self.title=@"充值记录";
       }
        default:
           break;
    
    }
    
}
@end
