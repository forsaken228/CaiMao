//
//  CMMiaoShaController.m
//  CaiMao
//
//  Created by Fengpj on 15/12/23.
//  Copyright © 2015年 58cm. All rights reserved.
//

#import "CMMiaoShaController.h"
#import "CMMiaoShaCell.h"
#import "CMMiaoShaList.h"
#import "CMJuHaiLiHeadView.h"

@interface CMMiaoShaController ()<UITableViewDataSource,UITableViewDelegate>
{
 
    NSArray *_zaomiaoShaList; // 喵杀惠产品列表 （早场）
    NSArray *_wanmiaoShaList; // 喵杀惠产品列表 （晚场）
    NSArray *upArr;
    NSArray *downArr;
}


@property (assign, nonatomic) BOOL isZaoChang;
@property (strong, nonatomic) UITableView *miaoShaTableView;
@property (strong, nonatomic) CMJuHaiLiHeadView *juhaiView;


@end

@implementation CMMiaoShaController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"喵杀惠";
    [self.view addSubview:self.miaoShaTableView];
    [self showDefaultProgressHUD];
    [self loadMiaoShaHuiData];
    
    self.miaoShaTableView.mj_header = [CMRefreshHeader headerWithRefreshingBlock:^{
        [self loadMiaoShaHuiData];
    }];
    // 马上进入刷新状态
  //  [self.miaoShaTableView.mj_header beginRefreshing];
   


}
-(void)setUI{
    self.miaoShaTableView.tableHeaderView = [self.juhaiView creatHeadViewWithTitle:@"喵杀惠" WithDetailTitle:@"1000元起存,最短15天" withMoringTitle:@"早场11:00开始" WithNight:@"晚场17:00开始" andDetailImage:@"details_banner_msh"];
    self.miaoShaTableView.tableFooterView=[CMBarView barFootViewWithImage:@"details_msh"];
    
    [self.juhaiView.moringBtn addTarget:self action:@selector(zaochangProduct) forControlEvents:UIControlEventTouchUpInside];
    [self.juhaiView.nightBtn addTarget:self action:@selector(wanchangProduct) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark Lazy
-(UITableView*)miaoShaTableView{
    if (!_miaoShaTableView) {
        
        _miaoShaTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        
        _miaoShaTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _miaoShaTableView.dataSource = self;
        _miaoShaTableView.delegate = self;
        _miaoShaTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
 
    }
    
    return _miaoShaTableView;

}

-(CMJuHaiLiHeadView*)juhaiView{
    if (!_juhaiView) {
            _juhaiView=[[CMJuHaiLiHeadView alloc]init];

    }
    return _juhaiView;
    
}

- (void)zaochangProduct
{
    [UIView animateWithDuration:0.3 animations:^{
         self.juhaiView.redView.frame = CGRectMake(0,  f_i5real(275)-2, CMScreenW/2.0, 2);
    }];
    self.isZaoChang = YES;
    [self.miaoShaTableView reloadData];
    [self.miaoShaTableView.mj_header endRefreshing];
}

- (void)wanchangProduct
{
    [UIView animateWithDuration:0.3 animations:^{
         self.juhaiView.redView.frame = CGRectMake(CMScreenW/2.0,  f_i5real(275)-2, CMScreenW/2.0, 2);
    }];
    self.isZaoChang = NO;
    [self.miaoShaTableView reloadData];
    [self.miaoShaTableView.mj_header endRefreshing];
}
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

- (void)loadMiaoShaHuiData
{
    if (![self checkNetWork]) {
        [self hiddenProgressHUD];
        [self.miaoShaTableView.mj_header endRefreshing];
       
    }
    [CMRequestHandle GetMiaoShaHuiProductMsgSuccess:^(id responseObj) {
        [self setUI];
        if ([[responseObj objectForKey:@"status"]intValue]==200) {
            
            [self hiddenProgressHUD];
            upArr = [[responseObj valueForKey:@"data"] valueForKey:@"uplist"];
            downArr = [[responseObj valueForKey:@"data"] valueForKey:@"downlist"];
            
            _zaomiaoShaList = [CMMiaoShaList objectArrayWithKeyValuesArray:upArr];
            _wanmiaoShaList = [CMMiaoShaList objectArrayWithKeyValuesArray:downArr];
            
            [self zaochangProduct];
        }
    } andFailure:^(id error) {
         [self.miaoShaTableView.mj_header endRefreshing];
    }];
       
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.isZaoChang == YES ? _zaomiaoShaList.count : _wanmiaoShaList.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"miaoCell";
//    CMMiaoShaCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    CMMiaoShaCell *cell =[tableView cellForRowAtIndexPath:indexPath];
    
    if (!cell) {
        cell = [[CMMiaoShaCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
//    CMJuHaiLiList *list = _juHaiLiList[indexPath.section];
    CMMiaoShaList *list = self.isZaoChang == YES ? _zaomiaoShaList[indexPath.section] : _wanmiaoShaList[indexPath.section];
    
    // 为CMDingqiCell属性赋值
    cell.miaoTitle.text = list.title;
    cell.miaoPaiShu.text = [NSString stringWithFormat:@"%d人参与",list.jbcnt];
    CGRect rect=[ cell.miaoPaiShu.text boundingRectWithSize:CGSizeMake(80, 21) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil];
    [cell.miaoPaiShu mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(rect.size.width+5);
    }];
     [NSString LoneAttributedStringEndString:@"人" FromLabel:cell.miaoPaiShu];
    cell.miaoQiSX.text=[NSString stringWithFormat:@"%.2f%%",list.nlv];
    NSAttributedString *attrStr =
    [[NSAttributedString alloc]initWithString:cell.miaoQiSX.text
                                   attributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:11.0f],
       NSForegroundColorAttributeName:[UIColor lightGrayColor],
       NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),
       NSStrikethroughColorAttributeName:[UIColor lightGrayColor]}];
    
    cell.miaoQiSX.attributedText = attrStr;
    

    // 设置年收益
    float shouyi = list.nlv_max;
    int x = (int)shouyi;
    cell.miaoShouZheng.text = [NSString stringWithFormat:@"%.0f",floorf(shouyi)];
    if ((shouyi-(float)x)*100 == 0) {
        cell.miaoShouXiao.text = [[NSString stringWithFormat:@".00"] stringByAppendingString:@"%"];
    } else {
        cell.miaoShouXiao.text = [[NSString stringWithFormat:@".%.f",(shouyi-(float)x)*100] stringByAppendingString:@"%"];
    }
    if (x<10) {
        [cell.miaoShouZheng mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@25);
        }];
    }
    // 设置期限

    if (list.jkqx_dw == 1) {    // 期限->天
  
        cell.miaoQiXian.text = [NSString stringWithFormat:@"期限%d天",list.jkqx];
        [NSString DoubleStringChangeColer:cell.miaoQiXian andFromStr:@"限" ToStr:@"天" withColor:RedButtonColor];
        
    } else if (list.jkqx_dw == 2) { // 期限->月
         cell.miaoQiXian.text = [NSString stringWithFormat:@"期限%d个月",list.jkqx];
         [NSString DoubleStringChangeColer:cell.miaoQiXian andFromStr:@"限" ToStr:@"个" withColor:RedButtonColor];
        
    } else {                            // 期限->年
        cell.miaoQiXian.text = [NSString stringWithFormat:@"期限%d年",list.jkqx];
         [NSString DoubleStringChangeColer:cell.miaoQiXian andFromStr:@"限" ToStr:@"年" withColor:RedButtonColor];
    }
    
    // 设置起投金额

    cell.miaoQiTou.text = [NSString stringWithFormat:@"%d元/份",list.cpfe];
    [NSString LoneAttributedStringEndString:@"元" FromLabel:cell.miaoQiTou];
    
    // 设置百分比
    float PercentNum = [[NSString stringWithFormat:@"%.2f",(float)list.jbfs / list.zjfs] floatValue];
    [cell.miaoPercentView setPercent:PercentNum * 100 animated:YES];
    
    cell.miaoJoin.tag = indexPath.section;
    [cell.miaoJoin addTarget:self action:@selector(miaoJoinBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 设置产品倒计时
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    
    NSDate *dqDate = [dateFormatter dateFromString:list.dqtime]; // 格式化到期时间
    
    NSString *dateNowstr = [dateFormatter stringFromDate:[NSDate date]];
    NSDate *dateNow = [dateFormatter dateFromString:dateNowstr]; // 格式化当前时间
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"yyyy/MM/dd"]; // 当前日期：年月日
    NSString *dateStr = [dateFormatter2 stringFromDate:[NSDate date]];
    
    // 早场、晚场开始时间
    NSString *zaoTimeStr = [dateStr stringByAppendingString:@" 11:00:00"];
    NSDate *zaoStartDate = [dateFormatter dateFromString:zaoTimeStr];
    NSString *wanTimeStr = [dateStr stringByAppendingString:@" 17:00:00"];
    NSDate *wanStartDate = [dateFormatter dateFromString:wanTimeStr];
    
  //  NSTimeInterval time = [dqDate timeIntervalSinceDate:dateNow]; // 比较时间差
    
    // 当前时间 ---> 早场即将开始 的时间差
    NSTimeInterval zaoTimeInterval = [zaoStartDate timeIntervalSinceDate:dateNow];
    // 早场开始后 ---> 结束 时间差
   // NSTimeInterval zaoKaiToEndInterval = [dqDate timeIntervalSinceDate:dateNow];
    
    // 当前时间 ---> 晚场即将开始 的时间差
    NSTimeInterval wanTimeInterval = [wanStartDate timeIntervalSinceDate:dateNow];
    // 晚场开始后 ---> 结束 时间差
    NSTimeInterval wanKaiToEndInterval = [dqDate timeIntervalSinceDate:dateNow];
    
    __block int timeout ; // 倒计时时间
    
    if (zaoTimeInterval < 0 && wanTimeInterval > 0) {
        timeout = wanTimeInterval;
    } else if (zaoTimeInterval > 0) {
        timeout = self.isZaoChang == YES ? zaoTimeInterval : wanTimeInterval;
    } else if (wanTimeInterval < 0) {
        timeout = self.isZaoChang == YES ? 0 :wanKaiToEndInterval;
    }
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); // 每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        
        // list.zjfs * 10 - 1 <= list.jbfs 表示产品拍完 结束竞拍
        if(timeout <= 0 || list.zjfs <= list.jbfs){ // 倒计时结束，关闭
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // 设置界面的按钮显示
                cell.miaoTime.text = @"00:00:00";
                [cell.miaoJoin setTitle:@"已结束" forState:UIControlStateNormal];
              [cell.miaoJoin setBackgroundColor:[UIColor lightGrayColor]];
                cell.miaoJoin.userInteractionEnabled = NO;
            });
        } else {
            int hour = timeout / 3600;
            int minutes = (timeout % 3600) / 60;
            int seconds = timeout % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                // 设置界面的按钮显示
                cell.miaoTime.text = [NSString stringWithFormat:@"%02d:%02d:%02d",hour,minutes,seconds];
                
                if (zaoTimeInterval < 0 && wanTimeInterval > 0) {
                    if (self.isZaoChang) {
                        [cell.miaoJoin setTitle:@"立即竞拍" forState:UIControlStateNormal];
                        [cell.miaoJoin setBackgroundColor:RedButtonColor];
                         cell.miaoJoin.userInteractionEnabled=YES;
                        
                    } else {
                        [cell.miaoJoin setTitle:@"即将开始" forState:UIControlStateNormal];
                        [cell.miaoJoin setBackgroundColor:CMColor(0, 175, 77)];
                        cell.miaoJoin.userInteractionEnabled=NO;
                    }
                } else if (zaoTimeInterval > 0) {
                    [cell.miaoJoin setTitle:@"即将开始" forState:UIControlStateNormal];
                    [cell.miaoJoin setBackgroundColor:CMColor(0, 175, 77)];
                    cell.miaoJoin.userInteractionEnabled=NO;
                } else if (wanTimeInterval < 0) {
                    
                    if (self.isZaoChang) {
                        [cell.miaoJoin setTitle:@"已结束" forState:UIControlStateNormal];
                        [cell.miaoJoin setBackgroundColor:[UIColor lightGrayColor]];
                        cell.miaoJoin.userInteractionEnabled=NO;
                    } else {
                        [cell.miaoJoin setTitle:@"立即竞拍" forState:UIControlStateNormal];
                        [cell.miaoJoin setBackgroundColor:RedButtonColor];
                         cell.miaoJoin.userInteractionEnabled=YES;
                    }
                }
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

    CMLiCaiDetailController *vc=[[CMLiCaiDetailController alloc]init];
    vc.productListArr=self.isZaoChang == YES ? upArr[indexPath.section] : downArr[indexPath.section];
    vc.isZao=self.isZaoChang;
    vc.isMiaosha=YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)miaoJoinBtnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;

    CMPayViewController *vc=[[CMPayViewController alloc]init];
    vc.ProuctListDict=self.isZaoChang == YES ? [upArr objectAtIndex:btn.tag] : [downArr objectAtIndex:btn.tag];
    vc.countNum=1;
    [self.navigationController pushViewController:vc animated:YES];
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }
    return 0.05;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

checkNet

@end
