//
//  CMYinPiaoDetailController.m
//  CaiMao
//
//  Created by Fengpj on 15/12/23.
//  Copyright © 2015年 58cm. All rights reserved.
//

#import "CMYinPiaoDetailController.h"
#import "CMYinPiaoList.h"
#import "CMYinDetailCell.h"

@interface CMYinPiaoDetailController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_yinpiaoTableView;
    NSArray *_yinPiaoList; // 银票通产品列表
    NSMutableAttributedString *_qixianStr; // 投资期限字符串
}



@end

@implementation CMYinPiaoDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"银票通";
    
    _yinpiaoTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    
    _yinpiaoTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _yinpiaoTableView.dataSource = self;
    _yinpiaoTableView.delegate = self;
    
   
    _yinpiaoTableView.tableHeaderView = [self creatHeadView];
    _yinpiaoTableView.tableFooterView = [self creatFootView];
    
    [self.view addSubview:_yinpiaoTableView];
    [self showDefaultProgressHUD];
    [self loadYinPiaoTongData];
    _yinpiaoTableView.mj_header = [CMRefreshHeader headerWithRefreshingBlock:^{
        [self loadYinPiaoTongData];
    }];
    
    // 马上进入刷新状态
   // [_yinpiaoTableView.mj_header beginRefreshing];

}

- (void)loadYinPiaoTongData
{
    if (![self checkNetWork]) {
        [_yinpiaoTableView.mj_header endRefreshing];
        
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/handler/app_interface.ashx?action=Product&mark=piaoju",OnLineCode];
    [CMHttpTool getWithURL:urlStr params:nil success:^(id responseObj) {
        
        NSArray *yinArr = [[responseObj  valueForKey:@"data"] valueForKey:@"list"];
        
        _yinPiaoList = [CMYinPiaoList objectArrayWithKeyValuesArray:yinArr];
        
        [_yinpiaoTableView reloadData];
        
        // 结束刷新状态
        [_yinpiaoTableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        DLog(@"银票通产品ListError---%@",error);
    }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _yinPiaoList.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"yinpiCell";
   // CMYinDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    CMYinDetailCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[CMYinDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    
    CMYinPiaoList *list = _yinPiaoList[indexPath.section];
    
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
    //NSString *qiStr = [NSString string];
    static NSString *qiStr;
    if (list.jkqx_dw == 1) {    // 期限->天
        qiStr = [NSString stringWithFormat:@"期限%d天",list.jkqx];
        _qixianStr = [[NSMutableAttributedString alloc] initWithString:qiStr];
        NSRange qiFromRang = [qiStr rangeOfString:@"限"];
        NSRange qiToRang = [qiStr rangeOfString:@"天"];
        [_qixianStr addAttribute:NSForegroundColorAttributeName value:RedButtonColor range:NSMakeRange(qiFromRang.location + 1, qiToRang.location - qiFromRang.location - 1)];
        
        cell.yinQiXian.attributedText = _qixianStr;
        
    } else if (list.jkqx_dw == 2) { // 期限->月
        qiStr = [NSString stringWithFormat:@"期限%d个月",list.jkqx];
        _qixianStr = [[NSMutableAttributedString alloc] initWithString:qiStr];
        NSRange qiFromRang = [qiStr rangeOfString:@"限"];
        NSRange qiToRang = [qiStr rangeOfString:@"个"];
        [_qixianStr addAttribute:NSForegroundColorAttributeName value:RedButtonColor range:NSMakeRange(qiFromRang.location + 1, qiToRang.location - qiFromRang.location - 1)];
        
        cell.yinQiXian.attributedText = _qixianStr;
        
    } else {                            // 期限->年
        qiStr = [NSString stringWithFormat:@"期限%d年",list.jkqx];
        _qixianStr = [[NSMutableAttributedString alloc] initWithString:qiStr];
        NSRange qiFromRang = [qiStr rangeOfString:@"限"];
        NSRange qiToRang = [qiStr rangeOfString:@"年"];
        [_qixianStr addAttribute:NSForegroundColorAttributeName value:RedButtonColor range:NSMakeRange(qiFromRang.location + 1, qiToRang.location - qiFromRang.location - 1)];
        
        cell.yinQiXian.attributedText = _qixianStr;
    }
    
    // 设置起投金额
   // NSString *qiTouStr = [NSString string];
     NSString *qiTouStr = [NSString stringWithFormat:@"%d元起",list.cpfe];
    
    NSMutableAttributedString *qiJinStr = [[NSMutableAttributedString alloc] initWithString:qiTouStr];
    NSRange qiToRang = [qiTouStr rangeOfString:@"元"];
    [qiJinStr addAttribute:NSForegroundColorAttributeName value:RedButtonColor  range:NSMakeRange(0, qiToRang.location)];
    
    cell.yinQitou.attributedText = qiJinStr;
    
    cell.yinPaiBtn.tag = indexPath.section;
    [cell.yinPaiBtn setBackgroundColor:CMColor(241, 121, 84)];
    [cell.yinPaiBtn addTarget:self action:@selector(yinPaiBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 设置百分比
    float PercentNum = [[NSString stringWithFormat:@"%f",(float)list.jbfs / list.zjfs] floatValue];
    [cell.yinPercentView setPercent:PercentNum * 100 animated:YES];
    
    // 设置产品倒计时
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
        if(timeout <= 0){ // 倒计时结束，关闭
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // 设置界面的按钮显示 根据自己需求设置
                cell.yinJiShi.text = @"00:00:00";
                [cell.yinPaiBtn setTitle:@"已结束" forState:UIControlStateNormal];
                [cell.yinPaiBtn setBackgroundColor:[UIColor lightGrayColor]];
                cell.yinPaiBtn.enabled = NO;
            });
        } else {
            int hour = timeout / 3600;
            int minutes = (timeout % 3600) / 60;
            int seconds = timeout % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                // 设置界面的按钮显示 根据自己需求设置
                cell.yinJiShi.text = [NSString stringWithFormat:@"%02d:%02d:%02d",hour,minutes,seconds];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
    // 设置担保银行
    cell.yinYinhang.text = [NSString stringWithFormat:@"%@担保",list.tgjg];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CMYinPiaoList *list = [_yinPiaoList objectAtIndex:indexPath.section];
    
    NSString *url = [NSString stringWithFormat:@"%@/tz/lcshow_%d.aspx",OnLineCode,list.pid];
    
    CMProductDetailController *productVc = [[CMProductDetailController alloc] init];
    productVc.urlStr = url;
//    productVc.titleStr = list.title;
    
    [self.navigationController pushViewController:productVc animated:YES];
}

- (void)yinPaiBtnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    CMYinPiaoList *list = [_yinPiaoList objectAtIndex:btn.tag];
    
    NSString *url = [NSString stringWithFormat:@"%@/lc/InvestConfig.aspx?pid=%d&pcont=1",OnLineCode,list.pid];
    
    CMProductDetailController *productVc = [[CMProductDetailController alloc] init];
    productVc.urlStr = url;
//    productVc.titleStr = @"合同确认";
    
    [self.navigationController pushViewController:productVc animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
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
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 148;
}
#pragma mark 创建表尾
-(UIView*)creatFootView{
    
    UIImageView *bgView=[[UIImageView alloc]init];
    bgView.frame=CGRectMake(0, 0, CMScreenW, 960);
    bgView.image = [UIImage imageNamed:@"details_ypt"];
    return bgView;
    
}
#pragma mark 创建表头
-(UIView*)creatHeadView{
    
    UIImageView *bgView=[[UIImageView alloc]init];
    bgView.frame=CGRectMake(0, 0,CMScreenW, 200);
    bgView.image = [UIImage imageNamed:@"details_banner_ypt"];

    return bgView;
    
}
#pragma mark 创建区头
-(UIView*)creatSectionHeadView{
    
    UIView *bgView=[[UIView alloc]init];
    bgView.frame=CGRectMake(0, 0, self.view.bounds.size.width, 40);
    bgView.backgroundColor = [UIColor whiteColor];
    
    UILabel *title=[UILabel new];
    //title.frame=CGRectMake(8, 6, 68, 27);
    title.text=@"银票通";
    title.textColor=CMColor(255, 134, 46);
    [bgView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.top.equalTo(bgView);
        make.left.equalTo(bgView.mas_left).offset(8);
        make.width.mas_equalTo(68);
    }];
    UILabel *right=[UILabel new];
    //right.frame=CGRectMake(98, 3, 214, 34);
    right.font=[UIFont systemFontOfSize:14.0];
    right.textAlignment=NSTextAlignmentRight;
    right.text=@"银行承兑票据资产 放心理财首选";
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
