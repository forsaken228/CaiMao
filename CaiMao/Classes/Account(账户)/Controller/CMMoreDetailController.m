//
//  CMMoreController.m
//  CaiMao
//
//  Created by Fengpj on 16/1/14.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMMoreDetailController.h"

@interface CMMoreDetailController ()<NSURLConnectionDelegate>
{
    NSArray *_moreArr;
    //DMAdView *_dmAdView;
    //NSString *_trackViewUrl;
    
}

@end

@implementation CMMoreDetailController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"更多";
    self.view.backgroundColor=ViewBackColor;
   
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _moreArr = [NSArray arrayWithObjects:@"关于财猫",@"帮助中心",@"意见反馈",@"联系我们",nil];
    

}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _moreArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"moreCell";
   CMMoreCell *cell= [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[CMMoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
   NSArray *ImageArr  = [NSArray arrayWithObjects:@"关于财猫猫",@"帮助",@"意见回馈",@"联系我们",nil];
    cell.leftImageView.image=[UIImage imageNamed:ImageArr[indexPath.row]];
    cell.moreTitle.text = _moreArr[indexPath.row];
    if (indexPath.row == 3) {
        cell.moreSubTitle.hidden = NO;
        cell.moreSubTitle.text = @"400-999-3972";
    }
//    if (indexPath.row == 4) {
//        cell.moreSubTitle.hidden = NO;
//        NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
//        NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
//        cell.moreSubTitle.text =[NSString stringWithFormat:@"         V%@",currentVersion];
//    }
    
    return cell;
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
   // CMProductDetailController *proVc = [[CMProductDetailController alloc] init];
    CMFeedBackController *feedVc = [[CMFeedBackController alloc] init];
    
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"4009993972"];
    UIWebView *callWebview = [[UIWebView alloc] init];
    
    switch (indexPath.row) {
        case 0:
//           proVc.urlStr = @"http://m.58cm.com/mi/index.aspx";
//           [self.navigationController pushViewController:proVc animated:YES];
        {            CMIntroduceController *proVc = [[CMIntroduceController alloc] init];
           [self.navigationController pushViewController:proVc animated:YES];
     }
            break;
        case 1:{
            CMHelpController *Help=[[CMHelpController alloc] init];
          // proVc.urlStr = @"http://m.58cm.com/hp/index.aspx";
            [self.navigationController pushViewController:Help animated:YES];
        }
            break;
        case 2:
            [self.navigationController pushViewController:feedVc animated:YES];
            break;
        case 3:
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
            [self.view addSubview:callWebview];
            break;
       
        default:
            break;
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
@end
