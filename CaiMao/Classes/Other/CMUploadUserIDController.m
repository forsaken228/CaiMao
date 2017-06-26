//
//  CMUploadUserIDController.m
//  CaiMao
//
//  Created by MAC on 16/10/25.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMUploadUserIDController.h"

@interface CMUploadUserIDController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    CMPersonerMsg *bgview;
    CMChagePhoto *alertPhoto;
    UIImagePickerController *picker;
    
}
@property(nonatomic,copy)NSString *recordName;
@end

@implementation CMUploadUserIDController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"验证个人信息";
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled=NO;
     self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"我的账户" style:UIBarButtonItemStylePlain target:self action:@selector(goMyAuccount)];
   
}

-(void)goMyAuccount{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 400;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0,0, CMScreenW, 40)];
    bgView.backgroundColor=ViewBackColor;
    UILabel *label=[[UILabel alloc]init];
    //label.backgroundColor=ViewBackColor;
    label.text=@"为验证您的身份,请填写以下信息";
    label.font=[UIFont systemFontOfSize:13];
    label.textColor=UIColorFromRGB(0x8e8e93);
    //label.textAlignment=NSTextAlignmentCenter;
    [bgView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.centerY.equalTo(bgView);
        make.left.equalTo(bgView.mas_left).offset(30);
        make.width.equalTo(@200);
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

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    bgview=[[CMPersonerMsg alloc]init];
    bgview.frame=CGRectMake(0, 0, CMScreenW,400);
    bgview.delegate=self;
    
    NSDictionary *dic=[self.bankListArr firstObject];
    NSString *name=[dic objectForKey:@"name"];
    self.recordName=name;
    NSString *nameID=[dic objectForKey:@"cardid"];
    if(name.length==2){
        
       
        bgview.userName.text= [name stringByReplacingCharactersInRange:NSMakeRange(1, 1) withString:@"*"];

    }else if(name.length==3){
        
    bgview.userName.text=[name stringByReplacingCharactersInRange:NSMakeRange(1, 2) withString:@"**"];
    }else if(name.length==4){
        
        bgview.userName.text=[name stringByReplacingCharactersInRange:NSMakeRange(1, 3) withString:@"***"];
    }else{
        
        bgview.userName.text=name;
    }
    if(![nameID isEqualToString:@""]){
       bgview.personerID.text=[nameID stringByReplacingCharactersInRange:NSMakeRange(7, 7) withString:@"*******"];
    }else{
        bgview.personerID.text=@"";
    }
    
    UITapGestureRecognizer *tap=[[ UITapGestureRecognizer alloc]initWithTarget:self action:@selector(uploadImage:)];
    bgview.FaceImageView.tag=10;
    [bgview.FaceImageView addGestureRecognizer:tap];
    UITapGestureRecognizer *tap1=[[ UITapGestureRecognizer alloc]initWithTarget:self action:@selector(uploadImage:)];
    bgview.backImageView.tag=11;
    [bgview.backImageView addGestureRecognizer:tap1];
    return bgview;
    
}
-(void)uploadImage:(id)sender{
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)sender;
    NSLog(@"%d",singleTap.view.tag);
   
     alertPhoto=[[CMChagePhoto alloc]initCMChangePhotoAlert];
     alertPhoto.delegate=self;
    alertPhoto.tag=singleTap.view.tag;
    [alertPhoto ShowAlert];
}
-(void)ChangeSourceWithTag:(NSInteger)aTag{
     NSLog(@"%d",aTag);
  picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES; //可编辑
    //判断是否可以打开照相机
    if (aTag==12) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            picker.sourceType=UIImagePickerControllerSourceTypeCamera;
            NSLog(@"相机为来源");
        }else{
            
            CMAlert(@"相机不可用");
            return;
        }
    }else{
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
            //图片库
            picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            NSLog(@"图片库为来源");
        }else
        {
           CMAlert(@"相册不可用");;
            
            return;
        }

        
    }
   [self presentViewController:picker animated:YES completion:nil];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{

    NSLog(@"dict===%@",info);
    
    if (alertPhoto.tag==10) {
        bgview.FaceImageView.image=[info objectForKey:UIImagePickerControllerEditedImage];
       
    }else{
         bgview.backImageView.image=[info objectForKey:UIImagePickerControllerEditedImage];
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}
//点击cancle按钮是调用的协议方法
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)goNextView{
    if (bgview.bankID.text.length<=0) {
        bgview.errorLabel.text=@"*解绑卡号不能为空";
        return;
    }
    
    if([bgview.FaceImageView.image isEqual:[UIImage imageNamed:@"faceimage"]]){
        bgview.errorLabel.text=@"*上传身份证正面照片不能为空";
        return;
        
    }
    if([bgview.backImageView.image isEqual:[UIImage imageNamed:@"backimage"]]){
        bgview.errorLabel.text=@"*上传身份证反面照片不能为空";
        return;
        
    }
  
    [CMRequestHandle userUserYanZhengWithUserID:[CMUserDefaults objectForKey:@"userID"] andName:self.recordName andNameID:bgview.personerID.text andbankNum:bgview.bankID.text andfaceImage:[NSString stringWithFormat:@"%@",[NSString UIImageToBase64Str:bgview.FaceImageView.image]] andbackImage:[NSString stringWithFormat:@"%@",[NSString UIImageToBase64Str:bgview.backImageView.image]] andSuccess:^(id responseObj) {
          DLog(@"responseObj++++%@",responseObj);
        if ([[responseObj objectForKey:@"Status"]intValue]==200) {
            
    CMCheackController *vc=[[CMCheackController alloc]init];
    vc.type=CheackTypeUpLoadSuccesse;
    [self.navigationController pushViewController:vc animated:NO];
        }else{
            
            bgview.errorLabel.text=[responseObj objectForKey:@"Result"];
        }

    }];
   
 
    
}

checkNet

@end
