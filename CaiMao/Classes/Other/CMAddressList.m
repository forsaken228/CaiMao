//
//  CMAddressList.m
//  CaiMao
//
//  Created by MAC on 16/6/29.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMAddressList.h"

@implementation CMAddressList

-(id)initWithAddressList:(NSMutableArray*)arr{
    self=[super init];
    if (self) {
   
        self.frame=[UIScreen mainScreen].bounds;
        //模糊视图
        UIView  *bgView=[[UIView alloc]initWithFrame:self.frame];
        bgView.userInteractionEnabled=YES;
        bgView.backgroundColor=[UIColor blackColor];
        bgView.alpha=0.52f;
        [self addSubview:bgView];
         self.dataSourceArray=arr;
        tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissView)];
        tap.delegate=self;
        [bgView addGestureRecognizer:tap];
        //弹框背景
        UIView *contentView=[[UIView alloc]init];
       
        //contentView.frame=CGRectMake(0, 0, 260,350);
    
        contentView.backgroundColor=[UIColor whiteColor];
        contentView.userInteractionEnabled=YES;
        contentView.layer.cornerRadius=5.0;
        contentView.clipsToBounds=YES;
        [self addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(bgView);
            make.height.mas_equalTo(400);
            make.width.mas_equalTo(260);
        }];
        if (arr.count<=2) {
            
            //contentView.frame=CGRectMake(0, 0, 260,60);
            [contentView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(bgView);
                make.height.mas_equalTo(60);
                make.width.mas_equalTo(260);
            }];
            
        }if (arr.count<=0) {
            // contentView.center=bgView.center;
            [contentView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(bgView);
                make.height.mas_equalTo(30);
                make.width.mas_equalTo(260);
            }];
            
        }
        //创建tableView
       
        _listTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 260, 400) style:UITableViewStylePlain];
        
        //_listTableView.autoresizingMask=UIViewAutoresizingFlexibleHeight;
        
        _listTableView.rowHeight=30;
        _listTableView.dataSource=self;
        _listTableView.delegate=self;
        [contentView addSubview:_listTableView];
        
        [self viewWillLayoutSubviews];
        
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
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:tCell];
        
        cell.selectionStyle=UITableViewCellSelectionStyleBlue;
    }
    if (indexPath.row==0) {
       cell.textLabel.text=@"请选择>";
        
    }else{
    cell.textLabel.text=self.dataSourceArray[indexPath.row-1];
      
    }
      cell.textLabel.font=[UIFont systemFontOfSize:15];

    return cell;
    
}
-(void)dismissView{
    
    
    if ([_delegate respondsToSelector:@selector(tapDismissView)]) {
        [_delegate  tapDismissView ];
    }
    

}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if([NSStringFromClass([touch.view class])isEqual:@"UITableViewCellContentView"]){
        
        return NO;
        
    }
    
    return YES;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    
  
    if ([_delegate respondsToSelector:@selector(alertViewShowAddressWithRow:)]) {
        [_delegate  alertViewShowAddressWithRow:indexPath.row ];
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
    for (UIView *vc in self.subviews) {
        [vc removeFromSuperview];
    }
    [self removeFromSuperview];
}
-(void)viewWillLayoutSubviews
{
    if ([_listTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_listTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([_listTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_listTableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

@end
