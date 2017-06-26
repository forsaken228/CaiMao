//
//  CMCFBBackGroundController.m
//  CaiMao
//
//  Created by MAC on 16/9/1.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMCFBBackGroundController.h"

@interface CMCFBBackGroundController ()
{
    
         CMRecordBgView *rbgView;
   // NSArray *bgImage;
    //NSArray *bTitle;
    CMCfbTopView *topview;
  UIView *bottomView;

}
@property(nonatomic,assign)int countPage;
@property(nonatomic,assign)int YuErPage;
@property(nonatomic,assign)int ZhuanRuPage;
@property(nonatomic,strong)NSDictionary *ZhuanRuDict;
@property(nonatomic,assign)int selectIndex;
@property(nonatomic,strong)NSArray *bgImage;
@property(nonatomic,strong)NSArray *bTitle;
@end

@implementation CMCFBBackGroundController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"财富宝";
    self.view.backgroundColor=ViewBackColor;

    [self.view addSubview:self.myTableView];
    [self showDefaultProgressHUD];
    [self  bottomSuspendView];
    [self loadAllDate];
    
    self.myTableView.mj_header = [CMRefreshHeader headerWithRefreshingBlock:^{
        [self loadAllDate];
    }];
    
    self.myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (_selectIndex==10) {
            [self updateRecord];
        }else if (_selectIndex==11){
            [self ZhuanRuRecord];
        }else{
            
            [self updateZhuanChuRecord];
        }
        
    }];
    [self zhuanChuData];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //异步操作代码块
         [self loadCaifuBaoData];
         
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //回到主线程操作代码块
           self.myTableView.tableHeaderView=[self tableHeadView];
            
            
        });
        
    });
 

 }

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.YuErMingXiArr.count<=0||[self.YuErMingXiArr isKindOfClass:[NSNull class]]) {
        rbgView=[[CMRecordBgView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW,300)];
        [rbgView creatHeadImage:[self bgImage][0] andTitle:[self bTitle][0]];
        self.myTableView.tableFooterView=rbgView;
        
    }else{
        [rbgView cleanNsstring];
        self.myTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 120)];
        
    }
    


}
-(void)loadAllDate{
    if (_selectIndex==10) {
        
        self.YuErPage=1;
        [self updateRecord];
    }else if (_selectIndex==11){
        self.ZhuanRuPage=1;
        [self ZhuanRuRecord];
    }else if (_selectIndex==12){
        self.countPage=1;
        [self updateZhuanChuRecord];
    }
    
    else{
        
        self.YuErPage=1;
        [self updateRecord];
        self.ZhuanRuPage=1;
        [self ZhuanRuRecord];
        self.countPage=1;
        [self updateZhuanChuRecord];
        
        _selectIndex=10;
        
        
        
    }
    
    
    
    
}
#pragma mark Lazy
-(UITableView*)myTableView{
    if (!_myTableView) {
        _myTableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _myTableView.backgroundColor=ViewBackColor;
        _myTableView.hidden=YES;
        _myTableView.dataSource=self;
        _myTableView.delegate=self;
        _myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    }
    return _myTableView;
}
-(NSDictionary*)ZhuanRuDict{
    if (!_ZhuanRuDict) {
        _ZhuanRuDict=[NSDictionary dictionary];
    }
    return _ZhuanRuDict;
   
    
}
-(NSMutableArray*)ZhuanRuArr{
    if (!_ZhuanRuArr) {
        _ZhuanRuArr=[NSMutableArray array];
    }
    return _ZhuanRuArr;
}
-(NSMutableArray*)ZhuanChuArr{
    if (!_ZhuanChuArr) {
        _ZhuanChuArr=[NSMutableArray array];
    }
    return _ZhuanChuArr;
}
-(NSMutableArray*)YuErMingXiArr{
    if (!_YuErMingXiArr) {
        _YuErMingXiArr=[NSMutableArray array];
    }
    return _YuErMingXiArr;
}
-(NSArray*)bgImage{
    return @[@"cfbht_yejl",@"cfbht_zrjl",@"cfbht_crjl"];
}
-(NSArray*)bTitle{
    
    return @[@"你不理财 财不理你",@"暂无记录 哦~",@"暂无记录 哦~"];
}
#pragma mark myTableView 代理协议
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (_selectIndex==10) {
       
        static NSString *cellID=@"CMYuErMingXiCell";
        CMYuErMingXiCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell=[[CMYuErMingXiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
       NSDictionary *dict=self.YuErMingXiArr[indexPath.section];
        NSString *date=[dict objectForKey:@"ValueDate"];
        NSString *new=[date substringToIndex:10];
        cell.QXDate.text=[NSString stringWithFormat:@"起息日:%@",new];
        [NSString loneStringChangeColer:cell.QXDate andFromStr:@":" withString:new  WithColor:UIColorFromRGB(0xfa3e19)];
        
        cell.JXMoney.text=[NSString stringWithFormat:@"计息金额:%@元",[dict objectForKey:@"AmountOfInterest"]];
        [NSString loneStringChangeColer:cell.JXMoney andFromStr:@":" withString:[NSString stringWithFormat:@"%@元",[dict objectForKey:@"AmountOfInterest"]]WithColor:UIColorFromRGB(0xfa3e19)];
        
        
        cell.MXID.text=[NSString stringWithFormat:@"ID:%@",[dict objectForKey:@"ID"]];
        
     
            cell.CurrentSY.text=[NSString stringWithFormat:@"当前年收益率:%.2f%%",[[dict objectForKey:@"CurrentYearIncome"]floatValue]];
            [NSString loneStringChangeColer:cell.CurrentSY andFromStr:@":" withString:[NSString stringWithFormat:@"%.2f%%",[[dict objectForKey:@"CurrentYearIncome"]floatValue]]WithColor:UIColorFromRGB(0xfa3e19)];
       
        
        
        cell.ZRJinEr.text=[NSString stringWithFormat:@"转入金额:%@",[dict objectForKey:@"InAmount"]];
        
        NSString *date1=[dict objectForKey:@"InDate"];
        NSString *new1=[date1 substringToIndex:10];
        cell.ZRDate.text=[NSString stringWithFormat:@"转入日:%@",new1];
        return cell;
        
        
    }else if (_selectIndex==11){
      
        static NSString *cellID=@"CMZhuanRuRecordCell";
        CMZhuanRuRecordCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell=[[CMZhuanRuRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        
         NSDictionary *dict=self.ZhuanRuArr[indexPath.section];
         cell.ZRID.text=[NSString stringWithFormat:@"ID:%@",[dict objectForKey:@"ID"]];
        if ([[dict objectForKey:@"CurrentStatus"]intValue]==1) {
             cell.ZRState.text=[NSString stringWithFormat:@"成功"];
        }else{
            
            cell.ZRState.text=[NSString stringWithFormat:@"失败"];

        }
       
        NSString *date1=[dict objectForKey:@"InDate"];
        NSString *new1=[date1 substringToIndex:10];
        cell.ZRRecordDate.text=[NSString stringWithFormat:@"转入日:%@",new1];
    
        [NSString loneStringChangeColer:cell.ZRRecordDate andFromStr:@":" withString:new1 WithColor:UIColorFromRGB(0xfa3e19)];
        
        cell.ZRRecordMoney.text=[NSString stringWithFormat:@"+%@元",[dict objectForKey:@"InAmount"]];
        
        return cell;
      
    }else{
        
        
        static NSString *cellID=@"CMZhuanChuCell";
        CMZhuanChuCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell=[[CMZhuanChuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        
        NSDictionary *dict=self.ZhuanChuArr[indexPath.section];
        NSString *date=[dict objectForKey:@"OutDate"];
        NSString *new=[date substringToIndex:10];
        
        cell.ZCRecordDate.text=[NSString stringWithFormat:@"转出时间:%@",new];
        
        [NSString loneStringChangeColer:cell.ZCRecordDate andFromStr:@":" withString:new WithColor:UIColorFromRGB(0xfa3e19)];
        
        cell.ZCRecordMoney.text=[NSString stringWithFormat:@"-%@元",[dict objectForKey:@"OutAmount"]];
        
        cell.ZCShouYiLv.text=[NSString stringWithFormat:@"最终年收益率:%.2f%%",[[dict objectForKey:@"FinalizedYearIncomePercent"]floatValue]];
        
        [NSString loneStringChangeColer:cell.ZCShouYiLv andFromStr:@":" withString:[NSString stringWithFormat:@"%.2f%%",[[dict objectForKey:@"FinalizedYearIncomePercent"]floatValue]] WithColor:UIColorFromRGB(0xfa3e19)];
        cell.ZCShouYi.text=[NSString stringWithFormat:@"最终收益:%.2f元",[[dict objectForKey:@"FinalizedYearIncome"]floatValue]];
        
        [NSString DoubleStringChangeColer: cell.ZCShouYi andFromStr:@":" ToStr:@"元" withColor:RedButtonColor];
        
        return cell;
        
        
    }
    
   
    
}
-( UIView*)tableHeadView{
      UIImage *tiIcon=[UIImage imageNamed:@"cfb_syijt"];
    topview=[[CMCfbTopView alloc]init];

    [topview.detaibtn addTarget:self action:@selector(detaiAlertShow) forControlEvents:UIControlEventTouchUpInside];
    topview.frame=CGRectMake(0, 0, CMScreenW, f_i5real(tiIcon.size.height+20+20)+265);
    topview.backgroundColor=ViewBackColor;
    
    __weak typeof (self) weakSelf = self;
    __block  CMRecordBgView *blockView=rbgView;
    __block  NSArray *imageArr=[self bgImage];
    __block  NSArray *titleArr=[self bTitle];
    topview.CfbBlock=^(NSInteger tag){
        
   switch (tag) {
                        case 10:
                        {
                            
                            _selectIndex=10;
                            if (weakSelf.YuErMingXiArr.count>0) {
                                weakSelf.myTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 120)];
           
                            }else{
                                blockView=[[CMRecordBgView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 300)];
                                [blockView creatHeadImage:imageArr[0] andTitle:titleArr[0]];
                                weakSelf.myTableView.tableFooterView=blockView;
           
                            }
                        }
                            break;
                        case 11:
                       {
                           _selectIndex=11;
                           if (weakSelf.ZhuanRuArr.count>0) {
                                weakSelf.myTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW,120)];
                                 [weakSelf.myTableView.mj_footer setState:MJRefreshStatePulling];
                            }else{
           
                                blockView=[[CMRecordBgView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW,300)];
                                [blockView creatHeadImage:imageArr[1] andTitle:titleArr[1]];
                                weakSelf.myTableView.tableFooterView=blockView;
                            }
           
                        }
                            break;
           
                        case 12:
                       {_selectIndex=12;
           
                            if (weakSelf.ZhuanChuArr.count>0) {
                              weakSelf.myTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 120)];
                                [weakSelf.myTableView.mj_footer setState:MJRefreshStatePulling];
                          }else{
           
                               blockView=[[CMRecordBgView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW,300)];
                                [blockView creatHeadImage:imageArr[2] andTitle:titleArr[2]];
                                weakSelf.myTableView.tableFooterView=blockView;
                           }
           
           
                        }
                            break;
           
           
                       default:
                           break;
                  }
           
                      [weakSelf.myTableView reloadData];
 
    };
    
   

    return topview;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_selectIndex==10) {
        return self.YuErMingXiArr.count;
    }else if (_selectIndex==11){
        return self.ZhuanRuArr.count;
    }else{
        return self.ZhuanChuArr.count;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 10;
    }else{
        return 0.05;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_selectIndex==10) {
        return 60;
    }else if (_selectIndex==11){
        return 50;
    }else{
        return 50;
    }
}

#pragma mark 加载数据
-(void)updateRecord{
    
    NSString *page=[NSString stringWithFormat:@"%d",self.YuErPage++];
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_CFB.ashx?Action=5",OnLineCode];
    NSDictionary *dict=@{@"HYID":[CMUserDefaults objectForKey:@"userID"],@"PageIndex":page};
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
       NSArray *result=[[responseObj objectForKey:@"ItemList"]objectForKey:@"ItemList"];
         //NSLog(@"余额明细==%@==%@",responseObj,result);
         if([[responseObj objectForKey:@"Status"]intValue]==200){
        
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
        if (self.YuErPage == 2) {
            for (;0 < self.YuErMingXiArr.count;) {
                [self.YuErMingXiArr removeObjectAtIndex:0];
            }
        }
        
        if (result.count<=0) {

              [self.myTableView.mj_footer setState:MJRefreshStateNoMoreData];
            return ;
        }else{
            
            // 将刷新到的数据添加到数组的后面
            for (NSMutableDictionary *item in result) {
                if (item != (NSMutableDictionary *)[NSNull null]) {
                    [self.YuErMingXiArr addObject:item];
                }
            }
           
        }
              
            // NSLog(@"Chongzhi==%d",self.YuErMingXiArr.count);
             if (self.YuErMingXiArr.count<=0) {
                 rbgView=[[CMRecordBgView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 300)];
                 [rbgView creatHeadImage:[self bgImage][0] andTitle:[self bTitle][0]];
                 self.myTableView.tableFooterView=rbgView;
                 
             }else{
                 [rbgView cleanNsstring];
                 self.myTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 120)];
                 
             }

        [self.myTableView reloadData];
        
         }
        
    } failure:^(NSError *error) {
        
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
    }];
    

    
}
-(void)ZhuanRuRecord{
    
    NSString *page=[NSString stringWithFormat:@"%d",self.ZhuanRuPage++];
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_CFB.ashx?Action=4",OnLineCode];
    NSDictionary *dict=@{@"HYID":[CMUserDefaults objectForKey:@"userID"],@"PageIndex":page};
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        NSArray *result=[[responseObj objectForKey:@"ItemList"]objectForKey:@"ItemList"];
       // NSLog(@"转入==%@",responseObj);
        if([[responseObj objectForKey:@"Status"]intValue]==200){
            
            [self.myTableView.mj_header endRefreshing];
            [self.myTableView.mj_footer endRefreshing];
            if (self.ZhuanRuPage == 2) {
                for (;0 < self.ZhuanRuArr.count;) {
                    [self.ZhuanRuArr removeObjectAtIndex:0];
                }
            }
            
            if (result.count<=0) {
        [self.myTableView.mj_footer setState:MJRefreshStateNoMoreData];
                return ;
            }else{
                
                // 将刷新到的数据添加到数组的后面
                for (NSMutableDictionary *item in result) {
                    if (item != (NSMutableDictionary *)[NSNull null]) {
                        [self.ZhuanRuArr addObject:item];
                    }
                }
                
            }
            
            // NSLog(@"Chongzhi==%d",self.YuErMingXiArr.count);
//            if (self.ZhuanRuArr.count<=0) {
//                rbgView=[[CMRecordBgView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 200)];
//                [rbgView creatHeadImage:bgImage[1] andTitle:bTitle[1]];
//                self.myTableView.tableFooterView=rbgView;
//                
//            }else{
//                [rbgView cleanNsstring];
//                self.myTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 100)];
//                
//            }
            
            [self.myTableView reloadData];
            
        }
        
    } failure:^(NSError *error) {
        
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
    }];
    
    
    
}

-(void)updateZhuanChuRecord{
    NSString *page=[NSString stringWithFormat:@"%d",self.countPage++];
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_CFB.ashx?Action=3",OnLineCode];
    
    NSDictionary *dict=@{@"HYID":[CMUserDefaults objectForKey:@"userID"],@"PageIndex":page};
     // NSLog(@"dict==%@",dict);
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
      //   NSLog(@"转出记录==%@",responseObj);
        if([[responseObj objectForKey:@"Status"]intValue]==200){
        NSArray *result=[[responseObj objectForKey:@"ItemList"]objectForKey:@"ItemList"];
       // NSLog(@"updateZhuanChuRecord==%@",responseObj);
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
                if (self.countPage ==2) {
                    for (;0 < self.ZhuanChuArr.count;) {
                        [self.ZhuanChuArr removeObjectAtIndex:0];
                    }
                }
        
                if (result.count<=0) {
                [self.myTableView.mj_footer setState:MJRefreshStateNoMoreData];
                    
                    return ;
                }else{

                    // 将刷新到的数据添加到数组的后面
                    for (NSMutableDictionary *item in result) {
                        if (item != (NSMutableDictionary *)[NSNull null]) {
                            [self.ZhuanChuArr addObject:item];
                        }
                    }
        
                }
            
            // NSLog(@"Chongzhi==%d",self.YuErMingXiArr.count);
//            if (self.ZhuanChuArr.count<=0) {
//                rbgView=[[CMRecordBgView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 200)];
//                [rbgView creatHeadImage:bgImage[2] andTitle:bTitle[2]];
//                self.myTableView.tableFooterView=rbgView;
//                
//            }else{
//                [rbgView cleanNsstring];
//                self.myTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 100)];
//                
//            }

                [self.myTableView reloadData];
        
        
        }
    } failure:^(NSError *error) {
        
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
    }];
    
    
    
}
-(void)loadCaifuBaoData{
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_CFB.ashx?Action=1",OnLineCode];
    NSDictionary *dict=@{@"HYID":[CMUserDefaults objectForKey:@"userID"],
                         @"PageIndex":@"1"};
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        [self hiddenProgressHUD];
        _myTableView.hidden=NO;
        bottomView.hidden=NO;
        if([[responseObj objectForKey:@"Status"]intValue]==200){
        topview.CFBYE.text=[NSString stringWithFormat:@"%.2f",[[responseObj objectForKey:@"Balance"] floatValue]];
        topview.yesterdayGain.text=[NSString stringWithFormat:@"%.2f",[[responseObj objectForKey:@"YesterDayIncome"] floatValue]];
        topview.totalGain.text=[NSString stringWithFormat:@"%.2f",[[responseObj objectForKey:@"TotalIncome"] floatValue]];

        
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
   }
   
    } failure:^(NSError *error) {
        
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
    }];
    }

#pragma mark 底部悬浮
-(void)bottomSuspendView{
    
   bottomView = [[UIView alloc] init];
    
    bottomView.backgroundColor = [UIColor whiteColor];
    //bottomView.alpha=0.8;
    bottomView.hidden=YES;
    [self.view addSubview:bottomView];
    [self.view bringSubviewToFront:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@50);
        make.left.right.bottom.equalTo(self.view);
        
    }];
    NSArray *bTitleArr=@[@"转入",@"转出"];
    NSArray *bImageTitle=@[@"cfbht_zhuanru",@"cfbht_zhuanchu"];
    
    for (int i=0; i<bTitleArr.count; i++) {
        CMBottomXuanFu *xuanfu=[[CMBottomXuanFu alloc]init];
        xuanfu.backgroundColor=RedButtonColor;
        [xuanfu creatbuttonImage:bImageTitle[i] andTitle:bTitleArr[i]];
        xuanfu.frame=CGRectMake(i%2*CMScreenW/2.0, 0, CMScreenW/2.0-0.5, 50);
        xuanfu.tag=i+20;
        [bottomView addSubview:xuanfu];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        [xuanfu addGestureRecognizer:tap];
  
    }
   
    
    
}
-(void)tapClick:(UIGestureRecognizer*)gesture{
    
    
    switch (gesture.view.tag) {
        case 20:
        { //转入
            CMZhuangRuCFBController *loginVc = [[CMZhuangRuCFBController alloc] init];
            loginVc.isFromHome=NO;
            CMPush(loginVc);
                   }
            break;
        case 21:
        {
            DLog(@"+++%@",self.ZhuanRuDict);
            if ([[self.ZhuanRuDict objectForKey:@"amount"]intValue]<=0) {
                
                
                CMCFBZhuangRuAlertView *DetailAlert=[[CMCFBZhuangRuAlertView alloc]initWithDeatilTitle:@"您的财富宝余额为0,开启活期理财吧!" WithCancleTitle:@"取消" WithDetaildown:@"立即转入" withTag:11];
                DetailAlert.delegate=self;
                [DetailAlert ShowAlert];

            }else{
            CMZHuangChuViewController *productVc = [[CMZHuangChuViewController alloc] init];
                productVc.yuAmountDict=self.ZhuanRuDict;
            [self.navigationController pushViewController:productVc animated:YES];
            }
            
        }
            break;
        default:
            break;
    }

}

-(void)jumpViewWithIndex:(NSInteger)Index{
    
    if (Index==1) {
     
        CMZhuangRuCFBController *loginVc = [[CMZhuangRuCFBController alloc] init];
        loginVc.isFromHome=NO;
        CMPush(loginVc);
      
    }
    
}

-(void)detaiAlertShow{
    
    CMCFBAlert *alert=[[CMCFBAlert alloc]initWithFrame:self.view.frame];
    [alert ShowAlert];
    
}


-(void)zhuanChuData{
    [CMRequestHandle CaiFuBaoZhuanChuMessageWithSuccess:^(id responseObj) {
        
        
        DLog(@"++++++%@",responseObj);
        
        
        if ([[responseObj objectForKey:@"Status"]intValue]==200) {
            self.ZhuanRuDict=[responseObj objectForKey:@"t"];
            
        }else{
            CMTiShi([responseObj objectForKey:@"Result"]);
            
        }
    } andFailure:^(id error) {
        
    }];
    
    
}



@end
