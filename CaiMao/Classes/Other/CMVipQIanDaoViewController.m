//
//  CMVipQIanDaoViewController.m
//  CaiMao
//
//  Created by MAC on 16/11/5.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMVipQIanDaoViewController.h"
#import "CMCircleAnimationView.h"
@interface CMVipQIanDaoViewController ()
{
    CMQianDaoView *view;

}

@end

@implementation CMVipQIanDaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"VIP成长体系" style:UIBarButtonItemStylePlain target:self action:@selector(ChengZhangTixiDetail)];
     self.title=@"会员等级";
    self.phoneNum=[CMUserDefaults objectForKey:@"name"];
    [self createView];
    
}
#pragma mark 成长值界面
-(void)ChengZhangTixiDetail{
    CMChengzhangController *vc=[[CMChengzhangController alloc]init];
    vc.isQiDao=YES;
    CMPush(vc);
}
-(void)createView{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
              [self getVIPLevel];
        dispatch_async(dispatch_get_main_queue(), ^{
            view=[[CMQianDaoView alloc]init];
            view.backgroundColor=[UIColor whiteColor];
            view.frame=CGRectMake(0, 0, CMScreenW, f_i5real(400+100));
            view.NameLabel.text=[self.phoneNum stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];

            [self.view  addSubview:view];
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(QiandaoAction)];
            [view.qiandaoImageView addGestureRecognizer:tap];
            [view.ShengjiButton addTarget:self action:@selector(ChengZhangTixiDetail) forControlEvents:UIControlEventTouchUpInside];
            // 设置动画类型
            view.chengzhangVaule.counterAnimationType = PPCounterAnimationTypeEaseOut;
            view.delegate=self;
           
            
        });
        
    });
   
}

-(void)bugVipProductOrCheackFuLiWithIndex:(NSInteger)index;{
    
      DLog(@"签到+++%d",index);
    switch (index) {
        case 10:{
            CMVIPController *vip=[[CMVIPController  alloc]init];
            CMPush(vip);
        }
            break;
        case 11:
        {
            CMVIPController *vip=[[CMVIPController  alloc]init];
            CMPush(vip);
        }

            break;
        default:
            break;
    }
    
}
#pragma mark 签到
-(void)QiandaoAction{
    

    [CMRequestHandle  QianDaoandSuccess:^(id responseObj) {
        
       // DLog(@"+++++++%@",responseObj);
        if ([[responseObj objectForKey:@"Status"]intValue]==200) {
            NSDictionary  *dict=[responseObj objectForKey:@"t"];
            switch ([[dict objectForKey:@"viplevl"]intValue]) {
                case 0:
                    view.currentLevel.text=[NSString stringWithFormat:@"当前等级-普通会员"];
                    [view.ShengjiButton setTitle:@"升级成VIP1" forState:UIControlStateNormal];
                    break;
                case 1:
                    view.currentLevel.text=[NSString stringWithFormat:@"当前等级-VIP1"];
                    [view.ShengjiButton setTitle:@"升级成VIP2" forState:UIControlStateNormal];
                    break;
                case 2:
                    view.currentLevel.text=[NSString stringWithFormat:@"当前等级-VIP2"];
                    [view.ShengjiButton setTitle:@"升级成VIP3" forState:UIControlStateNormal];
                    break;
                case 3:
                    view.currentLevel.text=[NSString stringWithFormat:@"当前等级-VIP3"];
                    [view.ShengjiButton setTitle:@"升级成VIP4" forState:UIControlStateNormal];
                    break;
                case 4:
                    view.currentLevel.text=[NSString stringWithFormat:@"当前等级-VIP4"];
                    [view.ShengjiButton setTitle:@"升级成VIP5" forState:UIControlStateNormal];
                    break;
                case 5:
                    view.currentLevel.text=[NSString stringWithFormat:@"当前等级-VIP5"];
                    [view.ShengjiButton setTitle:@"了解VIP成长体系" forState:UIControlStateNormal];
                    break;
                    
                default:
                    break;
            }
            
            [self getVIPLevel];
            
//            [view.chengzhangVaule pp_fromNumber:0 toNumber:[[dict objectForKey:@"vipval"] floatValue]duration:1.5f formatBlock:^NSString *(CGFloat number) {
//                return [NSString stringWithFormat:@"%.0f",number];
//            }];
            [view.chengzhangVaule pp_fromNumber:0 toNumber:[[dict objectForKey:@"vipval"]floatValue] duration:2.0f animationType:PPCounterAnimationTypeLinear formatBlock:^NSString *(CGFloat number) {
                return [NSString stringWithFormat:@"%.0f",number];
                
            } completeBlock:nil];
        }
        
    } andFailure:^(id error) {
        
        
        
        
    }];
    
    
}

-(void)getVIPLevel{
    [CMRequestHandle getVipLevelandSuccess:^(id responseObj) {
      
        DLog(@"+++++++%@",responseObj);
        if ([[responseObj objectForKey:@"Status"]intValue]==200) {
            NSDictionary  *dict=[responseObj objectForKey:@"t"];
            switch ([[dict objectForKey:@"viplevl"]intValue]) {
                case 0:
                    view.currentLevel.text=[NSString stringWithFormat:@"当前等级-普通会员"];
                    [view.ShengjiButton setTitle:@"升级成VIP1" forState:UIControlStateNormal];
                    break;
                case 1:
                    view.currentLevel.text=[NSString stringWithFormat:@"当前等级-VIP1"];
                      [view.ShengjiButton setTitle:@"升级成VIP2" forState:UIControlStateNormal];
                    break;
                case 2:
                    view.currentLevel.text=[NSString stringWithFormat:@"当前等级-VIP2"];
                      [view.ShengjiButton setTitle:@"升级成VIP3" forState:UIControlStateNormal];
                    break;
                case 3:
                    view.currentLevel.text=[NSString stringWithFormat:@"当前等级-VIP3"];
                      [view.ShengjiButton setTitle:@"升级成VIP4" forState:UIControlStateNormal];
                    break;
                case 4:
                    view.currentLevel.text=[NSString stringWithFormat:@"当前等级-VIP4"];
                      [view.ShengjiButton setTitle:@"升级成VIP5" forState:UIControlStateNormal];
                    break;
                case 5:
                    view.currentLevel.text=[NSString stringWithFormat:@"当前等级-VIP5"];
                      [view.ShengjiButton setTitle:@"了解VIP成长体系" forState:UIControlStateNormal];
                    break;
                  
                default:
                    break;
            }
            
            if ([[dict objectForKey:@"issign"]intValue]==0) {
                //未签到
                view.qiandaoImageView.userInteractionEnabled=YES;
                view.QianDaoLabel.userInteractionEnabled=YES;
                view.QianDaoLabel.text=@"签到";
            }else{
               //已签到
                view.qiandaoImageView.userInteractionEnabled=NO;
                view.QianDaoLabel.userInteractionEnabled=NO;
                view.QianDaoLabel.text=[NSString stringWithFormat:@"已连续签到%@天",[dict objectForKey:@"cnt"]];
                
            }
            // 开始计数
          [view.chengzhangVaule pp_fromNumber:0 toNumber:[[dict objectForKey:@"vipval"]floatValue] duration:2.0f animationType:PPCounterAnimationTypeLinear formatBlock:^NSString *(CGFloat number) {
              return [NSString stringWithFormat:@"%.0f",number];
 
          } completeBlock:nil];
//            [view.chengzhangVaule pp_fromNumber:0 toNumber:[[dict objectForKey:@"vipval"] floatValue]duration:1.5f formatBlock:^NSString *(CGFloat number) {
//                return [NSString stringWithFormat:@"%.0f",number];
//            }];
//            
            [self performSelector:@selector(circleAnimation:) withObject:dict afterDelay:1];
        }
        
        
    } andFailure:^(id error) {
        
    }];
    
}

-(void)circleAnimation:(NSDictionary*)dict{
    DLog(@"++%@",dict);
    
    int  val=[[dict objectForKey:@"vipval"]intValue];
    if (val <=500) {
        view.circleProgressView.percent=(val/500.0);
    }
   else if (val <=2000) {
       view.circleProgressView.percent=((val-500)/1500.0)+1;
    } else if (val <=5000) {
       view.circleProgressView.percent=((val-2000)/3000.0)+2;
   } else if (val <=10000) {
        view.circleProgressView.percent=((val-5000)/5000.0)+3.3;
    } else if(val  <= 20000) {
        view.circleProgressView.percent=((val-10000)/10000.0)+4.2;

    } else {
        view.circleProgressView.percent=((val-20000)/20000.0)+5;

    }
}
@end
