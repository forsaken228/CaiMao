//
//  CMExperienceSecuritiesView.m
//  CaiMao
//
//  Created by WangWei on 17/3/25.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import "CMExperienceSecuritiesView.h"
#import "CMMyYHCell.h"
@interface CMExperienceSecuritiesView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)NSMutableArray *dataArry;
@property(nonatomic,strong)CMRecordBgView *rbgView;
@end
@implementation CMExperienceSecuritiesView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=ViewBackColor;
       
        self.rbgView.frame=CGRectMake(0, self.frame.origin.y, CMScreenW, self.bounds.size.height);
        
        [self addSubview:self.myTableView];
         [self addSubview:self.rbgView];
        UIView *foot=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 100)];
        self.myTableView.tableFooterView=foot;
        
        [self LoadData];
        self.myTableView.mj_header=[CMRefreshHeader headerWithRefreshingBlock:^{
            [self LoadData];
        }];
        self.myTableView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            NSInteger pa=_dataArry.count/5+1;
            NSString *pag=[NSString stringWithFormat:@"%d",pa];
            [self requestDataWithType:@"3" WithPage:pag];
        }];
        
    }
    return self;
}
-(void)LoadData{
    
    
    [self requestDataWithType:@"3" WithPage:@"1"];
}

#pragma mark Lazy
-(CMRecordBgView*)rbgView{
    if (!_rbgView) {
        _rbgView=[[CMRecordBgView alloc]init];
        [_rbgView creatHeadImage:@"NoYHJ" andTitle:@"暂时没有记录"];;
        
        
    }
    return _rbgView;
}
-(NSMutableArray*)dataArry{
    if (!_dataArry) {
        _dataArry=[NSMutableArray arrayWithCapacity:0];
    }
    return _dataArry;
}
-(UITableView*)myTableView{
    if (!_myTableView) {
        _myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, CMScreenH-45) style:UITableViewStyleGrouped];
        _myTableView.delegate=self;
        _myTableView.dataSource=self;
        _myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _myTableView.hidden=YES;
        
        
    }
    return _myTableView;
}


#pragma mark tableView 代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    
    return self.dataArry.count;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 87.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        
        return 7.0f;
    }else{
        return 6.f;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *TCell=@"UITableViewCell";
    CMMyYHCell *cell=[tableView dequeueReusableCellWithIdentifier:TCell];
    
    if (!cell) {
        cell=[[CMMyYHCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TCell];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    
    NSDictionary *dict=self.dataArry[indexPath.section];
    
    if ([[dict objectForKey:@"status"]isEqualToString:@"已使用"]) {
        
        
        cell.MiaZhi.textColor=UIColorFromRGB(0x8e8d93);
        cell.YHState.textColor=UIColorFromRGB(0x8e8d93);
        cell.YHState.text=[dict objectForKey:@"status"];
    } else if ([[dict objectForKey:@"status"]isEqualToString:@"已过期"]||![self handleDateValidate:[dict objectForKey:@"date"]]){
        
        cell.MiaZhi.textColor=UIColorFromRGB(0x8e8d93);
        cell.YHState.textColor=UIColorFromRGB(0x8e8d93);
        cell.YHState.text=@"已过期";
        
    }
    else{
        
        cell.MiaZhi.textColor=RedButtonColor;
        cell.YHState.textColor=UIColorFromRGB(0x2edf73);
        cell.YHState.text=[dict objectForKey:@"status"];
    }
    cell.MiaZhi.text=[NSString stringWithFormat:@"￥%@",[dict objectForKey:@"num"]];
    [self LoneAttributedFontStringToString:@"￥" FromLabel:cell.MiaZhi];
    
    
    cell.FromSource.text=[NSString stringWithFormat:@"来源:%@",[dict objectForKey:@"name"]];
    cell.YouXiaoTime.text=[NSString stringWithFormat:@"有效时间:%@",[dict objectForKey:@"date"]];
    
    
    
    
    
    return cell;
    
}

#pragma mark 请求数据
-(void)requestDataWithType:(NSString*)Type WithPage:(NSString*)page{
    
    
    [CMRequestHandle MyYouHuiJuanWithUserID:[CMUserDefaults objectForKey:@"userID"] andType:Type andPageIndex:page andSuccess:^(id responseObj) {
        DLog(@"优惠券++++++%@",page) ;
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
        
        if ([[responseObj objectForKey:@"Status"]intValue]==200) {
            NSArray *result=[[responseObj objectForKey:@"t"]objectForKey:@"list"];
            
            if ([page isEqualToString:@"1"]) {
                [self.dataArry removeAllObjects];
                
            }
            
            if (result<=0) {
                [self.myTableView.mj_footer setState:MJRefreshStateNoMoreData];
                return ;
            }else{
                [self.dataArry addObjectsFromArray:result];
                self.myTableView.hidden=NO;
                if (self.dataArry.count>0) {
                    self.rbgView.hidden=YES;
                }else{
                   self.rbgView.hidden=NO;
                }
                
                [self.myTableView reloadData];
            }
            
            if (self.dataArry.count%5!=0) {
                [self.myTableView.mj_footer setState:MJRefreshStateNoMoreData];
                return ;
            }
            
            
            
            
            
        }
        
    } andFailure:^(id error) {
        
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
    }];
    
}

-(void)LoneAttributedFontStringToString:(NSString*)ToStr FromLabel:(UILabel*)FromLabel{
    
    NSMutableAttributedString *qixianStr = [[NSMutableAttributedString alloc] initWithString:FromLabel.text];
    
    [qixianStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0] range:NSMakeRange(0, 1)];
    
    FromLabel.attributedText = qixianStr;
    
}


-  (BOOL)handleDateValidate:(NSString*)date {
    
    NSString *now = [ [NSString stringWithFormat:@"%@", [NSDate date] ] substringToIndex:10 ];
    if([now compare: date]  !=  NSOrderedDescending) {
        return  YES;
    }
    
    return NO;
}



@end
