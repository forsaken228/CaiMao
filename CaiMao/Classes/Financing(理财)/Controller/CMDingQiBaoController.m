//
//  CMDingQiBaoController.m
//  CaiMao
//
//  Created by Fengpj on 15/11/23.
//  Copyright © 2015年 58cm. All rights reserved.
//

#import "CMDingQiBaoController.h"
#import "CMPayViewController.h"
@interface CMDingQiBaoController ()<UITableViewDataSource,UITableViewDelegate>
{
    //NSMutableAttributedString *_qixianStr; // 投资期限字符串
    NSArray *dingArr ;
}
@property(nonatomic,strong)UITableView *dingqiTableView;
@property(nonatomic,strong)NSArray *dingQiBaoList;
@end

@implementation CMDingQiBaoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"定期宝";
    self.view.backgroundColor=ViewBackColor;
    [self.view addSubview:self.dingqiTableView];
    [self showDefaultProgressHUD];
     [self loadDingQiBaoData];
    self.dingqiTableView.mj_header = [CMRefreshHeader headerWithRefreshingBlock:^{

        [self loadDingQiBaoData];
       
    }];
  
    // 马上进入刷新状态
  //  [self.dingqiTableView.mj_header beginRefreshing];
}
#pragma mark lazy
-(UITableView*)dingqiTableView{
    if (!_dingqiTableView) {

        
        _dingqiTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CMScreenW, CMScreenH-149) style:UITableViewStyleGrouped];
        _dingqiTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _dingqiTableView.dataSource = self;
        _dingqiTableView.delegate = self;
        
        _dingqiTableView.showsVerticalScrollIndicator=NO;
        _dingqiTableView.showsHorizontalScrollIndicator=NO;
        
        
    }
    return _dingqiTableView;
    
}

-(NSArray*)dingQiBaoList{
    if (!_dingQiBaoList) {
        _dingQiBaoList=[NSArray array];
    }
    return _dingQiBaoList;
    
}

- (void)loadDingQiBaoData
{
    if (![self checkNetWork]) {
           [self hiddenProgressHUD];
        [self.dingqiTableView.mj_header endRefreshing];
    }
    [CMRequestHandle GetDingQiBaoProductMsgSuccess:^(id responseObj) {
        [self hiddenProgressHUD];
        dingArr = [[responseObj  valueForKey:@"data"] valueForKey:@"list"];
        // NSLog(@"ding===%@",responseObj);
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
    return  self.dingQiBaoList.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"dingqiCell";
//    CMDingqiCell *dingCell = [tableView dequeueReusableCellWithIdentifier:cellID];
     CMDingqiCell *dingCell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (!dingCell) {
        dingCell = [[CMDingqiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    CMDingQiBaoList *list = _dingQiBaoList[indexPath.section];
    
    // 为CMDingqiCell属性赋值
    dingCell.dingqiTitle.text = list.title;
    dingCell.dingCanyu.text = [NSString stringWithFormat:@"%d人参与",list.jbcnt];
    CGRect rect=[ dingCell.dingCanyu.text boundingRectWithSize:CGSizeMake(80, 13) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil];
    [dingCell.dingCanyu mas_updateConstraints:^(MASConstraintMaker *make) {
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
    if (x==8) {
        [dingCell.dingZhengshu mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@25);
        }];
    }
    // 设置期限
   // NSString *qiStr = [NSString string];
    static NSString *qiStr;
    if (list.jkqx_dw == 1) {    // 期限->天
qiStr = [NSString stringWithFormat:@"期限%d天",list.jkqx];
//        _qixianStr = [[NSMutableAttributedString alloc] initWithString:qiStr];
//        NSRange qiFromRang = [qiStr rangeOfString:@"限"];
//        NSRange qiToRang = [qiStr rangeOfString:@"天"];
//        [_qixianStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(qiFromRang.location + 1, qiToRang.location - qiFromRang.location - 1)];
//        
        dingCell.dingQixian.text = qiStr;
        [NSString DoubleStringChangeColer:dingCell.dingQixian andFromStr:@"限" ToStr:@"天" withColor:RedButtonColor];
        
    } else if (list.jkqx_dw == 2) { // 期限->月
        qiStr = [NSString stringWithFormat:@"期限%d个月",list.jkqx];
        dingCell.dingQixian.text = qiStr;
        [NSString DoubleStringChangeColer:dingCell.dingQixian andFromStr:@"限" ToStr:@"个" withColor:RedButtonColor];
        
    } else {                            // 期限->年
        qiStr = [NSString stringWithFormat:@"期限%d年",list.jkqx];
        dingCell.dingQixian.text = qiStr;
        [NSString DoubleStringChangeColer:dingCell.dingQixian andFromStr:@"限" ToStr:@"年" withColor:RedButtonColor];
    }
    
    // 设置起投金额
    //NSString *qiTouStr = [NSString string];
    NSString *qiTouStr = [NSString stringWithFormat:@"%d元起",list.cpfe];
    dingCell.dingQitou.text = qiTouStr;
    [NSString LoneAttributedStringEndString:@"元" FromLabel:dingCell.dingQitou];
    
    
    // 设置百分比
    float PercentNum = [[NSString stringWithFormat:@"%f",(float)list.jbfs / list.zjfs] floatValue];
//    DLog(@"PercentNum---%d--%f---%f",, PercentNum, floor(PercentNum*100) / 100 );
    [dingCell.dingPercentView setPercent:PercentNum * 100 animated:YES];
    
    dingCell.dingJoinBtn.tag = indexPath.section;
    [dingCell.dingJoinBtn setBackgroundColor:RedButtonColor];
    [dingCell.dingJoinBtn addTarget:self action:@selector(dingJoinBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    dingCell.dingJoinBtn.userInteractionEnabled = YES;
    
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
   [tableView deselectRowAtIndexPath:indexPath animated:NO];
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
//-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    if (section==0) {
//        UILabel *label=[[UILabel alloc]init];
//        label.backgroundColor=UIColorFromRGB(0xcecece);
//        
//        label.text=@"每个工作日9:30发布新产品";
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
