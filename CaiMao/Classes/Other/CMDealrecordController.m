//
//  CMDealrecordController.m
//  CaiMao
//
//  Created by MAC on 16/8/9.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMDealrecordController.h"
#import "CMDealRecordFoot.h"
#import "CMDealRecordCell.h"
@interface CMDealrecordController ()
 {
     CMDealRecordFoot*footView;
     UIView *bgView;
     
}
@end

@implementation CMDealrecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"交易记录";
    self.view.backgroundColor=ViewBackColor;
    
    self.MyTableView.tableHeaderView=[[CMDealRecordHead alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 40)];
       // tTablew.rowHeight=40;
   UIView *foot= [[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 200)];
     foot.backgroundColor=ViewBackColor;
    UILabel *detail=[[UILabel alloc]init];
    detail.text=@"*每期收款金额已最终到账为准,本项目最终解释权归财猫网所有";
    detail.numberOfLines=0;
    detail.font=[UIFont systemFontOfSize:12.0];
    detail.textColor=UIColorFromRGB(0xacaca9);
    detail.textAlignment=NSTextAlignmentCenter;
    [foot addSubview:detail];
    [detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(foot.mas_left).offset(10);
        make.right.equalTo(foot.mas_right).offset(-10);
        make.height.equalTo(@30);
        make.top.equalTo(foot.mas_top).offset(20);
        
    }];
    self.MyTableView.tableFooterView=foot;
    self.MyTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page=1;
        [self loadUpdate];
    }];
    self.MyTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
         [self loadUpdate];
    }];
   // DLog(@"pid---%@---%@",self.pid,self.dataArr);
    [self.view addSubview:self.MyTableView];
    footView=  [[CMDealRecordFoot alloc]init];//WithFrame:CGRectMake(0, CMScreenH-20, CMScreenW, 40)
    [self.view  addSubview:footView];
    [self.view bringSubviewToFront:footView];
    [footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@70);
    }];
    
 


    
    
}

#pragma mark Lazy
-(UITableView*)MyTableView{
    
    if (!_MyTableView) {
       _MyTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, CMScreenH) style:UITableViewStylePlain];
        _MyTableView.separatorStyle=UITableViewCellSelectionStyleNone;
        _MyTableView.delegate=self;
        _MyTableView.dataSource=self;

    }
    return _MyTableView;
}

-(NSMutableArray*)dataArr{
    if (!_dataArr) {
        _dataArr=[NSMutableArray arrayWithCapacity:0];
        
    }
    return _dataArr;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.MyTableView.mj_header beginRefreshing];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if (self.dataArr.count<=0) {
        return 1;
    }
    else{
        return self.dataArr.count;
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.dataArr.count<=0) {
        return CMScreenH/2.0;
    }
    else{
        return 40;
        
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *TCell=@"UITableViewCell";
    CMDealRecordCell *cell=[tableView dequeueReusableCellWithIdentifier:TCell];
    if (!cell) {
        cell=[[CMDealRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TCell];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
   
  
    
        if (self.dataArr.count<=0) {
         
            self.MyTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
             bgView=[[UIView alloc]init];
            bgView.backgroundColor=[UIColor whiteColor];
            [cell.contentView addSubview:bgView];
            [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
    
                make.top.left.width.equalTo(cell.contentView);
                make.height.mas_equalTo(CMScreenH/2.0);
            }];
    
            UIImageView *imageView=[[UIImageView alloc]init];
            imageView.image=[UIImage imageNamed:@"cpjs_shuchu_ic"];
            [bgView addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.width.equalTo(@80);
                make.top.equalTo(bgView.mas_top).offset(25);
                make.left.equalTo(bgView.mas_left).offset(CMScreenW/2.0-40);
    
            }];
    
            UILabel *detail=[UILabel new];
            detail.text=@"暂无转出记录......";
            detail.textColor=UIColorFromRGB(0x666666);
            detail.textAlignment=NSTextAlignmentCenter;
            detail.font=[UIFont systemFontOfSize:14.0];
            [bgView addSubview:detail];
            [detail mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@15);
                make.width.mas_equalTo(CMScreenW);
                make.top.equalTo(imageView.mas_bottom).offset(10);
                make.centerX.equalTo(bgView);
            }];
            footView.hidden=YES;
    
        }else{
            footView.hidden=NO;
            bgView.hidden=YES;
            NSDictionary *dict=self.dataArr[indexPath.row];
            // DLog( @"arr==%@",dict);
            cell.JIPaiUser.text=[dict objectForKey:@"Bidders"];
            cell.TZJinEr.text=[NSString stringWithFormat:@"%@",[dict objectForKey:@"Amount"]];
            cell.TZFenNum.text=[NSString stringWithFormat:@"%@",[dict objectForKey:@"BiddingCopies"]];
            NSString *time=[dict objectForKey:@"BiddingTime"];
            NSString *newTime=[time substringToIndex:10];
            cell.TZDealTime.text=newTime;
            NSString *statees=[NSString stringWithFormat:@"%@",[dict objectForKey:@"BiddingStatus"]];
            if ([statees intValue]==0) {
                cell.TZState.image=[UIImage imageNamed:@"right"];
            }else{
                
                cell.TZState.image=[UIImage imageNamed:@"error"];
            }

              int amout=[[NSString stringWithFormat:@"%@",[dict objectForKey:@"TotalAmount"]]intValue];
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
            
            formatter.numberStyle =NSNumberFormatterDecimalStyle;
            
            NSString *newAmount = [formatter stringFromNumber:[NSNumber numberWithFloat:(float)amout]];
            footView.TotalJinEr.text=newAmount;
            
            //footView.TotalJinEr.text=[NSString stringWithFormat:@"%.2f",(float)amout];
            footView.TotalTJFS.text=[NSString stringWithFormat:@"%d",amout/self.fenEr];
            
        }
    
    
    
    
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

#pragma mark 交易记录数据
-(void)loadUpdate{
    NSString *urlStr = [NSString stringWithFormat:@"%@/handler/AppService_ProductAction.ashx?Action=5",OnLineCode];
    NSString *page=[NSString stringWithFormat:@"%d",self.page++];
    NSDictionary *dict=@{@"PID":self.pid,@"PageIndex":page};
    
    [CMHttpTool postWithURL:urlStr params:dict success:^(id responseObj) {
       NSArray *result=[responseObj objectForKey:@"ItemList"];
    DLog( @"amout==%@",responseObj);
        [self.MyTableView.mj_header endRefreshing];
        [self.MyTableView.mj_footer endRefreshing];
        if ( self.page ==2) {
            for (;0 < self.dataArr.count;) {
                [self.dataArr removeObjectAtIndex:0];
            }
        }
        
        if (result.count<=0) {
          [self.MyTableView.mj_footer setState:MJRefreshStateNoMoreData];
        }else{
            
            // 将刷新到的数据添加到数组的后面
            for (NSMutableDictionary *item in result) {
                if (item != (NSMutableDictionary *)[NSNull null]) {
                    [self.dataArr addObject:item];
                }
            }
                  }
        [self.MyTableView reloadData];
        

        
        
    } failure:^(NSError *error) {
      //  NSLog(@"----error==%@",error);
        [self.MyTableView.mj_header endRefreshing];
        [self.MyTableView.mj_footer endRefreshing];
        
        
        
    }];
    

    
}
@end
