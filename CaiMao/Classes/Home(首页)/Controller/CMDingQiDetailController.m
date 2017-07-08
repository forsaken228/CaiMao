//
//  CMDingQiDetailController.m
//  CaiMao
//
//  Created by Fengpj on 15/12/9.
//  Copyright © 2015年 58cm. All rights reserved.
//

#import "CMDingQiDetailController.h"
@interface CMDingQiDetailController ()<UITableViewDataSource,UITableViewDelegate>
{

    NSArray *dingArr; //定期宝列表
}
@property(nonatomic,strong)NSArray  *dingQiBaoList;
@property(nonatomic,strong)UITableView  *dingqiTableView;

@end

@implementation CMDingQiDetailController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"定期宝";
    
    [self.view addSubview:self.dingqiTableView];
 //   [self.dingqiTableView.mj_header beginRefreshing];
[self showDefaultProgressHUD];
     [self loadDingQiBaoData];
  }




#pragma mark lazy
-(UITableView*)dingqiTableView{
    if(!_dingqiTableView){
        
        _dingqiTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CMScreenW, CMScreenH) style:UITableViewStyleGrouped];
        _dingqiTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _dingqiTableView.dataSource = self;
        _dingqiTableView.delegate = self;
        _dingqiTableView.showsVerticalScrollIndicator=NO;
        _dingqiTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _dingqiTableView.mj_header = [CMRefreshHeader headerWithRefreshingBlock:^{
            
            [self loadDingQiBaoData];
            
        }];
        
    }
    return _dingqiTableView;
}
-(NSArray*)dingQiBaoList{
    if (!_dingQiBaoList) {
        _dingQiBaoList = [NSArray array];
    }
    return _dingQiBaoList;
}

//加载定期宝数据
- (void)loadDingQiBaoData
{
    if (![self checkNetWork]) {
        [self hiddenProgressHUD];
        [self.dingqiTableView.mj_header endRefreshing];
      
    }
    [CMRequestHandle GetDingQiBaoProductMsgSuccess:^(id responseObj) {
        [self hiddenProgressHUD];
        self.dingqiTableView.tableHeaderView = [CMBarView barHeadViewWithImage:@"details_banner_dqb"];
        self.dingqiTableView.tableFooterView = [CMBarView barFootViewWithImage:@"details_dqb"];
        dingArr = [[responseObj  valueForKey:@"data"] valueForKey:@"list"];
        
        self.dingQiBaoList = [CMDingQiBaoList objectArrayWithKeyValuesArray:dingArr];
        
        [self.dingqiTableView reloadData];
        
        // 结束刷新状态
        [self.dingqiTableView.mj_header endRefreshing];
    }andFailure:^(id error) {
        [self.dingqiTableView.mj_header endRefreshing];
    }];

   
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return   self.dingQiBaoList.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"dingCell";
    CMDingqiCell *dingCell = [tableView  cellForRowAtIndexPath:indexPath];
        
    if (!dingCell) {
        dingCell = [[CMDingqiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    CMDingQiBaoList *list =   self.dingQiBaoList[indexPath.section];
    
    // 为CMDingqiCell属性赋值
    dingCell.dingqiTitle.text = list.title;
    dingCell.dingCanyu.text = [NSString stringWithFormat:@"%d人参与",list.jbcnt];
    CGRect rect=[  dingCell.dingCanyu.text boundingRectWithSize:CGSizeMake(80, 13) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil];
    [ dingCell.dingCanyu mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(rect.size.width+5);
    }];
    [NSString LoneAttributedStringEndString:@"人" FromLabel:dingCell.dingCanyu];
    // 设置年收益
    float shouyi = list.nlv;
    int x = (int)shouyi;
    dingCell.dingZhengshu.text = [NSString stringWithFormat:@"%.0f",floorf(shouyi)];
    if ((shouyi-(float)x)*100 == 0) {
        dingCell.dingXiaoshu.text = [[NSString stringWithFormat:@".00"] stringByAppendingString:@"%"];
    } else {
        dingCell.dingXiaoshu.text = [[NSString stringWithFormat:@".%.f",(shouyi-(float)x)*100] stringByAppendingString:@"%"];
    }
    
    if (x<10) {
        [dingCell.dingZhengshu mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@25);
        }];
    }
    // 设置期限
   
    if (list.jkqx_dw == 1) {    // 期限->天
        dingCell.dingQixian.text = [NSString stringWithFormat:@"期限%d天",list.jkqx];
        [NSString DoubleStringChangeColer:dingCell.dingQixian andFromStr:@"限" ToStr:@"天" withColor:RedButtonColor];
        
    } else if (list.jkqx_dw == 2) { // 期限->月
        dingCell.dingQixian.text = [NSString stringWithFormat:@"期限%d个月",list.jkqx];
       [NSString DoubleStringChangeColer:dingCell.dingQixian andFromStr:@"限" ToStr:@"个" withColor:RedButtonColor];
        
    } else {                            // 期限->年
        dingCell.dingQixian.text = [NSString stringWithFormat:@"期限%d年",list.jkqx];
       [NSString DoubleStringChangeColer:dingCell.dingQixian andFromStr:@"限" ToStr:@"年" withColor:RedButtonColor];
    }
    
    // 设置起投金额
    dingCell.dingQitou.text = [NSString stringWithFormat:@"%d元起",list.cpfe];
    [NSString LoneAttributedStringEndString:@"元" FromLabel:dingCell.dingQitou];
    // 设置百分比
    float PercentNum = [[NSString stringWithFormat:@"%.2f",(float)list.jbfs / list.zjfs] floatValue];
    [dingCell.dingPercentView setPercent:PercentNum * 100 animated:YES];
    
    dingCell.dingJoinBtn.tag = indexPath.section;
    [dingCell.dingJoinBtn addTarget:self action:@selector(dingJoinBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 设置产品是否结束
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    
    NSDate *dqDate = [dateFormatter dateFromString:list.dqtime]; // 格式化到期时间
    
    NSString *dateNowstr = [dateFormatter stringFromDate:[NSDate date]];
    
    NSDate *dateNow = [dateFormatter dateFromString:dateNowstr]; // 格式化当前时间
    
    NSTimeInterval time = [dqDate timeIntervalSinceDate:dateNow]; // 比较时间差
    
    if (time <= 0||list.zjfs * 10 - 1 <= list.jbfs) {
        [dingCell.dingJoinBtn setTitle:@"已结束" forState:UIControlStateNormal];
        [dingCell.dingJoinBtn setBackgroundColor:[UIColor lightGrayColor]];
        dingCell.dingJoinBtn.userInteractionEnabled = NO;
    }
    
    
    
    return dingCell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CMLiCaiDetailController *vc=[[CMLiCaiDetailController alloc]init];
    vc.productListArr=[dingArr objectAtIndex:indexPath.section];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)dingJoinBtnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    CMPayViewController *vc=[[CMPayViewController alloc]init];
    vc.ProuctListDict=[dingArr objectAtIndex:btn.tag];
    vc.countNum=1;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return [self creatDingQiSectionHeadView];
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0){
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
    title.text=@"定期宝";
    title.textColor=CMColor(255, 134, 46);
    [bgView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.height.top.equalTo(bgView);
        make.left.equalTo(bgView.mas_left).offset(8);
        make.width.mas_equalTo(68);
    }];
    
    UILabel *right=[UILabel new];
    //right.frame=CGRectMake(107, 3, 205, 34);
    right.font=[UIFont systemFontOfSize:14.0];
    right.textAlignment=NSTextAlignmentRight;
    right.text=@"政府债 像银行一样安全";
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
