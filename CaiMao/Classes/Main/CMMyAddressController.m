//
//  CMMyAddressController.m
//  CaiMao
//
//  Created by MAC on 16/9/7.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMMyAddressController.h"

@interface CMMyAddressController ()
{
    UITextField *YouBian;
    UITextView *YouAddress;
     UILabel *textViewPlaceholderLabel;
    UITextField *phoneText;


}
@property(nonatomic,strong)NSDictionary *requestDict;
@end

@implementation CMMyAddressController
-(void)loadView{
    [super loadView];
    [self getAddress];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的地址";
    self.view.backgroundColor=ViewBackColor;
    
    [CMNSNotice addObserver:self selector:@selector(renzhengSuccess) name:@"renzhengSuccess" object:nil];
    [CMNSNotice addObserver:self selector:@selector(renzhengSuccess) name:@"setIdealPasswordSuccess" object:nil];
    
            //回到主线程操作代码块
    self.tableView.tableFooterView=[self creatHeadView];
   
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
   
}

-(void)renzhengSuccess{
     [self getAddress];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    if (![YouAddress.text isEqualToString:@""])
    {
        textViewPlaceholderLabel.hidden = YES;
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0;
}
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
     view.tintColor = [UIColor clearColor];

}

-(UIView*)creatHeadView{
    UIView *bgview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, CMScreenH)];
    bgview.backgroundColor=[UIColor whiteColor];
    UILabel *msg=[[UILabel alloc]init];
    msg.text=@"手机号";
    msg.textColor=UIColorFromRGB(0x333333);
    msg.font=[UIFont systemFontOfSize:14.0];
    [bgview  addSubview:msg];
    [msg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@14);
        make.top.equalTo(bgview.mas_top).offset(15);
        make.left.equalTo(bgview.mas_left).offset(15);
        make.width.mas_equalTo(100);
    }];
   
    UIImageView *list=[[UIImageView alloc]init];
    // list.frame=CGRectMake(295,16, 7,11);
    list.image=[UIImage imageNamed:@"listOpen.png"];
    [bgview addSubview:list];
    [list mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgview.mas_right).offset(-15);
        make.centerY.equalTo(msg.mas_centerY);
        make.height.mas_equalTo(11);
        make.width.mas_equalTo(7);
        
    }];
    
    UIButton *xiugai=[UIButton buttonWithType:UIButtonTypeSystem];
    [xiugai setTitle:@"修改" forState:UIControlStateNormal];
    [xiugai setTitleColor:CMColor(27, 172, 236) forState:UIControlStateNormal];
    xiugai.titleLabel.font=[UIFont systemFontOfSize:14.0];
    [xiugai setBackgroundColor:[UIColor whiteColor]];
    [xiugai addTarget:self action:@selector(ChangePhoneNumBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgview addSubview:xiugai];
    [xiugai mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(list.mas_left).offset(-2);
        make.width.equalTo(@30);
        make.centerY.height.equalTo(msg);
        
    }];
    
    UILabel *line=[[UILabel alloc]init];
    line.backgroundColor=separateLineColor;
    [bgview addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.left.width.equalTo(bgview);
        make.top.equalTo(msg.mas_bottom).offset(15);
        
    }];

    
   NSString *phoneNum=[CMUserDefaults valueForKey:@"name"];
    phoneText=[[UITextField alloc]init];
    phoneText.font=[UIFont systemFontOfSize:14.0];
    phoneText.userInteractionEnabled=NO;
    phoneText.textColor=UIColorFromRGB(0x8e8e93);
    phoneText.text=[phoneNum stringByReplacingCharactersInRange:NSMakeRange(3,4) withString:@"****"];
    [bgview addSubview:phoneText];
    [phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@100);
        make.right.equalTo(xiugai.mas_left).offset(-2);
        make.centerY.equalTo(xiugai);
        make.height.equalTo(@20);
    }];
    
    

    UILabel *YouBiantext=[[UILabel alloc]init];
    YouBiantext.text=@"邮编";
    YouBiantext.textColor=UIColorFromRGB(0x333333);
    YouBiantext.font=[UIFont systemFontOfSize:14.0];
    [bgview addSubview:YouBiantext];
    [YouBiantext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.left.equalTo(msg);
      
        make.top.equalTo(line.mas_bottom).offset(15);
        
    }];
    
  YouBian=[[UITextField alloc]init];
    // phoneText.borderStyle=UITextBorderStyleLine;
    YouBian.font=[UIFont systemFontOfSize:14.0];
    YouBian.keyboardType=UIKeyboardTypeNumberPad;
    YouBian.textColor=UIColorFromRGB(0x8e8e93);
    YouBian.delegate=self;
    YouBian.placeholder=@"请输入您当地邮编号";
    [bgview addSubview:YouBian];
    [YouBian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.left.equalTo(phoneText);
        make.width.equalTo(@150);
        make.centerY.equalTo(YouBiantext);
      
    }];
    
    
    UILabel *line1=[[UILabel alloc]init];
    line1.backgroundColor=separateLineColor;
    [bgview addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.left.equalTo(line);
        make.top.equalTo(YouBiantext.mas_bottom).offset(15);
        
    }];
    
  
    UILabel *YouAddresstext=[[UILabel alloc]init];
    YouAddresstext.text=@"邮编地址";
    YouAddresstext.textColor=UIColorFromRGB(0x333333);
    YouAddresstext.font=[UIFont systemFontOfSize:14.0];
    [bgview addSubview:YouAddresstext];
    [YouAddresstext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.left.equalTo(msg);
        make.top.equalTo(line1.mas_bottom).offset(15);
        
    }];
    textViewPlaceholderLabel = [[UILabel alloc] init];
    textViewPlaceholderLabel.text = @"请详细填写您的收货地址,便于财小猫给您邮寄礼品!";
    
    textViewPlaceholderLabel.numberOfLines=0;
    textViewPlaceholderLabel.textColor =[UIColor lightGrayColor];
    textViewPlaceholderLabel.font=[UIFont systemFontOfSize:12.0];
    YouAddress=[[UITextView alloc]init];
    YouAddress.font=[UIFont systemFontOfSize:13.0];
    YouAddress.textColor=UIColorFromRGB(0x8e8e93);
    YouAddress.layer.borderColor=separateLineColor.CGColor;
    YouAddress.layer.borderWidth=0.5;
    YouAddress.delegate=self;
   
    [bgview addSubview:YouAddress];
     [bgview addSubview: textViewPlaceholderLabel];
    [YouAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgview.mas_left).offset(20);
        make.right.equalTo(bgview.mas_right).offset(-20);
        make.height.equalTo(@80);
        make.top.equalTo(YouAddresstext.mas_bottom).offset(15);
    }];
    
    [textViewPlaceholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@15);
        make.left.equalTo(YouAddress.mas_left).offset(3);
        make.right.equalTo(YouAddress.mas_right);
        make.top.equalTo(YouAddress.mas_top).offset(8);
    }];
    

   
    UIButton *saveBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveBtn.titleLabel.font=[UIFont systemFontOfSize:15.0];
    [saveBtn setBackgroundColor:RedButtonColor];
    [saveBtn addTarget:self action:@selector(saveAddressBtnClick) forControlEvents:UIControlEventTouchUpInside];
    saveBtn.layer.cornerRadius=5.0;
    saveBtn.layer.masksToBounds=YES;
    [bgview addSubview:saveBtn];
    
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgview.mas_left).offset(10);
        make.right.equalTo(bgview.mas_right).offset(-10);
        make.height.mas_equalTo(buttonHeight);
        make.top.equalTo(YouAddress.mas_bottom).offset(20);
        
    }];
    
    return bgview;
}
#define mark 保存地址
-(void)saveAddressBtnClick{
    
    if ([YouBian.text isEqualToString:nil]||YouBian.text.length<=0) {
        
        CMAlert(@"请输入邮编!")
        return;
    }
    if ([YouAddress.text isEqualToString:nil]||YouAddress.text.length<=0) {
        
        CMAlert(@"请输入邮编地址!")
        return;
    }
   
  
    [self UpLoadAddress];
}

-(void)ChangePhoneNumBtnClick{
//    CMProductDetailController *productVc = [[CMProductDetailController alloc] init];
//    productVc.urlStr =[NSString stringWithFormat:@"%@/icm/zl/ccmob.aspx",OnLineCode];
//    
//    [self.navigationController pushViewController:productVc animated:YES];
       CMChangedetailController *vc=[[CMChangedetailController alloc]init];
    if ([[self.requestDict objectForKey:@"jy_password"]intValue]==0) {
        CMSafeDetailAlert *DetailAlert=[[CMSafeDetailAlert alloc]initWithDeatilTitle:@"您还没有设置交易密码,不能进行手机号修改的操作!" WithCancleTitle:@"稍后再说" WithDetaildown:@"设置交易密码" withTag:10];
        DetailAlert.delegate=self;
        [DetailAlert ShowAlert];
    }else{
        
        vc.type=ChangeViewControllerTypePhoneAuthentication;
        
        [self.navigationController pushViewController:vc animated:YES];
    }

    
    
}

-(void)jumpViewWithTag:(NSInteger)aTag{
    DLog(@"tag++=%d",aTag);
    switch (aTag) {
        case 10:
            //
            if ([[self.requestDict objectForKey:@"by_sfrz"]intValue]==0) {
                CMSafeDetailAlert *DetailAlert=[[CMSafeDetailAlert alloc]initWithDeatilTitle:@"请先完成实名认证,才能设置交易密码" WithCancleTitle:@"稍后再说" WithDetaildown:@"实名认证" withTag:11];
                DetailAlert.delegate=self;
                [DetailAlert ShowAlert];
            }else{
                CMChangedetailController *vc=[[CMChangedetailController alloc]init];
                vc.type=ChangeViewControllerTypeDealPasswordSetting;
                
                [self.navigationController pushViewController:vc animated:YES];
            }
            
            
            break;
        case 11:
            //实名认证
            [self rezhengMsg];
            
            
            break;
        default:
            break;
    }
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //[text isEqualToString:@""] 表示输入的是退格键
    if (![text isEqualToString:@""])
    {
        textViewPlaceholderLabel.hidden = YES;
    }
    
    //range.location == 0 && range.length == 1 表示输入的是第一个字符
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
        
    {
        textViewPlaceholderLabel.hidden = NO;
    }
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
    
}

-(void)rezhengMsg{
    
    
    if (self.UserBankListArr) {
//        NSDictionary *dic=[self.UserBankListArr firstObject];
//        NSMutableDictionary *userDic=[[NSMutableDictionary alloc]initWithCapacity:0];
//        [userDic setObject:[dic objectForKey:@"name"] forKey:@"name"];
//        [userDic setObject:[dic objectForKey:@"cardid"] forKey:@"nameID"];
//        [userDic setObject:[CMUserDefaults objectForKey:@"userID"] forKey:@"userID"];
        CMUserTrueController *productVc = [[CMUserTrueController alloc] init];
//        productVc.userMessageArray=[dic objectForKey:@"AddBankData"];
//        productVc.userMsg=userDic;
        [self.navigationController pushViewController:productVc animated:YES];

        
    }
    
    }

-(NSDictionary*)requestDict{
    if (!_requestDict) {
        _requestDict=[NSDictionary dictionary];
    }
    return _requestDict;
}
#pragma mark 保存
-(void)getAddress{
    
    
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_MyAddress.ashx?Action=5",OnLineCode];
    
    NSDictionary *dict=@{@"HYID":[CMUserDefaults objectForKey:@"userID"]};
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        
        DLog(@"我的地址===%@==%@",responseObj,[responseObj objectForKey:@"Result"]);
        if([[responseObj objectForKey:@"Status"]intValue]==200){
            NSDictionary *dict=[responseObj objectForKey:@"t"];
            if ([dict objectForKey:@"address"]!=nil&&![[dict objectForKey:@"address"] isKindOfClass:[NSNull class]]&&[dict objectForKey:@"Post"]!=nil&&![[dict objectForKey:@"Post"] isKindOfClass:[NSNull class]]) {
                phoneText.text=[[dict objectForKey:@"sj"] stringByReplacingCharactersInRange:NSMakeRange(3,4) withString:@"****"];
                YouAddress.text=[dict objectForKey:@"address"];
                YouBian.text=[dict objectForKey:@"Post"];
                
                if (![YouAddress.text isEqualToString:@""])
                {
                    textViewPlaceholderLabel.hidden = YES;
                }
 
            }
            
        }
        
    } failure:^(NSError *error) {
        
        
        
    }];
    
    
    [CMRequestHandle RequestUserStateWithUserID:[CMUserDefaults objectForKey:@"userID"] andSuccess:^(id responseObj) {
        //  DLog(@"responseObj+++++++%@",responseObj);
        if ([[responseObj objectForKey:@"Status"]intValue]==200) {
            self.requestDict= [responseObj objectForKey:@"t"];
            
            [self.tableView reloadData];
        }else if([[responseObj objectForKey:@"Status"]intValue]==400){
            
            CMTiShi([responseObj objectForKey:@"Result"]);
            
        }
    }];
    

    
    
}
-(void)UpLoadAddress{
    
    
    NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_MyAddress.ashx?Action=4",OnLineCode];
   

    NSDictionary *dict=@{@"HYID":[CMUserDefaults objectForKey:@"userID"]
                         ,@"ZCode":YouBian.text,@"Address":YouAddress.text};
    
    [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
        DLog(@"---%@",responseObj);
        
     
        if([[responseObj objectForKey:@"Status"]intValue]==200){
               // CMTiShi(@"恭喜您,地址信息保存成功!")
            
            CMEndAlertView *endAlert=[[CMEndAlertView alloc]initCMSmsCodeAlertWithTitle:@"恭喜您,地址信息保存成功!"];
            //endAlert.delegate=self;
            [endAlert ShowAlert];
            __weak typeof (self) weakSelf = self;

            endAlert.block=^{
                
                 [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            };
         
            
        }
       
    } failure:^(NSError *error) {
        
        
        
    }];
    
    
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [NSString validateNumber:string];
}


@end
