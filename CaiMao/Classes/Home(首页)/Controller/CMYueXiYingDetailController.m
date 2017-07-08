//
//  CMYueXiYingDetailController.m
//  CaiMao
//
//  Created by Fengpj on 15/12/9.
//  Copyright © 2015年 58cm. All rights reserved.
//

#import "CMYueXiYingDetailController.h"
@interface CMYueXiYingDetailController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *yinArr;
}

@property(nonatomic,strong)UITableView *yuexiyingTableView;
@property(nonatomic,strong)NSArray *yuexiYingList;
@end

@implementation CMYueXiYingDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"月息盈";
    [self.view addSubview:self.yuexiyingTableView];
    [self showDefaultProgressHUD];
    [self loadTableViewData];
 
}

#pragma mark Lazy
-(UITableView*)yuexiyingTableView{
    if (!_yuexiyingTableView) {
        _yuexiyingTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _yuexiyingTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _yuexiyingTableView.dataSource = self;
        _yuexiyingTableView.delegate = self;
        _yuexiyingTableView.showsVerticalScrollIndicator=NO;
        _yuexiyingTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    }
    return _yuexiyingTableView;
    
}
-(NSArray*)yuexiYingList{
    if (!_yuexiYingList) {
        _yuexiYingList=[NSArray array];
    }
    return _yuexiYingList;
}

-(void)loadTableViewData{
     [self loadYueXiYingData];
    self.yuexiyingTableView.mj_header = [CMRefreshHeader headerWithRefreshingBlock:^{
        [self loadYueXiYingData];
    }];
    // 马上进入刷新状态
  //  [self.yuexiyingTableView.mj_header beginRefreshing];
    
}


- (void)loadYueXiYingData
{
    if (![self checkNetWork]) {
          [self hiddenProgressHUD];
        [self.yuexiyingTableView.mj_header endRefreshing];
        
    }
  [CMRequestHandle GetYueXiYingProductMsgSuccess:^(id responseObj) {
      [self hiddenProgressHUD];
      self.yuexiyingTableView.tableHeaderView = [CMBarView barHeadViewWithImage:@"details_banner_yxy"];
      self.yuexiyingTableView.tableFooterView = [CMBarView barFootViewWithImage:@"details_yxy"];
      if ([[responseObj objectForKey:@"status"]intValue]==200) {
      yinArr = [[responseObj  valueForKey:@"data"] valueForKey:@"list"];
      
      self.yuexiYingList = [CMYueXiYingList objectArrayWithKeyValuesArray:yinArr];
      
      [self.yuexiyingTableView reloadData];
      }
      // 结束刷新状态
      [self.yuexiyingTableView.mj_header endRefreshing];
  }andFailure:^(id error) {
      [self.yuexiyingTableView.mj_header endRefreshing];
  }];
   }

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.yuexiYingList.count;;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"yuexiCell";
    CMYuexiCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[CMYuexiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    
    CMYueXiYingList *list = self.yuexiYingList[indexPath.section];
    
    // 为CMDingqiCell属性赋值
    cell.yueXiTitle.text = list.title;
    cell.yueCanyu.text = [NSString stringWithFormat:@"%d人参与",list.jbcnt];
    CGRect rect=[ cell.yueCanyu.text boundingRectWithSize:CGSizeMake(80, 13) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil];
    [cell.yueCanyu mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(rect.size.width+5);
    }];
    [NSString LoneAttributedStringEndString:@"人" FromLabel:cell.yueCanyu];
    // 设置年收益
    float shouyi = list.nlv;
    int x = (int)shouyi;
    cell.yueZhengshu.text = [NSString stringWithFormat:@"%.0f",floorf(shouyi)];
    if ((shouyi-(float)x)*100 == 0) {
        cell.yueXiaoshu.text = [[NSString stringWithFormat:@".00"] stringByAppendingString:@"%"];
    } else {
        cell.yueXiaoshu.text = [[NSString stringWithFormat:@".%.f",(shouyi-(float)x)*100] stringByAppendingString:@"%"];
    }
    
    
    // 设置期限
   
    if (list.jkqx_dw == 1) {    // 期限->天
        cell.yueQixian.text = [NSString stringWithFormat:@"期限%d天",list.jkqx];
         [NSString DoubleStringChangeColer:cell.yueQixian andFromStr:@"限" ToStr:@"天" withColor:RedButtonColor];
        
    } else if (list.jkqx_dw == 2) { // 期限->月
        cell.yueQixian.text = [NSString stringWithFormat:@"期限%d个月",list.jkqx];
      [NSString DoubleStringChangeColer:cell.yueQixian andFromStr:@"限" ToStr:@"个" withColor:RedButtonColor];
        
    } else {                            // 期限->年
    cell.yueQixian.text = [NSString stringWithFormat:@"期限%d年",list.jkqx];
     [NSString DoubleStringChangeColer:cell.yueQixian andFromStr:@"限" ToStr:@"年" withColor:RedButtonColor];
    }
    
    // 设置起投金额

    cell.yueQitou.text =  [NSString stringWithFormat:@"%d元/份",list.cpfe];
    [NSString  LoneAttributedStringEndString:@"元" FromLabel:cell.yueQitou];
    
    
    cell.yuePaiBtn.tag = indexPath.section;
    [cell.yuePaiBtn setBackgroundColor:RedButtonColor];
    [cell.yuePaiBtn addTarget:self action:@selector(yuePaiBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 设置百分比
    float PercentNum = [[NSString stringWithFormat:@"%f",(float)list.jbfs / list.zjfs] floatValue];
    [cell.yuePercentView setPercent:PercentNum * 100 animated:YES];
    
    // 设置产品是否结束
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    
    NSDate *dqDate = [dateFormatter dateFromString:list.dqtime]; // 格式化到期时间
    
    NSString *dateNowstr = [dateFormatter stringFromDate:[NSDate date]];
    
    NSDate *dateNow = [dateFormatter dateFromString:dateNowstr]; // 格式化当前时间
    
    NSTimeInterval time = [dqDate timeIntervalSinceDate:dateNow]; // 比较时间差
    
    if (time <= 0||list.zjfs<=list.jbfs) {
        [cell.yuePaiBtn setTitle:@"已结束" forState:UIControlStateNormal];
        [cell.yuePaiBtn setBackgroundColor:[UIColor lightGrayColor]];
        cell.yuePaiBtn.enabled = NO;
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CMLiCaiDetailController *vc=[[CMLiCaiDetailController alloc]init];
    vc.productListArr=[yinArr objectAtIndex:indexPath.section];
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)yuePaiBtnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    CMPayViewController *vc=[[CMPayViewController alloc]init];
    vc.ProuctListDict=[yinArr objectAtIndex:btn.tag];
    vc.countNum=1;
    [self.navigationController pushViewController:vc animated:YES];
   
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return  [self creatDingQiSectionHeadView];
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
    return 150;
}
#pragma mark 创建区头
-(UIView*)creatDingQiSectionHeadView{
    
    UIView *bgView=[[UIView alloc]init];
    bgView.frame=CGRectMake(0, 0, self.view.bounds.size.width, 40);
    bgView.backgroundColor = [UIColor whiteColor];
    
    UILabel *title=[UILabel new];
    //title.frame=CGRectMake(8, 3, 68, 34);
    title.text=@"月息盈";
    title.textColor=CMColor(255, 134, 46);
    [bgView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.top.equalTo(bgView);
        make.left.equalTo(bgView.mas_left).offset(8);
        make.width.mas_equalTo(68);
    }];
    
    
    UILabel *right=[UILabel new];
   // right.frame=CGRectMake(107, 3, 205, 34);
    right.font=[UIFont systemFontOfSize:14.0];
    right.textAlignment=NSTextAlignmentRight;
    right.text=@"每月付息 天天都有零钱花";
    right.textColor=[UIColor lightGrayColor];
    [bgView addSubview:right];
    [right mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.top.equalTo(bgView);
        make.right.equalTo(bgView.mas_right).offset(-8);
        make.width.mas_equalTo(205);
    }];
    
    return bgView;
    
}

checkNet

@end
