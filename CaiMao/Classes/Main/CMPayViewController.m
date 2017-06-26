//
//  CMPayViewController.m
//  CaiMao
//
//  Created by MAC on 16/6/14.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMPayViewController.h"
#import "CMMiddelView.h"
#import "CMProScrollSlider.h"
#import "CMBottomView.h"
#import "CMOnLinePayViewController.h"
#import "CMAlertGoRechargeView.h"
@interface CMPayViewController ()<UITextFieldDelegate,CMProScrollSliderDelegate,UIAlertViewDelegate,CMAlertGoRechargeViewDelegate>
{
    
    int mount;
    CMMiddelView *_middleView;
    CMProScrollSlider *productSlider;
    CMBottomView *_bottom;
    CMAlertRegitView *CMAlert;
    CMAlertGoRechargeView *CMChargeAlert;
    BOOL rightbar;
}
@end

@implementation CMPayViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
        // 监听通知 （登录成功 刷新表格 显示账户信息）
        [CMNSNotice addObserver:self selector:@selector(refreshAccountTable:) name:@"MesToAccount" object:nil];
        
        [CMNSNotice addObserver:self selector:@selector(renzhengSuccess) name:@"renzhengSuccess" object:nil];
        
           }
    return self;
}
-(void)dealloc{
    [CMNSNotice removeObserver:self];
}
-(void)renzhengSuccess{
    
    [self getRenZheng];
    [self getBankList];
    
}
- (void)refreshAccountTable:(NSNotification *)note
{
    rightbar=NO;
    self.phoneNum=note.userInfo[@"user"];
    self.userID=note.userInfo[@"userID"];
    self.yuer=note.userInfo[@"zhanghuyue"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"我的账户" style:UIBarButtonItemStylePlain target:self action:@selector(enterIntoMyAccount)];
   [self getRenZheng];
   [self getBankList];
    _bottom.YuEr.text=[NSString stringWithFormat:@"您的账户可用余额%.2f元",[self.yuer floatValue]];
    [NSString DoubleStringChangeColer: _bottom.YuEr andFromStr:@"额" ToStr:@"元" withColor:RedButtonColor];
    [_bottom.loginOrRechargebtn setTitle:@"充值" forState:UIControlStateNormal];
    _bottom.loginOrRechargebtn.tag=100;
    [_bottom.loginOrRechargebtn addTarget:self action:@selector(goLoginView:) forControlEvents:UIControlEventTouchUpInside];
    _bottom.shouJiNum.text=self.phoneNum;
    
  //DLog(@"self.phone==%@",note.userInfo);

   
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if ([self.navigationItem.rightBarButtonItem.title isEqualToString:@"我的账户"]&&rightbar==YES) {
        NSMutableArray  *arr=[[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
        for (UIViewController *vc in arr) {
            if ([vc isKindOfClass:[self class]]) {
                
                [arr removeObject:vc];
                break;
            }
            
        }
        self.navigationController.viewControllers=arr;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  
    self.view.backgroundColor=ViewBackColor;
    self.title=@"确认合同";
    
    self.productFenE=[[self.ProuctListArr objectForKey:@"cpfe"] intValue];
    self.userID = [CMUserDefaults valueForKey:@"userID"];
    self.phoneNum = [CMUserDefaults valueForKey:@"name"];
    self.yuer=[CMUserDefaults objectForKey:@"YuEr"];
  
    if ([CMRequestManager islogin]) {
       self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"我的账户" style:UIBarButtonItemStylePlain target:self action:@selector(enterIntoMyAccount)];
       rightbar=NO;
       [self getRenZheng];
       [self getBankList];
       [self loadAccountMes];

    }else{
        rightbar=YES;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(goLoginViewFromBar)];
        self.userID=@"0";
        
    }
  [self creatView];
 //DLog(@"---self.phone==%@---self.userarr==%@---%@--%@",self.phoneNum,userArr,self.NewBankArr,self.ProuctListArr);
  [self statisticalPage:[NSString stringWithFormat:@"%@+确认合同",[self.ProuctListArr objectForKey:@"title"]]];
}

#pragma mark 创建视图
-(void)creatView{
    CMZhuanTopView *topView=[[CMZhuanTopView alloc]initWithImage:@"转出"];
    topView.frame=CGRectMake(0, 8, CMScreenW, 30);
    [self.view addSubview:topView];
  
    _middleView=[[CMMiddelView alloc]init];
    //_middleView.frame=CGRectMake(0, 50,CMScreenW , 200);
    _middleView.productTitle.text=[self.ProuctListArr objectForKey:@"title"];
    _middleView.productId.text=[NSString stringWithFormat:@"代码%@",[self.ProuctListArr objectForKey:@"pid"]] ;
    
    
    [self productNum:self.countNum];
    _middleView.ButtonTextView.textField.text=[NSString stringWithFormat:@"%d",self.countNum];
    _middleView.ButtonTextView.textField.delegate=self;
    _middleView.ButtonTextView.textField.userInteractionEnabled=YES;
    // [_middleView.productInputNum addTarget:self  action:@selector(inputProductNum)  forControlEvents:UIControlEventAllEditingEvents];
    [CMNSNotice addObserver:self selector:@selector(inputProductNum) name:UITextFieldTextDidChangeNotification object:nil];
    [_middleView.ButtonTextView.decreaseBtn addTarget:self action:@selector(reduceProductNumBntClick) forControlEvents:UIControlEventTouchUpInside];
    [_middleView.ButtonTextView.increaseBtn addTarget:self action:@selector(addProductNumBntClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_middleView];
    [_middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo((CMScreenH-150)/2.0-30);
        make.top.equalTo(topView.mas_bottom).offset(8);
        make.width.left.equalTo(self.view);
        
    }];
    
    [self jinPiaNumlabelChange:self.countNum];
    
    if ([self productNum:self.countNum]<=0) {
         productSlider=[[CMProScrollSlider alloc]initWithFrame:CGRectMake(0, 46+(CMScreenH-150)/2.0-30, CMScreenW,100) MinValue:0 MaxValue:[self productNum:0]+self.productFenE*10 Step:self.productFenE Unit:@""];
     
        self.countNum=[self productNum:0]/self.productFenE;
        
        productSlider.valueTF.text=[NSString stringWithFormat:@"%d",self.countNum*self.productFenE];
        [productSlider.collectionView setContentOffset:CGPointMake(self.countNum*6, 0) animated:NO];
         _middleView.productNum.text=[NSString stringWithFormat:@"当前剩余份额%d(%d元)",0,0];
    }else{
    productSlider=[[CMProScrollSlider alloc]initWithFrame:CGRectMake(0, 46+(CMScreenH-150)/2.0-30, CMScreenW,100) MinValue:0 MaxValue:[self productNum:self.countNum]+self.productFenE*10 Step:self.productFenE Unit:@""];
     productSlider.valueTF.text=[NSString stringWithFormat:@"%d",self.countNum*self.productFenE];
        [productSlider.collectionView setContentOffset:CGPointMake(self.countNum*5, 0) animated:NO];
    }
    
  
    
    
    productSlider.delegate=self;
    [productSlider.allCharge addTarget:self action:@selector(quanErGouMai) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:productSlider];
    
    
    _bottom=[[CMBottomView alloc]init];
    _bottom.selectButton.selected=YES;
    [_bottom.selectButton addTarget:self action:@selector(isAgreeIdeal) forControlEvents:UIControlEventTouchUpInside];
    if ([CMRequestManager islogin]) {
        _bottom.shouJiNum.text=self.phoneNum;
        _bottom.shouJiNum.userInteractionEnabled=NO;
        _bottom.YuEr.text=[NSString stringWithFormat:@"您的账户可用余额%.2f元",[self.yuer floatValue]];
        [NSString DoubleStringChangeColer:_bottom.YuEr andFromStr:@"额" ToStr:@"元" withColor:RedButtonColor];
        CGRect rect=[_bottom.YuEr.text boundingRectWithSize:CGSizeMake(300, 20) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil];
        [_bottom.YuEr mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(rect.size.width+5);
        }];
        [_bottom.loginOrRechargebtn setTitle:@"充值" forState:UIControlStateNormal];
        _bottom.loginOrRechargebtn.tag=100;
        [_bottom.loginOrRechargebtn addTarget:self action:@selector(goLoginView:) forControlEvents:UIControlEventTouchUpInside];
      
    
       
    }else{
        _bottom.shouJiNum.userInteractionEnabled=YES;
        [_bottom.loginOrRechargebtn setTitle:@"登录" forState:UIControlStateNormal];
        _bottom.YuEr.text=[NSString stringWithFormat:@"我是会员?请登录"];
        CGRect rect=[_bottom.YuEr.text boundingRectWithSize:CGSizeMake(300, 20) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil];
        [_bottom.YuEr mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(rect.size.width+5);
        }];
        _bottom.loginOrRechargebtn.tag=101;
        [_bottom.loginOrRechargebtn addTarget:self action:@selector(goLoginView:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [_bottom.securityBtn addTarget:self action:@selector(dealDetail:) forControlEvents:UIControlEventTouchUpInside];
    _bottom.securityBtn.tag=11;
    
    [_bottom.zijinBtn addTarget:self action:@selector(dealDetail:) forControlEvents:UIControlEventTouchUpInside];
    _bottom.zijinBtn.tag=10;
    [_bottom.nextBtn addTarget:self action:@selector(goToNextView) forControlEvents:UIControlEventTouchUpInside];
    
     [self.view addSubview:_bottom];
    [_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.equalTo(self.view);
        make.top.equalTo(productSlider.mas_bottom);
        make.height.mas_equalTo((CMScreenH-150)/2.0+30);
       
    }];
}

#pragma mark 下一步
-(void)goToNextView{
 
    if (_bottom.selectButton.selected==NO) {
        NSString *msg=@"为了您的资金安全,请先同意条款";
        CMAlert(msg);
        return;
    }
    static  NSString *pid;
    pid=[self.ProuctListArr objectForKey:@"pid"];
    if ([CMRequestManager islogin]) {
        NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_ProductAction.ashx?Action=1",OnLineCode];
        NSDictionary *dict=@{@"PID":pid,@"BidingCopies":_middleView.ButtonTextView.textField.text,@"HYID":self.userID,@"Tel":_bottom.shouJiNum.text};
        [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
           // NSLog(@"order-----%@---%@",responseObj,[responseObj objectForKey:@"Result"]);
            if ([[responseObj objectForKey:@"Result"]isEqualToString:@""]&&[[responseObj objectForKey:@"Status"]intValue]==200) {
                
                CMOnLinePayViewController *vc=[[CMOnLinePayViewController alloc]init];
                vc.payMoney=[_middleView.ButtonTextView.textField.text intValue]*self.productFenE;
                vc.bankArr=self.NewBankArr;
                vc.orderDict=(NSDictionary*)responseObj;
                vc.productFenEr=self.productFenE;
                vc.prTitle=[self.ProuctListArr objectForKey:@"title"];
              //  vc.ProuctListArr=self.ProuctListArr;
                [self.navigationController pushViewController: vc animated:NO];
                
                return;
                
            }else{
                NSString *msg=[responseObj objectForKey:@"Result"];
                
                CMAlert(msg);
            }
            
        } failure:^(NSError *error) {
            
        }];
        
    }else{
        if(_bottom.shouJiNum.text.length<=0&&![CMRequestManager islogin]){
            NSString *msg=@"请输入您的手机号";
            CMAlert(msg);
            return;
            
        }
        if([CMRegularJudement checkTelNumber:_bottom.shouJiNum.text]){
            NSString *url=[NSString stringWithFormat:@"%@/handler/AppService_ProductAction.ashx?Action=1",OnLineCode];
            
            NSDictionary *dict=@{@"PID":pid,@"BidingCopies":_middleView.ButtonTextView.textField.text,@"HYID":self.userID,@"Tel":_bottom.shouJiNum.text};
            [CMHttpTool postWithURL:url params:dict success:^(id responseObj) {
                NSLog( @"red===%@==%@",responseObj,[responseObj objectForKey:@"Result"]);
                
                if ([[responseObj objectForKey:@"Result"]isEqualToString:@"已经在财猫网注册，请您用该手机登录后再提交订单！"]&&[[responseObj objectForKey:@"Status"]intValue]==400) {
                    NSString *msg=[responseObj objectForKey:@"Result"];
                    CMAlert(msg);
                    
                    return;
                }
                if ([[responseObj objectForKey:@"Result"]isEqualToString:@"该产品交易已经结束！"]&&[[responseObj objectForKey:@"Status"]intValue]==400) {
                    NSString *msg=[responseObj objectForKey:@"Result"];
                    CMAlert(msg);
                    
                    return;
                }
                
                if ([[responseObj objectForKey:@"Result"]isEqualToString:@""]&&[[responseObj objectForKey:@"Status"]intValue]==200) {
                    NSUserDefaults *userDefault = CMUserDefaults;
                    NSString *passWord=[_bottom.shouJiNum.text substringFromIndex:5];
                    
                    [userDefault setObject:_bottom.shouJiNum.text forKey:@"name"];
                    [PassWordTool savePassWord:passWord];
                    [userDefault synchronize];
                   // [self loginAuto];
                    [self getBankList];
                    [self getRenZheng];
   
                    CMAlert=[[CMAlertRegitView alloc]initWithRegist];
                    [CMAlert ShowAlert];
                    
                   [self performSelector:@selector(loadOtherdata:) withObject:(NSDictionary*)responseObj afterDelay:1];
                  
                    
                }
                
                
            } failure:^(NSError *error) {
                
                
                
                
            }];
            
        }else{
            NSString *msg=@"手机号格式错误！";
            CMAlert(msg);
            return;
            
            
        }
        
        
        
    }
   
    
}

-(void)loadOtherdata:(NSDictionary*)dict{
   // DLog(@"alert===%@",dict);
    CMOnLinePayViewController *vc=[[CMOnLinePayViewController alloc]init];
    vc.payMoney=[_middleView.ButtonTextView.textField.text intValue]*self.productFenE;
    vc.bankArr=self.NewBankArr;
    vc.orderDict=dict;
    //vc.ProuctListArr=self.ProuctListArr;
    vc.productFenEr=self.productFenE;
    [self.navigationController pushViewController: vc animated:NO];
    
    [CMAlert dimissAlert];
    
    
    
}

#pragma mark 同意条款
-(void)isAgreeIdeal{
   static BOOL isOk;
    if (isOk==YES) {
         [_bottom.selectButton setBackgroundImage:[UIImage imageNamed:@"btnSelected.png"] forState:UIControlStateNormal];
        _bottom.selectButton.selected=YES;
        isOk=NO;
    }else{
        
         [_bottom.selectButton setBackgroundImage:[UIImage imageNamed:@"btnUnselected.png"] forState:UIControlStateNormal];
        _bottom.selectButton.selected=NO;
        isOk=YES;
    }
    
    
}
#pragma mark全额付款点击事件
-(void)quanErGouMai{
   
    if ([self.yuer floatValue]/self.productFenE<1) {
        
        
        CMChargeAlert=[[CMAlertGoRechargeView alloc]initWithReChargeWith:self.productFenE];
        CMChargeAlert.delegate=self;
        [CMChargeAlert ShowAlert];
        
        
    }else{
        self.countNum=[self.yuer floatValue]/self.productFenE;
        _middleView.ButtonTextView.textField.text=[NSString stringWithFormat:@"%d",self.countNum];
        [self jinPiaNumlabelChange:self.countNum];
        productSlider.valueTF.text=[NSString stringWithFormat:@"%d",self.countNum*self.productFenE];
         [productSlider.collectionView setContentOffset:CGPointMake(self.countNum*6, 0) animated:NO];
        
    }
    
    
    
}
-(void)tapDismissView{
    
    [CMChargeAlert dimissAlert];
}
-(void)goRechargeView{

    [self isReChargeOrRenZheng];
    [CMChargeAlert dimissAlert];
    
}
#pragma mark 进入登录或者充值界面
-(void)goLoginViewFromBar{
    CMLoginController *login=[[CMLoginController alloc]init];
    [self.navigationController pushViewController:login animated:NO];
}

-(void)isReChargeOrRenZheng{
    
    NSDictionary *dic=[self.NewBankArr firstObject];
    NSDictionary *BankData=[dic objectForKey:@"BankData"];
    if (self.NewBankArr!=nil && ![self.NewBankArr isKindOfClass:[NSNull class]] && self.NewBankArr.count!=0){
        
        if (BankData.count==0||BankData.allKeys.count==0) {
            //银行卡认证
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您还没开通银行卡认证支付,请选择常用银行卡认证！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"认证", nil];
            alert.tag=102;
            [alert show];
            
        }
        //绑过卡和银行卡认证 进入充值页面[self.errMsg intValue]==0000&&
        else {
            // 充值
            CMRechargeViewController *productVc = [[CMRechargeViewController alloc] init];

            [self.navigationController pushViewController:productVc animated:YES];
           
        }
        
        
    }

    
}
-(void)goLoginView:(UIButton*)btn{
    switch (btn.tag) {
        case 100:{
            [self isReChargeOrRenZheng];
            

        }
            break;
        case 101:{
            CMLoginController *login=[[CMLoginController alloc]init];
            [self.navigationController pushViewController:login animated:NO];

        }
            
            break;
            
        default:
            break;
    }
    
  
   }
#pragma mark 标尺滑动
-(void)CMProScrollSlider:(CMProScrollSlider *)slider ValueChange:(int)value{
   
  

}
-(void)CMProScrollSliderMove:(CMProScrollSlider *)slider ValueChange:(int)value{
    
     NSLog(@"---%d",value);
    self.countNum=value/self.productFenE;
    _middleView.ButtonTextView.textField.text=[NSString stringWithFormat:@"%d",self.countNum];
    [self jinPiaNumlabelChange:self.countNum];
    [self productNum:self.countNum];
    if (value==0) {
        
        self.countNum=self.productFenE/self.productFenE;
        _middleView.ButtonTextView.textField.text=[NSString stringWithFormat:@"%d",self.countNum];
        [self jinPiaNumlabelChange:self.countNum];
        productSlider.valueTF.text=[NSString stringWithFormat:@"%d",self.countNum*self.productFenE];
        [productSlider.collectionView setContentOffset:CGPointMake(self.countNum*6, 0) animated:NO];
    }
    if([self productNum:self.countNum]<0){
        self.countNum=self.countNum-1;
        _middleView.ButtonTextView.textField.text=[NSString stringWithFormat:@"%d",self.countNum];
        [self jinPiaNumlabelChange:self.countNum];
        productSlider.valueTF.text=[NSString stringWithFormat:@"%d",(self.countNum)*self.productFenE];
        [productSlider.collectionView setContentOffset:CGPointMake((self.countNum)*6, 0) animated:NO];
        [self productNum:self.countNum];
       
    }
}

-(void)dealDetail:(UIButton*)btn
{
   
    NSArray *urlStr=@[@"http://m.58cm.com/hp/zjjyhetong.aspx",@"http://m.58cm.com/hp/aqbzhetong.aspx"];
    NSString *url=urlStr[btn.tag-10];
    CMProductDetailController *productVc = [[CMProductDetailController alloc] init];
    
    productVc.urlStr =url;
    
    [self.navigationController pushViewController:productVc animated:YES];
    
    
    
}
#pragma mark 监听竞拍份数
-(void)inputProductNum{
 
    self.countNum=[_middleView.ButtonTextView.textField.text intValue];
//    if([_middleView.productInputNum.text intValue]==0){
//        self.countNum=1;
//        _middleView.productInputNum.text=[NSString stringWithFormat:@"%d",self.countNum];
//        
//    }
    productSlider.valueTF.text=[NSString stringWithFormat:@"%d",self.countNum*self.productFenE];
    [productSlider.collectionView setContentOffset:CGPointMake(self.countNum*6, 0) animated:NO];
    [self jinPiaNumlabelChange:self.countNum];
    [self productNum:self.countNum];
    
     DLog(@"+++%d===%d,++=%d",[self productNum:self.countNum],self.countNum,[self productNum:0]);
    if ([self productNum:self.countNum]<=0) {
       // self.countNum=1;
        _middleView.ButtonTextView.textField.text=[NSString stringWithFormat:@"%d",[self productNum:0]/self.productFenE];
        self.countNum=[self productNum:0]/self.productFenE;
        
        productSlider.valueTF.text=[NSString stringWithFormat:@"%d",self.countNum*self.productFenE];
        [productSlider.collectionView setContentOffset:CGPointMake(self.countNum*6, 0) animated:NO];
        [self jinPiaNumlabelChange:self.countNum];
         _middleView.productNum.text=[NSString stringWithFormat:@"当前剩余份额%d(%d元)",0,0];
        //[self productNum:self.countNum];
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField{

    if([_middleView.ButtonTextView.textField.text intValue]==0){
        self.countNum=1;
        _middleView.ButtonTextView.textField.text=[NSString stringWithFormat:@"%d",self.countNum];
    
   
    productSlider.valueTF.text=[NSString stringWithFormat:@"%d",self.countNum*self.productFenE];
    [productSlider.collectionView setContentOffset:CGPointMake(self.countNum*6, 0) animated:NO];
    [self jinPiaNumlabelChange:self.countNum];

    [self productNum:self.countNum];
   }
}
-(void)jinPiaNumlabelChange:(int)aNum{
    _middleView.JinPaiNum.text=[NSString stringWithFormat:@"您竞拍%d份,需支付(元)",aNum];
//    NSMutableAttributedString  *qixianStr = [[NSMutableAttributedString alloc] initWithString: _middleView.JinPaiNum.text];
//    NSRange qiFromRang = [ _middleView.JinPaiNum.text rangeOfString:@"拍"];
//    NSRange qiToRang = [ _middleView.JinPaiNum.text rangeOfString:@"份"];
//    [qixianStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(qiFromRang.location + 1, qiToRang.location - qiFromRang.location - 1)];
//    
//    _middleView.JinPaiNum.attributedText = qixianStr;
 
}

#pragma mark 减产品数量方法
-(void)reduceProductNumBntClick{
   
  
    if (self.countNum<=1) {

        return;
    }
    self.countNum--;
      _middleView.ButtonTextView.textField.text=[NSString stringWithFormat:@"%d",self.countNum];
    int step=5;
    step++;
    productSlider.valueTF.text=[NSString stringWithFormat:@"%d",self.countNum*self.productFenE];
    [productSlider.collectionView setContentOffset:CGPointMake(self.countNum*step, 0) animated:NO];
   [self jinPiaNumlabelChange:self.countNum];

    [self productNum:self.countNum];
    
      DLog(@"[self productNum:self.countNum];===%d==%d",[self productNum:self.countNum],self.countNum);
    _middleView.ButtonTextView.increaseBtn.userInteractionEnabled=YES;
}

#pragma mark 加产品数量方法
-(void)addProductNumBntClick{
    
    if ([self productNum:self.countNum]==0) {
        _middleView.ButtonTextView.increaseBtn.userInteractionEnabled=NO;
        
        
    }else{
          _middleView.ButtonTextView.increaseBtn.userInteractionEnabled=YES;
    self.countNum++;
    _middleView.ButtonTextView.textField.text=[NSString stringWithFormat:@"%d",self.countNum];
    int step=5;
    step++;
    [self jinPiaNumlabelChange:self.countNum];
    productSlider.valueTF.text=[NSString stringWithFormat:@"%d",self.countNum*self.productFenE];
   [productSlider.collectionView setContentOffset:CGPointMake(self.countNum*step, 0) animated:NO];

    [self productNum:self.countNum];
   
   }
    DLog(@"[self productNum:self.countNum];===%d==%d",[self productNum:self.countNum],self.countNum);
}


#pragma mark 我的账户
-(void)enterIntoMyAccount{
   rightbar=YES;
    UIWindow *window=[UIApplication sharedApplication].windows.firstObject;
    CMTabBarController *tab=(CMTabBarController*)window.rootViewController;
    [tab selectTap:3];

   
    
}


#pragma mark请求是否认证数据

-(void)getRenZheng{
    
    [CMRequestHandle requestRenZhengMsgsuccess:^(id responseObj) {
        if ([[responseObj objectForKey:@"status"]intValue]==200) {
            
            self.NewArr=[responseObj objectForKey:@"result"];
            
        }
//        else{
//            [self loginAuto];
//            _bottom.shouJiNum.text=self.phoneNum;
//            
//        }
    }andFailure:^(id error) {
    }];
    
 
}
-(void)getBankList{
    
    [CMRequestHandle requestBankListMsgsuccess:^(id responseObj) {
        
        if ([[responseObj objectForKey:@"status"]intValue]==200) {
            
            self.NewBankArr=[responseObj objectForKey:@"result"];
            
        }
//        else if ([[responseObj objectForKey:@"result"] isEqualToString:@"账户失效，请重新登录！"]) {
//            [self loginAuto];
//            _bottom.shouJiNum.text=self.phoneNum;
//            return ;
//        }
    }andFailure:^(id error) {
     
        
    }];

  }
#pragma mark 产品剩余份数
-(int)productNum:(int)aCount{
    self.CPLB=[self.ProuctListArr objectForKey:@"cplb"];
    NSArray *shouArr=[self.ProuctListArr objectForKey:@"ShouYiLv"];
    if ([self.CPLB intValue]==3||shouArr.count>0||shouArr!=NULL) {
        mount=[[self.ProuctListArr objectForKey:@"zjfs"] intValue]*10-[[self.ProuctListArr objectForKey:@"jbfs"] intValue]-aCount;
    }else if ([self.CPLB intValue]==2||shouArr.count<=0||shouArr==NULL){
        mount=[[self.ProuctListArr objectForKey:@"zjfs"] intValue]-[[self.ProuctListArr objectForKey:@"jbfs"] intValue]-aCount;
    }
    int mountPay=mount*self.productFenE;
    _middleView.productNum.text=[NSString stringWithFormat:@"当前剩余份额%d(%d元)",mount,mountPay];
   
    return mountPay;
}

#pragma mark alertView协议方法
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag==102){
        if (buttonIndex==1) {
            
        CMUserTrueController *productVc = [[CMUserTrueController alloc] init];

        [self.navigationController pushViewController:productVc animated:YES];
        }
        
    }
    
}
/*
#pragma mark - 取出用户名密码自动登陆
- (void)loginAuto
{
    // 取出账号、密码
    NSUserDefaults *userDefault = CMUserDefaults;
    NSString *name = [userDefault objectForKey:@"name"];
    NSString *password = [PassWordTool readPassWord];
    if (name&&password) {
        
       NSString *urlStr = [NSString stringWithFormat:@"%@/handler/AppInterface.ashx?action=login&mobile=%@&pwd=%@&type=%@&id=%@",OnLineCode,name,password,@"1",[JPUSHService registrationID]];
       //  NSString *urlStr = [NSString stringWithFormat:@"http://%@/handler/AppInterface.ashx?action=login&mobile=%@&pwd=%@",OnLineCode,name,password];
        [CMHttpTool getWithURL:urlStr params:nil success:^(id responseObj) {
            
            //  DLog(@"loginAutoLogingChenggong----- %@",responseObj);
            
            NSString *strStatus = [responseObj valueForKey:@"status"];
            NSString *userID = [[[responseObj valueForKey:@"userMess"] objectAtIndex:0] valueForKey:@"userID"];
           
            if ([strStatus isEqualToString:@"200"]) {
                [CMUserDefaults objectForKey:@"userID"];
                [CMUserDefaults synchronize];
                // 请求用户信息
                [CMRequestHandle GetAccountMsgWithHYID:userID andSuccess:^(id responseObj) {
                    NSString *statusStr = [responseObj valueForKey:@"status"];
                    
                    if ([statusStr isEqualToString:@"200"]) {
                        
                        
                        NSString *userStr = name;
                        NSString *jinriStr = [[[responseObj valueForKey:@"result"] valueForKey:@"today_ShouYi_Amount"] objectAtIndex:0]; // 今日收益
                        NSString *leijiStr = [[[responseObj valueForKey:@"result"] valueForKey:@"leiji_shouyi_Amount"] objectAtIndex:0]; // 累计收益
                        NSString *yueStr = [[[responseObj valueForKey:@"result"] valueForKey:@"ky_amount"] objectAtIndex:0]; // 账户余额
                        NSString *zongStr = [[[responseObj valueForKey:@"result"] valueForKey:@"total_Amount"] objectAtIndex:0]; // 总资产
                        
                        NSDictionary *infoSign = @{@"userID":userID,
                                                   @"user":userStr,
                                                   @"jinrishouyi":jinriStr,
                                                   @"leijishouyi":leijiStr,
                                                   @"zhanghuyue":yueStr,
                                                   @"zongzichan":zongStr};
                        
                        [CMUserDefaults setObject:yueStr forKey:@"YuEr"];
                        [CMUserDefaults synchronize];
                        [CMNSNotice postNotificationName:@"MesToAccount" object:self userInfo:infoSign]; // 发送通知 —— 账户
                
                    }

                }];
                           }
            
        } failure:^(NSError *error) {
            DLog(@"自动陆失败------%@",error);
            [PassWordTool deletePassWord];
           
           NSString *url=[NSString stringWithFormat:@"%@/handler/AppInterface.ashx?action=quit",OnLineCode];
            [CMHttpTool getWithURL:url params:nil success:^(id responseObj) {
                
            } failure:^(NSError *error) {
                DLog(@"exitLoginAcconntError--%@",error);
            }];
            
        }];
        
    }
}
 */
- (void)loadAccountMes
{
    
  
    [CMRequestHandle GetAccountMsgWithHYID:[CMUserDefaults objectForKey:@"userID"] andSuccess:^(id responseObj) {
        NSString *statusStr = [responseObj valueForKey:@"status"];
        if ([statusStr isEqualToString:@"200"]) {

            NSString *yueStr = [[[responseObj valueForKey:@"result"] valueForKey:@"ky_amount"] objectAtIndex:0]; // 账户余额
            [CMUserDefaults setObject:yueStr forKey:@"YuEr"];
            [CMUserDefaults synchronize];
 
        }
        
        
    }];
    
}
@end
