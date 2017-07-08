//
//  CMJuHaiLiController.m
//  CaiMao
//
//  Created by Fengpj on 15/12/22.
//  Copyright © 2015年 58cm. All rights reserved.
//

#import "CMJuHaiLiController.h"
//#import "MJExtension.h"
//#import "MJRefresh.h"

#import "CMJuHaiLiList.h"
#import "CMJuHaiLiCell.h"
#import "CMJuHaiLiHeadView.h"

@interface CMJuHaiLiController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    NSArray *_zaojuHaiLiList; // 聚嗨利产品列表 （早场）
    NSArray *_wanjuHaiLiList; // 聚嗨利产品列表 （晚场）
    
    NSMutableAttributedString *_subTitStr; // 投资期限字符串
    NSArray *upArr;
    NSArray *downArr;
    
//    __block int timeout; // 倒计时时间
    
}


@property (assign, nonatomic) BOOL isZaoChang;
@property(strong,nonatomic)UITableView *juhaiTableView;
@property(strong,nonatomic)CMJuHaiLiHeadView *juhaiView;


@end

@implementation CMJuHaiLiController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"聚嗨利";
    
    [self.view addSubview:self.juhaiTableView];
    [self showDefaultProgressHUD];
    [self loadJuHaiLiData];
    self.juhaiTableView.mj_header = [CMRefreshHeader headerWithRefreshingBlock:^{
        [self loadJuHaiLiData];
        
    }];
    // 马上进入刷新状态
    //[ self.juhaiTableView.mj_header beginRefreshing];

}
-(void)setUi{
    
    self.juhaiTableView.tableHeaderView = [self.juhaiView creatHeadViewWithTitle:@"聚嗨利" WithDetailTitle:@"200元起存,一起嗨翻天" withMoringTitle:@"早场9:00开始" WithNight:@"晚场18:00开始"andDetailImage:@"details_banner_jhl"];
    [self.juhaiView.moringBtn addTarget:self action:@selector(zaochangProduct) forControlEvents:UIControlEventTouchUpInside];
    [self.juhaiView.nightBtn addTarget:self action:@selector(wanchangProduct) forControlEvents:UIControlEventTouchUpInside];
    
    self.juhaiTableView.tableFooterView=[CMBarView barFootViewWithImage:@"details_jhl"];
   

}

#pragma mark Lazy
-(UITableView*)juhaiTableView{
    if (!_juhaiTableView) {
        
        _juhaiTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        
        _juhaiTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _juhaiTableView.dataSource = self;
        _juhaiTableView.delegate = self;
        _juhaiTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
       
       
    }
    
    return _juhaiTableView;
    
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
  
    
        self.juhaiView.redView.frame=CGRectMake(0, f_i5real(275)-2, CMScreenW/2.0, 2);

    }];
    
    self.isZaoChang = YES;
    [self.juhaiTableView reloadData];
    [self.juhaiTableView.mj_header endRefreshing];
}
- (void)wanchangProduct
{

    [UIView animateWithDuration:0.3 animations:^{
       
     self.juhaiView.redView.frame=CGRectMake(CMScreenW/2.0, f_i5real(275)-2, CMScreenW/2.0, 2);
    }];
    
    
    
    self.isZaoChang = NO;
    [self.juhaiTableView reloadData];

    [self.juhaiTableView.mj_header endRefreshing];
}

- (void)loadJuHaiLiData
{
    if (![self checkNetWork]) {
        [self.juhaiTableView.mj_header endRefreshing];
        
    }
    [CMRequestHandle GetJuHaiLiProductMsgSuccess:^(id responseObj) {
        
        [self setUi];
        
        if ([[responseObj objectForKey:@"status"]intValue]==200) {
            upArr = [[responseObj valueForKey:@"data"] valueForKey:@"uplist"];
            downArr = [[responseObj valueForKey:@"data"] valueForKey:@"downlist"];
            
            _zaojuHaiLiList = [CMJuHaiLiList objectArrayWithKeyValuesArray:upArr];
            _wanjuHaiLiList = [CMJuHaiLiList objectArrayWithKeyValuesArray:downArr];
            
            [self hiddenProgressHUD];
            [self zaochangProduct];
        }
    }andFailure:^(id error) {
        [self.juhaiTableView.mj_header endRefreshing];
  
    }];
    }

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.isZaoChang == YES ? _zaojuHaiLiList.count : _wanjuHaiLiList.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"juCell";
   // CMJuHaiLiCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    CMJuHaiLiCell *cell = [tableView  cellForRowAtIndexPath:indexPath];
    
    if (!cell) {
        cell = [[CMJuHaiLiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
//    CMJuHaiLiList *list = _juHaiLiList[indexPath.section];
    CMJuHaiLiList *list = self.isZaoChang == YES ? _zaojuHaiLiList[indexPath.section] : _wanjuHaiLiList[indexPath.section];
    
    // 为CMJuHaiLiCell属性赋值
    cell.juTitle.text = list.title;
    cell.juPaiShu.text = [NSString stringWithFormat:@"%d人参与",list.jpRenShu];
    CGRect rect=[  cell.juPaiShu.text boundingRectWithSize:CGSizeMake(80, 13) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil];
    [ cell.juPaiShu mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(rect.size.width+5);
    }];
  [NSString LoneAttributedStringEndString:@"人" FromLabel:cell.juPaiShu];
    // 设置年收益
    float shouyi = list.nlv_max;
    int x = (int)shouyi;
    cell.juShouZheng.text = [NSString stringWithFormat:@"%.0f",floorf(shouyi)];
    if ((shouyi-(float)x)*100 == 0) {
        cell.juShouXiao.text = [[NSString stringWithFormat:@".00"] stringByAppendingString:@"%"];
    } else {
        cell.juShouXiao.text = [[NSString stringWithFormat:@".%.f",(shouyi-(float)x)*100] stringByAppendingString:@"%"];
    }
    
    // 设置期限

    if (list.jkqx_dw == 1) {    // 期限->天
         cell.juQixian.text = [NSString stringWithFormat:@"期限%d天",list.jkqx];
         [NSString DoubleStringChangeColer:cell.juQixian andFromStr:@"限" ToStr:@"天" withColor:RedButtonColor];
        
    } else if (list.jkqx_dw == 2) { // 期限->月
        cell.juQixian.text = [NSString stringWithFormat:@"期限%d个月",list.jkqx];
        [NSString DoubleStringChangeColer:cell.juQixian andFromStr:@"限" ToStr:@"个" withColor:RedButtonColor];
        
    } else {                            // 期限->年
        cell.juQixian.text = [NSString stringWithFormat:@"期限%d年",list.jkqx];
      [NSString DoubleStringChangeColer:cell.juQixian andFromStr:@"限" ToStr:@"年" withColor:RedButtonColor];
    }
    
    // 设置起投金额
  
    cell.juQitou.text = [NSString stringWithFormat:@"%d元/份",list.cpfe];
    [NSString  LoneAttributedStringEndString:@"元" FromLabel:cell.juQitou];
    // 设置百分比
    float PercentNum = [[NSString stringWithFormat:@"%.2f",(float)list.jbfs / list.zjfs] floatValue];
    [cell.juPercentView setPercent:PercentNum * 100 animated:YES];
    
    cell.juPaiBtn.tag = indexPath.section;
    [cell.juPaiBtn addTarget:self action:@selector(juPaiBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 起始收益率
    cell.juQiShilv.text = [[[list.ShouYiLv objectAtIndex:0] valueForKey:@"syl"] stringByAppendingString:@"%↑"];
    
    // 设置各个阶段的收益率和人数 和 显示效果
    cell.juShou1.text = [[[list.ShouYiLv objectAtIndex:0] valueForKey:@"syl"] stringByAppendingString:@"%"];
    cell.juRen1.text = [[[list.ShouYiLv objectAtIndex:0] valueForKey:@"ICount"]stringByAppendingString:@"人"];
    cell.juShou2.text = [[[list.ShouYiLv objectAtIndex:1] valueForKey:@"syl"] stringByAppendingString:@"%"];
    cell.juRen2.text = [[[list.ShouYiLv objectAtIndex:1] valueForKey:@"ICount"]stringByAppendingString:@"人"];
    cell.juShou3.text = [[[list.ShouYiLv objectAtIndex:2] valueForKey:@"syl"] stringByAppendingString:@"%"];
    cell.juRen3.text = [[[list.ShouYiLv objectAtIndex:2] valueForKey:@"ICount"] stringByAppendingString:@"人"];
    cell.juShou4.text = [[[list.ShouYiLv objectAtIndex:3] valueForKey:@"syl"] stringByAppendingString:@"%"];
    cell.juRen4.text = [[[list.ShouYiLv objectAtIndex:3] valueForKey:@"ICount"] stringByAppendingString:@"人"];
    
   // NSInteger renshu1;
    NSInteger renshu2;
    NSInteger renshu3;
    NSInteger renshu4;
   // renshu1 = [[[list.ShouYiLv objectAtIndex:0] valueForKey:@"ICount"] integerValue];
    renshu2 = [[[list.ShouYiLv objectAtIndex:1] valueForKey:@"ICount"] integerValue];
    renshu3 = [[[list.ShouYiLv objectAtIndex:2] valueForKey:@"ICount"] integerValue];
    renshu4 = [[[list.ShouYiLv objectAtIndex:3] valueForKey:@"ICount"] integerValue];

    if ( 0 <= list.jpRenShu && list.jpRenShu < renshu2) {
        cell.juShou1.textColor = RedButtonColor;
        cell.juRen1.textColor = RedButtonColor;
        cell.juImage1.image = [UIImage imageNamed:@"jhl_product_yuanquan_fill"];
        
    } else if ( renshu2 <= list.jpRenShu && list.jpRenShu < renshu3) {
        cell.juShou2.textColor = RedButtonColor;
        cell.juRen2.textColor = RedButtonColor;
        cell.juImage2.image = [UIImage imageNamed:@"jhl_product_yuanquan_fill"];
    } else if ( renshu3 <= list.jpRenShu && list.jpRenShu < renshu4 ){
        cell.juShou3.textColor = RedButtonColor;
        cell.juRen3.textColor = RedButtonColor;
        cell.juImage3.image = [UIImage imageNamed:@"jhl_product_yuanquan_fill"];
    } else {
        cell.juShou4.textColor = RedButtonColor;
        cell.juRen4.textColor = RedButtonColor;
        cell.juImage4.image = [UIImage imageNamed:@"jhl_product_yuanquan_fill"];
    }
    
    // 设置子标题 -- 嗨到顶了，一起来嗨吧
   // NSString *subStr = [NSString string];
    static NSString *subStr;

    if  (0 <= list.jpRenShu && list.jpRenShu < renshu2) {
        
        subStr = [NSString stringWithFormat:@"差%ld人嗨至%@",renshu2 - list.jpRenShu,cell.juShou2.text];
        _subTitStr = [[NSMutableAttributedString alloc] initWithString:subStr];
        
        NSRange rFromRang = [subStr rangeOfString:@"差"];
        NSRange rToRang = [subStr rangeOfString:@"人"];
        NSRange zFromRang = [subStr rangeOfString:@"至"];
        NSRange zToRang = [subStr rangeOfString:@"%"];
        [_subTitStr addAttribute:NSForegroundColorAttributeName value:RedButtonColor range:NSMakeRange(rFromRang.location + 1, rToRang.location - rFromRang.location - 1)];
        [_subTitStr addAttribute:NSForegroundColorAttributeName value:RedButtonColor range:NSMakeRange(zFromRang.location + 1, zToRang.location - zFromRang.location)];
        
        cell.juSubTitle.attributedText = _subTitStr;
        
    } else if (renshu2 <= list.jpRenShu && list.jpRenShu < renshu3) {
        
        subStr = [NSString stringWithFormat:@"差%ld人嗨至%@",renshu3 - list.jpRenShu,cell.juShou3.text];
        _subTitStr = [[NSMutableAttributedString alloc] initWithString:subStr];
        
        NSRange rFromRang = [subStr rangeOfString:@"差"];
        NSRange rToRang = [subStr rangeOfString:@"人"];
        NSRange zFromRang = [subStr rangeOfString:@"至"];
        NSRange zToRang = [subStr rangeOfString:@"%"];
        [_subTitStr addAttribute:NSForegroundColorAttributeName value:RedButtonColor range:NSMakeRange(rFromRang.location + 1, rToRang.location - rFromRang.location - 1)];
        [_subTitStr addAttribute:NSForegroundColorAttributeName value:RedButtonColor range:NSMakeRange(zFromRang.location + 1, zToRang.location - zFromRang.location)];
        
        cell.juSubTitle.attributedText = _subTitStr;
        
    } else if (renshu3 <= list.jpRenShu && list.jpRenShu < renshu4) {
        
        subStr = [NSString stringWithFormat:@"差%ld人嗨至%@",renshu4 - list.jpRenShu,cell.juShou4.text];
        
        _subTitStr = [[NSMutableAttributedString alloc] initWithString:subStr];
        
        NSRange rFromRang = [subStr rangeOfString:@"差"];
        NSRange rToRang = [subStr rangeOfString:@"人"];
        NSRange zFromRang = [subStr rangeOfString:@"至"];
        NSRange zToRang = [subStr rangeOfString:@"%"];
        [_subTitStr addAttribute:NSForegroundColorAttributeName value:RedButtonColor range:NSMakeRange(rFromRang.location + 1, rToRang.location - rFromRang.location - 1)];
        [_subTitStr addAttribute:NSForegroundColorAttributeName value:RedButtonColor range:NSMakeRange(zFromRang.location + 1, zToRang.location - zFromRang.location)];
        
        cell.juSubTitle.attributedText = _subTitStr;
        
    } else {
        
        subStr = @"嗨到顶了,一起来嗨吧!";
        cell.juSubTitle.text = subStr;

        [NSString DoubleStringChangeColer:cell.juSubTitle andFromStr:@"到" ToStr:@"了" withColor:RedButtonColor];
    }
    
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
    NSString *zaoTimeStr = [dateStr stringByAppendingString:@" 09:00:00"];
    NSDate *zaoStartDate = [dateFormatter dateFromString:zaoTimeStr];
    NSString *wanTimeStr = [dateStr stringByAppendingString:@" 18:00:00"];
    NSDate *wanStartDate = [dateFormatter dateFromString:wanTimeStr];
    
    //NSTimeInterval time = [dqDate timeIntervalSinceDate:dateNow]; // 比较时间差
    
    // 当前时间 ---> 早场即将开始 的时间差
    NSTimeInterval zaoTimeInterval = [zaoStartDate timeIntervalSinceDate:dateNow];
    // 早场开始后 ---> 结束 时间差
    //NSTimeInterval zaoKaiToEndInterval = [dqDate timeIntervalSinceDate:dateNow];
    
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
        if(timeout <= 0 || list.zjfs * 10 - 1 <= list.jbfs){ // 倒计时结束，关闭
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // 设置界面的按钮显示
                cell.juPaiBtn.userInteractionEnabled = NO;
                cell.juJiShi.text = @"00:00:00";
                [cell.juPaiBtn setTitle:@"已结束" forState:UIControlStateNormal];
                [cell.juPaiBtn setBackgroundColor:[UIColor lightGrayColor]];
                
            });
        } else {
            int hour = timeout / 3600;
            int minutes = (timeout % 3600) / 60;
            int seconds = timeout % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                // 设置界面的按钮显示
                cell.juJiShi.text = [NSString stringWithFormat:@"%02d:%02d:%02d",hour,minutes,seconds];
                
                if (zaoTimeInterval <0 && wanTimeInterval >0) {
                    if (self.isZaoChang) {
                        cell.juPaiBtn.userInteractionEnabled=YES;
                        [cell.juPaiBtn setTitle:@"立即竞拍" forState:UIControlStateNormal];
                        [cell.juPaiBtn setBackgroundColor:RedButtonColor];
                        
                    } else {
                        cell.juPaiBtn.userInteractionEnabled = NO;
                        [cell.juPaiBtn setTitle:@"即将开始" forState:UIControlStateNormal];
                        [cell.juPaiBtn setBackgroundColor:CMColor(0, 175, 77)];
                        cell.juSubTitle.text=@"准备好一起把收益嗨到顶";
                        
                    }
                } else if (zaoTimeInterval > 0) {
                    cell.juPaiBtn.userInteractionEnabled = NO;
                    [cell.juPaiBtn setTitle:@"即将开始" forState:UIControlStateNormal];
                     cell.juSubTitle.text=@"准备好一起把收益嗨到顶";
                    [cell.juPaiBtn setBackgroundColor:CMColor(0, 175, 77)];
                    
                } else if (wanTimeInterval < 0) {
                    
                    if (self.isZaoChang) {
                            cell.juPaiBtn.userInteractionEnabled = NO;
                        [cell.juPaiBtn setTitle:@"已结束" forState:UIControlStateNormal];
                        [cell.juPaiBtn setBackgroundColor:[UIColor lightGrayColor]];
                    
                    } else {
                        cell.juPaiBtn.userInteractionEnabled=YES;
                        [cell.juPaiBtn setTitle:@"立即竞拍" forState:UIControlStateNormal];
                        [cell.juPaiBtn setBackgroundColor:RedButtonColor];
                        
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
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (void)juPaiBtnClick:(id)sender
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
    return 235;
}



checkNet

@end
