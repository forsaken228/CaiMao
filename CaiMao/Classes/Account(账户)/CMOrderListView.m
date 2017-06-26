//
//  CMOrderListView.m
//  CaiMao
//
//  Created by WangWei on 2017/6/21.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import "CMOrderListView.h"
#import  "CMYuDingView.h"
#import "CMDQLCCell.h"
@interface CMOrderListView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)NSMutableArray *dataArry;
@property(nonatomic,assign)float height;
@property(nonatomic,strong)CMYuDingView *yudingView;

@end

@implementation CMOrderListView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor=ViewBackColor;
        _height=self.frame.size.height;
     
        [self addSubview:self.myTableView];
        [self addSubview:self.yudingView];
        
        UIView *foot=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 50)];
        self.myTableView.tableFooterView=foot;
        
        [self LoadData];
        self.myTableView.mj_header=[CMRefreshHeader headerWithRefreshingBlock:^{
            [self LoadData];
        }];
        self.myTableView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            NSInteger pa=_dataArry.count/5+1;
            NSString *pag=[NSString stringWithFormat:@"%d",pa];
            [self requestOrderDataWithPageIndex:pag];
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
-(CMYuDingView*)yudingView{
    
    if (!_yudingView) {
        _yudingView=[[CMYuDingView  alloc]init];
        [_yudingView.GoActionBtn addTarget:self action:@selector(GoActionClick) forControlEvents:UIControlEventTouchUpInside];
        _yudingView.frame=CGRectMake(0, 0, CMScreenW, 400);
    
    }
    
    return _yudingView;
}
-(void)GoActionClick{
    
    CMProductDetailController *productVc = [[CMProductDetailController alloc] init];
    productVc.urlStr =Miao18Action;
    
    [_receiveController.navigationController pushViewController:productVc animated:YES];
    
}
-(void)LoadData{
    
    [self requestOrderDataWithPageIndex:@"1"];
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
    NSDictionary *YuDingDict=self.dataArry[indexPath.section];
    cell.productTitle.text=[YuDingDict objectForKey:@"title"];
    cell.productId.hidden=YES;;
    cell.productBZ.text=[NSString stringWithFormat:@"￥%@",[YuDingDict objectForKey:@"amount"]];
    CGRect rect=[ cell.productBZ.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 14) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil];
    [cell.productBZ mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(rect.size.width+2);
    }];
    
    cell.productState.hidden=NO;
    cell.PLBZ .hidden=YES;
    cell.PSHY.hidden=YES;
    cell.productSY.hidden=YES;
    cell.productTime.text=[NSString stringWithFormat:@"%@",[YuDingDict objectForKey:@"time"]];
    [cell.productState setTitle:[NSString stringWithFormat:@"%@",[YuDingDict objectForKey:@"result"]] forState:UIControlStateNormal];
    [cell.productState setTitleColor:UIColorFromRGB(0x2ec075) forState:UIControlStateNormal];
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


-(void)setReceiveController:(CMDQLController *)receiveController{
    _receiveController=receiveController;
}

#pragma mark 请求数据
-(void)requestOrderDataWithPageIndex:(NSString*)page{
    
    // NSString *page=[NSString stringWithFormat:@"%d",self.ChiYouPageNum++];
    [CMRequestHandle MyIncomeOrderWithUserID:[CMUserDefaults objectForKey:@"userID"]  andPageIndex:page andSuccess:^(id responseObj) {
        
        DLog(@"预定++++++%@+++%@",responseObj,[responseObj objectForKey:@"Result"]) ;
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
        
                [self.dataArry addObjectsFromArray:result];
                self.myTableView.hidden=NO;
                if (self.dataArry.count>0) {
                    self.yudingView.hidden=YES;
                }else{
                    self.yudingView.hidden=NO;
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
