//
//  CMQQMailViewController.m
//  CaiMao
//
//  Created by WangWei on 16/12/13.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMQQMailViewController.h"
#import "CMQQEmailCell.h"
#import "CMQQModel.h"
@interface CMQQMailViewController ()<UIWebViewDelegate,UITableViewDelegate,UITableViewDataSource,CMQQEmailDelegate>
@property (strong,nonatomic) UIWebView *productWebView;
@property(nonatomic,strong)UITableView *myTabelview;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic, strong)  UIButton *bottomBtn;
@property (nonatomic, assign)  BOOL isAllPeople;
@end

@implementation CMQQMailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=ViewBackColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
   [self.view addSubview:self.myTabelview];
    [self.view addSubview: self.productWebView];
    self.urlStr=@"https://ui.ptlogin2.qq.com/cgi-bin/login?style=9&appid=522005705&daid=4&s_url=https%3A%2F%2Fw.mail.qq.com%2Fcgi-bin%2Flogin%3Fvt%3Dpassport%26vm%3Dwsk%26delegate_url%3D%26f%3Dxhtml%26target%3D&hln_css=http%3A%2F%2Fmail.qq.com%2Fzh_CN%2Fhtmledition%2Fimages%2Flogo%2Fqqmail%2Fqqmail_logo_default_200h.png&low_login=1&hln_autologin=%E8%AE%B0%E4%BD%8F%E7%99%BB%E5%BD%95%E7%8A%B6%E6%80%81&pt_no_onekey=1";
    [self loadWebViewDataWithUrl:self.urlStr];
}
#pragma mark lazy

-(UIWebView*)productWebView{
    if (!_productWebView) {
        _productWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, CMScreenH)];
        _productWebView.autoresizingMask = UIViewAutoresizingFlexibleHeight |UIViewAutoresizingFlexibleWidth ;
        _productWebView.delegate = self;
        _productWebView.scrollView.bounces = NO;
        _productWebView.scalesPageToFit=YES;
    }
    return _productWebView;
}
-(UIButton*)bottomBtn{
    if (!_bottomBtn) {
        _bottomBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomBtn setBackgroundColor:RedButtonColor];
        [_bottomBtn setTitle:@"送所有好友588元礼包" forState:UIControlStateNormal];
        [_bottomBtn setImage:[UIImage imageNamed:@"bottomImage"] forState:UIControlStateNormal];
        [_bottomBtn addTarget:self action:@selector(sendAllPeople) forControlEvents:UIControlEventTouchUpInside];
        [_bottomBtn setImageEdgeInsets:UIEdgeInsetsMake(-2, 0, 0, 10)];
        _bottomBtn.titleLabel.font=[UIFont systemFontOfSize:14.0];
    }
    
    return _bottomBtn;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"refresh" higlightedImage:nil target:self action:@selector(refreshWebView)];
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.productWebView removeFromSuperview];
    self.productWebView=nil;
    self.urlStr=nil;
    


}





#pragma mark 刷新页面
- (void)refreshWebView
{
    //DLog(@"++=%@",self.currentURL);
    [self loadWebViewDataWithUrl:self.urlStr];
    
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    NSURL *URL = request.URL.absoluteURL;
    NSString *scheme = [URL path];
    if ([scheme isEqualToString:@"/cgi-bin/mobile"]) {
      self.productWebView.hidden=YES;

   }
    
    return YES;
   
    
}


- (void)loadWebViewDataWithUrl:(NSString *)url
{
    
    NSURL *urlStr=[NSURL  URLWithString:url];
    [self cleanCacheAndCookieWithUrl:urlStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:urlStr];
    
    [self.productWebView loadRequest:request];
    
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    // 弹框
    [[CMProgressHud sharedCMProgressHud]LoadProgress:self.navigationController.view WithMessage:@"正在努力加载中..." ];
    

    
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

   self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    NSString  *str=webView.request.URL.absoluteString;
    NSRange to = [str rangeOfString:@"?"];
    NSString *sid=[NSString stringWithFormat:@"%@",[str substringWithRange:NSMakeRange(0,to.location)]];

    if ([sid isEqualToString:@"https://w.mail.qq.com/cgi-bin/mobile"]) {
        [self paramHtmlWithUrl:webView.request.URL.absoluteString];
        self.productWebView.hidden=YES;
       
    }
     [[CMProgressHud sharedCMProgressHud] removeProgressHUD];

}

-(void)paramHtmlWithUrl:(NSString*)url{
    
    [self.view bringSubviewToFront:self.myTabelview];
    [self creatBottomView];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:nil higlightedImage:nil target:self action:@selector(refreshWebView)];
            NSString  *str=url;
            NSRange from=[str rangeOfString:@"="];
            NSRange to = [ str rangeOfString:@"&"];
            NSString *sid=[NSString stringWithFormat:@"%@",[str substringWithRange:NSMakeRange(from.location+to.length,to.location-from.location-1) ]];
           
            if (sid.length>30) {
                NSString *url=[NSString stringWithFormat:@"https://w.mail.qq.com/cgi-bin/addr_listall?fromsidebar=1&sid=%@&flag=star&folderid=all&pagesize=10&from=today&fun=slock&page=0&topmails=0&t=addr_listall&loc=bottle_panel,bottle_index,,158&version=html",sid];
                NSData  * data     = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
                TFHpple * doc      = [[TFHpple alloc] initWithHTMLData:data];
                NSArray * elements = [doc searchWithXPathQuery:@"//span"];
                for (TFHppleElement *happleEm in elements) {
                    
                    CMQQModel *model=[CMQQModel new];
                    
                    static NSString *name;
                    if ([[happleEm objectForKey:@"class"]isEqualToString:@"qm_list_item_title"]) {
                        name=happleEm.text;
                    }
                    if ([[happleEm objectForKey:@"class"]isEqualToString:@"qm_list_item_subtitle"]) {
                        if ([CMRegularJudement checkUserEmail:happleEm.text ]) {
                            
                            model.Email=happleEm.text;
                            model.Name=name;
                            [self.dataArr addObject:model];
                        }
                        
                    }
                }
                
                
                [self upLoadEmailWithArr:self.dataArr];
                
                [self.myTabelview reloadData];
                
                
                
            }
            
    
    
    
}



#pragma mark tableView
-(void)creatBottomView{
    
    [self.view addSubview:self.bottomBtn];
    [self.view bringSubviewToFront:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.left.right.bottom.equalTo(self.view);
        
    }];
    
}


-(UITableView*)myTabelview{
    if (!_myTabelview) {
        _myTabelview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, CMScreenH) style:UITableViewStylePlain];
        _myTabelview.dataSource = self;
        _myTabelview.delegate = self;
        _myTabelview.separatorStyle=UITableViewCellSeparatorStyleNone;
        _myTabelview.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, f_i5real(150))];
        
    }
    return _myTabelview;
}

-(NSMutableArray*)dataArr{
    if (!_dataArr) {
        _dataArr=[NSMutableArray arrayWithCapacity:0];
    }
    return _dataArr;
    
}
#pragma mark  tableview代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50.0f;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"indexPath";
    CMQQEmailCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        
        cell=[[CMQQEmailCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    CMQQModel *model=self.dataArr[indexPath.row];
    cell.NinCheng.text=model.Name;
    cell.EmailNum.text=model.Email;
    cell.CMQQEmaildelegate=self;
    cell.indexPath=indexPath;
    [cell.headIcon setTitle:[model.Name substringWithRange:NSMakeRange(0, 1)] forState:UIControlStateNormal];
    
    if(!self.isAllPeople){
       
            if (model.isSend) {
                cell.sendEmailBtn.userInteractionEnabled=NO;
                [cell.sendEmailBtn setTitle:@"已发送" forState:UIControlStateNormal];
                [cell.sendEmailBtn setTitleColor:UIColorFromRGB(0x8e8d93) forState:UIControlStateNormal];
                [cell.sendEmailBtn setBackgroundColor:[UIColor whiteColor]];
                [cell.sendEmailBtn  mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(81/2.0);
                }];
            }else{
                [cell.sendEmailBtn setBackgroundColor:RedButtonColor];
                [cell.sendEmailBtn setTitle:@"免费送好友588元礼包" forState:UIControlStateNormal];
                [cell.sendEmailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                cell.sendEmailBtn.userInteractionEnabled=YES;
                [cell.sendEmailBtn  mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.equalTo(@130);
                }];
          }
        
    }
    else{
        if(model.isSend){
            cell.sendEmailBtn.userInteractionEnabled=NO;
            [cell.sendEmailBtn setTitle:@"已发送" forState:UIControlStateNormal];
            [cell.sendEmailBtn setTitleColor:UIColorFromRGB(0x8e8d93) forState:UIControlStateNormal];
            [cell.sendEmailBtn setBackgroundColor:[UIColor whiteColor]];
            [cell.sendEmailBtn  mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(81/2.0);
            }];
        }
        
           }

    
    
    
    return cell;
    
}
-(void)invationBtnClickWith:(NSIndexPath*)index{
   
    CMQQModel *people= [self.dataArr objectAtIndexCheack:index.row];
    NSMutableArray *peopleArr=[NSMutableArray arrayWithCapacity:0];
    [peopleArr addObject:people];
   [self sendEmailWithArr:peopleArr];
    
    people.isSend=YES;
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:index.row inSection:index.section];
    [self.myTabelview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    DLog(@"Email+++%@",people.Email);
 
    
    
    
}
-(void)sendAllPeople{
  
    

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *peopleArr=[NSMutableArray arrayWithCapacity:0];
         
                for (CMQQModel *p in self.dataArr) {
                    if (!p.isSend) {
                        p.isSend=YES;
                        [peopleArr addObject:p];
                    }
                    
                    }
                    
             [self sendEmailWithArr:peopleArr];
            self.isAllPeople=YES;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.myTabelview reloadData];
                self.bottomBtn.userInteractionEnabled=NO;
                CMSendMsgAlert *alert=[[CMSendMsgAlert alloc]initWithAlert];
                [alert ShowAlert];
                
            });
            
        });
   
    
    
}

-(void)upLoadEmailWithArr:(NSMutableArray*)arr{
  
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
    
        NSMutableArray  *data=[NSMutableArray array];
        for (CMQQModel *p in arr) {
            NSMutableDictionary  *dict=[NSMutableDictionary dictionary];
            [dict setObject:p.Name forKey:@"Name"];
            [dict setObject:p.Email forKey:@"Email"];
            [data addObject:dict];
        }
        [CMRequestHandle uploadQQEmailWithArr:data andSuccess:^(id responseObj) {
            
            DLog(@"++++%@",responseObj);
            
        }];
        
 
    });
    
    
    
}
#pragma mark 发送邮件

-(void)sendEmailWithArr:(NSMutableArray*)arr{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableArray  *data=[NSMutableArray array];
        for (CMQQModel *p in arr) {
            NSMutableDictionary  *dict=[NSMutableDictionary dictionary];
            [dict setObject:p.Name forKey:@"Name"];
            [dict setObject:p.Email forKey:@"Email"];
            [data addObject:dict];
         
        }
        DLog(@"data++++%@",data);
        [CMRequestHandle sendEmailWithArr:data andSuccess:^(id responseObj) {
            
            DLog(@"++++%@+++%@",responseObj,[responseObj objectForKey:@"Result"] );
            
        }];
    
        
    });
  
    
    
}


/**清除缓存和cookie*/
- (void)cleanCacheAndCookieWithUrl:(NSURL*)url{
   
    NSArray *cookieArr = [[NSHTTPCookieStorage sharedHTTPCookieStorage]cookiesForURL:url];
    for (NSHTTPCookie* cookie in cookieArr){
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
    //清除UIWebView的缓存
    [[NSURLCache sharedURLCache] removeCachedResponseForRequest:[NSURLRequest requestWithURL:url]];

    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
}
ReceiveMemoryWarning
@end
