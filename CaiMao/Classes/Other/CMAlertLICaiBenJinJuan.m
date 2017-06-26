//
//  CMAlertLICaiBenJinJuan.m
//  CaiMao
//
//  Created by MAC on 16/8/6.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMAlertLICaiBenJinJuan.h"

@implementation CMAlertLICaiBenJinJuan

-(id)initWithLiCaibenJinJuandata:(NSMutableArray*)Data{
    self=[super init];
    if (self) {
        
        self.dataSourceArray=Data;
        self.frame=[UIScreen mainScreen].bounds;
        //模糊视图
        UIImageView  *bgView=[[UIImageView alloc]initWithFrame:self.frame];
        bgView.userInteractionEnabled=YES;
        bgView.backgroundColor=[UIColor blackColor];
        bgView.alpha=0.52f;
        [self addSubview:bgView];
        tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissView)];
        tap.delegate=self;
        [bgView addGestureRecognizer:tap];
 
        UIView *contentView=[[UIView alloc]init];
        
        //contentView.frame=CGRectMake(0, 0, 260,350);
        
        contentView.backgroundColor=[UIColor whiteColor];
        contentView.userInteractionEnabled=YES;
        contentView.layer.cornerRadius=5.0;
        contentView.clipsToBounds=YES;
        [self addSubview:contentView];
        if (self.dataSourceArray.count<=0) {
            [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.height.mas_equalTo(100+45);
                make.left.right.bottom.mas_equalTo(self);
                
            }];
            
            tTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 100+45) style:UITableViewStylePlain];
          
        }else{
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(100+45*Data.count);
            make.left.right.bottom.mas_equalTo(self);
           
        }];
        
        tTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 100+45*Data.count) style:UITableViewStylePlain];
        }
        tTable.autoresizingMask=UIViewAutoresizingFlexibleHeight;
        tTable.scrollEnabled=NO;
        tTable.rowHeight=40;
        tTable.tableHeaderView=[self headView];
        tTable.tableFooterView=[self footView];
        tTable.dataSource=self;
        tTable.delegate=self;
        [contentView addSubview:tTable];

        
        
        [self viewWillLayoutSubviews];
        
    }
    
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataSourceArray.count<=0) {
        return 1;
    }else{
    
    return self.dataSourceArray.count;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *TCell=@"UITableViewCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:TCell];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TCell];
    }
    if (self.dataSourceArray.count<=0) {
         cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.textLabel.text=@"该产品不能使用优惠劵";
       
        
    }else{
    NSDictionary *dcit=self.dataSourceArray[indexPath.row];
   // DLog(@"self.dataSourceArray==%@",dcit);
  cell.textLabel.text=[NSString stringWithFormat:@"%@元面值 有效期:%@",[dcit objectForKey:@"MNum"], [dcit objectForKey:@"validityString"]
];
   
    }
    
    return cell;
}
-(UIView*)headView{
    
    UIView  *titleView=[UIView new];
    titleView.backgroundColor=[UIColor whiteColor];
    titleView.frame=CGRectMake(0, 0, CMScreenW, 40);
    UILabel *Headtitle=[[UILabel alloc]init];
    Headtitle.text=@"选择优惠券";
    Headtitle.font=[UIFont systemFontOfSize:16.0];
    [titleView addSubview:Headtitle];
    [Headtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.left.equalTo(titleView.mas_left).offset(8);
        make.top.equalTo(titleView);
        make.width.equalTo(@100);
        
        
    }];
    
    UIView *lineView=[[UIView alloc]init];
    
    lineView.backgroundColor=separateLineColor;
    [titleView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.width.left.equalTo(titleView);
        make.top.equalTo(Headtitle.mas_bottom);
    }];
    
    
    return titleView;
    
}

-(UIView *)footView{
    UIView *bgView=[[UIView alloc]init];
    bgView.backgroundColor=ViewBackColor;
    bgView.frame=CGRectMake(0, 0, CMScreenW, 60);
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
    btn.layer.cornerRadius=5.0;
    btn.layer.masksToBounds=YES;
    [btn setBackgroundColor:RedButtonColor];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bgView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.height.equalTo(@40);
        make.bottom.equalTo(bgView.mas_bottom);
        make.left.equalTo(bgView.mas_left).offset(10);
        make.right.equalTo(bgView.mas_right).offset(-10);
    }];
    
    
    return bgView;
}
-(void)cancleBtnClick{
    
    if ([_delegate respondsToSelector:@selector(tapDimissAlertView)]) {
        [_delegate  tapDimissAlertView ];
    }

    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataSourceArray.count>0) {
        
    
    if ([_delegate respondsToSelector:@selector(alertViewShowTiXianWithRow:)]) {
        [_delegate alertViewShowTiXianWithRow:indexPath.row];
    }
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
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if([NSStringFromClass([touch.view class])isEqual:@"UITableViewCellContentView"]){
        
        return NO;
        
    }
    
    return YES;
}
-(void)dismissView{
    
    
    if ([_delegate respondsToSelector:@selector(tapDimissAlertView)]) {
        [_delegate  tapDimissAlertView ];
    }
    
    
}
-(void)viewWillLayoutSubviews
{
    if ([tTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [tTable setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([tTable respondsToSelector:@selector(setLayoutMargins:)]) {
        [tTable setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}
@end
