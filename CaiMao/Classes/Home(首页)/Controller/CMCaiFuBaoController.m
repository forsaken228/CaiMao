//
//  CMCaiFuBaoController.m
//  CaiMao
//
//  Created by Fengpj on 15/12/9.
//  Copyright © 2015年 58cm. All rights reserved.
//

#import "CMCaiFuBaoController.h"

#import "CMCaiFuBaoCell.h"
@interface CMCaiFuBaoController ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong) UITableView *caiFuBaoTableView;
@property(nonatomic,copy) NSString *inPutAmount;
@end

@implementation CMCaiFuBaoController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"财富宝";
  
    [self.view addSubview:self.caiFuBaoTableView];

    self.inPutAmount=@"";
}


#pragma mark lazy
-(UITableView*)caiFuBaoTableView{
    if(!_caiFuBaoTableView){
        
        _caiFuBaoTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _caiFuBaoTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _caiFuBaoTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _caiFuBaoTableView.dataSource = self;
        _caiFuBaoTableView.delegate = self;
        _caiFuBaoTableView.showsVerticalScrollIndicator=NO;
        _caiFuBaoTableView.tableHeaderView = [CMBarView barHeadViewWithImage:@"details_banner_cfb"];
        _caiFuBaoTableView.tableFooterView = [CMBarView barFootViewWithImage:@"details_cfb"];
        
        
    }
    return _caiFuBaoTableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cllId=@"UITableViewCell";
    CMCaiFuBaoCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    
    if (!cell) {
        cell=[[ CMCaiFuBaoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cllId];
        
       cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    [cell.caiFuBaoBtn addTarget:self action:@selector(cunRuBtnClick) forControlEvents:UIControlEventTouchUpInside];
    cell.input.delegate=self;
    [CMNSNotice  addObserver:self selector:@selector(txetFieldChange:) name:UITextFieldTextDidChangeNotification object:nil];
    return cell;
}
-(void)txetFieldChange:(NSNotification*)notice{
    UITextField *field=(UITextField*)notice.object;
    self.inPutAmount=field.text;
    if ([field.text isEqualToString:@""]||field.text.length<=0 ||field.text==nil||[field.text isKindOfClass:[NSNull class]]) {
        self.inPutAmount=@"0";
    }
}
#pragma mark 立即存入实现方法
- (void)cunRuBtnClick
{   //是否登陆过--->没有登陆 返回登陆界面
    if (![CMRequestManager islogin]) {
        CMLoginController *loginVc = [[CMLoginController alloc] init];
         [self.navigationController pushViewController:loginVc animated:NO];

    } else {
        CMZhuangRuCFBController *loginVc = [[CMZhuangRuCFBController alloc] init];
        loginVc.isFromHome=YES;
        loginVc.productCount=self.inPutAmount;
        CMPush(loginVc);
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return [self creatDingQiSectionHeadView];
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 40;
    }
    return 0.05;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.05;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

#pragma mark 创建区头
-(UIView*)creatDingQiSectionHeadView{
    
    UIView *bgView=[[UIView alloc]init];
    bgView.frame=CGRectMake(0, 0, CMScreenW, 40);
    bgView.backgroundColor = [UIColor whiteColor];
    
    UILabel *title=[UILabel new];
    //title.frame=CGRectMake(8, 3, 68, 34);
    title.text=@"财富宝";
    title.textColor=RedButtonColor;
    [bgView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.top.equalTo(bgView);
        make.left.equalTo(bgView.mas_left).offset(8);
        make.width.mas_equalTo(68);
    }];
    UILabel *right=[UILabel new];
   // right.frame=CGRectMake(107, 3, 205, 34);
    right.font=[UIFont systemFontOfSize:14.0];
    right.textAlignment=NSTextAlignmentRight;
    right.text=@"随存随取 每7天升息";
    right.textColor=[UIColor lightGrayColor];
    [bgView addSubview:right];
    [right mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.top.equalTo(bgView);
        make.right.equalTo(bgView.mas_right).offset(-8);
        make.width.mas_equalTo(205);
    }];
    
    UILabel *line=[UILabel new];
    line.backgroundColor=separateLineColor;
    [bgView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.left.width.equalTo(bgView);
        make.bottom.equalTo(bgView);
    }];
    return bgView;
    
}

#pragma mark 只能输入

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
return [NSString validateNumber:string];
}



@end
