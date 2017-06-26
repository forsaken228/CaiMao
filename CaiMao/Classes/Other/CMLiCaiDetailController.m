//
//  CMLiCaiDetailController.m
//  CaiMao
//
//  Created by MAC on 16/8/8.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMLiCaiDetailController.h"
#import "CMProductDetailHeadView.h"

#import "CMJipaiView.h"
#import "CMPayViewController.h"

@interface CMLiCaiDetailController ()<CMJipaiViewDelegate>
{
   NSArray *TitleCell;
   dispatch_source_t _timer;
   NSArray *DetaiTitleCell;
    int count;
  
}
@property(nonatomic,strong)CMProductBottomview  *bottomView;
@property(nonatomic,strong)CMProductDetailHeadView  *productHeadView;
@property(nonatomic,strong)NSMutableArray  *introductMutableArray;
@end

@implementation CMLiCaiDetailController

- (void)viewDidLoad {
    [super viewDidLoad];

 
    count=1;
    self.title=[self.productListArr objectForKey:@"title"];

  
    self.view.backgroundColor=ViewBackColor;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"tehui_top_fenxiang" higlightedImage:nil target:self action:@selector(sharkClick:)];
    
    self.myTabelView.tableHeaderView=self.productHeadView;
 
    self.productHeadView.productDict=self.productListArr;
 
    
#pragma mark 剩余份数
    [self productNum:count];
    
    NSString *renshu=[self.productListArr objectForKey:@"jpRenShu"];
    if ([renshu isEqualToString:@""]||[renshu intValue]==0) {
        self.recordTotalNum=[self.productListArr objectForKey:@"jbcnt"];
    }else{
        self.recordTotalNum=[self.productListArr objectForKey:@"jpRenShu"];
    }
    
//    [self LoneAttributedStringEndString:@"人" FromLabel: productHeadView.JinPaiPeopleNum];
    


    //DLog(@"log===%@",[self.productListArr objectForKey:@"ShouYiLv"]);
    NSString *juHali=[self.productListArr objectForKey:@"jyfs"];
#pragma mark 不是聚嗨利产品
    if ([juHali intValue]!=1) {  //不是聚嗨利产品
        self.productHeadView.juQiShilv.hidden=YES;
        self.productHeadView.juShou2.hidden=YES;
        self.productHeadView.juShou1.hidden=YES;
        self.productHeadView.juShou3.hidden=YES;
        self.productHeadView.juShou4.hidden=YES;
        self.productHeadView.juImage1.hidden=YES;
        self.productHeadView.juImage2.hidden=YES;
        self.productHeadView.juImage3.hidden=YES;
        self.productHeadView.juImage4.hidden=YES;
        self.productHeadView.juRen1.hidden=YES;
        self.productHeadView.juRen2.hidden=YES;
        self.productHeadView.juRen3.hidden=YES;
        self.productHeadView.juRen4.hidden=YES;
        self.productHeadView.smallSj.hidden=YES;
        [self.productHeadView.topBg mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@220);
            
        }];
        self.productHeadView.bounds=CGRectMake(0, 0, CMScreenW, 220);
        [self.myTabelView setTableHeaderView:self.productHeadView];
        [self.productHeadView.horneLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
        }];
        if (self.isMiaosha) {//是喵杀惠
         
             
            [self countDownWith:@" 11:00:00" andWanTime:@" 17:00:00" andCount:1 withNum:0];
               
        }else{
#pragma mark 产品倒计时
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
        NSDate *endDate = [dateFormatter dateFromString:[self.productListArr objectForKey:@"dqtime"]]; // 格式化到期时间
        NSDate *endDate_tomorrow = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([endDate timeIntervalSinceReferenceDate])];
        NSString *dateNowstr = [dateFormatter stringFromDate:[NSDate date]];
        NSDate *dateNow = [dateFormatter dateFromString:dateNowstr]; // 格式化当前时间
        NSTimeInterval timeInterval =[endDate_tomorrow timeIntervalSinceDate:dateNow];
        //|| list.zjfs * 10 - 1 <= list.jbfs
        if (_timer==nil) {
            __block int timeout = timeInterval; //倒计时时间
            
            if (timeout!=0) {
                dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
                dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
                dispatch_source_set_event_handler(_timer, ^{
                    if(timeout<=0){ //倒计时结束，关闭
                        dispatch_source_cancel(_timer);
                        _timer = nil;
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.productHeadView.endTime.text=@"距结束:00:00:00";
                            self.bottomView.jiPaiView.userInteractionEnabled=NO;
                             self.bottomView.jiPaiView.backgroundColor=[UIColor lightGrayColor];
                             self.bottomView.jiPaiView.jinPai.text=@"已结束";
                            self.productHeadView.SFenShu.text=[NSString stringWithFormat:@"%d份(%d元)",0,0];
                             self.bottomView.ButtonText.increaseBtn.userInteractionEnabled=NO;
                            self.bottomView.ButtonText.decreaseBtn.userInteractionEnabled=NO;
                            self.bottomView.ButtonText.textField.userInteractionEnabled=NO;
                        });
                    }else{
                      
                        int hour = timeout / 3600;
                        int minutes = (timeout % 3600) / 60;
                        int seconds = timeout % 60;
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.CPLB=[self.productListArr objectForKey:@"cplb"];
                            if ([self.CPLB intValue]==2){
                                if ([[self.productListArr objectForKey:@"zjfs"]intValue]<=[[self.productListArr objectForKey:@"jbfs"]intValue]) {
                                    
                                    self.productHeadView.endTime.text=@"距结束:00:00:00";
                                    self.bottomView.jiPaiView.userInteractionEnabled=NO;
                                    self.bottomView.jiPaiView.backgroundColor=[UIColor lightGrayColor];
                                    self.bottomView.jiPaiView.jinPai.text=@"已结束";
                                    self.productHeadView.SFenShu.text=[NSString stringWithFormat:@"%d份(%d元)",0,0];
                                    self.bottomView.ButtonText.increaseBtn.userInteractionEnabled=NO;
                                    self.bottomView.ButtonText.decreaseBtn.userInteractionEnabled=NO;
                                    self.bottomView.ButtonText.textField.userInteractionEnabled=NO;
                                }else{
                                    
                                    
                                      self.productHeadView.endTime.text = [NSString stringWithFormat:@"距结束:%02d:%02d:%02d",hour,minutes,seconds];
                                }
                           
                            
                            }else{
                                
                                if ([[self.productListArr objectForKey:@"zjfs"]intValue]*10-1<=[[self.productListArr objectForKey:@"jbfs"]intValue]) {
                                    
                                    self.productHeadView.endTime.text=@"距结束:00:00:00";
                                    self.bottomView.jiPaiView.userInteractionEnabled=NO;
                                    self.bottomView.jiPaiView.backgroundColor=[UIColor lightGrayColor];
                                    self.bottomView.jiPaiView.jinPai.text=@"已结束";
                                    self.productHeadView.SFenShu.text=[NSString stringWithFormat:@"%d份(%d元)",0,0];
                                    self.bottomView.ButtonText.increaseBtn.userInteractionEnabled=NO;
                                    self.bottomView.ButtonText.decreaseBtn.userInteractionEnabled=NO;
                                    self.bottomView.ButtonText.textField.userInteractionEnabled=NO;
                                }else{
                                    
                                    
                                    self.productHeadView.endTime.text = [NSString stringWithFormat:@"距结束:%02d:%02d:%02d",hour,minutes,seconds];
                                }
  
                                
                            }

                          
                        
                            
                            
                        });
                        timeout--;
                    }
                });
                dispatch_resume(_timer);
            }
        }
        }
        
    }else{
        #pragma mark 是聚嗨利产品
        self.productHeadView.HaiPeopleNum.hidden=NO;
        self.productHeadView.hubImage.hidden=YES;
        [self.productHeadView.ShouYiZheng mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.productHeadView.hubImage.mas_top).offset(20);
           make.right.equalTo(self.productHeadView.topBg.mas_centerX).offset(-25);
        }];
     self.productHeadView.juQiShilv.text = [[self.productListArr objectForKey:@"nlv"] stringByAppendingString:@"%"];
   
    // 设置各个阶段的收益率和人数 和 显示效果
    self.productHeadView.juShou1.text = [[[[self.productListArr objectForKey:@"ShouYiLv"] objectAtIndex:0] valueForKey:@"syl"] stringByAppendingString:@"%"];
    self.productHeadView.juRen1.text = [[[[self.productListArr objectForKey:@"ShouYiLv"] objectAtIndex:0] valueForKey:@"ICount"]stringByAppendingString:@"人"];
    self.productHeadView.juShou2.text = [[[[self.productListArr objectForKey:@"ShouYiLv"] objectAtIndex:1] valueForKey:@"syl"] stringByAppendingString:@"%"];
    self.productHeadView.juRen2.text = [[[[self.productListArr objectForKey:@"ShouYiLv"] objectAtIndex:1] valueForKey:@"ICount"]stringByAppendingString:@"人"];
    self.productHeadView.juShou3.text = [[[[self.productListArr objectForKey:@"ShouYiLv"] objectAtIndex:2] valueForKey:@"syl"] stringByAppendingString:@"%"];
    self.productHeadView.juRen3.text = [[[[self.productListArr objectForKey:@"ShouYiLv"] objectAtIndex:2] valueForKey:@"ICount"] stringByAppendingString:@"人"];
    self.productHeadView.juShou4.text = [[[[self.productListArr objectForKey:@"ShouYiLv"] objectAtIndex:3] valueForKey:@"syl"] stringByAppendingString:@"%"];
    self.productHeadView.juRen4.text = [[[[self.productListArr objectForKey:@"ShouYiLv"] objectAtIndex:3] valueForKey:@"ICount"] stringByAppendingString:@"人"];
    
    //NSInteger renshu1;
    NSInteger renshu2;
    NSInteger renshu3;
    NSInteger renshu4;
   // renshu1 = [[[[self.productListArr objectForKey:@"ShouYiLv"] objectAtIndex:0] valueForKey:@"ICount"] integerValue];
    renshu2 = [[[[self.productListArr objectForKey:@"ShouYiLv"] objectAtIndex:1] valueForKey:@"ICount"] integerValue];
    renshu3 = [[[[self.productListArr objectForKey:@"ShouYiLv"] objectAtIndex:2] valueForKey:@"ICount"] integerValue];
    renshu4 = [[[[self.productListArr objectForKey:@"ShouYiLv"] objectAtIndex:3] valueForKey:@"ICount"] integerValue];
    NSInteger jprenshu=[[self.productListArr objectForKey:@"jpRenShu"]integerValue];
    if ( 0 <= jprenshu && jprenshu < renshu2) {

        self.productHeadView.juImage1.image = [UIImage imageNamed:@"jhl_yuanquan_fill"];
        
    } else if ( renshu2 <= jprenshu && jprenshu < renshu3) {

        self.productHeadView.juImage2.image = [UIImage imageNamed:@"jhl_yuanquan_fill"];
    } else if ( renshu3 <= jprenshu && jprenshu < renshu4 ){

        self.productHeadView.juImage3.image = [UIImage imageNamed:@"jhl_yuanquan_fill"];
    } else {

        self.productHeadView.juImage4.image = [UIImage imageNamed:@"jhl_yuanquan_fill"];
    }
      
        if  (0 <= jprenshu && jprenshu < renshu2) {
             self.productHeadView.HaiPeopleNum.text=[NSString stringWithFormat:@"差%ld人嗨至%@",renshu2 - jprenshu,self.productHeadView.juShou2.text];

            
        } else if (renshu2 <= jprenshu && jprenshu < renshu3) {
            
            self.productHeadView.HaiPeopleNum.text = [NSString stringWithFormat:@"差%ld人嗨至%@",renshu3 - jprenshu,self.productHeadView.juShou3.text];

            
        } else if (renshu3 <= jprenshu && jprenshu < renshu4) {
            
            self.productHeadView.HaiPeopleNum.text = [NSString stringWithFormat:@"差%ld人嗨至%@",renshu4 - jprenshu,self.productHeadView.juShou4.text];

        } else {
            
              self.productHeadView.HaiPeopleNum.text=@"嗨到顶了,一起来嗨吧!";

        }
        
 [self countDownWith:@" 09:00:00" andWanTime:@" 18:00:00" andCount:10 withNum:1];
            
       
    
    }

    
#pragma mark 底部悬浮视图

    UIView *footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 150)];
    footView.backgroundColor=ViewBackColor;
    self.myTabelView.tableFooterView=footView;
   
    [self.view addSubview:self.myTabelView];
   
    TitleCell=@[@"收益计划",@"交易记录",@"产品详情",@"安全保障"];
    DetaiTitleCell=@[@"计息日期",@"收益分配",@"收益类型",@"转让赎回",@"产品规模",@"风险评级"];
    [self bottomJinPaiView];

    [self setData];
   
    _productHeadView.LiCaiDeati=self;
   //  [self statisticalPage:[NSString stringWithFormat:@"%@+%@",self.title,]];
}
-(void)setData{
    [self.introductMutableArray addObject:@"T(成交日)+1天"];
    if([[self.productListArr objectForKey:@"hkfs"]intValue]==1){
        [self.introductMutableArray addObject:@"按月等额本息"];
    }else if ([[self.productListArr objectForKey:@"hkfs"]intValue]==2){

        [self.introductMutableArray addObject:@"按月付息到期还本"];
    }
    else if ([[self.productListArr objectForKey:@"hkfs"]intValue]==3){
        [self.introductMutableArray addObject:@"到期还本付息"];
    }
    else if ([[self.productListArr objectForKey:@"hkfs"]intValue]==4){

          [self.introductMutableArray addObject:@"每月付息,到期还本"];
    }
    else if ([[self.productListArr objectForKey:@"hkfs"]intValue]==5){
        [self.introductMutableArray addObject:@"按季付息,到期还本"];

        
    }else if ([[self.productListArr objectForKey:@"hkfs"]intValue]==6){
        
        [self.introductMutableArray addObject:@"半年付息,到期还本"];
    }
    else if ([[self.productListArr objectForKey:@"hkfs"]intValue]==7){
        
        [self.introductMutableArray addObject:@"到期还本付息"];
    }
    
    if([[self.productListArr objectForKey:@"sylx"]intValue]==1){
        
        [self.introductMutableArray addObject:@"保本+固定收益"];
    }else if ([[self.productListArr objectForKey:@"sylx"]intValue]==2){
        
        [self.introductMutableArray addObject:@"保本"];
    }
    else if ([[self.productListArr objectForKey:@"sylx"]intValue]==3){
     
        [self.introductMutableArray addObject:@"保底＋浮动"];
    }else if ([[self.productListArr objectForKey:@"sylx"]intValue]==4){
  
        [self.introductMutableArray addObject:@"浮动收益"];
    }
    
    
    if([[self.productListArr objectForKey:@"zrsh"]intValue]==0){

            [self.introductMutableArray addObject:@"不可转让和赎回"];
    }else if ([[self.productListArr objectForKey:@"zrsh"]intValue]==1){
        NSString*ZhuangShouHui=[NSString stringWithFormat:@"持有%@月后可转让",[self.productListArr objectForKey:@"zrys"]];
        [self.introductMutableArray addObject:ZhuangShouHui];
       
    }
    else if ([[self.productListArr objectForKey:@"zrsh"]intValue]==2){
        NSString*ZhuangShouHui=[NSString stringWithFormat:@"持有%@月后可赎回",[self.productListArr objectForKey:@"zrys"]];
        [self.introductMutableArray addObject:ZhuangShouHui];
    }else if ([[self.productListArr objectForKey:@"zrsh"]intValue]==3){

        [self.introductMutableArray addObject:@"即可转让又可以赎回"];
        
    }
    
    
    if([[self.productListArr objectForKey:@"jedw"]intValue]==1){
        
        NSString*ProductScale=[NSString stringWithFormat:@"%d元起",[[self.productListArr objectForKey:@"Amount"] intValue]];
        [self.introductMutableArray addObject:ProductScale];
        
    }else if ([[self.productListArr objectForKey:@"jedw"]intValue]==2){
        NSString*ProductScale=[NSString stringWithFormat:@"%d万元起",[[self.productListArr objectForKey:@"Amount"] intValue]];
        [self.introductMutableArray addObject:ProductScale];
    }
    

    [self.introductMutableArray addObject:@"风险极低"];
    

    
    
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
    }
    
    return _myTabelView;
}
-(CMProductDetailHeadView*)productHeadView{
    if (!_productHeadView) {
        _productHeadView=[[CMProductDetailHeadView alloc]init];
        _productHeadView.frame=CGRectMake(0, 0, CMScreenW, 260);
    }
    return _productHeadView;
}
-(NSMutableArray*)introductMutableArray{
    if(!_introductMutableArray){
        _introductMutableArray=[NSMutableArray arrayWithCapacity:0];
    }
    
    return _introductMutableArray;
}
#pragma mark 早晚场倒计时
-(void)countDownWith:(NSString*)zaoTime andWanTime:(NSString*)WanTime andCount:(int)aCount withNum:(int)num{

    // 设置产品倒计时
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSDate *dqDate = [dateFormatter dateFromString:[self.productListArr objectForKey:@"dqtime"]]; // 格式化到期时间
    
    NSString *dateNowstr = [dateFormatter stringFromDate:[NSDate date]];
    NSDate *dateNow = [dateFormatter dateFromString:dateNowstr]; // 格式化当前时间
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"yyyy/MM/dd"]; // 当前日期：年月日
    NSString *dateStr = [dateFormatter2 stringFromDate:[NSDate date]];
    
    // 早场、晚场开始时间
    NSString *zaoTimeStr = [dateStr stringByAppendingString:zaoTime];
    NSDate *zaoStartDate = [dateFormatter dateFromString:zaoTimeStr];
    NSString *wanTimeStr = [dateStr stringByAppendingString:WanTime];
    NSDate *wanStartDate = [dateFormatter dateFromString:wanTimeStr];
    
    //  NSTimeInterval time = [dqDate timeIntervalSinceDate:dateNow]; // 比较时间差
    
    // 当前时间 ---> 早场即将开始 的时间差
    NSTimeInterval zaoTimeInterval = [zaoStartDate timeIntervalSinceDate:dateNow];
    // 早场开始后 ---> 结束 时间差
  //  NSTimeInterval zaoKaiToEndInterval = [dqDate timeIntervalSinceDate:dateNow];
    
    // 当前时间 ---> 晚场即将开始 的时间差
    NSTimeInterval wanTimeInterval = [wanStartDate timeIntervalSinceDate:dateNow];
    // 晚场开始后 ---> 结束 时间差
    NSTimeInterval wanKaiToEndInterval = [dqDate timeIntervalSinceDate:dateNow];
    
    __block int timeout ; // 倒计时时间
    
    if (zaoTimeInterval < 0 && wanTimeInterval > 0) {
        timeout = wanTimeInterval;
    } else if (zaoTimeInterval > 0) {
        timeout = self.isZao == YES ? zaoTimeInterval : wanTimeInterval;
    } else if (wanTimeInterval < 0) {
        timeout = self.isZao == YES ? 0 :wanKaiToEndInterval;
    }
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timerSecond = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timerSecond,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); // 每秒执行
    dispatch_source_set_event_handler(_timerSecond, ^{
     //|| [[self.productListArr objectForKey:@"zjfs"]intValue] <= [[self.productListArr objectForKey:@"jbfs"]intValue]
        // list.zjfs * 10 - 1 <= list.jbfs 表示产品拍完 结束竞拍
        

        if(timeout <= 0 ||[[self.productListArr objectForKey:@"zjfs"]intValue ] * aCount - num <= [[self.productListArr objectForKey:@"jbfs"]intValue ]){ // 倒计时结束，关闭
            
            
            dispatch_source_cancel(_timerSecond);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // 设置界面的按钮显示
               
                self.productHeadView.endTime.text=@"距结束:00:00:00";
                self.bottomView.jiPaiView.userInteractionEnabled=NO;
                self.bottomView.jiPaiView.backgroundColor=[UIColor lightGrayColor];
                self.bottomView.jiPaiView.jinPai.text=@"已结束";
                self.productHeadView.SFenShu.text=[NSString stringWithFormat:@"%d份(%d元)",0,0];
                [NSString LoneAttributedFontStringEndString:@"份" FromLabel:self.productHeadView.SFenShu];
                self.bottomView.ButtonText.textField.userInteractionEnabled=NO;
                self.bottomView.ButtonText.increaseBtn.userInteractionEnabled=NO;
                self.bottomView.ButtonText.decreaseBtn.userInteractionEnabled=NO;
            });
            
            
        } else {
            int hour = timeout / 3600;
            int minutes = (timeout % 3600) / 60;
            int seconds = timeout % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
              
                // 设置界面的按钮显示
                self.productHeadView.endTime.text = [NSString stringWithFormat:@"距开始:%02d:%02d:%02d",hour,minutes,seconds];
                
                if (zaoTimeInterval < 0 && wanTimeInterval > 0) {
                 
                    if (self.isZao) {

                        self.productHeadView.endTime.text = [NSString stringWithFormat:@"距结束:%02d:%02d:%02d",hour,minutes,seconds];
                        self.bottomView.jiPaiView.userInteractionEnabled=YES;
                        self.bottomView.jiPaiView.jinPai.text=@"竞拍";
                        self.bottomView.jiPaiView.backgroundColor=RedButtonColor;
                       
                        
                    } else {
                        self.bottomView.jiPaiView.userInteractionEnabled=NO;
                        self.bottomView.jiPaiView.jinPai.text=@"即将开始";
                        self.bottomView.jiPaiView.backgroundColor=CMColor(0, 175, 77);
                        self.productHeadView.HaiPeopleNum.text=@"准备好一起把收益嗨到顶";
                    }
                } else if (zaoTimeInterval > 0) {
                    self.bottomView.jiPaiView.userInteractionEnabled=NO;
                    self.bottomView.jiPaiView.jinPai.text=@"即将开始";
                    self.bottomView.jiPaiView.backgroundColor=CMColor(0, 175, 77);
                     self.productHeadView.HaiPeopleNum.text=@"准备好一起把收益嗨到顶";
                } else if (wanTimeInterval < 0) {
                    
                    if (self.isZao) {
                        self.bottomView.jiPaiView.userInteractionEnabled=NO;
                        self.bottomView.jiPaiView.backgroundColor=[UIColor lightGrayColor];
                        self.bottomView.jiPaiView.jinPai.text=@"已结束";
                        self.productHeadView.SFenShu.text=[NSString stringWithFormat:@"%d份(%d元)",0,0];
                        [NSString LoneAttributedFontStringEndString:@"份" FromLabel:self.productHeadView.SFenShu];
                        self.bottomView.ButtonText.increaseBtn.userInteractionEnabled=NO;
                        self.bottomView.ButtonText.decreaseBtn.userInteractionEnabled=NO;
                       self.bottomView.ButtonText.textField.userInteractionEnabled=NO;
                    } else {
                        self.productHeadView.endTime.text = [NSString stringWithFormat:@"距结束:%02d:%02d:%02d",hour,minutes,seconds];
                        self.bottomView.jiPaiView.userInteractionEnabled=YES;
                        self.bottomView.jiPaiView.jinPai.text=@"竞拍";
                        self.bottomView.jiPaiView.backgroundColor=RedButtonColor;
                    }
                }
            });
          
            timeout--;
        }
    });
    dispatch_resume(_timerSecond);
    

    
    
}
#pragma mark 底部悬浮
-(void)bottomJinPaiView{
    self.bottomView=  [[CMProductBottomview alloc] init];
    self.bottomView.userInteractionEnabled=YES;
    self.bottomView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.bottomView];
    [self.view bringSubviewToFront:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@50);
        make.left.right.bottom.equalTo(self.view);
        
    }];
    
    
    [self.bottomView.ButtonText.increaseBtn addTarget:self action:@selector(addProductNumBntClick) forControlEvents:UIControlEventTouchUpInside];
    self.bottomView.ButtonText.textField.delegate=self;
    self.bottomView.ButtonText.textField.text=[NSString stringWithFormat:@"%d",count];
    [self.bottomView.ButtonText.textField addTarget:self  action:@selector(inputProductNum)  forControlEvents:UIControlEventAllEditingEvents];
    [self.bottomView.ButtonText.decreaseBtn addTarget:self action:@selector(increaseProductNumBntClick) forControlEvents:UIControlEventTouchUpInside];
    self.bottomView.jiPaiView.delegate=self;
    self.bottomView.jiPaiView.PayJinEr.text=[NSString stringWithFormat:@"需支付:%d元",count*self.productFenEr];
    
    
    
    
}
#pragma mark 竞拍
-(void)jiPaiBtnClick{
    DLog(@"竞拍点击了");
    CMPayViewController *vc=[[CMPayViewController alloc]init];
    vc.countNum=count;
    vc.ProuctListArr=self.productListArr;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return DetaiTitleCell.count;
    }else{
        return TitleCell.count;
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
        cell.titleLabel.text=DetaiTitleCell[indexPath.row];
        cell.detailLabel.text=self.introductMutableArray[indexPath.row];
        CGRect rect=[ cell.detailLabel.text boundingRectWithSize:CGSizeMake(150, 15) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0]} context:nil];
        [cell.detailLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(rect.size.width+2);
        }];
        if (indexPath.row==5) {
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
    cell.productLeft.text=TitleCell[indexPath.row];
    if (indexPath.row==1) {
       cell.PeopleNum.hidden=NO;
       cell.PeopleNum.text=[NSString stringWithFormat:@"%@人",self.recordTotalNum];
       
    }
  
    return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        
  
    switch (indexPath.row) {
        case 0://收益计划
        {
            CMShouYiRecordController *SYRecord=[[CMShouYiRecordController alloc]init];
             SYRecord.pid=[self.productListArr objectForKey:@"pid"];
            [self.navigationController pushViewController:SYRecord animated:YES];
        }
            break;
        case 1:{//交易记录
            CMDealrecordController *record=[[CMDealrecordController alloc]init];
            record.pid=[self.productListArr objectForKey:@"pid"];
            record.fenEr=self.productFenEr;
            [self.navigationController pushViewController:record animated:YES];
            
        }
            
            break;
        case 2:
        {  //产品详情
            CMProductDetailController *det=[[CMProductDetailController alloc]init];
            det.urlStr=[NSString stringWithFormat:@"%@/lc/productinfo.aspx?w=%@",OnLineCode,[self.productListArr objectForKey:@"pid"]];
            
            [self.navigationController pushViewController:det animated:YES];
            
        }
            break;
        case 3:{ //安全保障
            CMSsecurityAssuranceController *sec=[[CMSsecurityAssuranceController alloc]init];
            sec.pListDict=self.productListArr;
            [self.navigationController pushViewController:sec animated:YES];
        }
            break;
            
        default:
            break;
    }
    
      }
}

#pragma mark 监听竞拍份数
-(void)inputProductNum{
    
    count=[ self.bottomView.ButtonText.textField.text intValue];
//    if(self.midTextField.text.length<=0||[self.midTextField.text intValue]==0){
//        count=1;
//        self.midTextField.text=[NSString stringWithFormat:@"%d",count];
//        
//    }
   
 [self productNum:count];
    self.bottomView.jiPaiView.PayJinEr.text=[NSString stringWithFormat:@"需支付:%d元",count*self.productFenEr];
    DLog(@"++++%d+++%d-----%d",[self productNum:count],count,[self productNum:0]);
    if ([self productNum:count]<=0 ) {
        //count=1;
         self.bottomView.ButtonText.textField.text=[NSString stringWithFormat:@"%d",[self productNum:0]];
        count=[self productNum:0];
        self.bottomView.jiPaiView.PayJinEr.text=[NSString stringWithFormat:@"需支付:%d元",count*self.productFenEr];
          self.productHeadView.SFenShu.text=[NSString stringWithFormat:@"%d份(%d元)",0,0];
    }
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if([ self.bottomView.ButtonText.textField.text intValue]==0){
        count=1;
         self.bottomView.ButtonText.textField.text=[NSString stringWithFormat:@"%d",count];
        [self productNum:count];
        self.bottomView.jiPaiView.PayJinEr.text=[NSString stringWithFormat:@"需支付:%d元",count*self.productFenEr];
    
    }
}
#pragma mark 减产品数量方法
-(void)increaseProductNumBntClick{
    
    DLog(@"+++++减");
    if (count<=1) {
        
        return;
    }
    count--;
    self.bottomView.ButtonText.textField.text=[NSString stringWithFormat:@"%d",count];
 
   [self productNum:count];
  
    self.bottomView.jiPaiView.PayJinEr.text=[NSString stringWithFormat:@"需支付:%d元",count*self.productFenEr];
    if ([self productNum:count]>0) {
        self.bottomView.ButtonText.increaseBtn.userInteractionEnabled=YES;
        self.bottomView.ButtonText.textField.userInteractionEnabled=YES;
    }
    
}

#pragma mark 加产品数量方法
-(void)addProductNumBntClick{
     DLog(@"+++++加");
    count++;
     self.bottomView.ButtonText.textField.text=[NSString stringWithFormat:@"%d",count];
    
    [self productNum:count];
    self.bottomView.jiPaiView.PayJinEr.text=[NSString stringWithFormat:@"需支付:%d元",count*self.productFenEr];
    if ([self productNum:count]<=0) {
        self.bottomView.ButtonText.increaseBtn.userInteractionEnabled=NO;
        self.bottomView.ButtonText.textField.userInteractionEnabled=NO;
    }
}
#pragma mark 产品剩余份数
-(int)productNum:(int)aCount{
    self.CPLB=[self.productListArr objectForKey:@"cplb"];
    self.productFenEr=[[self.productListArr objectForKey:@"cpfe"]intValue];
      NSArray *shouArr=[self.productListArr objectForKey:@"ShouYiLv"];
    static int mount;
    if ([self.CPLB intValue]==3||shouArr.count>0||shouArr!=NULL) {
        mount=[[self.productListArr objectForKey:@"zjfs"] intValue]*10-[[self.productListArr objectForKey:@"jbfs"] intValue]-aCount;
    }else if ([self.CPLB intValue]==2||shouArr.count<=0||shouArr==NULL){
        mount=[[self.productListArr objectForKey:@"zjfs"] intValue]-[[self.productListArr objectForKey:@"jbfs"] intValue]-aCount;
    }
    int mountPay=mount*self.productFenEr;
    self.productHeadView.SFenShu.text=[NSString stringWithFormat:@"%d份(%d元)",mount,mountPay];
    [NSString LoneAttributedFontStringEndString:@"份" FromLabel:self.productHeadView.SFenShu];
    return mount;
}
#pragma mark - 分享
- (void)sharkClick:(id)sender
{
    
    
  UIWindow *window = [UIApplication  sharedApplication].keyWindow;
    CMCustomShareView   *shareView=[[CMCustomShareView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, CMScreenH)];

    [window addSubview:shareView];
    
    
   [CMRequestHandle shortUrl:[NSString stringWithFormat:@"http://m.58cm.com/tz/lcshow_%@.aspx",[self.productListArr objectForKey:@"pid"]] andSuccess:^(id responseObj) {
        for (NSDictionary *dict in responseObj) {
            
            shareView.contentUrl=[dict objectForKey:@"url_short"];
          
            shareView.titleConten = [self.productListArr objectForKey:@"title"];
            
           shareView.contentStr =[NSString stringWithFormat:@"%@ 年化收益：%@ %%；起点金额：%@元； 特大型担保公司本息担保；基于银行平台的高收益快乐理财！%@",[self.productListArr objectForKey:@"title"],[self.productListArr objectForKey:@"nlv_max"],[self.productListArr objectForKey:@"cpfe"],shareView.contentUrl];
            shareView.ShareImageName=@[[UIImage imageNamed:@"cmshare"]];

       }
        
        
   }];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 10.0f;
    }else{
    return 0.01f;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 10.0f;
    }else{
        return 0.01f;
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.myTabelView)
    {
        CGFloat sectionHeaderHeight = 10;
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}

@end
