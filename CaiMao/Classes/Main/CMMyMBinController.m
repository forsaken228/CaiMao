//
//  CMMyMBinController.m
//  CaiMao
//
//  Created by MAC on 16/10/27.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMMyMBinController.h"

@interface CMMyMBinController ()
{
    CMRecordBgView  *rbgView;
}
@property(nonatomic,strong)CMMBin *myBin;
@end

@implementation CMMyMBinController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的M币";
    self.view.backgroundColor=ViewBackColor;
    [self LoadData];
    self.tableView.mj_header=[CMRefreshHeader headerWithRefreshingBlock:^{
        [self LoadData];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self requestMyMBiDetail];
    }];

    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView=self.myBin;
}
-(void)LoadData{
    
    self.pageIndex=1;
    [self requestMyMBiDetail];
}

-(CMMBin*)myBin{
    if (!_myBin) {
        UIImage *image=[UIImage imageNamed:@"zh_wdmb_beijing"];
        _myBin=[[CMMBin alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, f_i5real(image.size.height)+f_i5real(45))];
        [_myBin.getMBin.MyIntegralBtn addTarget:self action:@selector(getMBinOrTouZi:)];
        [_myBin.GoTouZi.MyIntegralBtn addTarget:self action:@selector(getMBinOrTouZi:)];
    }
    return _myBin;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (self.MyMBArr.count<=0||[self.MyMBArr isKindOfClass:[NSNull class]]) {
        rbgView=[[CMRecordBgView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 200)];
        [rbgView creatHeadImage:@"wdjf_dhjl_icon" andTitle:@"暂无记录 哦~"];
        self.tableView.tableFooterView=rbgView;
    }else{
        [rbgView cleanNsstring];
        self.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 120)];
    }
}


-(void)getMBinOrTouZi:(UIGestureRecognizer*)gesture
{
    switch (gesture.view.tag) {
        case 10:{
            CMProductDetailController *productVc = [[CMProductDetailController alloc] init];
         
            productVc.urlStr =@"http://m.58cm.com/activity/fjhd/ification-pro.aspx";
            CMPush(productVc);
           
        }
            break;
        case 11:{

            CMLiCaiViewController *lici=[[CMLiCaiViewController alloc]init];
            [self.navigationController pushViewController:lici animated:YES];
        }
            break;
            
            
        default:
            break;
    }
    
}
//-(void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//    NSMutableArray  *arr=[[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
//    for (UIViewController *vc in arr) {
//        if ([vc isKindOfClass:[self class]]) {
//            
//            [arr removeObject:vc];
//            break;
//        }
//        
//    }
//    self.navigationController.viewControllers=arr;
//
//}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.MyMBArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(self.MyMBArr.count>0){
        
    return 10.0f;
    }else{
        return 0.01;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Tcell=@"indexPath";
    CMMBinCell *cell = [tableView dequeueReusableCellWithIdentifier:Tcell ];
    if (!cell) {
        cell=[[CMMBinCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Tcell];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    NSDictionary *dict=self.MyMBArr[indexPath.row];
    cell.FromSource.text=[dict objectForKey:@"memo"];
    cell.JoinDate.text=[dict objectForKey:@"date"];
    cell.MBNum.text=[NSString stringWithFormat:@"%@%@",[dict objectForKey:@"type"],[dict objectForKey:@"num"]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

-(NSMutableArray*)MyMBArr{
    if (!_MyMBArr) {
        _MyMBArr=[NSMutableArray arrayWithCapacity:0];
    }
    return _MyMBArr;
}

-(void)requestMyMBiDetail{
    if (![self checkNetWork]) {
        [self.tableView.mj_header endRefreshing];
    }
    NSString *page=[NSString stringWithFormat:@"%d",_pageIndex++];
    [CMRequestHandle MyMBinWithUserID:[CMUserDefaults objectForKey:@"userID"] andPageIndex:page andSuccess:^(id responseObj){
            DLog(@"我的M币===%@",responseObj);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([[responseObj objectForKey:@"Status"]intValue]==200) {
            NSArray *arr =[[responseObj objectForKey:@"t"]objectForKey:@"list"];
       
            _myBin.MyBin.text=[NSString stringWithFormat:@"%@个",[[responseObj objectForKey:@"t"]objectForKey:@"mbsum"]];
            [self  LoneAttributedFontStringEndString:@"个" FromLabel:_myBin.MyBin];

            if (_pageIndex ==2) {
                for (;0 < self.MyMBArr.count;) {
                    [self.MyMBArr removeObjectAtIndex:0];
                }
            }
            
            if (arr.count<=0) {
                
                [self.tableView.mj_footer setState:MJRefreshStateNoMoreData];
                return ;
            }else{
                
                // 将刷新到的数据添加到数组的后面
                for (NSMutableDictionary *item in arr) {
                    if (item != (NSMutableDictionary *)[NSNull null]) {
                        [self.MyMBArr addObject:item];
                    }
                }
                
            }
            if (self.MyMBArr.count<=0) {
                rbgView=[[CMRecordBgView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 200)];
                [rbgView creatHeadImage:@"wdjf_dhjl_icon" andTitle:@"暂无记录 哦~"];
                self.tableView.tableFooterView=rbgView;

                
            }else{
                [rbgView cleanNsstring];
                self.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 120)];
                
            }

   
            [self.tableView reloadData];
        }
       
        
    } andFailure:^(id error) {
        
    }];
    

    
    
}
-(void)LoneAttributedFontStringEndString:(NSString*)endStr FromLabel:(UILabel*)FromLabel{
    
    NSMutableAttributedString *qixianStr = [[NSMutableAttributedString alloc] initWithString:FromLabel.text];
    
    [qixianStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20.0] range:NSMakeRange(qixianStr.length -1, 1)];
    
    FromLabel.attributedText = qixianStr;
    
}
checkNet
@end
