//
//  CMZHuangChuViewController.m
//  CaiMao
//
//  Created by MAC on 16/11/10.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMZHuangChuViewController.h"

@interface CMZHuangChuViewController ()<UITextFieldDelegate>
{
    CMZhuangChuView *headView;


}
@property(nonatomic,copy)NSString *ZhuanChuAmount;
@property(nonatomic,copy)NSString *YuerAmount;
@end

@implementation CMZHuangChuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=ViewBackColor;
    self.title=@"财富宝转出";
    self.tableView.scrollEnabled=NO;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;

    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"转出说明" style:UIBarButtonItemStylePlain target:self action:@selector(zhuanchuShuoMing)];
    

           
           
                [self creatFootViewAndHeadView];
            
            
            
     
   
}
-(void)zhuanchuShuoMing{
    
    CMZhuanChuShuoMing *vc=[[CMZhuanChuShuoMing alloc]init];
    [vc ShowAlert];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}
-(void)creatFootViewAndHeadView{
    
    headView=[[CMZhuangChuView alloc]init];
    headView.CaiFuBaoYu.text=[NSString stringWithFormat:@"财富宝余额%@元",[self.yuAmountDict   objectForKey:@"amount"]];
    self.YuerAmount=[self.yuAmountDict    objectForKey:@"amount"];
    headView.TodayZhunaChu.text=[NSString stringWithFormat:@"今天已转出:%@元",[self.yuAmountDict    objectForKey:@"today_amount"]];
    headView.frame=CGRectMake(0, 0, CMScreenW, 80);
    self.tableView.tableHeaderView=headView;
    
    CMZhuanChuFootView *footView=[[CMZhuanChuFootView alloc]initWithButtonTitle:@"转出"];
    footView.frame=CGRectMake(0, 0, CMScreenW, CMScreenH);
    [footView.ZhuangChuBtn addTarget:self action:@selector(ZhuangChuBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView=footView;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CMZhuanChuFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"indexPath"];
    
    if (!cell) {
        cell=[[CMZhuanChuFirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"indexPath"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    cell.ZhuChuAmount.delegate=self;
    [CMNSNotice  addObserver:self selector:@selector(noticeTextFieldChange:) name:UITextFieldTextDidChangeNotification object:cell.ZhuChuAmount];
    
    self.ZhuanChuAmount=cell.ZhuChuAmount.text;
    return cell;
}
-(void)noticeTextFieldChange:(NSNotification*)notice{
    UITextField *field=(UITextField*)notice.object;
    if ([field.text intValue]<=100 &&[self.YuerAmount intValue]<=100) {
             field.text=self.YuerAmount;
    }

    self.ZhuanChuAmount=field.text;
    
}

-(void)ZhuangChuBtnAction{
    
      DLog(@"%@++++++",self.ZhuanChuAmount);

    [CMRequestHandle CaiFuBaoZhuanChuConfirmWithAmount:self.ZhuanChuAmount WithSuccess:^(id responseObj) {
        
        DLog(@"%@++++++%@",responseObj,[responseObj objectForKey:@"Result"]);
        if ([[responseObj objectForKey:@"Status"]intValue]==200) {
            
            CMZhuanChuSecondController *vc=[[CMZhuanChuSecondController alloc]init];
            vc.DataDict=[NSMutableDictionary dictionaryWithDictionary:[ responseObj objectForKey:@"t"]];
            [vc.DataDict setObject:self.ZhuanChuAmount forKey:@"ZhuanChuAmount"];
            
            [self.navigationController pushViewController:vc animated:NO];
            
        }else{
            
            CMTiShi([responseObj objectForKey:@"Result"]);
            
        }
        
        
    } andFailure:^(id error) {
        
    }];


    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [NSString validateNumber:string];
}

-(void)dealloc{
    [CMNSNotice removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    
}
@end
