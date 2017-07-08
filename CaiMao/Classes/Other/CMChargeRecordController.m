//
//  CMChargeRecordController.m
//  CaiMao
//
//  Created by MAC on 16/7/14.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMChargeRecordController.h"
#import "CMChargeRecordModel.h"
@interface CMChargeRecordController ()
@property(nonatomic,strong)NSMutableArray *dataSourceArray;
@property(nonatomic,strong)UITableView *RechargeTableView;
@property(nonatomic,assign)int page;
//@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *orderDate;
@property(nonatomic,copy)NSString *orderID;
@property(nonatomic,strong)CMRecordBgView *rbgView;

@end

@implementation CMChargeRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    self.view.backgroundColor=ViewBackColor;
     self.title=@"充值记录";
    [self LoadData];
    self.rbgView.frame=CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, CMScreenW, 400);
    [self.view addSubview:self.RechargeTableView];
    [self.view addSubview:self.rbgView];
    
    self.RechargeTableView.mj_header = [CMRefreshHeader headerWithRefreshingBlock:^{
        [self LoadData];
    }];
    self.RechargeTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self updateData];
    }];
    
    [self showDefaultProgressHUD];
}

-(void)LoadData{
    
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
-(CMRecordBgView*)rbgView{
    if (!_rbgView) {
        _rbgView=[[CMRecordBgView alloc]init];
        [_rbgView creatHeadImage:@"cfbht_zrjl" andTitle:@"暂无记录!"];;
        
        
    }
    return _rbgView;
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
    CMTRechargeCell *cell=[tableView dequeueReusableCellWithIdentifier:CELLID];
    if (!cell) {
        cell=[[CMTRechargeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLID];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
      
    }
    NSDictionary *dict=self.dataSourceArray[indexPath.row];
   //NSLog(@"Chongzhi==%@",dict);
    
//    NSString *IDStr=[NSString stringWithFormat:@"%@",[dict objectForKey:@"RecordID"]];
//    self.orderID=IDStr;
    NSString *dateStr=[dict objectForKey:@"ReChangeDateTime"];
    NSString *date=[dateStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSString*date1=[date stringByReplacingOccurrencesOfString:@":" withString:@""];
    NSString*date2=[date1 stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.orderDate=date2;
    cell.dateLabel.text=dateStr;
    
    

    //cell.SateLabel.text=[NSString stringWithFormat:@"%d",[dict objectForKey:@"State"]];
    NSString *code=[NSString stringWithFormat:@"%@",[dict objectForKey:@"State"] ];
    if ([code intValue]==1) {
        [cell.SateLabel setTitle:@"成功支付" forState:UIControlStateNormal];
        [cell.SateLabel setTitleColor:CMColor(46, 149, 251) forState:UIControlStateNormal];
        
        
    }else if([code intValue]==0){
        
       
        [cell.SateLabel setTitle:@"待付(核对)" forState:UIControlStateNormal];
        [cell.SateLabel setTitleColor:RedButtonColor forState:UIControlStateNormal];
        cell.SateLabel.tag=indexPath.row;
        [cell.SateLabel addTarget:self action:@selector(HeDuiOrderState:) forControlEvents:UIControlEventTouchUpInside];
        
    }
   
        cell.lineRecharge.text=@"在线充值";
//        NSString *str=cell.lineRecharge.text;
//        CGRect rect=[str boundingRectWithSize:CGSizeMake(100, 20) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil];
//        [cell.lineRecharge mas_updateConstraints:^(MASConstraintMaker *make) {
//           
//            make.height.mas_equalTo(rect.size.height);
//            make.width.mas_equalTo(rect.size.width);
//            make.left.equalTo(cell.mas_left).offset(8);
//            make.top.mas_equalTo(15);
//        }];
    
    [cell.lineRecharge mas_updateConstraints:^(MASConstraintMaker *make) {
        
                    make.width.mas_equalTo(60);
        
    }];
    cell.sourceTitle.text=[dict objectForKey:@"Source"];
    
   
    cell.jinE.text=[NSString stringWithFormat:@"￥%.2f",[[dict objectForKey:@"ReChangeAmount"]floatValue]];
  
    cell.jinE.textColor=UIColorFromRGB(0x666666);
    

    
    return cell;
}
#pragma mark 核对
-(void)HeDuiOrderState:(UIButton*)btn{
    
    NSDictionary *dict=self.dataSourceArray[btn.tag];
    NSString *IDStr=[NSString stringWithFormat:@"%@",[dict objectForKey:@"RecordID"]];

    NSString *dateStr=[dict objectForKey:@"ReChangeDateTime"];
    NSString *date=[dateStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSString*date1=[date stringByReplacingOccurrencesOfString:@":" withString:@""];
    NSString*date2=[date1 stringByReplacingOccurrencesOfString:@" " withString:@""];
  //  NSLog(@"------%@---%@----%d",date2,IDStr,btn.tag);
    NSString *urlStr=[NSString stringWithFormat:@"%@/handler/AppInterfaceTX.ashx?Action=8&OrderNo=%@&OrderDate=%@",OnLineCode,IDStr,date2];

    [CMHttpTool getWithURL:urlStr params:nil success:^(id responseObj) {
        
        //NSLog(@"hedui---%@",[responseObj objectForKey:@"Result"]);
        NSString *msg=[responseObj objectForKey:@"Result"];
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alert show];
        [self LoadData];
    } failure:^(NSError *error) {
        
    }];
    
    
}
#pragma mark 加载数据

- (void)updateData {
    
    if (![self checkNetWork]) {
        [self.RechargeTableView.mj_header endRefreshing];
        [self hiddenProgressHUD];
        return;
    }
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppInterfaceTX.ashx?Action=%d&CurrentPageIndex=%d&HYID=%@",OnLineCode,5,self.page++,[CMUserDefaults objectForKey:@"userID"]];
    [CMHttpTool getRecordWithURL:url params:nil success:^(id responseObj) {
      //  DLog(@"++%@",responseObj);
        [self.RechargeTableView.mj_header endRefreshing];
        [self.RechargeTableView.mj_footer endRefreshing];
        if ([[responseObj objectForKey:@"Status"]intValue]==200) {
            [self hiddenProgressHUD];
        NSArray *result=[responseObj objectForKey:@"ItemList"];
       
        if (self.page == 1) {
            for (;0 < self.dataSourceArray.count;) {
                [self.dataSourceArray removeObjectAtIndex:0];
            }
        }
        
        if (result.count<=0) {
         [self.RechargeTableView.mj_footer setState:MJRefreshStateNoMoreData];
            return ;
        }else{
            
            // 将刷新到的数据添加到数组的后面
            for (NSMutableDictionary *item in result) {
                if (item != (NSMutableDictionary *)[NSNull null]) {
                    [self.dataSourceArray addObject:item];
                }
            }
            self.RechargeTableView.hidden=NO;
            if (self.dataSourceArray.count>0) {
                self.rbgView.hidden=YES;
            }else{
                self.rbgView.hidden=NO;
            }
            
        }
       [self.RechargeTableView reloadData];
        
 }
        
    } failure:^(NSError *error) {
       
        [self.RechargeTableView.mj_header endRefreshing];
        [self.RechargeTableView.mj_footer endRefreshing];
    }];
    
    
    
   
}
checkNet
@end
