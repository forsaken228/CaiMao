//
//  CMInviteFriendListView.m
//  CaiMao
//
//  Created by WangWei on 17/3/29.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import "CMInviteFriendListView.h"
#import "CMYaoQingFriendCell.h"
@interface CMInviteFriendListView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)NSMutableArray *dataArry;
@property(nonatomic,strong)CMRecordBgView *rbgView;
@end
@implementation CMInviteFriendListView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=ViewBackColor;
        
        self.rbgView.frame=CGRectMake(0, self.frame.origin.y, CMScreenW, self.bounds.size.height);
        
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
        [_rbgView creatHeadImage:@"cfbht_zrjl" andTitle:@"暂时没有邀请记录"];;
        
        
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
        _myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, CMScreenH-190) style:UITableViewStyleGrouped];
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
    return 60.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *TCell=@"UITableViewCell";
    CMYaoQingFriendCell *cell=[tableView dequeueReusableCellWithIdentifier:TCell];
    
    if (!cell) {
        cell=[[CMYaoQingFriendCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TCell];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
 
    
    NSDictionary *dict=self.dataArry[indexPath.section];
    
    
    
    NSString *phone=[NSString stringWithFormat:@"%@",[dict objectForKey:@"Tel"]];
    NSString *newPhone= [phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    cell.phoneNum.text=newPhone;
    NSString *date=[dict objectForKey:@"RegTime"];
    NSString *new=[date substringToIndex:10];
    cell.registTime.text=[NSString stringWithFormat:@"%@",new];
    cell.totalJiang.text=[NSString stringWithFormat:@"%.2f元",[[dict objectForKey:@"AllAmount"]floatValue]];
    
    
    return cell;
    
}

#pragma mark 请求数据
-(void)requestDataWithPage:(NSString*)page{
    NSString *urlStr = [NSString stringWithFormat:@"%@/handler/AppService_InviteAction.ashx?Action=1",OnLineCode];
    NSDictionary *dict=@{@"HYID":[CMUserDefaults objectForKey:@"userID"],@"PageIndex":page};
    [CMHttpTool postWithURL:urlStr params:dict success:^(id responseObj) {
       
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
