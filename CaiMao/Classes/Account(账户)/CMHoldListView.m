//
//  CMHoldListView.m
//  CaiMao
//
//  Created by WangWei on 2017/6/21.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import "CMHoldListView.h"
#import "CMAllChiYouHead.h"
#import "CMDQLCCell.h"
#import "CMAllChiYouController.h"
#import "CMAllChiYouDetail.h"
#import "CMProductIncomeController.h"
@interface CMHoldListView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)NSMutableArray *dataArry;
@property(nonatomic,assign)float height;
@property(nonatomic,strong)CMRecordBgView *rbgView;
@end
@implementation CMHoldListView
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
            [self requestChiYouDataWithPageIndex:pag];
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
    
    [self requestChiYouDataWithPageIndex:@"1"];
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
        cell.productId.text=[NSString stringWithFormat:@"订单号:(%@)",[Dict objectForKey:@"zid"]];
        cell.productBZ.text=[NSString stringWithFormat:@"￥%@",[Dict objectForKey:@"amountbj"]];
        CGRect rect=[ cell.productBZ.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 14) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil];
        [cell.productBZ mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(rect.size.width+2);
        }];
        cell.PLBZ .hidden=YES;
        cell.PSHY.hidden=YES;
        cell.productId.hidden=NO;
        cell.productSY.hidden=YES;
        [cell.productState setTitle:[NSString stringWithFormat:@"%@",[Dict objectForKey:@"status"]] forState:UIControlStateNormal];
        [cell.productState setTitleColor:UIColorFromRGB(0x0e94ee) forState:UIControlStateNormal];
        
        cell.productTime.text=[NSString stringWithFormat:@"%@",[Dict objectForKey:@"time"]];
        cell.productState.hidden=NO;
        cell.productState.tag=indexPath.section;
        [cell.productState addTarget:self action:@selector(cheackShouYiDetail:) forControlEvents:UIControlEventTouchUpInside];
        cell.productState.userInteractionEnabled=YES;
        if([[Dict objectForKey:@"status"] isEqualToString:@"已持有，待权益确认"]){
            cell.productState.userInteractionEnabled=NO;
            [cell.productState setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
        }
        
        return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

        if (section==0) {
            return 30;
        }else{
            return 10;
        }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    

        if (section==0) {
            CMAllChiYouDetail  *allView=[[CMAllChiYouDetail alloc]init];
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(AlltapClick)];
            [allView addGestureRecognizer:tap];
            return allView;
            
            
        }else{
            return nil;
        }

    
}
-(void)AlltapClick{
    CMAllChiYouController  *allvc=[[CMAllChiYouController alloc]init];
    [_receiveController.navigationController pushViewController:allvc animated:YES];
}

-(void)cheackShouYiDetail:(UIButton*)btn{
    
    NSDictionary *Dict=self.dataArry[btn.tag];
    DLog(@"+++++%d+++%@",btn.tag,[Dict objectForKey:@"zid"]);
    
    if([[Dict objectForKey:@"status"] isEqualToString:@"追加投资"]){
        [CMRequestHandle getProductListWithUserID:[CMUserDefaults objectForKey:@"userID"] andProductId:[Dict objectForKey:@"pid"] andSuccess:^(id responseObj) {
            
            DLog(@"+++++%@+++%@",responseObj,[responseObj objectForKey:@"Result"]);
            
            if ([[responseObj objectForKey:@"Status"]intValue]==200) {
                CMPayViewController *vc=[[CMPayViewController alloc]init];
                vc.ProuctListDict=[responseObj objectForKey:@"t"];
                vc.countNum=1;
     [_receiveController.navigationController pushViewController:vc animated:YES];
                
               
                
            }else{
                
                CMTiShi([responseObj objectForKey:@"Result"]);
            }
            
            
        } andFailure:^(id error) {
            
        }];
        
    }
    if([[Dict objectForKey:@"status"] isEqualToString:@"收益查询"]){
        CMProductIncomeController *vc=[[CMProductIncomeController alloc]init];
        vc.ProductID=[Dict objectForKey:@"zid"];
        [_receiveController.navigationController pushViewController:vc animated:YES];
        
    }
    
}


-(void)setReceiveController:(CMDQLController *)receiveController{
    _receiveController=receiveController;
}

#pragma mark 请求数据
-(void)requestChiYouDataWithPageIndex:(NSString*)page{
 
   // NSString *page=[NSString stringWithFormat:@"%d",self.ChiYouPageNum++];
    [CMRequestHandle MyIncomeChiYouWithUserID:[CMUserDefaults objectForKey:@"userID"]  andPageIndex:page andSuccess:^(id responseObj) {
        
        DLog(@"持有++++++%@+++%@",responseObj,[responseObj objectForKey:@"Result"]) ;
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
    
        if ([[responseObj objectForKey:@"Status"]intValue]==200) {
            
            self.receiveDataSuccess();
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
        self.receiveDataSuccess();
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
    }];
    
}


@end
