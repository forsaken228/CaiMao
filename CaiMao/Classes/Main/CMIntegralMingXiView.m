//
//  CMIntegralMingXiView.m
//  CaiMao
//
//  Created by WangWei on 17/3/30.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import "CMIntegralMingXiView.h"
#import "CMIntegralMingXiCell.h"

@interface CMIntegralMingXiView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)NSMutableArray *dataArry;
@property(nonatomic,strong)CMRecordBgView *rbgView;
@property(nonatomic,assign)float height;
@end
@implementation CMIntegralMingXiView

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
        [_rbgView creatHeadImage:@"wdjf_jfmx_icon" andTitle:@"暂无记录~哦"];;
        
        
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
        _myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, _height) style:UITableViewStyleGrouped];
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
    return 50.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *TCell=@"UITableViewCell";
    CMIntegralMingXiCell *cell=[tableView dequeueReusableCellWithIdentifier:TCell];
    
    if (!cell) {
        cell=[[CMIntegralMingXiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TCell];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    NSDictionary *dict=self.dataArry[indexPath.section];
    //产品积分
    int  productBonus=[[dict objectForKey:@"ProductBonus"]intValue];
    //推荐好友积分
    int TJBonus=[[dict  objectForKey:@"TjBonus"]intValue];
    //分享好友积分
    int FXBonus=[[dict objectForKey:@"FXBonus"]intValue];
    //积分送好礼积分
    int  Credits=[[dict objectForKey:@"Credits"]intValue];
    
    if(productBonus==0&&TJBonus==0&&FXBonus==0){
        cell.productdetail.text=@"积分送好礼";
        
        NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
        [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        [inputFormatter setDateFormat:@"yyyy/MM/dd"];
        NSString *date=[dict objectForKey:@"TotalDate"];
        NSString *new=[date substringToIndex:10];
        NSDate *inputDate = [inputFormatter dateFromString:new];
        NSDate *nextDate = [NSDate dateWithTimeInterval:3*24*60*60 sinceDate:inputDate];
        
        cell.productdetailTime.text=[inputFormatter stringFromDate:nextDate];
        cell.productIntegralNum.text=[NSString stringWithFormat:@"-%d",Credits];
        
    }else if (productBonus!=0){
        cell.productdetail.text=@"购买产品";
        
        NSString *date=[dict objectForKey:@"TotalDate"];
        NSString *new=[date substringToIndex:10];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
        ///用[NSDate date]可以获取系统当前时间
        NSDate *cDate= [dateFormatter dateFromString:new];
        NSString *NewDate=[dateFormatter stringFromDate:cDate];
        
        cell.productdetailTime.text=NewDate;
        
        
        cell.productIntegralNum.text=[NSString stringWithFormat:@"+%d",productBonus];
        
    }else if (TJBonus!=0){
        
        cell.productdetail.text=@"推荐好友";
        
        NSString *date=[dict objectForKey:@"TotalDate"];
        NSString *new=[date substringToIndex:10];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
        ///用[NSDate date]可以获取系统当前时间
        NSDate *cDate= [dateFormatter dateFromString:new];
        NSString *NewDate=[dateFormatter stringFromDate:cDate];
        
        cell.productdetailTime.text=NewDate;
        
        cell.productIntegralNum.text=[NSString stringWithFormat:@"+%d",TJBonus];
        
        
    }else if (FXBonus!=0){
        
        cell.productdetail.text=@"分享";
        
        NSString *date=[dict objectForKey:@"TotalDate"];
        NSString *new=[date substringToIndex:10];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
        ///用[NSDate date]可以获取系统当前时间
        NSDate *cDate= [dateFormatter dateFromString:new];
        NSString *NewDate=[dateFormatter stringFromDate:cDate];
        
        cell.productdetailTime.text=NewDate;
        
        cell.productIntegralNum.text=[NSString stringWithFormat:@"+%d",FXBonus];
        
    }
    
    
    

    
    
    
    return cell;
    
}

#pragma mark 请求数据
-(void)requestDataWithPage:(NSString*)page{
    [CMRequestHandle MyJiFenWithUserID:[CMUserDefaults objectForKey:@"userID"] andPageIndex:page andSuccess:^(id responseObj) {
        
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
        
        
        

    } andFailure:^(id error) {
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
    }];
  
  
    
    
}


@end
