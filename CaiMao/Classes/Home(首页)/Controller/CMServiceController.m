//
//  CMServiceController.m
//  CaiMao
//
//  Created by Fengpj on 15/12/9.
//  Copyright © 2015年 58cm. All rights reserved.
//

#import "CMServiceController.h"

@interface CMServiceController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{

    NSArray *_titleArr;
   //NSArray *_subTitleArr1;
    NSArray *_subTitleArr;
    NSArray *_headerTitleArr;
 
}

@property(nonatomic,strong)UICollectionView *serviceCollectionView;
@property(nonatomic,strong)UICollectionViewFlowLayout *layout;
 @end

@implementation CMServiceController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全部服务";
    
    _titleArr = [NSArray arrayWithObjects:
                 [NSArray arrayWithObjects:@"银行监管",@"保障安全",@"资质协议",nil],
                 [NSArray arrayWithObjects:@"随心存",@"财富宝",@"定期宝",@"月息盈",@"",@"",nil],//@"银票通",@"",@""
                 [NSArray arrayWithObjects:@"喵客18节",@"聚嗨利",@"喵杀惠",@"新客专享",@"VIP专享",@"",nil],
                 [NSArray arrayWithObjects:@"我的账户",@"关于财猫",@"帮助中心",@"我的优惠券",@"意见反馈",@"联系客服",nil],
                 nil];
    
  //  _subTitleArr1 = [NSArray arrayWithObjects:@"期限自定", nil];
    _subTitleArr = [NSArray arrayWithObjects:@"每月18日",@"人越多收益越高",@"疯抢130%收益",@"专享高收益",@"送京东购物卡",@"",nil];
    _headerTitleArr = [NSArray arrayWithObjects:@"品牌介绍",@"投资理财",@"特惠活动",@"更多服务", nil];
 
    [self setupUI];

}



- (void)setupUI
{
    
    // 设置头部并给定大小
    [self.layout setHeaderReferenceSize:CGSizeMake(self.serviceCollectionView.frame.size.width, 50)];
    [self.serviceCollectionView registerClass:[CMServiceCell class] forCellWithReuseIdentifier:@"serviceCell"];
    // 注册头部视图
    [self.serviceCollectionView registerClass:[CMSerHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CMSerHeaderView"];
    
    [self.view addSubview:self.serviceCollectionView];
    
   
}
-(UICollectionViewLayout*)layout{
    
    if (!_layout) {
        
        // 1.创建流水布局
       _layout = [[UICollectionViewFlowLayout alloc] init];
        UIImage *image=[UIImage imageNamed:@"我的优惠券"];
        
        // 2.设置每个格子的尺寸
        _layout.itemSize = CGSizeMake(CMScreenW/3.0,image.size.width+8+6+21+21+5);
        // layout.headerReferenceSize = CGSizeMake(0, 40);
        // 3.设置整个collectionView的内边距
        _layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        // 4.设置每一行之间的间距
        _layout.minimumLineSpacing = 0;
        // 设置cell之间的间距
        _layout.minimumInteritemSpacing = 0;
        

    
    }
    return _layout;
}


-(UICollectionView*)serviceCollectionView{
    if (!_serviceCollectionView) {
        
        _serviceCollectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:self.layout];
        _serviceCollectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight |UIViewAutoresizingFlexibleWidth;
        _serviceCollectionView.dataSource = self;
        _serviceCollectionView.delegate = self;
        _serviceCollectionView.showsVerticalScrollIndicator=NO;
        _serviceCollectionView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1.0];
        
    }
    return _serviceCollectionView;
}


//多少个区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _titleArr.count;;
}
//每个区单元格个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_titleArr[section] count];
}
//创建CEll
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
   static NSString *CellIdentifier = @"serviceCell";
    CMServiceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
  
    cell.serTitle.text = _titleArr[indexPath.section][indexPath.row];
    cell.serIcon.image = [UIImage imageNamed:_titleArr[indexPath.section][indexPath.row]];
    
    if (indexPath.section == 0 || indexPath.section == 3) {
        cell.serSubTitle.hidden = YES;
    }
    
//    if (indexPath.section == 1) {
//        if (indexPath.row == 0) {
//           cell.serSubTitle.hidden = NO;
//           cell.serSubTitle.text = @"期限自定";
//      } else {
           // cell.serSubTitle.hidden = YES;
       // }
    //}
    
    if (indexPath.section == 2) {
        cell.serSubTitle.hidden = NO;
        cell.serSubTitle.text = _subTitleArr[indexPath.row];
    }
  
    return cell;
}

// 设置头尾部内容
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //UICollectionReusableView *reusableView = nil;
    
   // if (kind == UICollectionElementKindSectionHeader) {
        // 定制头部视图的内容
        CMSerHeaderView *headerV = (CMSerHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CMSerHeaderView" forIndexPath:indexPath];
        headerV.titleLab.text = _headerTitleArr[indexPath.section];
       // reusableView = headerV;
   // }
    return headerV;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    CMServiceCell *cell = (CMServiceCell *)[collectionView cellForItemAtIndexPath:indexPath];
 
    cell.backgroundColor = [UIColor lightGrayColor];
}
- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    CMServiceCell *cell = (CMServiceCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
}


//点击单元格事件
#pragma mark 点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
        CMProductDetailController *productVc = [[CMProductDetailController alloc] init];
        [self.navigationController pushViewController:productVc animated:YES];
        
        switch (indexPath.row) {
            case 0:
                productVc.urlStr = @"http://m.58cm.com/exten/Platform-2.aspx";
                break;
            case 1:
                productVc.urlStr = @"http://m.58cm.com/exten/Platform-3.aspx";
                break;
            case 2:
                productVc.urlStr = @"http://m.58cm.com/exten/Platform-4.aspx";
                break;
                
            default:
                break;
        }
    } else if (indexPath.section == 1){
        
        CMCaiFuBaoController *cfVc = [[CMCaiFuBaoController alloc] init];
        CMDingQiDetailController *dqVc = [[CMDingQiDetailController alloc] init];
        CMYueXiYingDetailController *yxyVc = [[CMYueXiYingDetailController alloc] init];
    //  CMYinPiaoDetailController *yinVc = [[CMYinPiaoDetailController alloc] init];
               CMAsDepositController *vc=[[CMAsDepositController alloc]init];
                   switch (indexPath.row) {
                           case 0:
                           vc.realVaule=30;
                           CMPush(vc);
                           break;
            case 1:

                [self.navigationController pushViewController:cfVc animated:YES];
                break;
            case 2:
                [self.navigationController pushViewController:dqVc animated:YES];
                break;
            case 3:
                [self.navigationController pushViewController:yxyVc animated:YES];
                break;
//            case 3:
//                [self.navigationController pushViewController:yinVc animated:YES];
//                break;
                
            default:
                break;
        }
    } else if (indexPath.section == 2) {
        
        CMProductDetailController *proVc = [[CMProductDetailController alloc] init];
        CMJuHaiLiController *juVc = [[CMJuHaiLiController alloc] init];
        CMMiaoShaController *miaoVc = [[CMMiaoShaController alloc] init];
        CMXinKeController *xinVc = [[CMXinKeController alloc] init];

        switch (indexPath.row) {
                
            case 0:
                proVc.urlStr =Miao18Action;
                [self.navigationController pushViewController:proVc animated:YES];
                break;
            case 1:
                [self.navigationController pushViewController:juVc animated:YES];
                break;
            case 2:
                [self.navigationController pushViewController:miaoVc animated:YES];
                break;
            case 3:
                [self.navigationController pushViewController:xinVc animated:YES];
           //     proVc.urlStr = @"http://m.58cm.com/partners/xk.aspx";
         //      [self.navigationController pushViewController:proVc animated:YES];
                break;
            case 4:
                //proVc.urlStr = @"http://m.58cm.com/vip/vip.aspx";
//                [self.navigationController pushViewController:proVc animated:YES];
            {
                CMVIPController *vip=[[CMVIPController  alloc]init];
                
                CMPush(vip);
            }
                break;
                
            default:
                break;
        }
    } else {
        
//        CMProductDetailController *proVc = [[CMProductDetailController alloc] init];
        CMFeedBackController *feedVc = [[CMFeedBackController alloc] init];
       
        
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"4009993972"];
        UIWebView *callWebview = [[UIWebView alloc] init];
                switch (indexPath.row) {
            case 0: // 我的账户
//proVc.urlStr = @"http://m.58cm.com/icm/default.aspx";
                        if ([CMRequestManager islogin]) {
            

//                            UIWindow *window=[UIApplication sharedApplication].windows.firstObject;
//                            CMTabBarController *tab=(CMTabBarController*)window.rootViewController;
//                           // tab.selectedIndex=3;
//                            [tab selectTap:3];
//                      
//                            NSMutableArray  *arr=[[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
//                            for (UIViewController *vc in arr) {
//                                if ([vc isKindOfClass:[self class]]) {
//                                    
//                                    [arr removeObject:vc];
//                                    break;
//                                }
//                                
//                            }
//                            self.navigationController.viewControllers=arr;
                            CMAccountViewController *Account = [[CMAccountViewController alloc] init];
                            
                            [self.navigationController pushViewController:Account animated:YES];
                            
                            
                            
                        } else {
                            
            CMLoginController *login = [[CMLoginController alloc] init];
            [self.navigationController pushViewController:login animated:NO];
                           
                        }
//            [self.navigationController pushViewController:proVc animated:YES];
                break;
            case 1: // 关于财猫
                    {
//                proVc.urlStr = @"http://m.58cm.com/mi/index.aspx";
                        CMIntroduceController *Introduce = [[CMIntroduceController alloc] init];
                        
                [self.navigationController pushViewController:Introduce animated:YES];
                }
                break;
            case 2: // 帮助中心
                    {
               // proVc.urlStr = @"http://m.58cm.com/hp/index.aspx";
               CMHelpController *Introduce = [[CMHelpController alloc] init];
                        
                [self.navigationController pushViewController:Introduce animated:YES];
                    }
                break;
            case 3: // 我的优惠券
//                proVc.urlStr = @"http://m.58cm.com/icm/acc/Myyhq.aspx";
//                [self.navigationController pushViewController:proVc animated:YES];
                        
                        if ([CMRequestManager islogin]) {
                            
                            
                         
                            CMMyCouponsController *productVc = [[CMMyCouponsController alloc] init];
                            CMPush(productVc);
                            
                            
                        } else {
                            
                            CMLoginController *login = [[CMLoginController alloc] init];
                            [self.navigationController pushViewController:login animated:NO];
                        }
     
                    
                break;
            case 4: // 意见反馈
                [self.navigationController pushViewController:feedVc animated:YES];
                break;
            case 5: // 联系客服
                [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
                [self.view addSubview:callWebview];
                break;
            
            default:
                break;
        }
    }
    
}


@end
