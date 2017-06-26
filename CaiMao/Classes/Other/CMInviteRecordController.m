//
//  CMInviteRecordController.m
//  CaiMao
//
//  Created by MAC on 16/8/12.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMInviteRecordController.h"
#import "CMInviteRecordHead.h"


#import "CMAwardListView.h"
#import "CMInviteFriendListView.h"
@interface CMInviteRecordController ()<CMInviteRecordHeadDelegate>
 
@property(nonatomic,strong) CMInviteRecordHead *IRHead;

@property(nonatomic,strong)UIScrollView *currentScrollView;
@end

@implementation CMInviteRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"邀请记录";
    self.view.backgroundColor=ViewBackColor;
    [self.view addSubview:self.IRHead];
    [self.view addSubview:self.currentScrollView];
    
    self.currentScrollView.contentSize=CGSizeMake(CMScreenW*2, self.view.frame.size.height-190);
    
    CMInviteFriendListView *FriendListView=[[CMInviteFriendListView alloc]initWithFrame:CGRectMake(0, 0, self.currentScrollView.bounds.size.width, self.currentScrollView.bounds.size.height)];
    [self.currentScrollView addSubview:FriendListView];
    
    CMAwardListView *AwardListView=[[CMAwardListView alloc]initWithFrame:CGRectMake(CMScreenW, 0, self.currentScrollView.bounds.size.width, self.currentScrollView.bounds.size.height)];
    [self.currentScrollView addSubview:AwardListView];
    
    
}

#pragma mark Lazy

-(CMInviteRecordHead*)IRHead{
    if (!_IRHead) {
        _IRHead=[[CMInviteRecordHead alloc]initWithFrame:CGRectMake(0, 0, CMScreenW, 190)];
        _IRHead.jLJE.text=[NSString stringWithFormat:@"￥%@",@"0"];
        _IRHead.ZCRS.text=[NSString stringWithFormat:@"注册人数:%@人",@"0"];
        _IRHead.TZRS.text=[NSString stringWithFormat:@"投资人数:%@人",@"0"];
       
        [_IRHead.QYQing addTarget:self action:@selector(goYaoQingFrieng) forControlEvents:UIControlEventTouchUpInside];
        _IRHead.delegate=self;
    }
    return _IRHead;
}

-(UIScrollView*)currentScrollView{
    if (!_currentScrollView) {
        _currentScrollView=[[UIScrollView alloc]init];
        _currentScrollView.bounces=NO;
        _currentScrollView.showsVerticalScrollIndicator=NO;
        _currentScrollView.showsHorizontalScrollIndicator=NO;
        _currentScrollView.backgroundColor=ViewBackColor;
        _currentScrollView.scrollEnabled=NO;
        
        _currentScrollView.frame=CGRectMake(0, 190, CMScreenW, self.view.frame.size.height-190);
    }
    return _currentScrollView;
}


-(void)inviteFriendListWithIndex:(NSInteger)index{
    
    CGRect rect = CGRectMake((index-10) *CGRectGetWidth(self.currentScrollView.frame), 0, CGRectGetWidth(self.currentScrollView.frame), CGRectGetHeight(self.currentScrollView.frame));
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        [self.currentScrollView scrollRectToVisible:rect animated:NO];
    } completion:^(BOOL finished) {
    }];
    
    
}



-(void)goYaoQingFrieng{
    
    [CMGetAddressBook requestAddressBookAuthorization:^{
        
    }];
    [[CMProgressHud sharedCMProgressHud]loadData:self.
     navigationController.view completion:^{
         CMContactViewController *proVc = [[CMContactViewController alloc] init];
         proVc.UserName=self.realName;
         [self.navigationController pushViewController:proVc animated:YES];//请求用户获取通讯录权限
         
     }];
    
}

checkNet;
@end
