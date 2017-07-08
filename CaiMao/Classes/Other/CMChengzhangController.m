//
//  CMChengzhangController.m
//  CaiMao
//
//  Created by MAC on 16/11/9.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMChengzhangController.h"
#import "CMChangzhangHeadView.h"
#import "CMChengzhangFootView.h"
#import "CMVipQIanDaoViewController.h"
@interface CMChengzhangController ()

@end

@implementation CMChengzhangController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"VIP专区";
     UIImage  *image=[UIImage imageNamed:@"VIPbanner"];
    UIImage  *image2=[UIImage imageNamed:@"VIPTeQuan"];
    self.view.backgroundColor=ViewBackColor;
    CMChangzhangHeadView *head=[[CMChangzhangHeadView alloc]init];
    head.frame=CGRectMake(0, 0, CMScreenW, f_i5real(image.size.height)+ f_i5real(image2.size.height)+120);
    self.tableView.tableHeaderView=head;
    CMChengzhangFootView *foot=[[CMChengzhangFootView alloc]init];
    foot.frame=CGRectMake(0, 0, CMScreenW,350);
    self.tableView.tableFooterView=foot;
    [foot.TouZiBtn addTarget:self action:@selector(GonewView:) forControlEvents:UIControlEventTouchUpInside];
    [foot.QianDaoBtn addTarget:self action:@selector(GonewView:) forControlEvents:UIControlEventTouchUpInside];
    [foot.YaoQingBtn addTarget:self action:@selector(GonewView:) forControlEvents:UIControlEventTouchUpInside];
    
   
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}
-(void)GonewView:(UIButton*)btn
{
    switch (btn.tag) {
        case 10:
        {
            CMLiCaiViewController *lici=[[CMLiCaiViewController alloc]init];
            [self.navigationController pushViewController:lici animated:YES];

           
        }
       
            break;
        case 11:
        {
           
                if( [CMRequestManager islogin]){
                    if(self.isQiDao){
                        [self.navigationController popViewControllerAnimated:YES];
                    }else{
                CMVipQIanDaoViewController *vc=[[CMVipQIanDaoViewController alloc]init];
                CMPush(vc);
                    }
                }else{
                    CMLoginController *vc=[[CMLoginController alloc]init];
                    CMPush(vc);
                    
                }
               
           
            
        }
            break;
        case 12:
        {
            
            if( [CMRequestManager islogin]){
                
               [self yaoqingFriend];
                
            }else{
                CMLoginController *vc=[[CMLoginController alloc]init];
                CMPush(vc);
                
            }

            
            
        }
            break;
            
        default:
            break;
    }
    
    
    
}

 -(void)yaoqingFriend{
 
 
     
     CMCustomShareView   *shareView=[[CMCustomShareView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, CMScreenH)];

     [shareView showShareView];
     

     [CMRequestHandle shortUrl:[NSString stringWithFormat:@"%@/FriendRegist-%@.aspx",OnLineCode,[CMUserDefaults objectForKey:@"userID"]] andSuccess:^(id responseObj) {
         for (NSDictionary *dict in responseObj) {
       
             shareView.contentUrl=[dict objectForKey:@"url_short"];
             
             shareView.titleConten = @"送你588元新客大礼包,不领就过期了_财猫网";
             
             shareView.contentStr =[NSString stringWithFormat:@"朋友送你588元新客大礼包,有便宜不占,天理不容的赔本儿买卖啊！%@", shareView.contentUrl];
             shareView.ShareImageName= @[[UIImage imageNamed:@"cmshare"]];
         }
         
     }];
     
     
     
     
 }

     
     
     




@end
