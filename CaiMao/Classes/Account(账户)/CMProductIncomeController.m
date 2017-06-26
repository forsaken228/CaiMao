//
//  CMProductIncomeController.m
//  CaiMao
//
//  Created by MAC on 16/10/28.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMProductIncomeController.h"

@interface CMProductIncomeController ()


@property(nonatomic,copy)NSString *BenJin;
@property(nonatomic,strong)CMProductIncomeHead *head;
@property(nonatomic,strong)CMProductIncomeFoot *footView;
@end

@implementation CMProductIncomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=ViewBackColor;
    self.title=@"收益详情";
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"我的账户" style:UIBarButtonItemStylePlain target:self action:@selector(goAuccount)];
    self.tableView.hidden=YES;
    self.tableView.tableHeaderView=self.head;
    self.tableView.tableFooterView=self.footView;
    [self showDefaultProgressHUD];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self LoadData];
    self.tableView.mj_header=[CMRefreshHeader headerWithRefreshingBlock:^{
        [self LoadData];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [self requestShouYiDetail];
    }];
   // [self.tableView.mj_header beginRefreshing];
    
}
-(void)goAuccount{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)LoadData{
    
    [self.TotalArr removeAllObjects];
    self.pageIndex=1;
    [self requestShouYiDetail];
}

#pragma mark Lazy

-(CMProductIncomeHead*)head{
    
    if (!_head) {
        _head=[[CMProductIncomeHead alloc]init];
        _head.frame=CGRectMake(0, 0, CMScreenW, 170);

    }
    return _head;
}

-(CMProductIncomeFoot*)footView{
    if (!_footView) {
        _footView=[[CMProductIncomeFoot alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 70)];
        _footView.BJin.text=@"0.00";
        _footView.LXi.text=@"0.00";
        _footView.TotalIncome.text=@"0.00";

    }
    
    return _footView;
}


-(NSMutableArray*)shouYiArr{
    if (!_shouYiArr) {
        _shouYiArr=[NSMutableArray arrayWithCapacity:0];
    }
    return _shouYiArr;
}
-(NSMutableArray*)TotalArr{
    if (!_TotalArr) {
        _TotalArr=[NSMutableArray arrayWithCapacity:0];
    }
    return _TotalArr;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.shouYiArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor clearColor];
    
}
-(void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor clearColor];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *TCell=@"UITableViewCell";
    CMShouYiPlanCell *cell=[tableView dequeueReusableCellWithIdentifier:TCell];
    
    if (!cell) {
        cell=[[CMShouYiPlanCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TCell];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    NSDictionary *dict=self.shouYiArr[indexPath.row];
    cell.QiCi.text=[NSString stringWithFormat:@"%@期",[dict objectForKey:@"issue"]];
    [cell.QiCi mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView.mas_left).offset(20);
    }];
    cell.ShouYiDate.text=[dict objectForKey:@"time"];
    cell.YSBenXi.textColor=RedButtonColor;
    cell.YSBenXi.text=[NSString stringWithFormat:@"%@",[dict objectForKey:@"amountlx"]];
    
    cell.YSBenJin.text=[NSString stringWithFormat:@"%@",[dict objectForKey:@"amountbj"]];
    
    cell.YSLiXi.textColor=RedButtonColor;
    cell.YSLiXi.text=[NSString stringWithFormat:@"%.2f",[[dict objectForKey:@"amountlx"] floatValue]+[[dict objectForKey:@"amountbj"] floatValue]];
    [cell.YSLiXi mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(cell.contentView.mas_right).offset(-20);
    }];
    
    
    if([[dict objectForKey:@"status"]isEqualToString:@"未到账"]||[[dict objectForKey:@"status"]isEqualToString:@"已转让"]){
        cell.SYBenJin.textColor=RedButtonColor;
        
    }else{
        
        cell.SYBenJin.textColor=UIColorFromRGB(0x2ec075);
    }
    cell.SYBenJin.text=[dict objectForKey:@"status"];
  
    
    
    return cell;

}

-(void)requestShouYiDetail{
    NSString *page=[NSString stringWithFormat:@"%d",_pageIndex++];
  [CMRequestHandle MyIncomeShouYiWithUserID:[CMUserDefaults objectForKey:@"userID"] andProductID:self.ProductID andPageIndex:page andSuccess:^(id responseObj) {
      [self hiddenProgressHUD];
      if ([[responseObj objectForKey:@"Status"]intValue]==200) {
      NSArray *arr =[[responseObj objectForKey:@"t"]objectForKey:@"list"];
          if ([page isEqualToString:@"1"]) {
              self.head.productName.text=[[responseObj objectForKey:@"t"]objectForKey:@"title"];
              self.head.productOrderNum.text=[NSString stringWithFormat:@"订单号:%@",[[responseObj objectForKey:@"t"]objectForKey:@"orderid"]];
              self.head.productOrderID.text=[NSString stringWithFormat:@"ID:%@",[[responseObj objectForKey:@"t"]objectForKey:@"pid"]];;
              self.head.productExplain.text=[NSString stringWithFormat:@"%@",[[responseObj objectForKey:@"t"]objectForKey:@"explain"]];
              NSString *pid=[NSString stringWithFormat:@"%@",[[responseObj objectForKey:@"t"]objectForKey:@"pid"]];
              [NSString loneStringChangeColer:self.head.productOrderID andFromStr:@":" withString:pid WithColor:RedButtonColor];
              
          }
          if (_pageIndex == 2) {
              for (;0 < self.shouYiArr.count;) {
                  [self.shouYiArr removeObjectAtIndex:0];
              }
          }
              if (arr.count<=0) {
       
                  [self.tableView.mj_footer setState:MJRefreshStateNoMoreData];
                  return ;
              }else{
                  
                  // 将刷新到的数据添加到数组的后面
                  for (NSMutableDictionary *item in arr) {
                      if (item != (NSMutableDictionary *)[NSNull null]) {
                          [self.shouYiArr addObject:item];
                          
                          NSString  *LIXi=[NSString stringWithFormat:@"%@",[item objectForKey:@"amountlx"]];
                          [self.TotalArr addObject:LIXi];
                          self.BenJin=[NSString stringWithFormat:@"%@",[item objectForKey:@"amountbj"]];
                          
                      }
                      
                   
                  }
                  
                  DLog(@"+++%@++%@",self.TotalArr,self.BenJin);
                 self.footView.BJin.text=[NSString stringWithFormat:@"%.2f",[ self.BenJin floatValue]];
                  
                  float z = 0.00;
                  for (NSString *LiXi in self.TotalArr) {
                      float a= [LiXi floatValue];
                      z +=a;
                      self.footView.LXi.text=[NSString stringWithFormat:@"%.2f",z];
                  }
                 self.footView.TotalIncome.text=[NSString stringWithFormat:@"%.2f",[self.footView.BJin.text floatValue]+[self.footView.LXi.text floatValue]];
                  
                  

                  
                  
              }
          

          [self.tableView reloadData];
          self.tableView.hidden=NO;
      }
       [self.tableView.mj_header endRefreshing];
       [self.tableView.mj_footer endRefreshing];
      
  } andFailure:^(id error) {
      [self.tableView.mj_header endRefreshing];
      [self.tableView.mj_footer endRefreshing];

  }];
    
    
}

@end
