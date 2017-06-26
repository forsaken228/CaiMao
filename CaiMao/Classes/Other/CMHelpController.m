//
//  CMHelpController.m
//  CaiMao
//
//  Created by MAC on 16/10/21.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMHelpController.h"
#import "CMHelpHeadView.h"
#import "CMHelpViewCell.h"
@interface CMHelpController ()

{
   NSMutableDictionary *OpenOrCloseDict;//创建一个字典进行判断收缩还是展开

}
@property(nonatomic,strong)NSDictionary *dict;
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)NSArray *DetailArr;
@property(nonatomic,strong)NSDictionary *Urldict;


@end

@implementation CMHelpController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"帮助中心";
    self.view.backgroundColor=ViewBackColor;
     OpenOrCloseDict = [NSMutableDictionary dictionary];
    self.titleArr=@[@"新手入门", @"我是投资人",@"账户管理",@"特惠活动"];
    self.dict=@{@"新手入门":@[@"收费标准",@"常见问题",@"我的招财猫",@"名词解释",@"喵劵介绍",@"收益提现说明"],
                @"我是投资人":@[@"了解产品",@"投资交易",@"支付",@"投资收益",@"财富宝"],
                @"账户管理":@[@"财富账户",@"充值",@"取现",@"资金记录"],
                @"特惠活动":@[@"关于财猫",@"安全保障",@"推荐好友"]};
    
       self.Urldict=@{@"新手入门":@[@"http://m.58cm.com/help/2/收费标准.aspx",@"http://m.58cm.com/help/3/常见问题.aspx",@"http://m.58cm.com/help/4/我的招财猫.aspx",@"http://m.58cm.com/help/5/名词解释.aspx",@"http://m.58cm.com/help/29/喵劵介绍.aspx",@"http://m.58cm.com/help/30/收益及提现说明.aspx"],@"我是投资人":@[@"http://m.58cm.com/help/7/了解产品.aspx",@"http://m.58cm.com/help/8/投资交易.aspx",@"http://m.58cm.com/help/9/支付.aspx",@"http://m.58cm.com/help/10/投资收益.aspx",@"http://m.58cm.com/help/28/财富宝.aspx"],@"账户管理":@[@"http://m.58cm.com/help/21/财富账户.aspx",@"http://m.58cm.com/help/22/充值.aspx",@"http://m.58cm.com/help/23/取现.aspx",@"http://m.58cm.com/help/24/资金记录.aspx"],@"特惠活动":@[@"http://m.58cm.com/help/1/关于财猫.aspx",@"http://m.58cm.com/help/6/安全保障.aspx",@"http://m.58cm.com/help/25/推荐好友.aspx"]};
//    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, CMScreenH)];
//    bgView.backgroundColor=CMColor(234, 234, 234);
//    
//    self.tableView.tableFooterView=bgView;
    self.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self HeadViewImageView];
    [OpenOrCloseDict setObject:@"1" forKey:@"0"];

}


-(void)HeadViewImageView{
    
    UIImage *image=[UIImage imageNamed:@"帮助中心HeadView"];
    UIImageView *contentView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,f_i5real( image.size.width),f_i5real( image.size.height))];
    contentView.image=image;
    self.tableView.tableHeaderView=contentView;

    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *string = [NSString stringWithFormat:@"%ld",section];
    if ([OpenOrCloseDict[string] integerValue] == 1 ) {  //打开cell返回数组的count
        NSArray *arr=[self.dict objectForKey:self.titleArr[section]];
        
        return  arr.count;

    }else{
        return 0;
    }
   
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"moreCell";
    CMHelpViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[CMHelpViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
   
    NSArray *arr=[self.dict objectForKey:self.titleArr[indexPath.section]];
    cell.HeadTitle.text = arr[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString *head=@"section";
    CMHelpHeadView *headView=[tableView dequeueReusableHeaderFooterViewWithIdentifier:head];
    if (!headView) {
        headView=[[CMHelpHeadView alloc]initWithReuseIdentifier:head];
    }
   // DLog(@"+++%@",self.dict.allKeys[section]);
    headView.LeftImageView.image=[UIImage imageNamed:self.titleArr[section]];
    headView.titleLabel.text=self.titleArr[section];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(action_tap:)];
    headView.tag = 300 + section;
    [headView addGestureRecognizer:tap];
    NSString *str = [NSString stringWithFormat:@"%ld",section] ;
    if ([OpenOrCloseDict[str] integerValue] == 0) {
       
      headView.rightImageView.transform=CGAffineTransformMakeRotation(M_PI_2);
       
    }else{
         headView.rightImageView.transform=CGAffineTransformIdentity;
       
    }
 
    return headView;
}

- (void)action_tap:(UIGestureRecognizer *)tap{
    NSString *str = [NSString stringWithFormat:@"%ld",tap.view.tag - 300];
  
    if ([OpenOrCloseDict[str] integerValue] == 0) {//如果是0，就把1赋给字典,打开cell
        [OpenOrCloseDict setObject:@"1" forKey:str];
        for (NSString *keys in OpenOrCloseDict.allKeys) {
            
            
            if (![str isEqualToString:keys]) {
                [OpenOrCloseDict setObject:@"0" forKey:keys];
            }
                
           
        }
      
    }else{//反之关闭cell
        
         [OpenOrCloseDict setObject:@"0" forKey:str];
//        for (NSString *keys in OpenOrCloseDict.allKeys) {
//            if (![str isEqualToString:keys]) {
//                [OpenOrCloseDict setObject:@"1" forKey:keys];
//            }
//              
//            
//        }
        
    }
   //  [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:[str integerValue]] withRowAnimation:UITableViewRowAnimationFade];//有动画的刷新
    [self.tableView reloadData];

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *arr=[self.Urldict objectForKey:self.titleArr[indexPath.section]];
  
    CMProductDetailController *proVc = [[CMProductDetailController alloc] init];
    proVc.urlStr=arr[indexPath.row];
    [self.navigationController pushViewController:proVc animated:YES];
}
@end
