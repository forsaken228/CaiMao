//
//  CMYinPiaoController.m
//  CaiMao
//
//  Created by Fengpj on 15/11/23.
//  Copyright © 2015年 58cm. All rights reserved.
//

#import "CMYinPiaoController.h"


@interface CMYinPiaoController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableAttributedString *_qixianStr; // 投资期限字符串
}
@property(nonatomic,strong)UITableView *yinpiaoTableView;
@property(nonatomic,strong)NSArray *yinPiaoList;
@end

@implementation CMYinPiaoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.yinpiaoTableView];
    self.yinpiaoTableView.mj_header = [CMRefreshHeader headerWithRefreshingBlock:^{
        [self loadYinPiaoTongData];
    }];
    
    // 马上进入刷新状态
    [self.yinpiaoTableView.mj_header beginRefreshing];
}



#pragma mark lazy
-(UITableView*)yinpiaoTableView{
    if (!_yinpiaoTableView) {
        
        CGRect Frame = CGRectMake(0, 0, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height-149);
        
   
        _yinpiaoTableView = [[UITableView alloc] initWithFrame:Frame style:UITableViewStyleGrouped];
        _yinpiaoTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _yinpiaoTableView.dataSource = self;
        _yinpiaoTableView.delegate = self;
   
    }
    return _yinpiaoTableView;
    
}

-(NSArray*)yinPiaoList{
    if (!_yinPiaoList) {
        _yinPiaoList=[NSArray array];
    }
    return _yinPiaoList;
    
}
- (void)loadYinPiaoTongData
{
    if (![self checkNetWork]) {
        [self.yinpiaoTableView.mj_header endRefreshing];
        
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/handler/app_interface.ashx?action=Product&mark=piaoju",OnLineCode];
    [CMHttpTool getWithURL:urlStr params:nil success:^(id responseObj) {
        NSLog(@"yin===%@",responseObj);
        NSArray *yinArr = [[responseObj  valueForKey:@"data"] valueForKey:@"list"];
        
        self.yinPiaoList = [CMYinPiaoList objectArrayWithKeyValuesArray:yinArr];
        
        [self.yinpiaoTableView reloadData];
        
        // 结束刷新状态
        [self.yinpiaoTableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        DLog(@"银票通产品ListError---%@",error);
    }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.yinPiaoList.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"yinpiaoCell";
    CMYinpiaoCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[CMYinpiaoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    
    CMYinPiaoList *list = self.yinPiaoList[indexPath.section];
    
    // 为CMDingqiCell属性赋值
    cell.yinPiaoTitle.text = list.title;
    cell.yinCanyu.text = [NSString stringWithFormat:@"%d人参与",list.jbcnt];
    
    // 设置年收益
    float shouyi = list.nlv;
    int x = (int)shouyi;
    cell.yinZhengshu.text = [NSString stringWithFormat:@"%.0f",floorf(shouyi)];
    if ((shouyi-(float)x)*100 == 0) {
        cell.yinXiaoshu.text = [[NSString stringWithFormat:@".00"] stringByAppendingString:@"%"];
    } else {
        cell.yinXiaoshu.text = [[NSString stringWithFormat:@".%.f",(shouyi-(float)x)*100] stringByAppendingString:@"%"];
    }
    
    // 设置期限
   // NSString *qiStr = [NSString string];
    static NSString *qiStr;
    if (list.jkqx_dw == 1) {    // 期限->天
        qiStr = [NSString stringWithFormat:@"期限%d天",list.jkqx];
       cell.yinQiXian.text = qiStr;
        [NSString DoubleStringChangeColer:cell.yinQiXian andFromStr:@"限" ToStr:@"天" withColor:RedButtonColor];
        
    } else if (list.jkqx_dw == 2) { // 期限->月
        qiStr = [NSString stringWithFormat:@"期限%d个月",list.jkqx];
        cell.yinQiXian.text = qiStr;
        [NSString DoubleStringChangeColer:cell.yinQiXian andFromStr:@"限" ToStr:@"个" withColor:RedButtonColor];
    } else {                            // 期限->年
        qiStr = [NSString stringWithFormat:@"期限%d年",list.jkqx];
        cell.yinQiXian.text = qiStr;
       [NSString DoubleStringChangeColer:cell.yinQiXian andFromStr:@"限" ToStr:@"年" withColor:RedButtonColor];
    }
     
    // 设置起投金额
    //NSString *qiTouStr = [NSString string];
    NSString *qiTouStr = [NSString stringWithFormat:@"%d元起",list.cpfe];
    cell.yinQitou.text = qiTouStr;
    [NSString LoneAttributedStringEndString:@"元" FromLabel:cell.yinQitou];
    
    cell.yinPaiBtn.tag = indexPath.section;
    [cell.yinPaiBtn setBackgroundColor:CMColor(255, 35, 40)];
    [cell.yinPaiBtn addTarget:self action:@selector(yinPaiBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 设置百分比
    float PercentNum = [[NSString stringWithFormat:@"%f",(float)list.jbfs / list.zjfs] floatValue];
    
    [cell.yinPercentView setPercent:PercentNum * 100 animated:YES];
    
    // 担保银行
    cell.yinYinhang.text = [NSString stringWithFormat:@"%@担保",list.tgjg];
    
    // 产品倒计时 -- 是否结束竞拍
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    
    NSDate *dqDate = [dateFormatter dateFromString:list.dqtime]; // 格式化到期时间
    
    NSString *dateNowstr = [dateFormatter stringFromDate:[NSDate date]];
    
    NSDate *dateNow = [dateFormatter dateFromString:dateNowstr]; // 格式化当前时间
    
    NSTimeInterval time = [dqDate timeIntervalSinceDate:dateNow]; // 比较时间差
    
    __block int timeout = time; // 倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0||list.zjfs<=list.jbfs){ // 倒计时结束，关闭
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // 设置界面的按钮显示 根据自己需求设置
                [cell.yinPaiBtn setTitle:@"已结束" forState:UIControlStateNormal];
                [cell.yinPaiBtn setBackgroundColor:[UIColor lightGrayColor]];
                cell.yinPaiBtn.enabled = NO;
            });
        } else {

            dispatch_async(dispatch_get_main_queue(), ^{
                // 设置界面的按钮显示 根据自己需求设置
                [cell.yinPaiBtn setTitle:@"立即竞拍" forState:UIControlStateNormal];
                [cell.yinPaiBtn setBackgroundColor:CMColor(255, 35, 40)];
                cell.yinPaiBtn.enabled = YES;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CMYinPiaoList *list = [self.yinPiaoList objectAtIndex:indexPath.section];
    
    NSString *url = [NSString stringWithFormat:@"%@/tz/lcshow_%d.aspx",OnLineCode,list.pid];
    
    CMProductDetailController *productVc = [[CMProductDetailController alloc] init];
    productVc.urlStr = url;
//    productVc.titleStr = list.title;
    
    [self.navigationController pushViewController:productVc animated:YES];
}

- (void)yinPaiBtnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    CMYinPiaoList *list = [self.yinPiaoList objectAtIndex:btn.tag];
    
    NSString *url = [NSString stringWithFormat:@"%@/lc/InvestConfig.aspx?pid=%d&pcont=1",OnLineCode,list.pid];
    
    CMProductDetailController *productVc = [[CMProductDetailController alloc] init];
    productVc.urlStr = url;
//    productVc.titleStr = @"合同确认";
    
    [self.navigationController pushViewController:productVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 175;
}

checkNet

@end
