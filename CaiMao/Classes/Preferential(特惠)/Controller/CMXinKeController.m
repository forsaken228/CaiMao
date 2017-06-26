//
//  CMXinKeController.m
//  CaiMao
//
//  Created by Fengpj on 16/1/6.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMXinKeController.h"

@interface CMXinKeController ()<UITableViewDataSource,UITableViewDelegate>
{
   
   
    NSArray *xinArr;
}

@property(nonatomic,strong)UITableView *xinkeTableView;
@property(nonatomic,strong)NSArray *xinkeList;

@end

@implementation CMXinKeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新客专享";
    
   
    [self.view addSubview:self.xinkeTableView];
    [self loadXinKeData];
    [self showDefaultProgressHUD];
    self.xinkeTableView.mj_header = [CMRefreshHeader headerWithRefreshingBlock:^{
        
        [self loadXinKeData];
        
    }];
    
    if (self.fromWebView) {
        self.navigationItem.hidesBackButton=YES;
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"nav_back_btn" higlightedImage:nil target:self action:@selector(backBtnClick)];
    }
    
    
    if(![CMRequestManager islogin]){
        
          self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(EnterRegist)];
    }
   // [self.xinkeTableView.mj_header beginRefreshing];
}

-(void)EnterRegist{
    
    CMRegistController *regist=[[CMRegistController alloc]init];
    [self.navigationController pushViewController:regist animated:YES];
}
-(void)backBtnClick{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

#pragma mark Lazy
-(UITableView*)xinkeTableView{
    if (!_xinkeTableView) {
        _xinkeTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        
        _xinkeTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _xinkeTableView.dataSource = self;
        _xinkeTableView.delegate = self;
        _xinkeTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
      
        
       
    }
    return _xinkeTableView;
}
-(NSArray*)xinkeList{
    if (!_xinkeList) {
        _xinkeList=[NSArray array];
    }
    return _xinkeList;
}
- (void)loadXinKeData
{
    if (![self checkNetWork]) {
        [self.xinkeTableView.mj_header endRefreshing];
        
    }
    [CMRequestHandle GetXinKeProductMsgSuccess:^(id responseObj) {
        if ([[responseObj  valueForKey:@"status"]intValue]==200) {
            xinArr = [[responseObj  valueForKey:@"data"] valueForKey:@"list"];
            
            self.xinkeList = [CMXinKeList objectArrayWithKeyValuesArray:xinArr];
            
            [self.xinkeTableView reloadData];
            
            [self hiddenProgressHUD];
        }
        
        self.xinkeTableView.tableHeaderView = [CMBarView barHeadViewWithImage:@"xk_banner.jpg"];
        self.xinkeTableView.tableFooterView = [CMBarView barFootViewWithImage:@"xk_xq"];
        // 结束刷新状态
        [self.xinkeTableView.mj_header endRefreshing];
    }andFailure:^(id error) {
        
        [self.xinkeTableView.mj_header endRefreshing];

    }];


   }
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.xinkeList.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"xinkeCell";
    CMXinKeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[CMXinKeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
     
    }

    cell.list=_xinkeList[indexPath.section];
    cell.xinPaiBtn.tag = indexPath.section;
    [cell.xinPaiBtn addTarget:self action:@selector(xinPaiBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    

    CMLiCaiDetailController *vc=[[CMLiCaiDetailController alloc]init];
    vc.productListArr=[xinArr objectAtIndex:indexPath.section];
    [self.navigationController pushViewController:vc animated:YES];
}
*/
- (void)xinPaiBtnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    CMPayViewController *vc=[[CMPayViewController alloc]init];
    vc.ProuctListArr=[xinArr objectAtIndex:btn.tag];
    vc.countNum=1;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        //return self.xinSectionHeaderView;
        return [self creatSectionHeadView];
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 40;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}
#pragma mark 创建区头
-(UIView*)creatSectionHeadView{
    
    UIView *bgView=[[UIView alloc]init];
    bgView.frame=CGRectMake(0, 0, self.view.bounds.size.width, 40);
    bgView.backgroundColor = [UIColor whiteColor];
    
    UILabel *title=[UILabel new];
    //title.frame=CGRectMake(8, 3, 68, 34);
    title.text=@"新客专享";
    title.textColor=RedButtonColor;
    [bgView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.top.equalTo(bgView);
        make.left.equalTo(bgView.mas_left).offset(10);
        make.width.mas_equalTo(100);
    }];
    
    UILabel *right=[UILabel new];
   // right.frame=CGRectMake(107, 3, 205, 34);
    right.font=[UIFont systemFontOfSize:14.0];
    right.textAlignment=NSTextAlignmentRight;
    right.text=@"到期还本利息";
    right.textColor=[UIColor lightGrayColor];
    [bgView addSubview:right];
    [right mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.top.equalTo(bgView);
        make.right.equalTo(bgView.mas_right).offset(-10);
        make.width.mas_equalTo(205);
    }];
    
    UILabel *line=[UILabel new];
    line.backgroundColor=separateLineColor;
    [bgView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.left.width.equalTo(bgView);
        make.bottom.equalTo(bgView);
    }];
    return bgView;
    
}


checkNet

@end
