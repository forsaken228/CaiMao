//
//  CMSsecurityAssuranceController.m
//  CaiMao
//
//  Created by MAC on 16/8/9.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMSsecurityAssuranceController.h"
#import "CMTSafeGuardCell.h"
@interface CMSsecurityAssuranceController () 
@property(nonatomic,strong)UITableView *tTablew;
@end

@implementation CMSsecurityAssuranceController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"投资安全保障";
    self.view.backgroundColor=ViewBackColor;
    
    
    CMSafeGuardHead *headView= [[CMSafeGuardHead alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 70)];
    headView.proudctName.text=[self.pListDict objectForKey:@"title"];
    NSString *pid=[self.pListDict objectForKey:@"pid"];
    headView.proudctID.text=[NSString stringWithFormat:@"代码:%@",pid];
    NSMutableAttributedString *AttStr=[[NSMutableAttributedString alloc]initWithString: headView.proudctID.text];
NSRange startRang=[headView.proudctID.text rangeOfString:@":"];
   // NSRange endRang=[headView.proudctID.text rangeOfString:[self.pListDict objectForKey:@"pid"]];
    [AttStr addAttribute:NSForegroundColorAttributeName value:RedButtonColor range:NSMakeRange(startRang.location+1, pid.length)];
    headView.proudctID.attributedText=AttStr;
    
    //tTablew.rowHeight = 100;
    
    self.tTablew.tableHeaderView=headView;
    self.tTablew.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 100)];
   [self.view addSubview:self.tTablew];
    self.titleArr=@[@[@"基础资产安全"],@[@"项目安全"],@[@"资金安全"],@[@"专业的风险管理(7级风险管控)"],@[@"担保机构代偿赔付"],@[@"先行赔付(风险保障金超1亿元)"],@[@"交易安全与信息安全"]];
    self.detailArr=@[@[@"  基础资产为类政府债，政府兜底，财政还款担保；政府核心优质资产抵押；银行尽调及实时风险监测。"],@[@"  价值为先。财猫从源头控制风险，产品所挂钩的项目价值优先，必须具备“好团队+好企业+好项目”的基础条件，同时要求提供抵押+质押+保证，并监管还款资金，借款人如违约将上报央行征信系统。"],@[@"  财猫所有交易资金由银行托管和第三方支付全程监管。交易资金的保管完全按照“专户专款专用”的标准模式进行运作，投资者可以实时查询账户资金交易详情，账户资金只能转出到财猫认证过的银行账号。财猫不接触交易资金，坚持阳光化、透明化、公平化、合法合规的原则，保障交易资金安全。"],@[@"  财猫与专业的风险管理机构紧密合作，利用国际最先进的信用管理模型，及安全的7级风险管控体系，实时监测管理每一笔交易资金，安全无忧。"],@[@"  财猫与银行系或金融控股集团背景的大型担保机构合作，为会员投资安全提供代偿保障，确保投资人本金和收益安全。合作担保机构资产均不低于60亿，担保能力超过百亿，根据授信额度向财猫缴纳保证金，代偿有保障。"],@[@"  “先行赔付”是财猫保障会员投资安全的重要保障体系。当会员加入“投资安全保障计划”在财猫投资后，如因借款人问题导致投资人本金受损，投资人有权按照本规则向借款人追偿，并申请“先行赔付”。财猫建立风险保障金制度用于“先行赔付”，保障金来源于交易服务费、担保保证金、罚息等定期拨付，目前已超过1亿元。"],@[@"  财猫采用银行级系统安全措施。交易系统采用国内领先的技术加密，配合手机短信动态码验证，让您的交易更加安全，更有保障。财猫承诺不会在网站上透露交易双方的个人信息和隐私，确保个人信息不被人擅自或意外取得、处理或删除。"]];
    
    

}

-(UITableView*)tTablew{
    if (!_tTablew) {
        _tTablew=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, CMScreenH) style:UITableViewStyleGrouped];
        _tTablew.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tTablew.delegate=self;
        _tTablew.dataSource=self;
    }
    return _tTablew;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
      return 1;

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.titleArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *TCell=@"UITableViewCell";
    CMTSafeGuardCell *cell=[tableView dequeueReusableCellWithIdentifier:TCell];
    if (!cell) {
        cell=[[CMTSafeGuardCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TCell];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    cell.sTitle.text=self.titleArr[indexPath.section][0];
    NSString *detail=self.detailArr[indexPath.section][0];
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:detail];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:6];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [detail length])];
    [cell.sDetailTitle setAttributedText:attributedString1];
    [cell.sDetailTitle sizeToFit];

    //cell.sDetailTitle.text=detail;
    cell.sDetailTitle.lineBreakMode = NSLineBreakByWordWrapping;
  CGRect   Gheight=[detail boundingRectWithSize:CGSizeMake(CMScreenW-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]} context:nil];
   // cell.sDetailTitle.frame=CGRectMake(10, 25, CMScreenW-20, Gheight.size.height+70);
    [cell.sDetailTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(Gheight.size.height+40);
        make.top.equalTo(cell.sTitle.mas_bottom);
        make.left.equalTo(cell.contentView.mas_left).offset(10);
        make.right.equalTo(cell.contentView.mas_right).offset(-10);
    }];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *detail=self.detailArr[indexPath.section][0];
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:detail];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:6];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [detail length])];
   
   // cell.sDetailTitle.text=detail;
 CGRect Gheight=[detail boundingRectWithSize:CGSizeMake(CMScreenW-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]} context:nil];
    return Gheight.size.height+70;
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
   
        return 10.0f;
    
  
}

@end
