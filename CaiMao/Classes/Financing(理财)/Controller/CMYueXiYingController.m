//
//  CMYueXiYingController.m
//  CaiMao
//
//  Created by Fengpj on 15/11/23.
//  Copyright © 2015年 58cm. All rights reserved.
//

#import "CMYueXiYingController.h"

@interface CMYueXiYingController ()<UITableViewDataSource,UITableViewDelegate>
{
    //NSMutableAttributedString *_qixianStr; // 投资期限字符串
    NSArray *yinArr;
}

@property(nonatomic,strong)UITableView *yueXiTableView;
@property(nonatomic,strong)NSArray *yuexiYingList;
@end

@implementation CMYueXiYingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.title=@"月息盈";
    self.view.backgroundColor=ViewBackColor;
    [self.view addSubview:self.yueXiTableView];
    [self showDefaultProgressHUD];
    [self loadYueXiYingData];
    
    self.yueXiTableView.mj_header = [CMRefreshHeader headerWithRefreshingBlock:^{
        [self loadYueXiYingData];
    }];
    
    // 马上进入刷新状态
   // [self.yueXiTableView.mj_header beginRefreshing];
}
#pragma mark lazy
-(UITableView*)yueXiTableView{
    if (!_yueXiTableView) {

        _yueXiTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CMScreenW, CMScreenH-149) style:UITableViewStyleGrouped];
        _yueXiTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _yueXiTableView.showsVerticalScrollIndicator=NO;
        _yueXiTableView.showsHorizontalScrollIndicator=NO;
        _yueXiTableView.dataSource = self;
        _yueXiTableView.delegate = self;
    }
    return _yueXiTableView;
    
}

-(NSArray*)yuexiYingList{
    if (!_yuexiYingList) {
        _yuexiYingList=[NSArray array];
    }
    return _yuexiYingList;
    
}
- (void)loadYueXiYingData
{
    if (![self checkNetWork]) {
           [self hiddenProgressHUD];
        [self.yueXiTableView.mj_header endRefreshing];
       
    }
    
    [CMRequestHandle GetYueXiYingProductMsgSuccess:^(id responseObj) {
        [self hiddenProgressHUD];
        yinArr = [[responseObj  valueForKey:@"data"] valueForKey:@"list"];
        
        self.yuexiYingList = [CMYueXiYingList objectArrayWithKeyValuesArray:yinArr];
        
        [self.yueXiTableView reloadData];
        
        // 结束刷新状态
        [self.yueXiTableView.mj_header endRefreshing];
        
    }andFailure:^(id error) {
        
        [self.yueXiTableView.mj_header endRefreshing];
    }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.yuexiYingList.count;
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
   // NSString *qiStr = [NSString string];
    static  NSString *qiStr;
    if (list.jkqx_dw == 1) {    // 期限->天
        qiStr = [NSString stringWithFormat:@"期限%d天",list.jkqx];
         cell.yueQixian.text = qiStr;
        [NSString DoubleStringChangeColer:cell.yueQixian andFromStr:@"限" ToStr:@"天" withColor:RedButtonColor];
        
    } else if (list.jkqx_dw == 2) { // 期限->月
        qiStr = [NSString stringWithFormat:@"期限%d个月",list.jkqx];
        cell.yueQixian.text = qiStr;
       [NSString DoubleStringChangeColer:cell.yueQixian andFromStr:@"限" ToStr:@"个" withColor:RedButtonColor];
        
    } else {                            // 期限->年
        qiStr = [NSString stringWithFormat:@"期限%d年",list.jkqx];
        cell.yueQixian.text = qiStr;
        [NSString DoubleStringChangeColer:cell.yueQixian andFromStr:@"限" ToStr:@"年" withColor:RedButtonColor];
    }
   
    
    // 设置起投金额
    //NSString *qiTouStr = [NSString string];
    NSString *qiTouStr = [NSString stringWithFormat:@"%d元/份",list.cpfe];
    
    cell.yueQitou.text = qiTouStr;
  [NSString LoneAttributedStringEndString:@"元" FromLabel:cell.yueQitou];
    
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
    
    if (time <= 0||list.zjfs==list.jbfs) {
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
//-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    if (section==0) {
//        UILabel *label=[[UILabel alloc]init];
//        label.backgroundColor=UIColorFromRGB(0xcccccc);
//        label.text=@"每天10:00发布新产品";
//        label.textColor=[UIColor whiteColor];
//        label.textAlignment=NSTextAlignmentCenter;
//        label.font=[UIFont systemFontOfSize:14.0];
//        label.frame=CGRectMake(0, 0, CMScreenW, 20);
//        
//        return label;
//        
//    }else{
//        
//        return nil;
//    }
//    
//}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else{
        return 10;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 160;
}

checkNet

@end
