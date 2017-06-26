//
//  CMBankListController.m
//  CaiMao
//
//  Created by MAC on 16/10/24.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMBankListController.h"

@interface CMBankListController ()

@end

@implementation CMBankListController
-(void)loadView{
    [super loadView];
    [self bankList];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的银行卡";
   [CMNSNotice addObserver:self selector:@selector(renzhengSuccess) name:@"setIdealPasswordSuccess" object:nil];
    self.view.backgroundColor=ViewBackColor;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"我的账户" style:UIBarButtonItemStylePlain target:self action:@selector(goMyAuccount)];
  
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
//        NSDictionary *bankDict=[self.bankListArr firstObject];
//    NSDictionary *RenDict=[bankDict objectForKey:@"BankData"];
//    [self.dataList addObject:RenDict];
//    NSArray *AddBank=[bankDict objectForKey:@"AddBankData"];
//    for (NSDictionary *dict in AddBank) {
//        [self.dataList addObject:dict];
//    }
    
    self.tableView.tableFooterView=[self tableViewFootView];
    DLog(@"_________%@",self.dataList);
   
}
-(void)renzhengSuccess{
    self.NotSetIdeal=NO;
    
}
-(NSArray*)dataList{
    if (!_dataList) {
        _dataList=[NSArray array];
    }
    return _dataList;
}
-(NSMutableDictionary*)bankStateDict{
    if (!_bankStateDict) {
        _bankStateDict=[NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _bankStateDict;
}
-(void)goMyAuccount{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tCell=@"indexPath";
    CMMyBankListCell *cell = [tableView dequeueReusableCellWithIdentifier:tCell ];
    if (!cell) {
        cell=[[CMMyBankListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tCell];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    NSDictionary *dict=self.dataList[indexPath.row];
    
    DLog(@"url==%@",[NSString stringWithFormat:@"%@",[dict objectForKey:@"avatar"]]);
    [cell.bankIcon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dict objectForKey:@"avatar"]]] placeholderImage:nil];
    if ([[dict objectForKey:@"approve"]intValue]==1) {
        cell.RenZhengIcon.hidden=NO;
    }
    cell.bankName.text=[dict objectForKey:@"bankname"];
    cell.bankNum.text=[dict objectForKey:@"bankcode"]; //   stringByReplacingCharactersInRange:NSMakeRange(4, 11) withString:@"***********"];
    cell.TiXianCount.text=[NSString stringWithFormat:@"取现%@次",[dict objectForKey:@"draw"]];
    //NSString *time=[dict objectForKey:@"BankTime"];
//    cell.BDTime.text=[NSString stringWithFormat:@"绑定时间%@",[[time substringToIndex:9] stringByReplacingOccurrencesOfString:@"/" withString:@"."]];
    cell.BDTime.text=[NSString stringWithFormat:@"绑定时间%@",[dict objectForKey:@"date"]];
    
    
    return cell;
}
#pragma mark 区头
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   
    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0,0, CMScreenW, 40)];
    bgView.backgroundColor=ViewBackColor;
    UILabel *label=[[UILabel alloc]init];
    //label.backgroundColor=ViewBackColor;
    label.text=@"快捷支付只能绑定一张卡,请选择常用银行卡";
    label.font=[UIFont systemFontOfSize:13];
    label.textColor=UIColorFromRGB(0x8e8e93);
    //label.textAlignment=NSTextAlignmentCenter;
    [bgView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.centerY.equalTo(bgView);
        make.left.equalTo(bgView.mas_left).offset(30);
        make.width.equalTo(@300);
    }];
    UIImage *image=[UIImage imageNamed:@"topTiShi_image"];
    UIImageView *imageView=[[UIImageView alloc]init];
    imageView.image=image;
    [bgView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(f_i5real(image.size.height));
        make.width.mas_equalTo(f_i5real(image.size.width));
        make.centerY.equalTo(label);
        make.right.equalTo(label.mas_left).offset(-5);
    }];
    return bgView;

}
-(UIView *)tableViewFootView{
    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 150)];
    UILabel *tShi=[[UILabel alloc]init];
    tShi.numberOfLines=0;
    tShi.text=@"提醒:若要更换已认证银行卡,请点击";
    tShi.font=[UIFont systemFontOfSize:12.0];
    tShi.textColor=UIColorFromRGB(0x8e8e93);
    [bgView addSubview:tShi];
    [tShi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@192);
        make.left.equalTo(bgView.mas_left).offset(10);
        make.height.equalTo(@13);
        make.top.equalTo(bgView.mas_top).offset(10);
    }];
    UIButton *ChangeBank=[UIButton buttonWithType:UIButtonTypeSystem];
    ChangeBank.titleLabel.font=[UIFont systemFontOfSize:12];
    [ChangeBank setTitle:@"更换银行卡" forState:UIControlStateNormal];
    [ChangeBank setTitleColor:CMColor(78, 180, 242) forState:UIControlStateNormal];
   
    [ChangeBank addTarget:self action:@selector(ChangeBank) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:ChangeBank];
    [ChangeBank mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@62);
        make.height.equalTo(tShi);
        make.bottom.equalTo(tShi).offset(1);
        make.left.equalTo(tShi.mas_right);
        
    }];
    UILabel *tShi1=[[UILabel alloc]init];
    tShi1.text=@"变更";
    tShi1.font=[UIFont systemFontOfSize:12.0];
    tShi1.textColor=UIColorFromRGB(0x8e8e93);
    [bgView addSubview:tShi1];
    [tShi1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@30);
        make.height.bottom.equalTo(tShi);
        make.left.equalTo(ChangeBank.mas_right);
    }];
    UIButton *ReChargeBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    ReChargeBtn.titleLabel.font=[UIFont systemFontOfSize:14.0];
    [ReChargeBtn setTitle:@"充值" forState:UIControlStateNormal];
    [ReChargeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    ReChargeBtn.layer.cornerRadius=4.0;
    ReChargeBtn.clipsToBounds=YES;
    [ReChargeBtn setBackgroundColor:RedButtonColor];
    [ReChargeBtn addTarget:self action:@selector(ReChargeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:ReChargeBtn];
    [ReChargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left).offset(15);
        make.right.equalTo(bgView.mas_right).offset(-15);
        make.top.equalTo(tShi.mas_bottom).offset(20);
        make.height.mas_equalTo(buttonHeight);
        
    }];
    
    UILabel *tShi2=[[UILabel alloc]init];
    tShi2.numberOfLines=0;
    tShi2.lineBreakMode =NSLineBreakByWordWrapping;
//    tShi2.text=@"尊敬的财猫理财用户,更换绑定银行卡时,需发送身份证正反面照片,原卡提现后,注册手机号,至客服邮箱申请解绑,会有客服联系您,若原卡遗失,需提供银行挂失证明,身份证复印件正反面。如有其它疑问,请拨打财猫理财客服热线:4009993972";
    tShi2.text=@"换卡要求如下:\n 1、提供身份证正反面、新银行卡以及原银行卡的照片;\n 2、提供本人与身份证、新银行卡的合照;\n 3、合照上的本人与身份证上的照片必须一致、原银行卡和新银行卡与持卡人提供的资料必须一致;\n 4、若是因为原银行卡丢失而换卡，需提供原银行卡的挂失证明或原银行卡的交易流水;若是因不支持银行卡快捷支付或者其他情况而换卡，需提供原银行卡照片或原银行卡的交易流水。";
    tShi2.font=[UIFont systemFontOfSize:12.0];
    tShi2.textColor=UIColorFromRGB(0x8e8e93);
    
    [bgView addSubview:tShi2];
    [tShi2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left).offset(15);
        make.right.equalTo(bgView.mas_right).offset(-15);
        make.height.equalTo(@150);
        make.top.equalTo(ReChargeBtn.mas_bottom).offset(10);
    }];
    
    
    return bgView;
}
#pragma mark充值界面
-(void)ReChargeBtnClick{
    
    
    CMRechargeViewController *productVc = [[CMRechargeViewController alloc] init];
    
    [self.navigationController pushViewController:productVc animated:YES];
//    CMProductDetailController *pro=[[CMProductDetailController alloc]init];
//    pro.urlStr=[NSString stringWithFormat:@"%@/icm/acc/warecharge.aspx",OnLineCode];
//    [self.navigationController pushViewController:pro animated:YES];

    [CMRequestHandle requestRenZhengMsgsuccess:^(id responseObj) {
        if ([[responseObj objectForKey:@"status"]intValue]==200) {
            
            
        }
    }
     andFailure:^(id error) {
    }];
    
   

}
-(void)bankList{
    
    [CMRequestHandle getUserbankListWithUserID:[CMUserDefaults objectForKey:@"userID"] andSuccess:^(id responseObj) {
        if ([[responseObj objectForKey:@"Status"]intValue]==200) {
            
             DLog(@"++++%@",responseObj);
            self.dataList=[[responseObj objectForKey:@"t"]objectForKey:@"list"];
           
            [self.bankStateDict setObject:[[responseObj objectForKey:@"t"]objectForKey:@"state"] forKey:@"state" ];
            [self.bankStateDict setObject:[[responseObj objectForKey:@"t"]objectForKey:@"message"] forKey:@"message" ];
            [self.tableView reloadData];
        }else{
            
            CMTiShi([responseObj objectForKey:@"Result"]);
        }
    }];
}
#pragma mark更换银行卡
-(void)ChangeBank{
//    CMYZSFController *vc=[[CMYZSFController alloc]init];
//    vc.bankListArr=self.bankListArr;
//    CMPush(vc);
//  /*
    if (self.NotSetIdeal) { //没有设置交易密码
        CMSafeDetailAlert *DetailAlert=[[CMSafeDetailAlert alloc]initWithDeatilTitle:@"您还没有设置交易密码,不能进行更换银行!" WithCancleTitle:@"稍后再说" WithDetaildown:@"设置交易密码" withTag:10];
                         DetailAlert.delegate=self;
                       [DetailAlert ShowAlert];
        
    }else{
    
    if ([[self.bankStateDict objectForKey:@"state"]intValue]==0) {
        CMYZSFController *vc=[[CMYZSFController alloc]init];
        vc.bankListArr=self.bankListArr;
        CMPush(vc);
 
    }else if([[self.bankStateDict objectForKey:@"state"]intValue]==1){
     
        CMCheackController *vc=[[CMCheackController alloc]init];
        vc.type=CheackTypeISCheack;
        CMPush(vc);
    }else{
        
        CMCheackController *vc=[[CMCheackController alloc]init];
        vc.type=CheackTypeCheackFailure;
        vc.bankListArry=self.bankListArr;
        vc.message=[self.bankStateDict objectForKey:@"message"];
        CMPush(vc);
    }
        DLog(@"8990er0+++%@",self.bankStateDict);
    
    }
   
   //*/
}
-(void)jumpViewWithTag:(NSInteger)aTag{
    
    if(aTag==10){
        CMChangedetailController *vc=[[CMChangedetailController alloc]init];
        vc.type=ChangeViewControllerTypeDealPasswordSetting;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
        CGFloat sectionHeaderHeight = 40; //sectionHeaderHeight
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    
}
checkNet
@end
