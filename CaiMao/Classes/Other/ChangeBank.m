//
//  ChangeBank.m
//  TestAlertView
//
//  Created by MAC on 16/6/20.
//  Copyright © 2016年 MAC. All rights reserved.
//

#import "ChangeBank.h"

@implementation ChangeBank

-(id)initWithHistoryBankListWithBankList:(NSMutableArray*)arr{
    
    self=[super init];
    if (self) {
      
        self.frame=[UIScreen mainScreen].bounds;
        //模糊视图
        UIImageView  *bgView=[[UIImageView alloc]initWithFrame:self.frame];
        bgView.userInteractionEnabled=YES;
        bgView.backgroundColor=[UIColor blackColor];
        bgView.alpha=0.52f;
        [self addSubview:bgView];
        
        //弹框背景
        UIView *contentView=[[UIView alloc]init];//WithFrame:CGRectMake(50, 150, 220,(arr.count+1)*50)
        contentView.center=bgView.center;
        contentView.bounds=CGRectMake(0, 0, 220, (arr.count+1)*50);
        contentView.backgroundColor=[UIColor whiteColor];
        contentView.userInteractionEnabled=YES;
        contentView.layer.cornerRadius=5.0;
        contentView.clipsToBounds=YES;
        [self addSubview:contentView];
        
        UITapGestureRecognizer  *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissView)];
        
        [bgView addGestureRecognizer:tap];
              //创建tableView
        self.dataSourceArray=arr;
        UITableView *listTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, contentView.bounds.size.width, (arr.count+1)*50) style:UITableViewStylePlain];
        //listTableView.autoresizingMask=UIViewAutoresizingFlexibleHeight;
        listTableView.rowHeight=50;
        listTableView.dataSource=self;
        listTableView.delegate=self;
        self.myTableView=listTableView;
        [self viewDidLayoutSubviews];

        [contentView addSubview:listTableView];
        
       // self.dataSourceArray=@[@"工商银行(123)",@"建设银行(456)",@"中信银行(789)"];
        
    }
    
    return self;
}
-(void)dismissView
{
    [self removeFromSuperview];
    //    if ([_delegate respondsToSelector:@selector(buttonClick)]) {
    //        [_delegate buttonClick];
    //    }
    
}

#pragma mark tableView协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
    return self.dataSourceArray.count;
    }
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   static NSString *tCell=@"UITableViewCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:tCell];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tCell];
      
        
   }
    
    UILabel *bankName=[[UILabel alloc]init];
    //WithFrame:CGRectMake(0, 0, 220,50)
    bankName.textAlignment=NSTextAlignmentCenter;
    bankName.font=[UIFont systemFontOfSize:14];

    if (indexPath.section==0) {
        bankName.text=self.dataSourceArray[indexPath.row];
        bankName.textColor=CMColor(77, 77, 77);

    }else{
     bankName.text=@"使用新卡认证";
    bankName.textColor=CMColor(27, 133, 239);
        
    }
  
    
      [cell addSubview:bankName];
    [bankName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.height.equalTo(cell);
       
        
    }];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if ([_delegate respondsToSelector:@selector(alertViewShowWithSection:andRow:)]) {
        [_delegate alertViewShowWithSection:indexPath.section andRow:indexPath.row];
    }
}
// //展示alertView
-(void)ShowAlert
{
    UIWindow *window=[[[UIApplication sharedApplication]delegate]window];
    // //展示alertView,将alertView展示在window
    [window addSubview:self];
    
}
-(void)dimissAlert{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    [self removeFromSuperview];
}
-(void)viewDidLayoutSubviews
{
    if ([self.myTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.myTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.myTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.myTableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}
@end
