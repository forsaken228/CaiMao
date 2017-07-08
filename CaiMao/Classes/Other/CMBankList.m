//
//  CMBankList.m
//  CaiMao
//
//  Created by MAC on 16/6/16.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMBankList.h"
#import "CMBankModel.h"
@interface CMBankList ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)NSArray *dataArr;
@end
@implementation CMBankList
-(id)init{
    self=[super init];
    if (self) {

        [self creatTopContent];
        [self LoadData];
        [self viewWillLayoutSubviews];
        
    }
    return self;
    

}
#pragma mark 顶部内容
-(void)creatTopContent{
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
-(NSArray*)dataArr{
    if (!_dataArr) {
        _dataArr=[NSArray array];
    }
    return _dataArr;
}

#pragma mark银行列表
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
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
    CMBankModel *model=self.dataArr[indexPath.row];
    cell.bankName.text=model.name;
    cell.limit.text=model.banksquota;
    [cell.BankIcon sd_setImageWithURL:[NSURL URLWithString:model.nameIcon] placeholderImage:nil options:SDWebImageProgressiveDownload];
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
-(void)LoadData{
    
    [CMRequestHandle requestSupportBankListMsgsuccess:^(id responseObj) {
        
        NSArray *result=[responseObj objectForKey:@"result"];
        NSDictionary *dict=result.firstObject;
        NSArray  *listArray=[dict objectForKey:@"bankName"];
       // DLog(@"支持银行++++%@",[CMBankModel mj_objectArrayWithKeyValuesArray:listArray]);
            self.dataArr=[CMBankModel mj_objectArrayWithKeyValuesArray:listArray];
            [self.myTableView reloadData];
        
    }];
}
@end
