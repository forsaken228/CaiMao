//
//  CMZiJinRecordController.m
//  CaiMao
//
//  Created by MAC on 16/7/14.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMZiJinRecordController.h"
#import "CMMoneyRecordModel.h"
@interface CMZiJinRecordController ()
@property(nonatomic,strong)NSMutableArray *dataSourceArray;
@property(nonatomic,strong)UITableView *RechargeTableView;
@property(nonatomic,assign)int page;
@property(nonatomic,copy)NSString *userId;
@property(nonatomic,strong)CMRecordBgView *rbgView;

@end

@implementation CMZiJinRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=ViewBackColor;
    self.title=@"资金记录";
    self.userId = [CMUserDefaults valueForKey:@"userID"];
    
    self.rbgView.frame=CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, CMScreenW, 400);
    [self.view addSubview:self.RechargeTableView];
    [self.view addSubview:self.rbgView];
    [self LoadDate];
    self.RechargeTableView.mj_header = [CMRefreshHeader headerWithRefreshingBlock:^{
        [self LoadDate];
    }];
    self.RechargeTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self updateData];
    }];
    [self showDefaultProgressHUD];
}

-(CMRecordBgView*)rbgView{
    if (!_rbgView) {
        _rbgView=[[CMRecordBgView alloc]init];
        [_rbgView creatHeadImage:@"cfbht_zrjl" andTitle:@"暂无记录!"];;
        
        
    }
    return _rbgView;
}
- (void)LoadDate{
    self.page = 0;
    [self updateData];
    
}
#pragma mark  Lazy

-(NSMutableArray*)dataSourceArray{
    if (!_dataSourceArray) {
        _dataSourceArray=[NSMutableArray arrayWithCapacity:0];
    }
    return _dataSourceArray;
}
-(UITableView*)RechargeTableView{
    if (!_RechargeTableView) {
        _RechargeTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, CMScreenH) style:UITableViewStylePlain];
        _RechargeTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _RechargeTableView.rowHeight=60;
        _RechargeTableView.dataSource=self;
        _RechargeTableView.delegate=self;
        _RechargeTableView.backgroundColor=ViewBackColor;
        UIView *footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, f_i5real(100))];
       footView.backgroundColor=ViewBackColor;
        _RechargeTableView.tableFooterView=footView;
        _RechargeTableView.hidden=YES;
    }
    return _RechargeTableView;
}
#pragma  mark tableView协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataSourceArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CELLID=@"MyCell";
    CMTRechargeCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell=[[CMTRechargeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLID];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
    CMMoneyRecordModel *RecordModel=self.dataSourceArray[indexPath.row];
    
    cell.lineRecharge.text=RecordModel.Title;
    [cell.lineRecharge mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(75);
        
    }];
    cell.sourceTitle.text=RecordModel.StateString;
    if ([cell.sourceTitle.text isEqualToString:@"转入"]) {
        cell.sourceTitle.backgroundColor=CMColor(46,149,251);
    }else{
        cell.sourceTitle.backgroundColor=UIColorFromRGB(0xff661b);
        
    }
    
    cell.jinE.text=[NSString stringWithFormat:@"￥%.2f",RecordModel.Amount];
    cell.dateLabel.text=RecordModel.CreateDateTime;
    [cell.SateLabel setTitle:[NSString stringWithFormat:@"￥%.2f",RecordModel.Balance] forState:UIControlStateNormal];
    [cell.SateLabel setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
    
    return cell;
}


#pragma mark 加载数据
- (void)updateData {
    if (![self checkNetWork]) {
        [self hiddenProgressHUD];
        [self.RechargeTableView.mj_header endRefreshing];
        return;
    }
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppInterfaceTX.ashx?Action=%d&CurrentPageIndex=%d&HYID=%@",OnLineCode,7,self.page++,self.userId];
    [CMHttpTool getRecordWithURL:url params:nil success:^(id responseObj) {
        [self.RechargeTableView.mj_header endRefreshing];
        [self.RechargeTableView.mj_footer endRefreshing];
      
        if ([[responseObj objectForKey:@"Status" ]intValue]==200) {
            
       [self hiddenProgressHUD];
        NSArray *result=[responseObj objectForKey:@"ItemList"];
        NSArray *newResult=[CMMoneyRecordModel objectArrayWithKeyValuesArray:result];
        if (self.page == 1) {
            // 如果是下拉刷新数据，将所有数据移除，再重新添加刚刷新的数据
            for (;0 < self.dataSourceArray.count;) {
                [self.dataSourceArray removeObjectAtIndex:0];
            }
        }
        if (result.count<=0) {
            [self.RechargeTableView.mj_footer setState:MJRefreshStateNoMoreData];
            return ;
        }else{
            
            [self.dataSourceArray addObjectsFromArray:newResult];
            self.RechargeTableView.hidden=NO;
            if (self.dataSourceArray.count>0) {
                self.rbgView.hidden=YES;
            }else{
                self.rbgView.hidden=NO;
            }
         
             [self.RechargeTableView reloadData];
        }
       
        
         }
        
    } failure:^(NSError *error) {
        [self.RechargeTableView.mj_header endRefreshing];
        [self.RechargeTableView.mj_footer endRefreshing];
            }];
    
    
    
    
    
    
}

checkNet
@end
