//
//  CMSafeController.m
//  CaiMao
//
//  Created by MAC on 16/10/21.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMSafeController.h"
#import "CMSafeViewCell.h"


@interface CMSafeController ()
@property(nonatomic,strong)NSDictionary *titleDict;
@property(nonatomic,strong)NSDictionary *requestDict;
@property(nonatomic,copy)NSString *userName;
@property(nonatomic,copy)NSString *nameID;
@end

@implementation CMSafeController
-(void)loadView{
    [super loadView];
    [self myRenZhengMsg];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=ViewBackColor;
    self.tableView.backgroundColor=ViewBackColor;
    self.title=@"安全认证";

    [self showDefaultProgressHUD];
    self.titleDict=@{@"One":@[@"手机认证",@"邮箱认证"],@"Two":@[@"交易密码",@"登录密码"],@"Three":@[@"实名认证",@"银行卡认证"]};
    self.tableView.tableFooterView=[UIView new];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    DLog(@"列表++++%@__--%@",  [CMUserDefaults objectForKey:@"userID"],self.UserBankListArr);
    [CMNSNotice addObserver:self selector:@selector(renzhengSuccess) name:@"renzhengSuccess" object:nil];
    [CMNSNotice addObserver:self selector:@selector(renzhengSuccess) name:@"setIdealPasswordSuccess" object:nil];
    [CMNSNotice addObserver:self selector:@selector(renzhengSuccess) name:@"setEmailSuccess" object:nil];
    [CMNSNotice addObserver:self selector:@selector(renzhengSuccess) name:@"ChangeEmailSuccess" object:nil];
    [CMNSNotice addObserver:self selector:@selector(renzhengSuccess) name:@"ThePhoneRenZhengSuccess" object:nil];
    if (self.UserBankListArr) {
        NSDictionary *dic=[self.UserBankListArr firstObject];
        self.BankDataListDict=[dic objectForKey:@"BankData"];
        self.userName=[dic objectForKey:@"name"];
        self.nameID=[dic objectForKey:@"cardid"];
        

    }



}

-(void)dealloc{
   [CMNSNotice removeObserver:self];
}
-(NSDictionary*)requestDict{
    if (!_requestDict) {
        _requestDict=[NSDictionary dictionary];
    }
    return _requestDict;
}
-(void)myRenZhengMsg{
    if (![self checkNetWork]) {
        return;
    }
   
    [CMRequestHandle RequestUserStateWithUserID:[CMUserDefaults objectForKey:@"userID"] andSuccess:^(id responseObj) {
    DLog(@"responseObj+++++++%@",responseObj);
        if ([[responseObj objectForKey:@"Status"]intValue]==200) {
       
            [self hiddenProgressHUD];
            self.requestDict= [responseObj objectForKey:@"t"];
            
            [self.tableView reloadData];
        }else if([[responseObj objectForKey:@"Status"]intValue]==400){
            CMTiShi([responseObj objectForKey:@"Result"]);
            
        }
    }];
  

 }

-(void)renzhengSuccess{
    if (![self checkNetWork]) {
        return;
    }
    [CMRequestHandle requestBankListMsgsuccess:^(id responseObj) {
       
        if ([[responseObj objectForKey:@"status"]intValue]==200) {
            
            self.UserBankListArr=[responseObj objectForKey:@"result"];
             [self.tableView reloadData];
        }
    } andFailure:^(id error) {
        
    }];
     [self myRenZhengMsg];
   
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titleDict.allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr=[self.titleDict objectForKey:self.titleDict.allKeys[section]];
    
    return  arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Tcell=@"indexPath";

    CMSafeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Tcell];
    if (!cell) {
        cell=[[CMSafeViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Tcell];
        
    }
    
     NSArray *arr=[self.titleDict objectForKey:self.titleDict.allKeys[indexPath.section]];
    cell.tTitle.text=arr[indexPath.row];
    cell.icon.image=[UIImage imageNamed:arr[indexPath.row]];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            if ([[self.requestDict objectForKey:@"kx_sjsmrz"]intValue]!=0) {
                NSString *str=[self.requestDict objectForKey:@"sj"];
                cell.deatilContent.text=[str stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
            }
            
        }else{
            if ([[self.requestDict objectForKey:@"by_email"]intValue]==0) {
              cell.deatilContent.text=@"立即认证";
               
            }else{
            cell.deatilContent.text=[self.requestDict objectForKey:@"email"];
            }
        }
        
    }else if (indexPath.section==1){
        if (indexPath.row==0) {
            if ([[self.requestDict objectForKey:@"jy_password"]intValue]==0) {
                cell.deatilContent.text=@"未设置";
            }else{
                cell.deatilContent.text=@"重置";
            }
            
            
        }else{
            cell.deatilContent.text=@"重置";
        }
        
        
    }else {
        
        if (indexPath.row==0) {
           
            if ([[self.requestDict objectForKey:@"by_sfrz"]intValue]==0) {
                //银行卡未认证
                cell.deatilContent.text=@"立即认证";
                cell.userInteractionEnabled=YES;
            }
            
            else {
                cell.nameMessage.hidden=NO;
              // cell.nameMessage.text=self.userName;
                 cell.nameMessage.text=[self.requestDict objectForKey:@"sname"];
//            cell.deatilContent.text=[self.nameID stringByReplacingCharactersInRange:NSMakeRange(7, 7) withString:@"*******"];
                if(![[self.requestDict objectForKey:@"sfzh"] isEqualToString:@""]){
                cell.deatilContent.text=[[self.requestDict objectForKey:@"sfzh"] stringByReplacingCharactersInRange:NSMakeRange(7, 7) withString:@"*******"];
                }else{
                     cell.deatilContent.text=@"";
                }
                [cell.deatilContent mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(cell).offset(10);
                }];
                
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                cell.userInteractionEnabled=NO;
    
                cell.list.hidden=YES;
          }
           
        }else{
            if ([[self.requestDict objectForKey:@"by_bank"]intValue]==0) {
                //银行卡未认证
                cell.deatilContent.text=@"立即认证";
                
            }
            
            else {
//                NSString *bankNum=[self.BankDataListDict objectForKey:@"BankNumber"];
//            cell.deatilContent.text=[NSString stringWithFormat:@"%@%@",[self.BankDataListDict objectForKey:@"Bankname"],[bankNum substringFromIndex:bankNum.length-4]];
                
                cell.deatilContent.text=[self.requestDict objectForKey:@"bankname"] ;
            
}
            
            
        }
    }
    
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48.0f;
    
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor clearColor];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
[tableView deselectRowAtIndexPath:indexPath animated:YES];
     CMChangedetailController *vc=[[CMChangedetailController alloc]init];
    
  //  DLog(@"sourct===%@",self.requestDict);
    if (indexPath.section==0) {
        if (indexPath.row==0) {
        //先判断是否设置交易密码，如果设置直接跳转到手机认证修改，如果没认证跳转到设置交易密码
         
            if ([[self.requestDict objectForKey:@"jy_password"]intValue]==0) {
                  CMSafeDetailAlert *DetailAlert=[[CMSafeDetailAlert alloc]initWithDeatilTitle:@"您还没有设置交易密码,不能进行手机号修改的操作!" WithCancleTitle:@"稍后再说" WithDetaildown:@"设置交易密码" withTag:10];
                DetailAlert.delegate=self;
               [DetailAlert ShowAlert];
           }else{
            
                vc.type=ChangeViewControllerTypePhoneAuthentication;
            
                [self.navigationController pushViewController:vc animated:YES];
            }
         
        }else{
            
            if ([[self.requestDict objectForKey:@"by_email"]intValue]==0) {
                vc.type=ChangeViewControllerTypeEmailSetting;
                if([self.requestDict objectForKey:@"email"]){
                     vc.email=[self.requestDict objectForKey:@"email"];
                    
                }
                
            }else{
                
                if ([[self.requestDict objectForKey:@"jy_password"]intValue]==0) {
                    CMSafeDetailAlert *DetailAlert=[[CMSafeDetailAlert alloc]initWithDeatilTitle:@"您还没有设置交易密码,不能进行手机号修改的操作!" WithCancleTitle:@"稍后再说" WithDetaildown:@"设置交易密码" withTag:10];
                    DetailAlert.delegate=self;
                    [DetailAlert ShowAlert];
                }else{
                    vc.email=[self.requestDict objectForKey:@"email"];
                    vc.type=ChangeViewControllerTypeEmailChange;
                }
                
                
            }
         
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
    }else if (indexPath.section==1){
        if (indexPath.row==0) {
            if ([[self.requestDict objectForKey:@"by_sfrz"]intValue]==0) {
                CMSafeDetailAlert *DetailAlert=[[CMSafeDetailAlert alloc]initWithDeatilTitle:@"请先完成实名认证,才能设置交易密码" WithCancleTitle:@"稍后再说" WithDetaildown:@"实名认证" withTag:11];
                DetailAlert.delegate=self;
                [DetailAlert ShowAlert];
            }else{
                if ([[self.requestDict objectForKey:@"jy_password"]intValue]==0) {
                vc.type=ChangeViewControllerTypeDealPasswordSetting;
                }else{
                    vc.type=ChangeViewControllerTypeDealPasswordChange;
                }
               
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }
            

          
            
        }else{
            
            vc.type=ChangeViewControllerTypeLoginwordChange;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
        
    }else {
        
        if (indexPath.row==0) {
           [self rezhengMsg];
            
        }else{
            
            if (self.BankDataListDict.count==0||self.BankDataListDict.allKeys.count==0) {
                //银行卡未认证
               
                [self rezhengMsg];
            }
            
            else {
                
                CMBankListController *vc=[[CMBankListController alloc]init];
                vc.bankListArr=self.UserBankListArr;
                
                if([[self.requestDict objectForKey:@"jy_password"]intValue]==0){
                    vc.NotSetIdeal=YES;
                }else{
                     vc.NotSetIdeal=NO;
                }
                [self.navigationController pushViewController:vc animated:YES];
                
            }

          
            
            
        }
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
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

-(void)rezhengMsg{
    
    CMUserTrueController *productVc = [[CMUserTrueController alloc] init];

    [self.navigationController pushViewController:productVc animated:YES];
//    CMProductDetailController *pro=[[CMProductDetailController alloc]init];
//    pro.urlStr=[NSString stringWithFormat:@"%@/icm/acc/addbankcard.aspx",OnLineCode];
//    [self.navigationController pushViewController:pro animated:YES];
}
-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView  setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.tableView  respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView  setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}
checkNet

@end
