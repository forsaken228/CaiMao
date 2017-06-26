//
//  CMShouYiRecordController.m
//  CaiMao
//
//  Created by MAC on 16/8/9.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMShouYiRecordController.h"
#import "CMShouYiHeadView.h"
#import "CMShouYiFootView.h"
#import "CMShouYiPlanCell.h"
@interface CMShouYiRecordController ()
{
    CMShouYiHeadView *headView;
    CMShouYiFootView *footView;
    UIView *bgView;
}
@end

@implementation CMShouYiRecordController
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.MyTableView.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"收益计划";
    self.view.backgroundColor=[UIColor whiteColor];


    [self.view addSubview:self.MyTableView];
 
    
    self.MyTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadUpdate];
       
    }];
//    self.MyTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//       
//    }];
    
    

}

#pragma mark Lazy
-(UITableView*)MyTableView{
    if (!_MyTableView) {
        _MyTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0, CMScreenW, CMScreenH) style:UITableViewStyleGrouped];
        _MyTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _MyTableView.delegate=self;
        _MyTableView.dataSource=self;
    }
    return _MyTableView;
}

-(NSArray*)PlandataArr{
    if (!_PlandataArr) {
        _PlandataArr=[NSArray array];
    }
    return _PlandataArr;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.PlandataArr.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *TCell=@"UITableViewCell";
   CMShouYiPlanCell *cell=[tableView dequeueReusableCellWithIdentifier:TCell];
    
    if (!cell) {
        cell=[[CMShouYiPlanCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
         headView.JiXiDate.text=[NSString stringWithFormat:@"预期计息日:%@",self.JXDate];
    NSDictionary *dict=self.PlandataArr[indexPath.section];
    cell.QiCi.text=[NSString stringWithFormat:@"%@期",[dict objectForKey:@"Issue"]];
    NSString *oldStr=[dict objectForKey:@"IncomeDistributionDateTime"];
    NSString *newStr=[oldStr substringToIndex:10];
    cell.ShouYiDate.text=newStr;

    
    
   
    cell.YSBenXi.text=[self numberSet:@"PrincipalInterest" andDict:dict];
    
    cell.YSBenJin.text=[self numberSet:@"ReceivablePrincipal" andDict:dict];
  
    cell.YSLiXi.text=[self numberSet:@"InterestReceivable" andDict:dict];;
    
    NSString *Shengyu=[NSString stringWithFormat:@"%.2f",[[dict objectForKey:@"ResidualPrincipal"] floatValue]];
    cell.SYBenJin.text=Shengyu;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    
    formatter.numberStyle =NSNumberFormatterDecimalStyle;
    // 小数位最多位数
    formatter.maximumFractionDigits = 2;
    
    // 小数位最少位数
    formatter.minimumFractionDigits = 2;
     float total=0.00;
    float total1=0.00;
    float total2=0.00;
   for (NSDictionary *dic in self.PlandataArr) {
        total=[[dic objectForKey:@"PrincipalInterest"]floatValue]+total;
       
        total1=[[dict objectForKey:@"ReceivablePrincipal"]floatValue]+total1;
       total2=[[dict objectForKey:@"InterestReceivable"]floatValue]+total2;
   }
    NSString *TYSBX=[formatter stringFromNumber:[NSNumber numberWithFloat:total]];

    footView.fYSBX.text=TYSBX;
    
    
    //    for (NSDictionary *dic in self.PlandataArr) { }
   
    NSString *TYSBj=[formatter stringFromNumber:[NSNumber numberWithFloat:total1]];
    
   footView.fSYBJ.text=TYSBj;
    
    
    //    for (NSDictionary *dic in self.PlandataArr) { }
    
    NSString *TYSLx=[formatter stringFromNumber:[NSNumber numberWithFloat:total2]];
    
    footView.fYSLX.text=TYSLx;
    
    
    return cell;
}
#pragma mark 数字格式
-(NSString*)numberSet:(NSString*)aStr andDict:(NSDictionary*)aDict{
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    
    formatter.numberStyle =NSNumberFormatterDecimalStyle;
    // 小数位最多位数
    formatter.maximumFractionDigits = 2;
    
    // 小数位最少位数
    formatter.minimumFractionDigits = 2;
 
    double benxi=[[aDict objectForKey:aStr]doubleValue];
    
    NSString *newAmount = [formatter stringFromNumber:[NSNumber numberWithDouble:benxi]];
    return newAmount;
    
}



#pragma mark 交易记录数据
-(void)loadUpdate{
    NSString *urlStr = [NSString stringWithFormat:@"%@/handler/AppService_ProductAction.ashx?Action=6",OnLineCode];

    NSDictionary *dict=@{@"PID":self.pid};
    DLog( @"dict==%@",dict);
    [CMHttpTool postWithURL:urlStr params:dict success:^(id responseObj) {
       //NSArray *result=[responseObj objectForKey:@"List"];
        DLog( @"amout==%@---%@",responseObj,[responseObj objectForKey:@"Result"]);
        
        if ([[responseObj objectForKey:@"Status"]intValue]==200) {
            
        
        self.PlandataArr=[responseObj objectForKey:@"List"];
        self.JXDate=[responseObj objectForKey:@"Result"];
        headView=[[CMShouYiHeadView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 95)];
        
        footView=[[CMShouYiFootView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 70)];
        
        self.MyTableView.tableHeaderView=headView;
        self.MyTableView.tableFooterView=footView;
       [self.MyTableView reloadData];
    }
        
     [self.MyTableView.mj_header endRefreshing];   
        
    } failure:^(NSError *error) {
        NSLog(@"----error==%@",error);
        [self.MyTableView.mj_header endRefreshing];
        
        
        
        
    }];
    
    
    
}

@end
