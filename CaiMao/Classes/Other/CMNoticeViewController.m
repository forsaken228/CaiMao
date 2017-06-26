//
//  CMNoticeViewController.m
//  CaiMao
//
//  Created by MAC on 16/11/5.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMNoticeViewController.h"

@interface CMNoticeViewController ()
@property(nonatomic,strong)UIButton *selectBtn;
@property(nonatomic,assign)int pageIndex;
@property(nonatomic,assign)int DPpageIndex;
@property(nonatomic,strong)NSMutableArray *dataSourceArr;
@property(nonatomic,strong)NSMutableArray *DDdataSourceArr;
@end

@implementation CMNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=ViewBackColor;
    self.title=@"公告/动态";
    
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self requestData];
    self.tableView.mj_header=[CMRefreshHeader headerWithRefreshingBlock:^{
        [self requestData];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (self.selectBtn.tag==10) {
           
                [self requestMessageWithType:@"1"];
            
            
        }else{
           [self requestDongTaiMessageWithType:@"4"];
        }
    }];


    if(![CMRequestManager islogin]){
        
        
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(GoLogin)];
        
    }
}
-(void)requestData{
    self.pageIndex=1;
    self.DPpageIndex=1;
    [self requestMessageWithType:@"1"];
    [self requestDongTaiMessageWithType:@"4"];
    
    
}
-(void)GoLogin{
    
    CMLoginController *loginVc = [[CMLoginController alloc] init];
    [self.navigationController pushViewController:loginVc animated:NO];
    NSMutableArray  *arr=[[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    for (UIViewController *vc in arr) {
        if ([vc isKindOfClass:[CMServiceController class]]||[vc isKindOfClass:[self class]]) {
            
            [arr removeObject:vc];
            break;
        }
    }
       self.navigationController.viewControllers=arr;
    
    
}
-(NSMutableArray*)dataSourceArr{
    if (!_dataSourceArr) {
        _dataSourceArr=[NSMutableArray arrayWithCapacity:0];
    }
    return _dataSourceArr;
}
-(NSMutableArray*)DDdataSourceArr{
    if (!_DDdataSourceArr) {
        _DDdataSourceArr=[NSMutableArray arrayWithCapacity:0];
    }
    return _DDdataSourceArr;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.selectBtn.tag==10) {
         return self.dataSourceArr.count;
    }else{
         return self.DDdataSourceArr.count;
    }
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *TCell=@"indexPath";
    CMNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:TCell];
    if (!cell) {
        cell=[[CMNoticeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TCell];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
    NSDictionary *dict=nil;
    if (self.selectBtn.tag==10) {
    dict=self.dataSourceArr[indexPath.row];
    }else{
        
   dict=self.DDdataSourceArr[indexPath.row];
    }
    
   cell.Title.text=[dict objectForKey:@"title"];
    cell.GaiYao.text=[dict objectForKey:@"gaiyao"];
    cell.Time.text=[dict objectForKey:@"date"];;
   // cell.CheackDeatiBtn.tag=indexPath.row;
   // [cell.CheackDeatiBtn addTarget:self action:@selector(didSelectRowAtIndexPath:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    NSDictionary *dict=nil;
    if (self.selectBtn.tag==10) {
        dict= self.dataSourceArr[indexPath.row];
    }else{
        
        dict=self.DDdataSourceArr[indexPath.row];
    }
    CMProductDetailController *proVc = [[CMProductDetailController alloc] init];
    proVc.urlStr=[dict objectForKey:@"url"];
    [self.navigationController pushViewController:proVc animated:YES];
    
    
}
-(UIView*)tableViewHeadView{
    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 50)];
    bgView.backgroundColor=ViewBackColor;
    
    UIButton *GongGaoBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    GongGaoBtn.center=CGPointMake(bgView.center.x-65, bgView.center.y);
    GongGaoBtn.bounds=CGRectMake(0, 0, 130, 30);
    GongGaoBtn.layer.borderColor=RedButtonColor.CGColor;
    GongGaoBtn.layer.borderWidth=0.5;
    GongGaoBtn.layer.cornerRadius=5;
    GongGaoBtn.layer.masksToBounds=YES;
    self.selectBtn=GongGaoBtn;
    GongGaoBtn.selected=YES;
    [GongGaoBtn setTitle:@"公告" forState:UIControlStateNormal];
    GongGaoBtn.titleLabel.font=[UIFont systemFontOfSize:14.0];
    [GongGaoBtn setTitleColor:RedButtonColor forState:UIControlStateNormal];
    [GongGaoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [GongGaoBtn addTarget:self action:@selector(choiceGonggaoOrDongTaiClick:) forControlEvents:UIControlEventTouchUpInside];
    GongGaoBtn.tag=10;
    [GongGaoBtn setBackgroundColor:RedButtonColor];

    [bgView addSubview:GongGaoBtn];
    
    
    UIButton *dongTaiBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    dongTaiBtn.center=CGPointMake(bgView.center.x+75, bgView.center.y);
    dongTaiBtn.bounds=CGRectMake(0, 0, 130, 30);
    dongTaiBtn.layer.borderColor=RedButtonColor.CGColor;
    dongTaiBtn.titleLabel.font=[UIFont systemFontOfSize:14.0];
    dongTaiBtn.layer.borderWidth=0.5;
    dongTaiBtn.layer.cornerRadius=5;
    dongTaiBtn.layer.masksToBounds=YES;
    [dongTaiBtn setTitle:@"动态" forState:UIControlStateNormal];
    [dongTaiBtn setTitleColor:RedButtonColor forState:UIControlStateNormal];
    [dongTaiBtn addTarget:self action:@selector(choiceGonggaoOrDongTaiClick:) forControlEvents:UIControlEventTouchUpInside];
    dongTaiBtn.tag=11;
    [dongTaiBtn setBackgroundColor:[UIColor whiteColor]];
    [bgView addSubview:dongTaiBtn];
    
    return bgView;
}

-(void)choiceGonggaoOrDongTaiClick:(UIButton*)btn{
    
    if (self.selectBtn==btn) {
        return;
    }
    self.selectBtn.selected=NO;
    [self.selectBtn setTitleColor:RedButtonColor forState:UIControlStateNormal];
    [self.selectBtn setBackgroundColor:[UIColor whiteColor]];
    //点击btn
    btn.selected=YES;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn setBackgroundColor:RedButtonColor];
    self.selectBtn=btn;
    [self.tableView reloadData];
}

-(void)requestMessageWithType:(NSString*)Type {
    if (![self checkNetWork]) {
        [self.tableView.mj_header endRefreshing];
    }
    self.tableView.tableHeaderView=[self tableViewHeadView];
    NSString *page=[NSString stringWithFormat:@"%d",self.pageIndex++];
    [CMRequestHandle getGongGaotWithType:Type andPageIndex:page andSuccess:^(id responseObj) {
        
      
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([[responseObj objectForKey:@"Status"]intValue]==200) {
          
            NSArray *result=[[responseObj objectForKey:@"t"]objectForKey:@"list"];
            if (self.pageIndex == 2) {
                for (;0 < self.dataSourceArr.count;) {
                    [self.dataSourceArr removeObjectAtIndex:0];
                }
            }
            
            if (result.count<=0) {
                
                [self.tableView.mj_footer setState:MJRefreshStateNoMoreData];
                return ;
            }else{
                
                // 将刷新到的数据添加到数组的后面
                for (NSMutableDictionary *item in result) {
                    if (item != (NSMutableDictionary *)[NSNull null]) {
                        [self.dataSourceArr addObject:item];
                    }
                }
                
            }
            
           
            
            [self.tableView reloadData];
        }
  
  
        
    } andFailure:^(id error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
}

-(void)requestDongTaiMessageWithType:(NSString*)Type {
    if (![self checkNetWork]) {
        [self.tableView.mj_header endRefreshing];
    }
    NSString *page=[NSString stringWithFormat:@"%d",self.DPpageIndex++];
    [CMRequestHandle getGongGaotWithType:Type andPageIndex:page andSuccess:^(id responseObj) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([[responseObj objectForKey:@"Status"]intValue]==200) {
    
            NSArray *result=[[responseObj objectForKey:@"t"]objectForKey:@"list"];
            if (self.DPpageIndex == 2) {
                for (;0 < self.DDdataSourceArr.count;) {
                    [self.DDdataSourceArr removeObjectAtIndex:0];
                }
            }
            
            if (result.count<=0) {
                
                [self.tableView.mj_footer setState:MJRefreshStateNoMoreData];
                return ;
            }else{
                
                // 将刷新到的数据添加到数组的后面
                for (NSMutableDictionary *item in result) {
                    if (item != (NSMutableDictionary *)[NSNull null]) {
                        [self.DDdataSourceArr addObject:item];
                    }
                }
                
            }
            
            
            
            [self.tableView reloadData];
        }
        
        
        
    } andFailure:^(id error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
}
checkNet
@end
