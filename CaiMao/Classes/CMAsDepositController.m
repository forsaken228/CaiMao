//
//  CMAsDepositController.m
//  CaiMao
//
//  Created by WangWei on 17/3/23.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import "CMAsDepositController.h"
#import "CMAsDespositDetailHeadView.h"
#import "CMOnLinePayViewController.h"
@interface CMAsDepositController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property(nonatomic,strong)UITableView *myTabelView;
@property(nonatomic,copy)NSArray *firstTitleArr;
@property(nonatomic,strong)NSArray *firstDetailArr;
@property(nonatomic,strong)NSArray *secondTitleArr;
@property(nonatomic,strong)CMAsDespositDetailHeadView *AsDespositDetailHead;
@property(nonatomic,copy)NSString *inputStr;


@property(nonatomic,strong)NSArray *NewBankArr;


@end

@implementation CMAsDepositController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"随心存";
    self.view.backgroundColor=ViewBackColor;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"tehui_top_fenxiang" higlightedImage:nil target:self action:@selector(sharkClick:)];
    
   
    
    [self getBankList];
    UIView *footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 150)];
    footView.backgroundColor=ViewBackColor;
    self.myTabelView.tableFooterView=footView;
    
    [self.view addSubview:self.myTabelView];
    [CMNSNotice addObserver:self selector:@selector(noticeTextFiled:) name:UITextFieldTextDidChangeNotification object:self.AsDespositDetailHead.InPutText];
    self.AsDespositDetailHead.productSlider.realValue=self.realVaule;
    [self.AsDespositDetailHead.depositBtn addTarget:self action:@selector(despositEventcliek) forControlEvents:UIControlEventTouchUpInside];
    self.inputStr=@"0";
    if (self.fromWebView) {
        self.navigationItem.hidesBackButton=YES;
         self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"nav_back_btn" higlightedImage:nil target:self action:@selector(backBtnClick)];
    }
}
-(void)backBtnClick{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
#pragma mark Lazy
-(UITableView*)myTabelView{
    if (!_myTabelView) {
        
        _myTabelView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, CMScreenH) style:UITableViewStylePlain];
        _myTabelView.dataSource=self;
        _myTabelView.delegate=self;
        _myTabelView.rowHeight=40;
        _myTabelView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _myTabelView.showsHorizontalScrollIndicator=NO;
        _myTabelView.showsVerticalScrollIndicator=NO;
        _myTabelView.tableHeaderView=self.AsDespositDetailHead;
    }
    
    return _myTabelView;
}
-(NSArray*)firstTitleArr{
    return @[@"计息日期",@"收益分配",@"收益类型",@"转让赎回",@"风险评级"];
}
-(NSArray*)secondTitleArr{
    
    return @[@"收益规则",@"产品详情",@"安全保障"];
}
-(NSArray*)firstDetailArr{
    
    return @[@"T(成交日)+1天",@"赎回时本息即时到账",@"期限任选,天天计息",@"自由赎回",@"风险极低"];
}
-(CMAsDespositDetailHeadView*)AsDespositDetailHead{
    if (!_AsDespositDetailHead) {
        _AsDespositDetailHead=[[CMAsDespositDetailHeadView alloc]initWithFrame:CGRectMake(0,0, CMScreenW, 400)];
    }
    return _AsDespositDetailHead;
}
#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return self.firstTitleArr.count;
    }else{
        return self.secondTitleArr.count;
    }
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        
        static NSString *KCell=@"indexPath";
        CMProductDetailHeadCell *cell=[tableView dequeueReusableCellWithIdentifier:KCell];
        if (!cell) {
            cell=[[CMProductDetailHeadCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:KCell];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        cell.titleLabel.text=self.firstTitleArr[indexPath.row];
        cell.detailLabel.text=self.firstDetailArr[indexPath.row];
        
        CGRect rect=[ cell.detailLabel.text boundingRectWithSize:CGSizeMake(150, 15) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0]} context:nil];
        [cell.detailLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(rect.size.width+2);
        }];
        if (indexPath.row==4) {
            cell.riskImageView.hidden=NO;
        }
        return cell;
        
        
        
    }else{
        static NSString *tCell=@"indexPath";
        CMProductDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:tCell];
        if (!cell) {
            cell=[[CMProductDetailCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:tCell];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        cell.productLeft.text=self.secondTitleArr[indexPath.row];
       
        
        return cell;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        
        CMProductDetailController *pr=[[CMProductDetailController alloc]init];
        switch (indexPath.row) {
            case 0://收益计划
            {
                pr.urlStr=@"http://m.58cm.com/sxincun/syguize.aspx";
               
            }
                break;
            case 1:{//交易记录
               
                 pr.urlStr=@"http://m.58cm.com/sxincun/detail.aspx";
            }
                
                break;
            case 2:
            {   //安全保障
                 pr.urlStr=@"http://m.58cm.com/sxincun/anquan.aspx";
            }
             
            default:
                break;
        }
        CMPush(pr);
        
    }
}

-(void)noticeTextFiled:(NSNotification*)noti{
    
    UITextField *field=(UITextField*)noti.object;
   // NSLog(@"=== %@",field.text);
    self.inputStr=field.text;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 10.0f;
    }else{
        return 0.01f;
    }
}
-(void)despositEventcliek{
    
  if ([CMRequestManager islogin]) {
        
        if ([self.inputStr floatValue]<1) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入数字大于1的金额" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alert show];
        return ;

    }
      
      if ([self.inputStr floatValue]>1000000) {
          UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"单笔金额不能超过1百万" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
          [alert show];
          return ;
          
      }
    static int ID;
    switch (self.AsDespositDetailHead.selectVaule) {
        case 15:
            ID=1;
            break;
        case 30:
            ID=2;
            break;
        case 58:
            ID=3;
            break;
        case 98:
            ID=4;
            break;
        case 180:
            ID=5;
            break;
        case 360:
            ID=6;
            break;
        default:
            break;
    }
   // NSLog(@"despositEventcliek+++++%.2f ++%d++++%d+++%@",self.realVaule,self.AsDespositDetailHead.selectVaule,ID,self.NewBankArr);
    [CMRequestHandle AsDepositPayOrderMessageWithAmount:self.inputStr andDaysId:ID andSuccess:^(id responseObj) {
     // NSLog(@"responseObj+++%@++%@",responseObj,[responseObj  objectForKey:@"Result"]);
        if ([[responseObj objectForKey:@"Status"]intValue]==200) {
            
     
        CMOnLinePayViewController *vc=[[CMOnLinePayViewController alloc]init];
        vc.payMoney=[self.inputStr intValue];
        vc.bankArr=self.NewBankArr;
        vc.orderDict=(NSDictionary*)responseObj;
        vc.isSuxincun=YES;
        vc.productFenEr=1000;
        
        [self.navigationController pushViewController: vc animated:NO];
               }
        
    }];
    

}
    else {
        CMLoginController *loginVc = [[CMLoginController alloc] init];
        
        [self.navigationController pushViewController:loginVc animated:NO];

    }
    
    

    

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 10.0f;
    }else{
        return 0.01f;
    }
}
- (void)sharkClick:(id)sender
{
    
    
    UIWindow *window = [UIApplication  sharedApplication].keyWindow;
    CMCustomShareView   *shareView=[[CMCustomShareView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, CMScreenH)];
    
    [window addSubview:shareView];
    
   
    [CMRequestHandle shortUrl:[NSString stringWithFormat:@"%@/sxincun/index.aspx",OnLineCode] andSuccess:^(id responseObj) {
        for (NSDictionary *dict in responseObj) {
            
            shareView.contentUrl=[dict objectForKey:@"url_short"];
            shareView.titleConten=@"随心存 个性定制 存取随心";
            shareView.contentStr=[NSString stringWithFormat:@"随心存,风险极低、期限灵活、到期仍能计息,是财猫为特定用户打造的一款个性化定制型理财产品。%@",shareView.contentUrl];
            shareView.ShareImageName=@[[UIImage imageNamed:@"cmshare"]];
            
        }
        
        
    }];
    
    
}
#pragma mark请求是否认证数据

-(void)getBankList{
    
    [CMRequestHandle requestBankListMsgsuccess:^(id responseObj) {
        
        if ([[responseObj objectForKey:@"status"]intValue]==200) {
            
            self.NewBankArr=[responseObj objectForKey:@"result"];
            
        }
    }andFailure:^(id error) {
        
        
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [CMNSNotice removeObserver:self];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
