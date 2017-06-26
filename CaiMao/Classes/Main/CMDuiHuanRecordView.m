//
//  CMDuiHuanRecordView.m
//  CaiMao
//
//  Created by WangWei on 17/3/30.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import "CMDuiHuanRecordView.h"
#import "CMDuiHuanRecordCell.h"

@interface CMDuiHuanRecordView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)NSMutableArray *dataArry;
@property(nonatomic,strong)CMRecordBgView *rbgView;
@property(nonatomic,assign)float height;
@end
@implementation CMDuiHuanRecordView
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=ViewBackColor;
        
        self.rbgView.frame=CGRectMake(0, self.frame.origin.y, CMScreenW, self.bounds.size.height);
        _height=self.frame.size.height;
        [self addSubview:self.myTableView];
        [self addSubview:self.rbgView];
        UIView *foot=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 100)];
        self.myTableView.tableFooterView=foot;
        
        [self LoadData];
        self.myTableView.mj_header=[CMRefreshHeader headerWithRefreshingBlock:^{
            [self LoadData];
        }];
        self.myTableView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            NSInteger pa=_dataArry.count/10+1;
            NSString *pag=[NSString stringWithFormat:@"%d",pa];
            [self requestDataWithPage:pag];
        }];
        
    }
    return self;
}
-(void)LoadData{
    
    [self requestDataWithPage:@"1"];
}

#pragma mark Lazy
-(CMRecordBgView*)rbgView{
    if (!_rbgView) {
        _rbgView=[[CMRecordBgView alloc]init];
        [_rbgView creatHeadImage:@"wdjf_dhjl_icon" andTitle:@"暂无记录~哦"];;
        
        
    }
    return _rbgView;
}
-(NSMutableArray*)dataArry{
    if (!_dataArry) {
        _dataArry=[NSMutableArray arrayWithCapacity:0];
    }
    return _dataArry;
}
-(UITableView*)myTableView{
    if (!_myTableView) {
        _myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW,_height) style:UITableViewStyleGrouped];
        _myTableView.delegate=self;
        _myTableView.dataSource=self;
        _myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _myTableView.hidden=YES;
        
        
    }
    return _myTableView;
}


#pragma mark tableView 代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArry.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *TCell=@"UITableViewCell";
    CMDuiHuanRecordCell *cell=[tableView dequeueReusableCellWithIdentifier:TCell];
    
    if (!cell) {
        cell=[[CMDuiHuanRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TCell];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    NSDictionary *dict=self.dataArry[indexPath.section];
    NSString *date=[dict objectForKey:@"CreateOrderDate"];
    NSString *new=[date substringToIndex:10];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    ///用[NSDate date]可以获取系统当前时间
    NSDate *cDate= [dateFormatter dateFromString:new];
    NSString *NewDate=[dateFormatter stringFromDate:cDate];
    cell.productDate.text=NewDate;
    
    if ([[dict objectForKey:@"IsMail"]intValue]==0) {
        cell.productState.text=@"未邮寄";
        cell.productState.textColor=RedButtonColor;
    }else{
        
        cell.productState.text=@"交易成功";
        cell.postAddress.text=[NSString stringWithFormat:@"已邮寄(%@:%@)",[dict objectForKey:@"DeliveryName"],[dict objectForKey:@"DeliveryOrderID"]];
    }
    
    cell.productName.text=[dict  objectForKey:@"ExchangeProName"];
    cell.productIntegral.text=[NSString stringWithFormat:@"%@积分",[dict  objectForKey:@"SpendingCredits"]];
    
    NSMutableAttributedString *qixianStr = [[NSMutableAttributedString alloc] initWithString:cell.productIntegral.text];
    
    NSRange qiToRang = [cell.productIntegral.text rangeOfString:@"积"];
    [qixianStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xfb3e1b) range:NSMakeRange(0, qiToRang.location)];
    
    cell.productIntegral.attributedText = qixianStr;
    
    
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",OnLineCode,[dict objectForKey:@"ImageUrl"]]];
    [cell.productImage sd_setImageWithURL:url placeholderImage:nil options:SDWebImageAllowInvalidSSLCertificates];
    return cell;
    
}

#pragma mark 请求数据
-(void)requestDataWithPage:(NSString*)page{
  
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_MyCount.ashx?Action=2",OnLineCode];
    
    NSDictionary *dict=@{@"HYID":[CMUserDefaults objectForKey:@"userID"],@"PageIndex":page};
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        
              
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
        
        if ([[responseObj objectForKey:@"Status"]intValue]==200) {
            NSArray *result=[[responseObj objectForKey:@"ItemList"]objectForKey:@"ItemList"];
            if ([page isEqualToString:@"1"]) {
                [self.dataArry removeAllObjects];
                
            }
            
            if (result<=0) {
                
                [self.myTableView.mj_footer setState:MJRefreshStateNoMoreData];
                return ;
            }else{
                
                [self.dataArry addObjectsFromArray:result];
                self.myTableView.hidden=NO;
                if (self.dataArry.count>0) {
                    self.rbgView.hidden=YES;
                }else{
                    self.rbgView.hidden=NO;
                }
                [self.myTableView reloadData];
            }
            
            if (self.dataArry.count%10!=0) {
                [self.myTableView.mj_footer setState:MJRefreshStateNoMoreData];
                return ;
            }
            
            
            
            
            
        }
        
        
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
}

@end
