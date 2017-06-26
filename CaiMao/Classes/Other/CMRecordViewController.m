//
//  CMRecordViewController.m
//  CaiMao
//
//  Created by MAC on 16/7/19.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMRecordViewController.h"
#import "CMTiXianRecordViewCell.h"
#import "CMTiXianRecordModel.h"
@interface CMRecordViewController ()


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property(nonatomic,copy)NSString *recordId;
@property(nonatomic,strong)CMRecordBgView *rbgView;

@end

@implementation CMRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=ViewBackColor;
    self.title=@"提现记录";
    [self loadData];
    self.rbgView.frame=CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, CMScreenW, 400);
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.rbgView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
  
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        NSInteger index=self.dataArray.count/10+1;
        NSString *page=[NSString stringWithFormat:@"%d",index];
        [self updateDataWithPage:page];
    }];
   
    
   // [self.tableView.mj_header beginRefreshing];
    [self showDefaultProgressHUD];
    
    
    
    
}
-(void)loadData{
        [self updateDataWithPage:@"0"];
    
}

#pragma mark Lazy
-(UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CMScreenW, CMScreenH) style:UITableViewStyleGrouped];
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
       _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 60;
        _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, f_i5real(100))];
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.showsHorizontalScrollIndicator=NO;
        _tableView.hidden=YES;
    }
    return _tableView;
}
-(NSMutableArray*)dataArray{
    if (!_dataArray) {
        _dataArray=[NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}
-(CMRecordBgView*)rbgView{
    if (!_rbgView) {
        _rbgView=[[CMRecordBgView alloc]init];
        [_rbgView creatHeadImage:@"cfbht_zrjl" andTitle:@"暂无记录!"];;
        
        
    }
    return _rbgView;
}

- (void)updateDataWithPage:(NSString*)page {
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppInterfaceTX.ashx?action=1&CurrentPageIndex=%@&HYID=%@",OnLineCode,page,[CMUserDefaults valueForKey:@"userID"]];
    [CMHttpTool getRecordWithURL:url params:nil success:^(id responseObj) {
        
    //  NSLog(@"recharge---%@",responseObj);
        [self hiddenProgressHUD];
        NSArray *result=[responseObj objectForKey:@"ItemList"];
        NSArray *newResult=[CMTiXianRecordModel objectArrayWithKeyValuesArray:result];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([page isEqualToString:@"0"]) {
            // 如果是下拉刷新数据，将所有数据移除，再重新添加刚刷新的数据
            
                [self.dataArray removeAllObjects];
          
        }
        if (newResult.count<=0) {
            
            
          [self.tableView.mj_footer setState:MJRefreshStateNoMoreData];
            return ;
        }else{
            
            // 将刷新到的数据添加到数组的后面
            [self.dataArray addObjectsFromArray:newResult];
            self.tableView.hidden=NO;
            if (self.dataArray.count>0) {
                self.rbgView.hidden=YES;
            }else{
                self.rbgView.hidden=NO;
            }
             [self.tableView reloadData];
        }
       
        if (self.dataArray.count%10!=0) {
            [self.tableView.mj_footer setState:MJRefreshStateNoMoreData];
            return ;
        }
        
        
    } failure:^(NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *tCell=@"UITableViewCell";
    CMTiXianRecordViewCell *cell=[tableView  cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell=[[CMTiXianRecordViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tCell];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    
    CMTiXianRecordModel *TiXianRecordModel=self.dataArray[indexPath.section];
    
  //  NSLog(@"+++%@",TiXianRecordModel.ActualAmount);
    
    cell.tDdateLabel.text=TiXianRecordModel.ApplyDateString;
    cell.tTiXianLabel.text=[NSString stringWithFormat:@"%.2f",TiXianRecordModel.Amount];
    cell.tShouXuLabel.text=[NSString stringWithFormat:@"%.2f",TiXianRecordModel.Commission];
    cell.tStateMoneyLabel.text=[NSString stringWithFormat:@"%.2f",TiXianRecordModel.ActualAmount];
 
    cell.tStateButton.tag=indexPath.section;
  
    if (TiXianRecordModel.State==0) {
        
        if (TiXianRecordModel.ProcessBatch==0) {
            [cell.tStateButton setTitle:@"待处理(撤销)" forState:UIControlStateNormal];
            [NSString DoubleStringChangeColer:cell.tStateButton.titleLabel andFromStr:@"(" ToStr:@")" withColor:CMColor(47,147,253)];
            
            [cell.tStateButton addTarget:self action:@selector(changeOrderState:) forControlEvents:UIControlEventTouchUpInside];
            
        }else{
            [cell.tStateButton setTitle:@"待处理" forState:UIControlStateNormal];
        }

        }else if (TiXianRecordModel.State==1){
            [cell.tStateButton setTitle:@"已到账" forState:UIControlStateNormal];
            [cell.tStateButton setTitleColor:CMColor(0,192,138) forState:UIControlStateNormal];
           
        }else if (TiXianRecordModel.State==2){
            [cell.tStateButton setTitle:@"提现失败" forState:UIControlStateNormal];
            [cell.tStateButton setTitleColor:CMColor(255,0,0) forState:UIControlStateNormal];
            
            
        }else if (TiXianRecordModel.State==3){
            [cell.tStateButton setTitle:@"提现取消" forState:UIControlStateNormal];
            [cell.tStateButton setTitleColor:CMColor(247,147,30) forState:UIControlStateNormal];

        }
        
    
    
    

    
    return cell;
    
}

#pragma mark 改变订单状态
-(void)changeOrderState:(UIButton *)gestureRecognizer{
    
   // UILabel *v = (UILabel *)[gestureRecognizer view];
 
     CMTiXianRecordModel *tixian=self.dataArray[gestureRecognizer.tag];
    self.recordId=tixian.ZID;
    //NSLog(@"+++%@",self.recordId);
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请确认是否撤销提现" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alert.delegate=self;
    [alert show];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //撤销请求
    if(buttonIndex==1){
      
        NSString *urlStr=[NSString stringWithFormat:@"%@/handler/AppInterfaceTX.ashx?Action=2&ZID=%@&HYID=%@",OnLineCode,self.recordId,[CMUserDefaults valueForKey:@"userID"]];
        
  // NSLog(@"record---%@",self.recordId);
        
        [CMHttpTool getRecordWithURL:urlStr params:nil success:^(id responseObj) {
           
            //NSLog(@"result====%@",[responseObj objectForKey:@"Result"]);
            if ([[responseObj objectForKey:@"Status"]intValue]==200) {
                
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"本次提现撤销成功，提现金额已解冻，请核对" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                [CMNSNotice postNotificationName:@"BeginRefresh" object:self];
                MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
                [self.navigationController.view addSubview:hud];
                
                [hud showAnimated:YES whileExecutingBlock:^{
     
                    [self updateDataWithPage:@"1"];
                
                     sleep(1);
                } completionBlock:^{
                    [hud removeFromSuperview];
                    
                }];
                
            }else{
                NSString *msg=[responseObj objectForKey:@"Result"];
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                
                
            }
        } failure:^(NSError *error) {
            DLog(@"exitLoginAcconntError--%@",error);
            [self.tableView.mj_header endRefreshing];
            
            
        }];
        
        
        
    }
    
    
    
}

@end
