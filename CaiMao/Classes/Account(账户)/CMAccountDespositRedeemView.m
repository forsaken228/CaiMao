//
//  CMCMCMAccountDespositRedeemView.m
//  CaiMao
//
//  Created by WangWei on 17/3/24.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import "CMAccountDespositRedeemView.h"
#import "CMAccountDespositRedeemCell.h"
@interface CMAccountDespositRedeemView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)CMRecordBgView *rbgView;
@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)NSMutableArray *dataArry;
@end
@implementation CMAccountDespositRedeemView

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
        UIView *footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, f_i5real(300))];
        footView.backgroundColor=ViewBackColor;
        _myTableView.tableFooterView=footView;
    }
    return _myTableView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArry.count;
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
    CMAccountDespositRedeemCell *cell=[tableView dequeueReusableCellWithIdentifier:TCell];
    
    if (!cell) {
        cell=[[CMAccountDespositRedeemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TCell];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    CMAsDespositRedeemModel  *model=self.dataArry[indexPath.section];
    cell.redeemTimeLabel.text=[NSString stringWithFormat:@"赎回时间:%@",model.ShuHuiTime];
    cell.annualProfitLabel.text=[[NSString stringWithFormat:@"年收益率:%@",model.Syl]stringByAppendingString:@"%"];
    [self DoubleAttributedStringFromString:@"年" andEndString:@":" FromLabel:cell.annualProfitLabel];
    cell.JxDateLabel.text=[NSString stringWithFormat:@"计息天数:%@天",model.JxDays];
     [self DoubleAttributedStringFromString:@"计" andEndString:@":" FromLabel:cell.JxDateLabel];
    cell.productBZ.text=[NSString stringWithFormat:@"￥%@",model.Amount];
    cell.productSY.text=[NSString stringWithFormat:@"￥%@",model.Amount_Lx];


    
    CGRect rect=[ cell.productBZ.text boundingRectWithSize:CGSizeMake(100, 14) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil];
    [cell.productBZ mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(rect.size.width+5);
    }];

    CGRect rectSecond=[ cell.productSY.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 14) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil];
    [cell.productSY mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(rectSecond.size.width+2);
    }];
    
    
    return cell;
    
}
-(void)DoubleAttributedStringFromString:(NSString*)FromStr andEndString:(NSString*)endStr FromLabel:(UILabel*)FromLabel{
    
    NSMutableAttributedString *qixianStr = [[NSMutableAttributedString alloc] initWithString:FromLabel.text];
    NSRange qiFromRang = [FromLabel.text rangeOfString:FromStr];
    NSRange qiToRang = [FromLabel.text rangeOfString:endStr];
    [qixianStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xbbbbbb) range:NSMakeRange(qiFromRang.location, qiToRang.location - qiFromRang.location+1)];
    FromLabel.attributedText = qixianStr;
    
}
-(void)setReceiveConfirm:(BOOL)receiveConfirm{
    if (receiveConfirm) {
        NSLog(@"redeem");
        [self LoadDataWithPageIndex:0];
    }
    
}

-(void)LoadDataWithPageIndex:(NSInteger)index{
    [CMRequestHandle AsDepositRedeemListWithPage:index andSuccess:^(id responseObj) {
        
        
       // NSLog(@"赎回++++%@++%@++%d",responseObj,[responseObj objectForKey:@"Result"],index);
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
        if ([[responseObj objectForKey:@"Status"]intValue]==200) {
            NSArray *result=[[responseObj objectForKey:@"t"]objectForKey:@"list"];
            NSArray *NewResult=[CMAsDespositRedeemModel objectArrayWithKeyValuesArray:result];
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
