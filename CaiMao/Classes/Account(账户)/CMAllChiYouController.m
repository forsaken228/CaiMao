//
//  CMAllChiYouController.m
//  CaiMao
//
//  Created by WangWei on 16/12/1.
//  Copyright © 2016年 58cm. All rights reserved.
//
#import "CMAllChiYouHead.h"
#import "CMAllChiYouController.h"
#import "CMChiYouModel.h"
@interface CMAllChiYouController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)NSMutableArray *dataArr;


@property(nonatomic,strong)CMAllChiYouHead  *chiYouhead;
@property(nonatomic,strong)CMProductIncomeFoot  *footView;
@property(nonatomic,assign)int  pageIndex;

@property(nonatomic,copy)NSString *BenJin;

@end

@implementation CMAllChiYouController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=ViewBackColor;
    
    [self.view addSubview:self.myTableView];
   
    [self.view addSubview:self.footView];
    [self.view bringSubviewToFront:self.footView];

    self.title=@"收益报告";
  
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"我的账户" style:UIBarButtonItemStylePlain target:self action:@selector(goAuccount)];
//self.myTableView.tableFooterView=self.footView;

    [self showDefaultProgressHUD];
    [self LoadDefualData];
    self.myTableView.mj_header=[CMRefreshHeader headerWithRefreshingBlock:^{
    
        [self LoadDefualData];
    }];
    self.myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // [self.TotalArr removeAllObjects];
        [self requestDate];
    }];
    //[self.myTableView.mj_header beginRefreshing];
}
-(void)goAuccount{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)LoadDefualData{
    self.pageIndex=1;
    [self  requestDate];

}
#pragma mark Lazy
-(UITableView*)myTableView{
    if (!_myTableView) {
        _myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, CMScreenH-70) style:UITableViewStyleGrouped];
        _myTableView.delegate=self;
        _myTableView.dataSource=self;
        _myTableView.hidden=YES;
        _myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _myTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 70)];
          _myTableView.tableHeaderView=self.chiYouhead;
    }
    return _myTableView;
}
-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr=[NSMutableArray arrayWithCapacity:0];
    }
    return _dataArr;
    
}


-(CMAllChiYouHead *)chiYouhead
{
    if (!_chiYouhead) {
        _chiYouhead= [[CMAllChiYouHead alloc]init];
        _chiYouhead.frame=CGRectMake(0, 0, CMScreenW, 60);
    }
    return _chiYouhead;
    
}

-(CMProductIncomeFoot *)footView
{
    if (!_footView) {
        _footView=[[CMProductIncomeFoot alloc]initWithFrame:CGRectMake(0, CMScreenH-134, CMScreenW,70)];
        _footView.BJin.text=@"0.00";
        _footView.LXi.text=@"0.00";
        _footView.TotalIncome.text=@"0.00";
      _footView.hidden=YES;
    }
    return _footView;
    
}

#pragma mark tableViewDataDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr=[self.dataArr objectAtIndex:section];
    return arr.count;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *TCell=@"UITableViewCell";
    CMAllChiCell *cell=[tableView dequeueReusableCellWithIdentifier:TCell];
    
    if (!cell) {
        cell=[[CMAllChiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TCell];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }

 NSArray *arr=self.dataArr[indexPath.section];
 // DLog(@"self.dataArr++++++%@++",self.dataArr);
    CMChiYouModel *dict=arr[indexPath.row];
    cell.QiCi.text=[NSString stringWithFormat:@"%d期",dict.qibie];
    cell.ShouYiDate.text=dict.dzrq;
    cell.YSBenXi.textColor=RedButtonColor;
    cell.YSBenXi.text=[NSString stringWithFormat:@"%@",dict.amountlx];
    //
    cell.YSBenJin.text=[NSString stringWithFormat:@"%@",dict.amountbj];
    
    cell.YSLiXi.textColor=RedButtonColor;
    cell.YSLiXi.text=[NSString stringWithFormat:@"%.2f",[dict.amountlx floatValue]+[dict.amountbj floatValue]];
    
    

    if([dict.status  isEqualToString:@"未到账"]||[dict.status isEqualToString:@"已转让"]){
        cell.SYBenJin.textColor=RedButtonColor;
        
    }else{
        
        cell.SYBenJin.textColor=UIColorFromRGB(0x2ec075);
    }
    cell.SYBenJin.text=dict.status;
    //int qishu=[[dict objectForKey:@"qishu"]intValue];
    
   
    CMChiYouModel *Firstdict=arr[0];
    if (Firstdict.qishu>1) {
        if(indexPath.row==arr.count-1){
            cell.loadMoreImage.hidden=NO;
            cell.userInteractionEnabled=YES;
            
            if (arr.count==Firstdict.qishu) {
                if(indexPath.row==arr.count-1){
                    if (arr.count==Firstdict.qishu) {
                        cell.loadMoreImage.transform=CGAffineTransformMakeRotation(M_PI);
                        cell.loadMoreImage.hidden=NO;
                        cell.userInteractionEnabled=YES;
                    }
                }
            }else{
                
                
                
                cell.loadMoreImage.transform=CGAffineTransformIdentity;
                
                
            }
            
        }else{
            
            cell.loadMoreImage.hidden=YES;
             cell.userInteractionEnabled=NO;
        }
        
    }else{
        
        cell.loadMoreImage.hidden=YES;
        cell.userInteractionEnabled=NO;
    }
   
    
    
    return cell;

    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arr=self.dataArr[indexPath.section];
    
    //CMChiYouModel *dict=arr[indexPath.row];
   // int qishu=[[dict objectForKey:@"qishu"]intValue];
    DLog(@"arr.count===%d",arr.count);
    CMChiYouModel *Firstdict=arr.firstObject;
    if (Firstdict.qishu>1) {
        if(indexPath.row==arr.count-1){
//            if (arr.count==Firstdict.qishu) {
//                return 60;
//            }else{
               return 70;
           // }
        }else{
            
            return 60;
        }
    }else{
    return 60;
    }
    
    
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString *tablehead=@"section";
    CMAllChiheadFootView *headCell=[tableView  dequeueReusableHeaderFooterViewWithIdentifier:tablehead];
    if (!headCell) {
        headCell=[[CMAllChiheadFootView  alloc]initWithReuseIdentifier:tablehead];
    }
   // DLog(@"self.dataDict+++%@",self.SmallArr);
    NSArray *arr=self.dataArr[section];
    
    CMChiYouModel *dict=arr.firstObject;
    headCell.productTitle.text=dict.title;
    return headCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   // DLog(@"+++%d",indexPath.section);
  NSArray *arr=self.dataArr[indexPath.section];
   NSMutableArray *marr=[NSMutableArray arrayWithArray:arr];
    //CMChiYouModel *dict=arr[indexPath.row];
    CMChiYouModel *Firstdict=arr.firstObject;
    // int qishu=[[dict objectForKey:@"qishu"]intValue];
    if (Firstdict.qishu>1) {
      
        if (arr.count==Firstdict.qishu) {
            NSMutableIndexSet *indexsets=[[NSMutableIndexSet alloc]init];
            for (int i=0; i<arr.count; i++) {
                if (i>0) {
                    [indexsets addIndex:i];
                }
                
            }
            Firstdict.pageCount=0;
     [marr removeObjectsAtIndexes:indexsets];
            
       //  NSMutableArray *data=[NSMutableArray arrayWithArray:self.dataArr];
           [self.dataArr replaceObjectAtIndex:indexPath.section withObject:marr];
//            self.dataArr=data;
            
           //[self bottomTotoalIncome];
            [self.myTableView reloadData];
        }else{
            
            Firstdict.pageCount++;
            [self requestDate:[NSString stringWithFormat:@"%d",Firstdict.zid] andPageIndex:[NSString stringWithFormat:@"%d",Firstdict.pageCount] indexRow:indexPath];
        }
    }
    
}
#pragma mark  请求数据
-(void)requestDate{
     NSString *page=[NSString stringWithFormat:@"%d",_pageIndex++];
    [CMRequestHandle  allChiYouProductListPageIndex:page andSuccess:^(id responseObj) {
        self.myTableView.hidden=NO;
        self.footView.hidden=NO;
      // DLog(@"++++++%@++%@++%@",responseObj,[responseObj objectForKey:@"Result"],page);
        
        if ([[responseObj objectForKey:@"Status"]intValue]==200) {
            [self.myTableView.mj_header  endRefreshing];
            [self.myTableView.mj_footer  endRefreshing];
            [self hiddenProgressHUD];
         NSArray *arr =[[responseObj objectForKey:@"t"]objectForKey:@"list"];
         self.footView.LXi.text=[NSString stringWithFormat:@"%@",[[responseObj objectForKey:@"t"]objectForKey:@"lx" ]];
         self.footView.BJin.text=[NSString stringWithFormat:@"%@",[[responseObj objectForKey:@"t"]objectForKey:@"bj" ]];
          self.footView.TotalIncome.text=[NSString stringWithFormat:@"%.2f",[self.footView.BJin.text floatValue]+[self.footView.LXi.text floatValue]];
            
            NSArray *modelArr=[CMChiYouModel  objectArrayWithKeyValuesArray:arr];
            if (_pageIndex == 2) {
                for (;0 < self.dataArr.count;) {
                    [self.dataArr removeObjectAtIndex:0];
                }
            }
            if (modelArr.count<=0) {
                
                [self.myTableView.mj_footer setState:MJRefreshStateNoMoreData];
                return ;
            }else{
                
                // 将刷新到的数据添加到数组的后面
                
                for (CMChiYouModel *item in modelArr) {
                    if (item != (CMChiYouModel *)[NSNull null]) {
                        NSMutableArray    *SmallArr=[NSMutableArray arrayWithCapacity:0];
                        [SmallArr addObject:item];
                        [self.dataArr addObject:SmallArr];
                        
                    }
                }
                
                
                //[self bottomTotoalIncome];
                
                
                
                [self.myTableView  reloadData];
            }
        }
    } andFailure:^(id error) {
        [self.myTableView.mj_header  endRefreshing];
        [self.myTableView.mj_footer  endRefreshing];
        
    }];
    
    
}

-(void)requestDate:(NSString *)ID andPageIndex:(NSString*)pageIndex indexRow:(NSIndexPath*)index{
    
    [CMRequestHandle allChiYouProductListPageIndex:pageIndex WithOrderID:ID andSuccess:^(id responseObj) {
       
        //DLog(@"more++++++%@",responseObj);
       
        if ([[responseObj objectForKey:@"Status"]intValue]==200) {
            NSArray *arr =[[responseObj objectForKey:@"t"]objectForKey:@"list"];
            
          
            NSArray *modelArr=[CMChiYouModel  objectArrayWithKeyValuesArray:arr];
            
            if (modelArr.count<=0) {
               
                NSArray *arr=self.dataArr[index.section];
                
                CMChiYouModel *dict=arr[index.row];
                //dict.pageCount=0;
                dict.qibie=0;
                CMAllChiCell *cell=[self.myTableView  cellForRowAtIndexPath:index];
                cell.loadMoreImage.hidden=YES;
                cell.userInteractionEnabled=NO;
                
                return ;
            }else{
                
            for (CMChiYouModel *item in modelArr) {
                if (item != (CMChiYouModel *)[NSNull null]) {
                    
                   NSMutableArray *sArr=[NSMutableArray arrayWithArray:self.dataArr[index.section]];
                    [sArr addObject:item];
                    [self.dataArr replaceObjectAtIndex:index.section withObject:sArr];
                 // DLog(@"sArr++++++%@",sArr);
                   


                }
                
                
            }
                //[self bottomTotoalIncome];
           }
            
          
            [self.myTableView reloadData];
        }
        
        
    } andFailure:^(id error) {
        
        
        
        
    }];
    
}
/*
#pragma mark 底部总和计算
-(void)bottomTotoalIncome{
    
    float z = 0.00;
    float b = 0.00;
    for (NSArray *arr in self.dataArr) {
        for (CMChiYouModel *LiXi in arr) {
            float a= [LiXi.amountlx floatValue];
            z +=a;
            self.footView.LXi.text=[NSString stringWithFormat:@"%.2f",z];
            float c= [LiXi.amountbj floatValue];
            b +=c;
            self.footView.BJin.text=[NSString stringWithFormat:@"%.2f",b];
            
        }
    }
    self.footView.TotalIncome.text=[NSString stringWithFormat:@"%.2f",[self.footView.BJin.text floatValue]+[self.footView.LXi.text floatValue]];
    

}
 */
@end
