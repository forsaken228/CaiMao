//
//  CMEvenUpListView.m
//  CaiMao
//
//  Created by WangWei on 2017/6/21.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import "CMEvenUpListView.h"
#import "CMDQLCCell.h"
@interface CMEvenUpListView()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)NSMutableArray *dataArry;
@property(nonatomic,assign)float height;
@property(nonatomic,strong)CMRecordBgView *rbgView;
@end
@implementation CMEvenUpListView
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor=ViewBackColor;
        _height=self.frame.size.height;
        self.rbgView.frame=CGRectMake(0, self.frame.origin.y, CMScreenW, self.bounds.size.height);
        [self addSubview:self.myTableView];
        [self addSubview:self.rbgView];
        
        UIView *foot=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 50)];
        self.myTableView.tableFooterView=foot;
        
        [self LoadData];
        self.myTableView.mj_header=[CMRefreshHeader headerWithRefreshingBlock:^{
            [self LoadData];
        }];
        self.myTableView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            NSInteger pa=_dataArry.count/5+1;
            NSString *pag=[NSString stringWithFormat:@"%d",pa];
            [self requestJieQingDataWithPageIndex:pag];
        }];
        
        
    }
    
    return self;
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

-(CMRecordBgView*)rbgView{
    if (!_rbgView) {
        _rbgView=[[CMRecordBgView alloc]init];
        [_rbgView creatHeadImage:@"cfbht_zrjl" andTitle:@"暂无记录~哦"];;
        
        
    }
    return _rbgView;
}
-(void)LoadData{
    
    [self requestJieQingDataWithPageIndex:@"1"];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArry.count;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *Tcell=@"indexPath";
    CMDQLCCell *cell=[tableView dequeueReusableCellWithIdentifier:Tcell];
    if (!cell) {
        cell=[[CMDQLCCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Tcell];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    NSDictionary *Dict=self.dataArry[indexPath.section];
    
    cell.productTitle.text=[Dict objectForKey:@"title"];
    cell.productId.hidden=YES;;
    cell.productBZ.text=[NSString stringWithFormat:@"￥%@",[Dict objectForKey:@"amountbj"]];
    CGRect rect=[ cell.productBZ.text boundingRectWithSize:CGSizeMake(100, 14) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil];
    [cell.productBZ mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(rect.size.width+5);
    }];
    cell.PLBZ .hidden=NO;
    cell.PSHY.hidden=NO;
    cell.productSY.hidden=NO;
    cell.productSY.text=[NSString stringWithFormat:@"￥%@",[Dict objectForKey:@"amountlx"]];
    
    CGRect rectSecond=[ cell.productSY.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 14) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil];
    [cell.productSY mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(rectSecond.size.width+2);
    }];
    cell.productTime.text=[NSString stringWithFormat:@"%@至%@",[Dict objectForKey:@"time"],[Dict objectForKey:@"totime"]];
    cell.productState.hidden=YES;
    cell.productState.userInteractionEnabled=NO;
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
return 10;

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}



#pragma mark 请求数据
-(void)requestJieQingDataWithPageIndex:(NSString*)page{
    
    // NSString *page=[NSString stringWithFormat:@"%d",self.ChiYouPageNum++];
     [CMRequestHandle MyIncomeJieQingWithUserID:[CMUserDefaults objectForKey:@"userID"] andPageIndex:page andSuccess:^(id responseObj) {
        
        DLog(@"结清++++++%@+++%@",responseObj,[responseObj objectForKey:@"Result"]) ;
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
        
        if ([[responseObj objectForKey:@"Status"]intValue]==200) {
            NSArray *result=[[responseObj objectForKey:@"t"]objectForKey:@"list"];
            if ([page isEqualToString:@"1"] ) {
                [self.dataArry removeAllObjects];
                
            }
            
            if (result.count<=0) {
                
                [self.myTableView.mj_footer setState:MJRefreshStateNoMoreData];
                return ;
            }else{
                
                // 将刷新到的数据添加到数组的后面
                //                for (NSMutableDictionary *item in result) {
                //                    if (item != (NSMutableDictionary *)[NSNull null]) {
                //                        [self.dataArry addObject:item];
                //                    }
                //                }
                [self.dataArry addObjectsFromArray:result];
                self.myTableView.hidden=NO;
                if (self.dataArry.count>0) {
                    self.rbgView.hidden=YES;
                }else{
                    self.rbgView.hidden=NO;
                }
                [self.myTableView reloadData];
                
            }
            
            if (self.dataArry.count%5!=0) {
                [self.myTableView.mj_footer setState:MJRefreshStateNoMoreData];
                return ;
            }
            
            
            
            
            [self.myTableView reloadData];
            
        }
        
    } andFailure:^(id error) {
        
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
    }];
    
}




@end
