//
//  CMBankList.m
//  CaiMao
//
//  Created by MAC on 16/6/16.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMBankList.h"
@implementation CMBankList
-(id)initCreateBankListArry:(NSArray*)bankArry{
    self=[super init];
    if (self) {

    
        [self creatTopContent:bankArry];
        
        [self viewWillLayoutSubviews];
        
    }
    return self;
    

}
#pragma mark 顶部内容
-(void)creatTopContent:(NSArray *)arr{
    self.frame=[UIScreen mainScreen].bounds;
    //模糊视图
    UIImageView  *bgView=[[UIImageView alloc]initWithFrame:self.frame];
    bgView.userInteractionEnabled=YES;
    bgView.backgroundColor=[UIColor blackColor];
    bgView.alpha=0.52f;
    [self addSubview:bgView];
    //弹框背景
    UIImageView *contentView=[[UIImageView alloc]init];//WithFrame:CGRectMake(20, 100, 280,400)
    contentView.backgroundColor=[UIColor whiteColor];
    contentView.userInteractionEnabled=YES;
    contentView.layer.cornerRadius=5.0;
    contentView.clipsToBounds=YES;
    [self addSubview:contentView];
    UITapGestureRecognizer  *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissView)];
    
    [bgView addGestureRecognizer:tap];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.mas_top).offset(100);
        make.centerX.equalTo(bgView);
        make.width.mas_equalTo(280);
        make.height.mas_equalTo(450);
    }];
    
    //弹框顶部背景
    UIImageView *topView=[[UIImageView alloc]init];//WithFrame:CGRectMake(0, 0, 280,62)
    topView.backgroundColor=RedButtonColor;
    topView.userInteractionEnabled=YES;
    [contentView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
   
        make.left.right.top.equalTo(contentView);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *topTitle=[[UILabel alloc]init];
    topTitle.font=[UIFont systemFontOfSize:12];
    topTitle.text=@"支持的银行卡和限额";
    topTitle.textAlignment=NSTextAlignmentCenter;
    topTitle.textColor=[UIColor whiteColor];
    [topView addSubview:topTitle];
    [topTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(topView);
        make.top.equalTo(topView.mas_top).offset(5);
        make.height.mas_equalTo(13);
    }];
   
    UILabel *bottomTitle=[[UILabel alloc]init];
    bottomTitle.font=[UIFont systemFontOfSize:11];
    bottomTitle.text=@"充值限额会根据银行规定适时调整，仅供参考";
    bottomTitle.textAlignment=NSTextAlignmentCenter;
    bottomTitle.textColor=[UIColor whiteColor];
    [topView addSubview:bottomTitle];
    [bottomTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(topView);
        make.top.equalTo(topTitle.mas_bottom).offset(5);
        make.height.mas_equalTo(12);
    }];
    
//    UIButton *CancleBtn=[UIButton buttonWithType:UIButtonTypeSystem];
//    CancleBtn.frame=CGRectMake(245, 5, 30, 30);
//    //CancleBtn.alpha=0.5;
//    CancleBtn.layer.cornerRadius=15.0;
//    CancleBtn.clipsToBounds=YES;
//    //[CancleBtn setBackgroundImage:[UIImage imageNamed:@"cancleBtn"] forState:UIControlStateNormal];
//    CancleBtn.titleLabel.font=[UIFont boldSystemFontOfSize:15.0];
//    [CancleBtn setTitle:@"取消" forState:UIControlStateNormal];
//    [CancleBtn setTitleColor:RedButtonColor forState:UIControlStateNormal];
//    [CancleBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
//    
//    [contentView addSubview:CancleBtn];
//    

    for (NSDictionary *name in arr) {
        NSString *nameArray=[name objectForKey:@"name"];
        
        //self.BankNameArray=nameArray;
        [self.BankNameArray addObject:nameArray];
    }
    for (NSDictionary *limit in arr) {
        NSString *nameArray=[limit objectForKey:@"banksquota"];
        //self.BankNameArray=nameArray;
        [self.BankLimitArray addObject:nameArray];
    }
    for (NSDictionary *icon in arr) {
        NSString *nameArray=[icon objectForKey:@"nameIcon"];
        
        //self.BankNameArray=nameArray;
        [self.BankIconArray addObject:nameArray];
    }
    
    
    
   
   
    [contentView addSubview:self.myTableView];
    

    
}

#pragma mark Lazy
-(UITableView*)myTableView{
    if (!_myTableView) {
       _myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 40, 280,450-40) style:UITableViewStylePlain];
        
        _myTableView.dataSource=self;
        _myTableView.delegate=self;
        _myTableView.rowHeight=47;
            }
    
    return _myTableView;
}
-(NSMutableArray*)BankIconArray{
    if (!_BankIconArray) {
        _BankIconArray=[NSMutableArray arrayWithCapacity:0];
    }
    return _BankIconArray;
}
-(NSMutableArray*)BankNameArray{
    if (!_BankNameArray) {
        _BankNameArray=[NSMutableArray arrayWithCapacity:0];
    }
    return _BankNameArray;
}
-(NSMutableArray*)BankLimitArray{
    if (!_BankLimitArray) {
        _BankLimitArray=[NSMutableArray arrayWithCapacity:0];
    }
    return _BankLimitArray;
}

#pragma mark银行列表
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.BankNameArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
static NSString *tCell=@"cell";
    CMBankListCell *cell=[tableView dequeueReusableCellWithIdentifier:tCell];
    if (!cell) {
        cell=[[CMBankListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tCell];
        cell.selectionStyle=UITableViewCellSeparatorStyleNone;
      
    }
    
    cell.bankName.text=self.BankNameArray[indexPath.row];
    cell.limit.text=self.BankLimitArray[indexPath.row];
    [cell.BankIcon sd_setImageWithURL:self.BankIconArray[indexPath.row] placeholderImage:nil options:SDWebImageProgressiveDownload];
    return cell;
}
#pragma mark展示AlertView
// //展示alertView
-(void)show
{
    UIWindow *window=[[[UIApplication sharedApplication]delegate]window];
    // //展示alertView,将alertView展示在window
    [window addSubview:self];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 5;
}

#pragma mark 取消
-(void)dismissView
{
    [self removeFromSuperview];
//    if ([_delegate respondsToSelector:@selector(buttonClick)]) {
//        [_delegate buttonClick];
//    }
    
}
-(void)viewWillLayoutSubviews
{
    if ([self.myTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.myTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.myTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.myTableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}
@end
