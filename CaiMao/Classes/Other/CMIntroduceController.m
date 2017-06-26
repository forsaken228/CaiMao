//
//  CMIntroduceController.m
//  CaiMao
//
//  Created by MAC on 16/10/19.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMIntroduceController.h"

@interface CMIntroduceController ()
@property(nonatomic,strong)NSArray *titileArray;
@end

@implementation CMIntroduceController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"财猫网简介";
    self.view.backgroundColor=ViewBackColor;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.titileArray=@[@"关于我们",@"公告/动态",@"法律法规",@"合作伙伴",@"联系我们",@"网站声明"];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.titileArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"moreCell";
    CMMoreCell *cell= [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[CMMoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSArray *arr=@[@"关于我们",@"公告:动态",@"法律法规",@"合作伙伴",@"联系我们",@"网站声明"];
    cell.leftImageView.image=[UIImage imageNamed:arr[indexPath.row]];
    cell.moreTitle.text = self.titileArray[indexPath.row];

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *url=@[@"http://m.58cm.com/mi/about.aspx",@"http://m.58cm.com/mi/newslist.aspx",@"http://m.58cm.com/mi/laws.aspx",@"http://m.58cm.com/mi/partner.aspx",@"http://m.58cm.com/mi/contact.aspx",@"http://m.58cm.com/mi/shengming.aspx"];
    if (indexPath.row==1) {
        CMNoticeViewController* vc=[[CMNoticeViewController alloc]init];
        CMPush(vc);
    }else{
    CMProductDetailController *proVc = [[CMProductDetailController alloc] init];
    proVc.urlStr=url[indexPath.row];
    [self.navigationController pushViewController:proVc animated:YES];
    }
}
@end
