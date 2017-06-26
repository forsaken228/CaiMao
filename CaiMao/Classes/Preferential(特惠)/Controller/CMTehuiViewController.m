//
//  CMTehuiViewController.m
//  CaiMao
//
//  Created by Fengpj on 14-12-12.
//  Copyright (c) 2014年 58cm. All rights reserved.
//

#import "CMTehuiViewController.h"


@interface CMTehuiViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic)UIView *teHeaderView;

@property (strong, nonatomic)UITableView *tehuiTableView;

@property (strong, nonatomic)NSArray *tehuiList;

@property (strong, nonatomic)NSMutableArray *sourceArray;
@property (strong, nonatomic)NSMutableArray *bannerURLArray;

@end

@implementation CMTehuiViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor=ViewBackColor;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"tehui_top_fenxiang" higlightedImage:nil target:self action:@selector(sharkClick:)];
    
    [self showDefaultProgressHUD];
    self.tehuiTableView.hidden=YES;
    [self.view addSubview:self.tehuiTableView];
    
    [self LoadData];
    
    self.tehuiTableView.mj_header = [CMRefreshHeader headerWithRefreshingBlock:^{
        [self LoadData];
        
    }];
    

    [CMNSNotice addObserver:self selector:@selector(perferenceBackLoginVc) name:@"preferenceLoginVc" object:nil];
}
-(void)LoadData{
    [self loadBannerData];
    [self loadTeHuiData];
}

-(void)perferenceBackLoginVc{
    CMLoginController *loginVc = [[CMLoginController alloc] init];
    [self.navigationController pushViewController:loginVc animated:NO];

}
#pragma  mark Lazy
-(UITableView*)tehuiTableView{
    if (!_tehuiTableView) {
        _tehuiTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        
        _tehuiTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _tehuiTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tehuiTableView.showsVerticalScrollIndicator=NO;
        _tehuiTableView.showsHorizontalScrollIndicator=NO;
        _tehuiTableView.dataSource = self;
        _tehuiTableView.delegate = self;
        _tehuiTableView.tableHeaderView = [self creatDingQiHeadView];
    }
    return _tehuiTableView;
    
}
-(NSArray*)tehuiList{
    if (!_tehuiList) {
        _tehuiList=[NSArray array];
    }
    return _tehuiList;
    
}
-(NSMutableArray*)sourceArray{
    if (!_sourceArray) {
        _sourceArray=[NSMutableArray array];
    }
    return _sourceArray;
    
}
-(NSMutableArray*)bannerURLArray{
    if (!_bannerURLArray) {
        _bannerURLArray=[NSMutableArray array];
    }
    return _bannerURLArray;
    
}
#pragma mark 加载特惠数据
- (void)loadTeHuiData
{
    if (![self checkNetWork]) {
        [self.tehuiTableView.mj_header endRefreshing];
        
    }
    [CMRequestHandle  GetTeHuiTopAdsMsgSuccess:^(id responseObj){
        //DLog(@"+++%@",responseObj);
        if([[responseObj objectForKey:@"status"]intValue]==200){
            NSArray *resultArr = [responseObj  valueForKey:@"result"];
            
            self.tehuiList = [CMTeHuiList objectArrayWithKeyValuesArray:resultArr];
            
            [self.tehuiTableView reloadData];
            
        }
        
        [self.tehuiTableView.mj_header endRefreshing];
    }andFailure:^(id error) {
        [self.tehuiTableView.mj_header endRefreshing];
    }];
}

#pragma mark - 请求banner数据
- (void)loadBannerData
{
    if (![self checkNetWork]) {
        [self.tehuiTableView.mj_header endRefreshing];
      
    }
    [CMRequestHandle GetTeHuiBarMsgSuccess:^(id responseObj) {
     
        if ([[responseObj objectForKey:@"status"]intValue]==200 ) {
            [self hiddenProgressHUD];
            self.tehuiTableView.hidden=NO;
             [self.sourceArray removeAllObjects];
             [self.bannerURLArray removeAllObjects];
        NSArray *imgArr = [responseObj valueForKey:@"result"];
    
        
        // 遍历数组取出图片的url地址
        for (NSString *adUrl in imgArr) {
            [self.sourceArray addObject:[adUrl valueForKey:@"adUrl"]];
        }
       
        
        // 遍历数组取出图片的链接url地址
        for (NSString *linkUrl in imgArr) {
            [self.bannerURLArray addObject:[linkUrl valueForKey:@"linkUrl"]];
        }
        
        
        [self addBannerImages];
         }
    }andFailure:^(id error) {
        [self.tehuiTableView.mj_header endRefreshing];
    }];
   
}


#pragma mark 添加Banner图片
- (void)addBannerImages
{
    FFScrollView *scroll = [[FFScrollView alloc] initPageViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, f_i5real(230)) views:self.sourceArray];
    
    //scroll.pageViewDelegate = self;
    [self.teHeaderView addSubview:scroll];
    scroll.scrollViewDidClickedBlock=^(NSInteger  pageNumber){
        
        CMProductDetailController *proVc = [[CMProductDetailController alloc] init];
        
        proVc.urlStr = [self.bannerURLArray objectAtIndex:pageNumber];
        
        [self.navigationController pushViewController:proVc animated:YES];
        
    };
}



#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  self.tehuiList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"Detailcell";
    CMTehuiCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[CMTehuiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    CMTeHuiList *list =  self.tehuiList[indexPath.section];
    
    
    cell.teTitle.text = list.title;
    cell.teSubTitle.text = list.content;
    
    NSURL *url = [NSURL URLWithString:list.adUrl];

    [cell.teImageView sd_setImageWithURL:url placeholderImage:nil options:SDWebImageAllowInvalidSSLCertificates];
    cell.teImageView.contentMode=UIViewContentModeScaleAspectFill;
    cell.teImageView.clipsToBounds=YES;
    
    CGSize rect=[ cell.teSubTitle.text boundingRectWithSize:CGSizeMake(304, MAXFLOAT) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil].size;
    
    [cell.teSubTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(rect.height+5);
    }];

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return [self creatDingQiSectionHeadView];
    }
    
    return nil;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CMTeHuiList *list =  self.tehuiList[indexPath.section];
   
    if (list.type==1) {
        //VIP
        CMVIPController *proVc = [[CMVIPController alloc] init];
        
        [self.navigationController pushViewController:proVc animated:YES];
    } else if(list.type==2) {
        //新客
        CMXinKeController *proVc = [[CMXinKeController alloc] init];
        
        [self.navigationController pushViewController:proVc animated:YES];
    }
    else if(list.type==3) {
        //定期理财
        CMDingQiDetailController *proVc = [[CMDingQiDetailController alloc] init];
        
        [self.navigationController pushViewController:proVc animated:YES];
    }

    else if(list.type==4) {
        //聚嗨利
        CMJuHaiLiController *proVc = [[CMJuHaiLiController alloc] init];
        
        [self.navigationController pushViewController:proVc animated:YES];
    }

    else if(list.type==5) {
        //喵杀惠
        CMMiaoShaController *proVc = [[CMMiaoShaController alloc] init];
        
        [self.navigationController pushViewController:proVc animated:YES];
    }

    else if(list.type==6) {
        //月息盈
        CMYueXiYingDetailController *proVc = [[CMYueXiYingDetailController alloc] init];
        
        [self.navigationController pushViewController:proVc animated:YES];
    }
    else if(list.type==7) {
        CMCaiFuBaoController *proVc = [[CMCaiFuBaoController alloc] init];
        
        [self.navigationController pushViewController:proVc animated:YES];
        
        //财富宝
    }else{
        CMProductDetailController *proVc = [[CMProductDetailController alloc] init];
        
        proVc.urlStr = list.linkUrl;
       
        [self.navigationController pushViewController:proVc animated:YES];
        
    }

    
//    CMProductDetailController *proVc = [[CMProductDetailController alloc] init];
//    
//    proVc.urlStr = list.linkUrl;
//    if (indexPath.section==0) {
//        proVc.NoNav=YES;
//    }
//    [self.navigationController pushViewController:proVc animated:YES];

   
//    DLog(@"++++%d",list.type);
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 40;
    }
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    CMTeHuiList *list =  self.tehuiList[indexPath.section];
  
    
    CGSize rect=[  list.content boundingRectWithSize:CGSizeMake(304, MAXFLOAT) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil].size;
    return  rect.height+148+24+20;
}

#pragma mark - 分享
- (void)sharkClick:(id)sender
{
   
    
    UIWindow *window = [UIApplication  sharedApplication].keyWindow;
    CMCustomShareView   *shareView=[[CMCustomShareView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, CMScreenH)];
    
    [window addSubview:shareView];
    
    
    [CMRequestHandle shortUrl:@"http://m.58cm.com/partners/tehui.aspx" andSuccess:^(id responseObj) {
        for (NSDictionary *dict in responseObj) {
            
            shareView.contentUrl=[dict objectForKey:@"url_short"];
            
            shareView.titleConten = @"传说猫有九条命，可财小猫生财之道不止九种！";
            
            shareView.contentStr =@"我正在参加财猫网特惠活动，福利大派送，快来一起领钱吧！";
            shareView.ShareImageName=@[[UIImage imageNamed:@"shareImage.png"]];
            
        }
        
        
    }];
    
    
    
}
-(void)dealloc{
    [CMNSNotice removeObserver:self name:@"preferenceLoginVc" object:nil];
}
#pragma mark 创建区头
-(UIView*)creatDingQiSectionHeadView{
    
    UIView *bgView=[[UIView alloc]init];
    bgView.frame=CGRectMake(0, 0, self.view.bounds.size.width, 40);
    bgView.backgroundColor = [UIColor whiteColor];
    
    
    
    UILabel *title=[UILabel new];
   // title.frame=CGRectMake(8,3, self.view.bounds.size.width-8, 33);
    title.text=@"最新优惠";
    title.textColor=UIColorFromRGB(0x333333);
    title.font=[UIFont boldSystemFontOfSize:18.0];
    [bgView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@18);
        make.left.equalTo(bgView.mas_left).offset(8);
        make.top.equalTo(bgView.mas_top).offset(10);
        make.width.equalTo(@100);
        
    }];
    
    UIView *level=[UIView new];
    level.backgroundColor=ViewBackColor;
    
    [bgView addSubview:level];
    
    [level mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title.mas_bottom).offset(10);
        make.left.right.width.equalTo(bgView);
        make.height.mas_equalTo(0.5);
    }];
    return bgView;
    
}
#pragma mark 创建表头
-(UIView*)creatDingQiHeadView{
    
    NSArray *btnImage=@[@"btn_xkzx",@"btn_jhl",@"btn_msh",@"btn_mk18j"];
    UIImage *image=[UIImage imageNamed:btnImage[0]];
    UIView *bgView=[[UIView alloc]init];
    
    bgView.frame=CGRectMake(0, 0, self.view.bounds.size.width,f_i5real(230+10+image.size.height));
    self.teHeaderView=bgView;
    
    for (int i=0; i<btnImage.count; i++) {
    
            UIButton *detailBtn=[UIButton buttonWithType:UIButtonTypeSystem];
            UIImage *image=[UIImage imageNamed:btnImage[i]];
            [detailBtn setBackgroundImage:image forState:UIControlStateNormal];
            detailBtn.frame=CGRectMake((i%btnImage.count)*(CMScreenW/4.0), f_i5real(230),CMScreenW/4.0, f_i5real(image.size.height));
            [detailBtn addTarget:self action:@selector(goDetailView:) forControlEvents:UIControlEventTouchUpInside];
            detailBtn.tag=i+10;
            [bgView addSubview:detailBtn];
      
        
    }
    UIView *level=[UIView new];
    level.backgroundColor=ViewBackColor;
    
    [bgView addSubview:level];
    
    [level mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bgView.mas_bottom);
        make.left.right.width.equalTo(bgView);
        make.height.mas_equalTo(f_i5real(10));
    }];
    
    
    return bgView;
    
}
-(void)goDetailView:(UIButton*)btn{
    switch (btn.tag) {
        case 10:
        {
            CMXinKeController *proVc = [[CMXinKeController alloc] init];
            [self.navigationController pushViewController:proVc animated:YES];
        }
            break;
            
        case 11:
        {
            CMJuHaiLiController *juVc = [[CMJuHaiLiController alloc] init];
            [self.navigationController pushViewController:juVc animated:YES];
        }
            
            break;
        case 12:
        {
            CMMiaoShaController *miaoVc = [[CMMiaoShaController alloc] init];
            [self.navigationController pushViewController:miaoVc animated:YES];
        }
            
            break;
        case 13:
        {
            CMProductDetailController *proVc = [[CMProductDetailController alloc] init];
            
            proVc.urlStr =Miao18Action;
            
            [self.navigationController pushViewController:proVc animated:YES];
        }
            
            break;
            
            
            
        default:
            break;
    }
    
    
}
checkNet

@end
