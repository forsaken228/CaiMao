//
//  CMTiXianBank.m
//  CaiMao
//
//  Created by MAC on 16/6/28.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMTiXianBank.h"

@implementation CMTiXianBank

-(id)initWithBankList:(NSMutableArray*)arr{
    self=[super init];
    if (self) {
      
        self.frame=[UIScreen mainScreen].bounds;
        //模糊视图
        UIImageView  *bgView=[[UIImageView alloc]initWithFrame:self.frame];
        bgView.userInteractionEnabled=YES;
        bgView.backgroundColor=[UIColor blackColor];
        bgView.alpha=0.52f;
        [self addSubview:bgView];
       UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissView)];
        tap.delegate=self;
        [bgView addGestureRecognizer:tap];
        //弹框背景
        UIView *contentView=[[UIView alloc]init];
        contentView.center=bgView.center;
        contentView.bounds=CGRectMake(0, 0, 250,arr.count*50);
       
        contentView.backgroundColor=[UIColor whiteColor];
        contentView.userInteractionEnabled=YES;
        contentView.layer.cornerRadius=5.0;
        contentView.clipsToBounds=YES;
        [self addSubview:contentView];
      
        
        
        //创建tableView
        self.dataSourceArray=arr;
        UITableView *listTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, contentView.bounds.size.width, arr.count*50) style:UITableViewStylePlain];
        
        listTableView.autoresizingMask=UIViewAutoresizingFlexibleRightMargin;
        listTableView.rowHeight=50;
        listTableView.dataSource=self;
        listTableView.delegate=self;
        [contentView addSubview:listTableView];
        
        if ([listTableView respondsToSelector:@selector(setSeparatorInset:)]) {
            
            [listTableView setSeparatorInset:UIEdgeInsetsZero];
            
        }

    
    }
    return self;
}

#pragma mark tableView协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
        return self.dataSourceArray.count;
  
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *tCell=@"UITableViewCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:tCell];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tCell];
        
        
    }
    
    UILabel *bankName=[[UILabel alloc]init];
    
    bankName.textAlignment=NSTextAlignmentCenter;
    
    bankName.font=[UIFont boldSystemFontOfSize:14];
    bankName.text=self.dataSourceArray[indexPath.row];
    bankName.textColor=[UIColor lightGrayColor];
    // bankName.textColor=CMColor(77, 77, 77);
    [cell.contentView addSubview:bankName];
    
    [bankName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(200);
        make.centerX.equalTo(cell.mas_centerX);
        make.height.equalTo(@30);
        make.top.equalTo(cell.mas_top).offset(10);
    }];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_delegate respondsToSelector:@selector(alertViewShowWithRow:)]) {
        [_delegate alertViewShowWithRow:indexPath.row];
    }
}
-(void)dismissView{
    [self removeFromSuperview];
    if ([_delegate respondsToSelector:@selector(tapDimissView)]) {
        [_delegate tapDimissView];
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
    [self removeFromSuperview];
}

@end
