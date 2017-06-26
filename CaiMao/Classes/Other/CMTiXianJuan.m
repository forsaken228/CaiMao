//
//  CMTiXianJuan.m
//  CaiMao
//
//  Created by MAC on 16/7/1.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMTiXianJuan.h"

@implementation CMTiXianJuan


-(id)initWithTiXianJuanList:(NSMutableArray*)arr{
    self=[super init];
    if (self) {
        self.dataSourceArray=arr;
        self.frame=[UIScreen mainScreen].bounds;
        //模糊视图
        UIImageView  *bgView=[[UIImageView alloc]initWithFrame:self.frame];
        bgView.userInteractionEnabled=YES;
        bgView.backgroundColor=[UIColor blackColor];
        bgView.alpha=0.52f;
        [self addSubview:bgView];
        
        //弹框背景
        UIView *contentView=[[UIView alloc]init];
        contentView.frame=CGRectMake(80, 300, 200,(arr.count+1)*30);
        if (arr.count<=0) {
            contentView.frame=CGRectMake(80, 300, 200,30);
        }
        
        contentView.backgroundColor=[UIColor whiteColor];
        contentView.userInteractionEnabled=YES;
        contentView.layer.cornerRadius=5.0;
        contentView.clipsToBounds=YES;
        [self addSubview:contentView];
        //创建tableView
        
        UITableView *listTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 200, (arr.count+1)*30) style:UITableViewStylePlain];
        
        listTableView.rowHeight=30;
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
    
    return self.dataSourceArray.count+1;
    
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
    UILabel *bankName=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200,30)];
    bankName.textAlignment=NSTextAlignmentCenter;
    bankName.font=[UIFont boldSystemFontOfSize:14];
   
    bankName.textColor=[UIColor lightGrayColor];
    // bankName.textColor=CMColor(77, 77, 77);
    [cell addSubview:bankName];
    if (self.dataSourceArray.count<=0) {
        bankName.text=@"暂无提现劵可用";
    }else{
    if (indexPath.row==0) {
        bankName.text=@"不使用提现劵";
        
    }else{
        
         bankName.text=self.dataSourceArray[indexPath.row-1];
    }
    }

        return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_delegate respondsToSelector:@selector(alertViewShowTiXianWithRow:)]) {
        [_delegate alertViewShowTiXianWithRow:indexPath.row];
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
