//
//  CMProductDetailController.m
//  CaiMao
//
//  Created by Fengpj on 15/12/19.
//  Copyright © 2015年 58cm. All rights reserved.
//

#import "CMProductDetailController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "JQIndicatorView.h"
@interface CMProductDetailController ()<UIWebViewDelegate>

@property (strong,nonatomic) UIWebView *productWebView;
@property (assign,nonatomic) int navHeight;
@property (strong,nonatomic) JSContext *context;
@property(nonatomic,copy)NSString *nextUrl;
@property(nonatomic,strong)JQIndicatorView *IndicatorView;
@end


@implementation CMProductDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
   // self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor=ViewBackColor;
    self.automaticallyAdjustsScrollViewInsets = NO;

   [self.view addSubview:self.IndicatorView];
 
    [self.IndicatorView startAnimating];
//    self.productWebView.scrollView.mj_header=[CMRefreshHeader headerWithRefreshingBlock:^{
//        [self refreshWebView];
//    }];
    
    [self.view addSubview: self.productWebView];
    [self statisticalPage:[NSString stringWithFormat:@"web页+%@",self.urlStr]];
}
#pragma mark lazy
-(JQIndicatorView*)IndicatorView{
    if (!_IndicatorView) {
        _IndicatorView=[[JQIndicatorView alloc]initWithType:0 tintColor:RedButtonColor];
        _IndicatorView.center=CGPointMake(self.productWebView.center.x, self.productWebView.center.y-30);
        
    }
    return _IndicatorView;
}
-(UIWebView*)productWebView{
    if (!_productWebView) {
       _productWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, CMScreenH)];
        _productWebView.autoresizingMask = UIViewAutoresizingFlexibleHeight |UIViewAutoresizingFlexibleWidth ;
        _productWebView.delegate = self;
        //_productWebView.scrollView.bounces = NO;
        _productWebView.scalesPageToFit=YES;
        _productWebView.hidden=YES;
       
    }
    
    return _productWebView;
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    self.navigationItem.hidesBackButton=YES;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"nav_back_btn" higlightedImage:nil target:self action:@selector(backBtnClick)];
  // self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"refresh" higlightedImage:nil target:self action:@selector(refreshWebView)];
   self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"tehui_top_fenxiang" higlightedImage:nil target:self action:@selector(sharkClick:)];
  self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0]};
   [self loadWebViewData];
}
- (void)sharkClick:(id)sender
{

    CMCustomShareView   *shareView=[[CMCustomShareView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, CMScreenH)];
    [shareView showShareView];
    [CMRequestHandle shortUrl:self.urlStr andSuccess:^(id responseObj) {
        for (NSDictionary *dict in responseObj) {
            shareView.contentUrl=[dict objectForKey:@"url_short"];
            shareView.titleConten = self.title;
            shareView.contentStr =[NSString stringWithFormat:@"%@ %@",self.title ,shareView.contentUrl];
            shareView.ShareImageName=@[[UIImage imageNamed:@"cmshare"]];
        }

    }];
}


#pragma mark 导航返回事件
- (void)backBtnClick
{
    
    
    if ([self.productWebView canGoBack]) {
    
        if ([self.nextUrl containsString:@"Questionnaire"]) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
            [self.navigationController popViewControllerAnimated:YES];
        }
        
     [self.productWebView goBack];
        
    } else {
        [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        [self.navigationController popViewControllerAnimated:YES];
    }
 
}

#pragma mark 刷新页面
- (void)refreshWebView
{
    [self loadWebViewData];
}

- (void)loadWebViewData
{
    [self.productWebView reload];
   // self.urlStr=@"https://m.58cm.com/lc/julist.aspx";
   [CMCookie setCoookieForHost:self.urlStr];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:[self.urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    [self.productWebView loadRequest:request];
 
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    //self.currentTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
  //  [[CMProgressHud sharedCMProgressHud] removeFromSuperview];
    // 获取当前页面的title
  
    
  //  NSString *state=  [webView stringByEvaluatingJavaScriptFromString:@"document.readyState"];
  //  DLog(@"+++%@",state);
  // if([state isEqualToString:@"complete"]){
        
       [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByTagName('header')[0].hidden=true"];
       
       if ([self.title containsString:@"连连支付"]) {
           [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('header')[0].hidden=true"];
       }
       self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
       
       if (!webView.loading) {
           [self performSelector:@selector(webViewHiddenNot) withObject:nil afterDelay:1.5];
           
       }
  // }
  
    
   
    //self.currentURL = webView.request.URL.absoluteString;
   // [[CMProgressHud sharedCMProgressHud] removeProgressHUD];
   
//    NSString *scheme =webView.request.URL.path;
//    if ([scheme isEqualToString:@"/lc/InvestConfig.aspx"]||[scheme isEqualToString:@"lc/InvestPaymentSuccess2.aspx"] ||[scheme isEqualToString:@"/lc/InvestPayment.aspx00"] ) {
//        webView.frame=CGRectMake(0, -40, CMScreenW, CMScreenH+40);
//    }
    
    
  
//    // 关联 JSContext
//       // 打印异常
//    self.context.exceptionHandler =
//    ^(JSContext *context, JSValue *exceptionValue)
//    {
//        context.exception = exceptionValue;
//        DLog(@"异常%@", exceptionValue);
//    };
//  
//    
}
-(void)webViewHiddenNot{
    self.productWebView.hidden=NO;
    [self.IndicatorView stopAnimating];
    [self.IndicatorView removeFromSuperview];
    [self.productWebView.scrollView.mj_header endRefreshing];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
  [self.productWebView.scrollView.mj_header endRefreshing];
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;

  //  [[CMProgressHud sharedCMProgressHud]LoadProgress:self.navigationController.view WithMessage:@"正在努力加载中..." ];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByTagName('header')[0].hidden=true"];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
   [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByTagName('header')[0].hidden=true"];
    NSURL *URL = request.URL.absoluteURL;
    NSString *scheme = [URL path];
    self.nextUrl=scheme;
//DLog(@"+++%@",request.URL.absoluteString);
    
    

    if ([scheme isEqualToString:@"/login.aspx"]) {
        if (![CMRequestManager islogin]) {
            CMLoginController *login=[[CMLoginController alloc]init];
            [self.navigationController pushViewController:login animated:NO];
            return NO;
        }
          }
    if([scheme isEqualToString:@"/partners/xk.aspx"]){
        CMXinKeController *XinKe=[[CMXinKeController alloc]init];
        XinKe.fromWebView=YES;
        [self.navigationController pushViewController:XinKe animated:NO];
        return NO;
        
    }
    
    if(navigationType==UIWebViewNavigationTypeLinkClicked){
        [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByTagName('header')[0].hidden=true"];
       // DLog(@"UIWebViewNavigationTypeLinkClicked");
        if([scheme isEqualToString:@"/mi/index.aspx"]){
            CMIntroduceController *login=[[CMIntroduceController alloc]init];
            [self.navigationController pushViewController:login animated:NO];
            return NO;
            
        }
      
        
        if([scheme isEqualToString:@"/hp/index.aspx"]){
            CMHelpController *login=[[CMHelpController alloc]init];
            [self.navigationController pushViewController:login animated:NO];
            return NO;
            
        }
        
    }
    if([scheme isEqualToString:@"/cfb/cfbIndex.aspx"]){
        CMCaiFuBaoController *login=[[CMCaiFuBaoController alloc]init];
        [self.navigationController pushViewController:login animated:NO];
        return NO;
        
    }
    if ([scheme isEqualToString:@"/sxincun/Index.aspx"]) {
        
        CMAsDepositController *vc=[[CMAsDepositController alloc]init];
        vc.realVaule=30;
        vc.fromWebView=YES;
        [self.navigationController pushViewController:vc animated:NO];
   
        return NO;
    }
    

    
    
    return YES;
}


ReceiveMemoryWarning

@end
