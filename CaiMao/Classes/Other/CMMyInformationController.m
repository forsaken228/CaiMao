//
//  CMMyInformationController.m
//  CaiMao
//
//  Created by MAC on 16/10/26.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMMyInformationController.h"
#import "CMInformModel.h"
@interface CMMyInformationController ()<CMInformationCellDelegate>


@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)NSArray *placeHoldArr;
@property(nonatomic,strong)UILabel *errorLabel;

@property(nonatomic,copy)NSString *niCheng;
@property(nonatomic,copy)NSString *Name;
@property(nonatomic,copy)NSString *NameID;
@property(nonatomic,assign) NSInteger Sex;
@property(nonatomic,copy)NSString *Email;

@property(nonatomic,strong)CMInformModel *InformModel;

@end

@implementation CMMyInformationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的资料";
    self.view.backgroundColor=ViewBackColor;
    self.tableView.tableFooterView=[self creatFootView];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
         [self getMyMessage];
 
    [self showDefaultProgressHUD];
    
}
#pragma mark LazyData
-(NSArray*)titleArr{
    return @[@"昵称",@"真实姓名",@"性别",@"手机号",@"邮箱",@"身份证号"];
}
-(NSArray*)placeHoldArr{
    
    return @[@"请设置您的昵称",@"请输入您的真实姓名",@"",@"请输入您的手机号",@"请输入您的邮箱",@"请输入身份证号"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.titleArr.count;
}
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor=[UIColor clearColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Tcell=@"indexPath";
    CMInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:Tcell];
    
    if (!cell) {
        cell=[[CMInformationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Tcell];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    cell.DetailTitle.text=self.titleArr[indexPath.row];
    cell.detailField.placeholder=self.placeHoldArr[indexPath.row];
    [CMNSNotice addObserver:self selector:@selector(noticeTextFiled:) name:UITextFieldTextDidChangeNotification object:cell.detailField];
    cell.detailField.tag=indexPath.row;
    
    cell.IndexPath=indexPath;
    cell.delegate=self;
    
    if (indexPath.row==0||indexPath.row==1||indexPath.row==3||indexPath.row==4||indexPath.row==5) {
        [cell.WomanBtn removeFromSuperview];
        [cell.manBtn removeFromSuperview];
    }else{
        [cell.detailField removeFromSuperview];
    }

    switch (indexPath.row) {
        case 0:
            
            cell.detailField.text=_InformModel.nicheng;
            self.niCheng=cell.detailField.text;
            
            break;
        case 1:
        {
            if(_InformModel.by_sfrz==1){
                cell.detailField.userInteractionEnabled=NO;
            }
                cell.detailField.text=_InformModel.sname;

            self.Name=cell.detailField.text;
 
        }
            break;
            
        case 2:
        {
            if(_InformModel.xb==1){//男
                cell.manBtn.selected=YES;
                cell.WomanBtn.selected=NO;
             [cell.manBtn setImage:[UIImage imageNamed:@"zhigu_xzicon-01.png"]
                          forState:UIControlStateSelected];
            [cell.WomanBtn setImage:[UIImage imageNamed:@"zhifu_xziocn.png"] forState:UIControlStateNormal];
            }else if(_InformModel.xb==2){
                cell.WomanBtn.selected=YES;
                  cell.manBtn.selected=NO;
               [cell.WomanBtn setImage:[UIImage imageNamed:@"zhigu_xzicon-01.png"] forState:UIControlStateSelected];
                 [cell.manBtn setImage:[UIImage imageNamed:@"zhifu_xziocn.png"] forState:UIControlStateNormal];
            }else{
                cell.WomanBtn.selected=NO;
                cell.manBtn.selected=NO;
            }
            self.Sex=_InformModel.xb;
        }
            break;
        case 3:
            
                cell.detailField.text=_InformModel.mobile;
                cell.detailField.userInteractionEnabled=NO;
       
            break;
        case 4:
            
            if(_InformModel.by_sfrz==1){
                cell.detailField.text=_InformModel.email;
                cell.detailField.userInteractionEnabled=NO;
            }
           cell.detailField.text=_InformModel.email;
            self.Email=cell.detailField.text;
            break;
        case 5:
            if(_InformModel.by_sfrz==1){
                
                cell.detailField.userInteractionEnabled=NO;
            }
            cell.detailField.text=_InformModel.sfzh;
            self.NameID=cell.detailField.text;
            break;
            
        default:
            break;
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}
-(void)SaveMessage{
    if (self.niCheng.length<=0) {
        self.errorLabel.text=@"请输入昵称";
        return;
    }
    if (self.Name.length<=0) {
        self.errorLabel.text=@"请输入您的真实姓名";
        return;
    }
    if (self.Email.length<=0) {
        self.errorLabel.text=@"请输入邮箱";
        return;
    }
   
    if (self.NameID.length<=0) {
        self.errorLabel.text=@"请输入身份证号";
        return;
    }
    [CMRequestHandle SaveMyMessageWithUserID:[CMUserDefaults objectForKey:@"userID"] andNiCheng:self.niCheng andName:self.Name andSex:[NSString stringWithFormat:@"%ld",self.Sex] andEmail:self.Email andNameId:self.NameID andSuccess:^(id responseObj) {
         // DLog(@"++++%@++++%@",responseObj,[responseObj objectForKey:@"Result"]);
        if ([[responseObj objectForKey:@"Status"]intValue]==200) {
             CMEndAlertView *endAlert=[[CMEndAlertView alloc]initCMSmsCodeAlertWithTitle:[responseObj objectForKey:@"Result"]];
          
            [endAlert ShowAlert];
            __weak typeof (self) weakSelf = self;
            
            endAlert.block=^{
                
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            };
            
            
        }else{
            self.errorLabel.text=[responseObj objectForKey:@"Result"];
        }
        
        
    } andFailure:^(id error) {
        
    }];
}


-(void)clickChangeWithButtonTag:(NSInteger)Tag andIndex:(NSIndexPath *)index{
    
    
    CMInformationCell *cell=[self.tableView cellForRowAtIndexPath:index];
    switch (Tag) {
        case 100:
            cell.manBtn.selected=YES;
            cell.WomanBtn.selected=NO;
            [cell.manBtn setImage:[UIImage imageNamed:@"zhigu_xzicon-01.png"] forState:UIControlStateSelected];
            [cell.WomanBtn setImage:[UIImage imageNamed:@"zhifu_xziocn.png"] forState:UIControlStateNormal];
            self.Sex=1;
            break;
        case 101:
            cell.manBtn.selected=NO;
            cell.WomanBtn.selected=YES;
            [cell.WomanBtn setImage:[UIImage imageNamed:@"zhigu_xzicon-01.png"] forState:UIControlStateSelected];
            [cell.manBtn setImage:[UIImage imageNamed:@"zhifu_xziocn.png"] forState:UIControlStateNormal];
            self.Sex=2;
            break;
        default:
            break;
    }

    
}


-(UIView*)creatFootView{
    
    UIView *bgview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 300)];
    bgview.backgroundColor=ViewBackColor;
    self.errorLabel=[[UILabel alloc]init];
    self.errorLabel.textColor=RedButtonColor;
    self.errorLabel.font=[UIFont systemFontOfSize:12.0];
    [bgview addSubview:self.errorLabel];
    [self.errorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgview.mas_top).offset(10);
        make.height.equalTo(@13);
        make.left.equalTo(bgview.mas_left).offset(20);
        make.width.mas_equalTo(CMScreenW-20);
    }];
    UIButton *SureBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    [SureBtn setTitle:@"保存" forState:UIControlStateNormal];
    [SureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [SureBtn setBackgroundColor:RedButtonColor];
    SureBtn.layer.cornerRadius=4.0;
    SureBtn.clipsToBounds=YES;
    SureBtn.titleLabel.font=[UIFont systemFontOfSize:14.0];
    [SureBtn addTarget:self action:@selector(SaveMessage) forControlEvents:UIControlEventTouchUpInside];
    [bgview addSubview:SureBtn];
    [SureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgview.mas_left).offset(20);
        make.right.equalTo(bgview.mas_right).offset(-20);
        make.top.equalTo(self.errorLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(buttonHeight);
    }];
    
    
    
    return bgview;
}
-(void)noticeTextFiled:(NSNotification*)noti{
    
    UITextField *field=(UITextField*)noti.object;
    //NSLog(@"%d === %@", field.tag, field.text);
    if (field.tag==0) {
        self.niCheng=field.text;
    }else if (field.tag==1){
       self.Name=field.text;
        
    }else if (field.tag==4){
        self.Email=field.text;
        
    }else{
        self.NameID=field.text;
    }
    
    
}
-(void)getMyMessage{
    
    [CMRequestHandle MyMessageWithUserID:[CMUserDefaults objectForKey:@"userID"] andSuccess:^(id responseObj) {
        
        DLog(@"ziliao++++%@",responseObj);
        
        if ([[responseObj objectForKey:@"Status"]intValue]==200) {

       _InformModel= [CMInformModel objectWithKeyValues:[responseObj objectForKey:@"t"]];
            
            [self hiddenProgressHUD];
        }
        
        [self.tableView reloadData];
    }];
}
@end
