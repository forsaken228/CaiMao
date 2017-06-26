//
//  CMZhuanChuSecondController.m
//  CaiMao
//
//  Created by MAC on 16/11/11.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMZhuanChuSecondController.h"
#import "CMZhuanChuConfirmCell.h"
@interface CMZhuanChuSecondController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *MyTableView;
@property(nonatomic,strong)NSArray *DataSourceArr;
@end

@implementation CMZhuanChuSecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=ViewBackColor;
    self.title=@"财富宝转出确认";
    self.MyTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.MyTableView];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"转出说明" style:UIBarButtonItemStylePlain target:self action:@selector(zhuanchuShuoMing)];
    [self creatFootViewAndHeadView];
    
   //  DLog(@"%@++++++",self.DataDict);
    
    self.DataSourceArr=[self.DataDict objectForKey:@"list"];
    
    
}
-(void)zhuanchuShuoMing{
    
   
    CMZhuanChuShuoMing *vc=[[CMZhuanChuShuoMing alloc]init];
    [vc ShowAlert];
    
}
-(void)creatFootViewAndHeadView{
    
    CMZhuanChuConfirmHeadView *top=[[CMZhuanChuConfirmHeadView alloc]init];
    top.frame=CGRectMake(0, 0, CMScreenW, 140);
    top.ZhuanJinEr.text=[NSString stringWithFormat:@"%@元",[self.DataDict objectForKey:@"ZhuanChuAmount"]];
    [self LoneAttributedStringFromString:@"元" FromLabel: top.ZhuanJinEr];
    
    top.ShouYi.text=[NSString stringWithFormat:@"%@元",[self.DataDict objectForKey:@"shouyi"]];
    [self LoneAttributedStringFromString:@"元" FromLabel: top.ShouYi];
    self.MyTableView.tableHeaderView=top;
    CMZhuanChuFootView *footView=[[CMZhuanChuFootView alloc]initWithButtonTitle:@"确认转出"];
    [footView.DetailLabel removeFromSuperview];
    footView.frame=CGRectMake(0, 0, CMScreenW, 300);
    [footView.ZhuangChuBtn addTarget:self action:@selector(ZhuangChuBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.MyTableView.tableFooterView=footView;
    
}
-(void)ZhuangChuBtnAction{
    
   
    
    
    [CMRequestHandle CaiFuBaoZhuanChuSuccessWithAmount:[self.DataDict objectForKey:@"ZhuanChuAmount"] andItemS:[self.DataDict objectForKey:@"items"] WithSuccess:^(id responseObj) {
        
      
        
        if ([[responseObj objectForKey:@"Status"]intValue]==200) {
            CMZhuanChuSuccessViewController *vc=[[CMZhuanChuSuccessViewController alloc]init];
            vc.amount=[self.DataDict objectForKey:@"ZhuanChuAmount"];
            [self.navigationController pushViewController:vc animated:NO];
        }
        
        
    } andFailure:^(id error) {
        
    }];
}

#pragma mark Lazy
-(UITableView*)MyTableView{
    if (!_MyTableView) {
        _MyTableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _MyTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _MyTableView.dataSource=self;
        _MyTableView.delegate=self;
    }
    
    return _MyTableView;
}
-(NSArray*)DataSourceArr{
    if (!_DataSourceArr) {
        _DataSourceArr=[NSArray array];
    }
    return _DataSourceArr;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.DataSourceArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *Tcell=@"indexPath";
    CMZhuanChuConfirmCell *cell=[tableView dequeueReusableCellWithIdentifier:Tcell];
    if (!cell) {
        cell=[[CMZhuanChuConfirmCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Tcell];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    NSDictionary *dict=self.DataSourceArr[indexPath.section];
    cell.amount.text=[NSString stringWithFormat:@"金额:%@元",[dict objectForKey:@"amount"]];
   [NSString DoubleStringChangeColer:cell.amount andFromStr:@":" ToStr:@"元" withColor:RedButtonColor];
    cell.Zdate.text=[NSString stringWithFormat:@"转入时间:%@",[dict objectForKey:@"indate"]];
      NSString  *str=[NSString stringWithFormat:@"%@",[dict objectForKey:@"startdate"]];
    cell.JXBegindate.text=[NSString stringWithFormat:@"计息开始日期:%@",str];
  
    [NSString  loneStringChangeColer:cell.JXBegindate andFromStr:@":" withString:str WithColor:RedButtonColor];
    NSString *dateone=[NSString stringWithFormat:@"%@",[dict objectForKey:@"days"]];
    cell.JXTotalDate.text=[NSString stringWithFormat:@"计息天数:%@天",dateone];
    
   [NSString loneStringChangeColer:cell.JXTotalDate andFromStr:@":" withString:dateone WithColor:RedButtonColor];
    NSString *shou=[NSString stringWithFormat:@"%@%%",[dict objectForKey:@"rate"]];
    cell.SJShouYi.text=[NSString stringWithFormat:@"实际收益率:%@",shou];
   [NSString  loneStringChangeColer:cell.SJShouYi andFromStr:@":" withString:shou WithColor:RedButtonColor];
     cell.ZZShouYi.text=[NSString stringWithFormat:@"最终受益:%@元",[dict objectForKey:@"income"]];
     [NSString DoubleStringChangeColer:cell.ZZShouYi andFromStr:@":" ToStr:@"元" withColor:RedButtonColor];
       cell.BeiZhu.text=[NSString stringWithFormat:@"备注:%@",[dict objectForKey:@"context"]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

-(void)LoneAttributedStringFromString:(NSString*)FromStr FromLabel:(UILabel*)FromLabel{
    
    NSMutableAttributedString *qixianStr = [[NSMutableAttributedString alloc] initWithString:FromLabel.text];
    
    NSRange qiToRang = [FromLabel.text rangeOfString:FromStr];
    [qixianStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x4d4d4d) range:NSMakeRange(qiToRang.location, 1)];
    
    FromLabel.attributedText = qixianStr;
    
}


@end
