//
//  CMCMAccountDespositHoldView.m
//  CaiMao
//
//  Created by WangWei on 17/3/24.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import "CMAccountDespositHoldView.h"
#import "CMAccountDespositHoldCell.h"
#import "CMConfirmRedeemView.h"
@interface CMAccountDespositHoldView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)NSMutableArray *dataArry;
@property(nonatomic,strong)CMRecordBgView *rbgView;
@end
@implementation CMAccountDespositHoldView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        self.rbgView.frame=CGRectMake(0, self.frame.origin.y, CMScreenW, self.bounds.size.height);
        [self addSubview:self.myTableView];
        [self addSubview:self.rbgView];
        [self LoadDataWithPageIndex:0];
        self.myTableView.mj_header=[CMRefreshHeader headerWithRefreshingBlock:^{
            [self LoadDataWithPageIndex:0];
            
        }];
     
            UIView *footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, f_i5real(50))];
            self.myTableView.tableFooterView=footView;

        self.myTableView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            NSInteger index=self.dataArry.count/5;
            [self LoadDataWithPageIndex:index];
        }];
    }
    return self;
}
#pragma mark Lazy
-(CMRecordBgView*)rbgView{
    if (!_rbgView) {
        _rbgView=[[CMRecordBgView alloc]init];
        [_rbgView creatHeadImage:@"cfbht_zrjl" andTitle:@"暂时没有记录"];;
       
        
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
        _myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, CMScreenH-350) style:UITableViewStyleGrouped];
        _myTableView.delegate=self;
        _myTableView.dataSource=self;
        _myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _myTableView.showsVerticalScrollIndicator=NO;
        _myTableView.showsHorizontalScrollIndicator=NO;
    }
    return _myTableView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  self.dataArry.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
       return 10;
    }else{
    return 0.01;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *TCell=@"UITableViewCell";
    CMAccountDespositHoldCell *cell=[tableView dequeueReusableCellWithIdentifier:TCell];
    
    if (!cell) {
        cell=[[CMAccountDespositHoldCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TCell];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }

    CMAsDespositHoldModel *holdModel=self.dataArry[indexPath.section];
    cell.depositLabel.text=[NSString stringWithFormat:@"存入日期:%@",holdModel.IntoDate];
    cell.radomLabel.text=[NSString stringWithFormat:@"￥%@",holdModel.Amount];
    cell.endLabel.text=[NSString stringWithFormat:@"封闭期:%@天",holdModel.FbDays];
    cell.radomLvLabel.text=[[NSString stringWithFormat:@"收益率:%@",holdModel.Syl]stringByAppendingString:@"%"];
    [self DoubleAttributedStringFromString:@"封" andEndString:@":" FromLabel:cell.endLabel];
    [self DoubleAttributedStringFromString:@"收" andEndString:@":" FromLabel:cell.radomLvLabel];
    
    if([holdModel.StatusName isEqualToString:@"赎回"]){
    [cell.redemptionbutton setTitle:holdModel.StatusName forState:UIControlStateNormal];
    cell.redemptionbutton.tag=indexPath.section;
    [cell.redemptionbutton addTarget:self action:@selector(cofirmClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [cell.redemptionbutton setTitleColor:UIColorFromRGB(0x00b2ed) forState:UIControlStateNormal];
    }else{
        [cell.redemptionbutton setTitle:holdModel.StatusName forState:UIControlStateNormal];
        [cell.redemptionbutton setTitleColor:UIColorFromRGB(0xbbbbbb) forState:UIControlStateNormal];
    }
    return cell;
    
}

-(void)DoubleAttributedStringFromString:(NSString*)FromStr andEndString:(NSString*)endStr FromLabel:(UILabel*)FromLabel{
    
    NSMutableAttributedString *qixianStr = [[NSMutableAttributedString alloc] initWithString:FromLabel.text];
    NSRange qiFromRang = [FromLabel.text rangeOfString:FromStr];
    NSRange qiToRang = [FromLabel.text rangeOfString:endStr];
    [qixianStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xbbbbbb) range:NSMakeRange(qiFromRang.location, qiToRang.location - qiFromRang.location+1)];
    FromLabel.attributedText = qixianStr;
    
}
-(void)cofirmClickEvent:(UIButton*)sender{
    CMAsDespositHoldModel *holdModel=self.dataArry[sender.tag];
  
    CMConfirmRedeemView *RedeemView=[[CMConfirmRedeemView alloc]init];
    RedeemView.orderId=holdModel.OrderID;
    [RedeemView ShowAlert];
}
-(void)setReceiveConfirm:(BOOL)receiveConfirm{
    if (receiveConfirm) {
        NSLog(@"hold");
        [self LoadDataWithPageIndex:0];
    }
    
}
-(void)LoadDataWithPageIndex:(NSInteger)index{
    [CMRequestHandle AsDepositHoldListWithPage:index andSuccess:^(id responseObj) {
      

      // NSLog(@"Hold++++%@++%@++%d",responseObj,[responseObj objectForKey:@"Result"],index);
            [self.myTableView.mj_header endRefreshing];
            [self.myTableView.mj_footer endRefreshing];
            if ([[responseObj objectForKey:@"Status"]intValue]==200) {
                NSArray *result=[[responseObj objectForKey:@"t"]objectForKey:@"list"];
                NSArray *NewResult=[CMAsDespositHoldModel objectArrayWithKeyValuesArray:result];
                if (index ==0) {
                [self.dataArry removeAllObjects];
                    
                }
                
                if (NewResult.count<=0) {
                    [self.myTableView.mj_footer setState:MJRefreshStateNoMoreData];
                    return ;
                }else{
                 [self.dataArry addObjectsFromArray:NewResult];
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
      
    }];
    
}


@end
