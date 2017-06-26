//
//  CMZhuanChuSuccessViewController.m
//  CaiMao
//
//  Created by MAC on 16/11/11.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMZhuanChuSuccessViewController.h"

@interface CMZhuanChuSuccessViewController ()

@end

@implementation CMZhuanChuSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=ViewBackColor;
    self.title=@"财富宝转出成功";
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"转出说明" style:UIBarButtonItemStylePlain target:self action:@selector(zhuanchuShuoMing)];
     [CMNSNotice postNotificationName:@"BeginRefresh" object:nil];
    [self creatFootViewAndHeadView];
}

- (void)zhuanchuShuoMing {
    
    CMZhuanChuShuoMing *vc=[[CMZhuanChuShuoMing alloc]init];
    [vc ShowAlert];

  
}
-(void)creatFootViewAndHeadView{
    UIView *bgView=[[UIView alloc]init];
    bgView.frame=CGRectMake(0, 0, CMScreenW, 50);
    CMTopBgView *top=[[CMTopBgView alloc]initWithImage:@"转出成功"];
    top.frame=CGRectMake(0,10, CMScreenW, 30) ;
    [bgView addSubview:top];
    self.tableView.tableHeaderView=bgView;
    CMZhuanChuSuccessFootView *foot=[[CMZhuanChuSuccessFootView alloc]init];
    NSString *yuer=[CMUserDefaults objectForKey:@"YuEr"];
    NSString *total=[NSString stringWithFormat:@"%.2f",[self.amount floatValue]+[yuer floatValue]];
    foot.frame=CGRectMake(0, 0, CMScreenW, 180) ;
    foot.detailLabel.text=[NSString stringWithFormat:@"您已转出%@元到财猫账户,财富宝余额%@元",self.amount,total];
    [self loneStringChangeColer:foot.detailLabel andFromStr:@"出" withString:self.amount andFromStr:@"额" withString:total WithColor:RedButtonColor];
    foot.delegate=self;
                self.tableView.tableFooterView=foot;
}
-(void)changeViewActionWithTag:(NSInteger)aTag{
    switch (aTag) {
        case 10:{
          
             NSMutableArray  *arr=[[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
            [self.navigationController popToViewController:arr[1] animated:YES];
        }
            break;
        case 11:{
            UIWindow *window=[UIApplication sharedApplication].windows.firstObject;
            CMTabBarController *tab=(CMTabBarController*)window.rootViewController;
            
                [tab selectTap:2];
       
            NSMutableArray  *arr=[[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    
                [arr removeObjectsInRange:NSMakeRange(1, arr.count - 1)];
            
          
            self.navigationController.viewControllers=arr;
        }
            break;
        case 12:
        {
            UIWindow *window=[UIApplication sharedApplication].windows.firstObject;
            CMTabBarController *tab=(CMTabBarController*)window.rootViewController;
            
            
            [tab selectTap:1];
            
            NSMutableArray  *arr=[[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
        
                [arr removeObjectsInRange:NSMakeRange(1, arr.count - 1)];
           
          
            self.navigationController.viewControllers=arr;
        }

            break;
            
        default:
            break;
    }
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}

-(void)loneStringChangeColer:(UILabel *)mainStr andFromStr:(NSString *)aFromStr withString:(NSString*)toStr andFromStr:(NSString *)TFromStr withString:(NSString*)soStr WithColor:(UIColor*)color{
    //UIColorFromRGB(0xfa3e19)
    NSMutableAttributedString *Pay=[[NSMutableAttributedString alloc]initWithString: mainStr.text];
    NSRange PayFromRang1 = [mainStr.text rangeOfString:aFromStr];
    
    [Pay addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(PayFromRang1.location+1,toStr.length)];
    NSRange PayFromRang2 = [mainStr.text rangeOfString:TFromStr];
    
    [Pay addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(PayFromRang2.location+1,soStr.length)];

    
    
    mainStr.attributedText = Pay;
    
}
@end
