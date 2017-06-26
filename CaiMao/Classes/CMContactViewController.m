//
//  CMContactViewController.m
//  CaiMao
//
//  Created by MAC on 16/10/12.
//  Copyright © 2016年 58cm. All rights reserved.
//
#import "CMContactViewController.h"
#import "CMSelectionIndex.h"
@interface CMContactViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableDictionary *contactPeopleDict;
@property (nonatomic, strong) NSMutableArray *keys;
@property (nonatomic, strong) NSMutableArray *resultArray;
@property (nonatomic, strong) NSMutableDictionary *plistDict;
@property (nonatomic, strong) NSArray *peopleArray;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIView *footView;
@property (nonatomic, assign) BOOL isAllPeople;
@property (nonatomic, assign) BOOL isSearch;
@property (nonatomic, strong)  UIButton *top;
@property (nonatomic, strong)  CMEmailSearchView *searchBarBgView;
@property (nonatomic, strong)  UIButton *bottomBtn;
@property (nonatomic, strong)  CMSelectionIndex  *CMindex;

@end


@implementation CMContactViewController



-(void)viewDidLoad{
   [super viewDidLoad];
    self.title=@"手机联系人";
    self.view.backgroundColor=ViewBackColor;
   
    self.isSearch=NO;
    self.isAllPeople=NO;
    [self.view addSubview:self.myTableView];

    if (ABAddressBookGetAuthorizationStatus()  ==  kABAuthorizationStatusAuthorized ||[CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] ==CNAuthorizationStatusAuthorized)
 {
     if ([[NSFileManager defaultManager]fileExistsAtPath:[CMCache getFilePath:@"Contanct.plist"]]) {
       
       //[self isInvationWithData:self.peopleArray];
         NSMutableArray *joinArr=[NSMutableArray arrayWithCapacity:0];
             //根据路径直接获取
             NSDictionary *dict=[NSKeyedUnarchiver unarchiveObjectWithFile:[CMCache getFilePath:@"Contanct.plist"]];
             //联系人分组按拼音分组的Key值
             self.peopleArray=[dict objectForKey:@"addressBookArray"];
             self.contactPeopleDict = [[NSMutableDictionary alloc]initWithDictionary:[self sortDict:self.peopleArray]];
             NSArray *nameKeys = [[self.contactPeopleDict allKeys] sortedArrayUsingSelector:@selector(compare:)];
             self.keys = [NSMutableArray arrayWithArray:nameKeys];
             
             
             for (CMContanct *p in self.peopleArray) {
                 if (p.isInvation) {
                     [joinArr addObject:p];
                 }
             }

                     [self creatSearchBar];
                     [self creatBottomView];
                     [self topView];
                     [self creatSelectIndex];
                     self.myTableView.tableFooterView = self.footView;
                     self.myTableView.scrollEnabled=YES;
                     self.searchBarBgView.JoinPeopleLabel.text=[NSString stringWithFormat:@"您还有%d位好友待邀请,已有%d位好友加入财猫",self.peopleArray.count-joinArr.count,joinArr.count];
        
                 
     }else{
         [[CMProgressHud sharedCMProgressHud]LoadProgress:self.navigationController.view  WithMessage:@"正在努力加载中..." ];
         [CMCache getFilePath:@"Contanct.plist"];
         [CMGetAddressBook getOriginalAddressBook:^(NSArray<CMContanct *> *addressBookArray) {
             if (addressBookArray.count!=0) {
               
                 [[CMProgressHud sharedCMProgressHud]removeProgressHUD];
                 self.peopleArray=addressBookArray;
                 
            
                 
                 
                 self.contactPeopleDict = [[NSMutableDictionary alloc]initWithDictionary:[self sortDict:addressBookArray]];
                 //联系人分组按拼音分组的Key值
                 NSArray *nameKeys = [[self.contactPeopleDict allKeys] sortedArrayUsingSelector:@selector(compare:)];
                 self.keys = [NSMutableArray arrayWithArray:nameKeys];
                 //[self.myTableView reloadData];
                 [self.plistDict setObject:addressBookArray forKey:@"addressBookArray"];
                   [NSKeyedArchiver  archiveRootObject:self.plistDict toFile:[CMCache getFilePath:@"Contanct.plist"]];
                 [self uploadContanctWithData:addressBookArray];
                 [self isInvationWithData:addressBookArray];
             }
            
                 // self.myTableView.tableHeaderView = [self creatSearchBar];
                 [self creatSearchBar];
                 [self creatBottomView];
                 [self topView];
             [self creatSelectIndex];
                 self.myTableView.tableFooterView = self.footView;
                 self.myTableView.scrollEnabled=YES;
           

             
         } authorizationFailure:^{
             self.myTableView.frame=CGRectMake(0, 45,CMScreenW, CMScreenH-64-40);
             CMGetContactFail *failView=[[CMGetContactFail alloc]initWithFrame:self.view.frame];
             self.myTableView.tableFooterView = failView;
             self.myTableView.scrollEnabled=NO;
             DLog(@"授权失败了");

         }];
         
     
     }
     self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"refresh" higlightedImage:nil target:self action:@selector(refreshData)];
            }else{
        self.myTableView.frame=CGRectMake(0, 45,CMScreenW, CMScreenH-64-40);
        CMGetContactFail *failView=[[CMGetContactFail alloc]initWithFrame:self.view.frame];
        self.myTableView.tableFooterView = failView;
        self.myTableView.scrollEnabled=NO;
        [self.myTableView reloadData];
       // [Bottombgview removeFromSuperview];
    }
    
    [CMNSNotice addObserver:self selector:@selector(requestAccessSuccess) name:@"requestAccessSuccess" object:nil];
    if ([CMUserDefaults boolForKey:@"gaibai"]==YES) {
        [self refreshData];
        [CMUserDefaults setBool:NO forKey:@"gaibai"];
        [CMUserDefaults synchronize];
    }
    

   
  
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
   
    self.tabBarController.tabBar.hidden = YES;
}

-(void)dealloc{
    
   [CMNSNotice removeObserver:self];
 
}

-(void)requestAccessSuccess{
   
     [CMCache getFilePath:@"Contanct.plist"];
    
    UIImage *QImageView=[UIImage imageNamed:@"QQEmailImage"];
    self.myTableView.frame=CGRectMake(0, f_i5real(QImageView.size.height)+30+45,CMScreenW, CMScreenH-64-40);
    [[CMProgressHud sharedCMProgressHud]LoadProgress:self.navigationController.view  WithMessage:@"正在努力加载中..." ];
    [CMGetAddressBook getOriginalAddressBook:^(NSArray<CMContanct *> *addressBookArray) {
        if (addressBookArray.count!=0) {
            //[CMContanct supportsSecureCoding];
           
            [[CMProgressHud sharedCMProgressHud]removeProgressHUD];
            self.peopleArray=addressBookArray;
           
            self.contactPeopleDict = [[NSMutableDictionary alloc]initWithDictionary:[self sortDict:addressBookArray]];
            //联系人分组按拼音分组的Key值
            NSArray *nameKeys = [[self.contactPeopleDict allKeys] sortedArrayUsingSelector:@selector(compare:)];
            self.keys = [NSMutableArray arrayWithArray:nameKeys];
            //[self.myTableView reloadData];
            [self.plistDict setObject:addressBookArray forKey:@"addressBookArray"];
            [NSKeyedArchiver  archiveRootObject:self.plistDict toFile:[CMCache getFilePath:@"Contanct.plist"]];
            [self uploadContanctWithData:addressBookArray];
            [self isInvationWithData:addressBookArray];
            

        }
        
            // self.myTableView.tableHeaderView = [self creatSearchBar];
            [self creatSearchBar];
            [self creatBottomView];
            [self topView];
            self.myTableView.tableFooterView = self.footView;
            self.myTableView.scrollEnabled=YES;
        
         self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"refresh" higlightedImage:nil target:self action:@selector(refreshData)];
        
        
    } authorizationFailure:^{
        
        
    }];
    [self.myTableView reloadData];
    
    }

#pragma mark 懒加载

-(UITableView*)myTableView{
    if (!_myTableView) {
         UIImage *QImageView=[UIImage imageNamed:@"QQEmailImage"];
        _myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, f_i5real(QImageView.size.height)+30+45, CMScreenW, CMScreenH-64-40) style:UITableViewStyleGrouped];
        _myTableView.delegate=self;
        _myTableView.dataSource=self;
        _myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _myTableView.showsVerticalScrollIndicator=NO;
        
    }
    return _myTableView;
}
-(NSMutableDictionary*)plistDict{
    if (!_plistDict) {
        _plistDict=[[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return _plistDict;
}
-(NSMutableArray*)keys{
    if (!_keys) {
        _keys=[NSMutableArray array];
        
    }
    return _keys;
}
-(NSMutableDictionary*)contactPeopleDict{
    if (!_contactPeopleDict ) {
        _contactPeopleDict=[NSMutableDictionary dictionary];
    }
    return _contactPeopleDict;
}
-(NSMutableArray*)resultArray{
    if (!_resultArray) {
        _resultArray=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return _resultArray;
}
-(NSArray*)peopleArray{
    if (!_peopleArray) {
        _peopleArray=[[NSArray alloc]init];
    }
    return _peopleArray;
}
-(UIView*)footView{
    if (!_footView) {
        _footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CMScreenW,f_i5real(150))];
        _footView.backgroundColor=ViewBackColor;

    }
    return _footView;
}
-(UISearchBar*)searchBar{
    if (!_searchBar) {
        _searchBar=[[UISearchBar alloc]init];
        _searchBar.backgroundColor=ViewBackColor;
        _searchBar.backgroundImage=[self GetImageWithColor:[UIColor clearColor] andHeight:24.0];
        _searchBar.delegate=self;
         [_searchBar setPlaceholder:@"搜索"];
        [_searchBar sizeToFit];
        
    }
    return _searchBar;
}
-(CMEmailSearchView*)searchBarBgView{
    if (!_searchBarBgView) {
        _searchBarBgView=[[CMEmailSearchView alloc]init];

    }
    return _searchBarBgView;
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
-(CMSelectionIndex*)CMindex{
    if (!_CMindex) {
        _CMindex=[[CMSelectionIndex alloc]initWithKeys:self.keys];
    }
    
    return _CMindex;
}

#pragma mark
-(void)creatSearchBar{
    UIImage *QImageView=[UIImage imageNamed:@"QQEmailImage"];
    [self.view addSubview:self.searchBarBgView];
    [self.view addSubview:self.searchBar];
    [self.searchBarBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(f_i5real(QImageView.size.height)+30);
        make.width.top.left.equalTo(self.view);
       
    }];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@45);
        make.width.left.equalTo(self.view);
        make.top.equalTo(self.searchBarBgView.mas_bottom);
    }];
    __weak typeof(self) weakself=self;
    self.searchBarBgView.QQEmailLogin=^{
        
        CMQQMailViewController *productVc = [[CMQQMailViewController alloc] init];
        [weakself.navigationController pushViewController:productVc animated:YES];
    };
    
}

#pragma mark 刷新通讯录数据
-(void)refreshData{
    
[[CMProgressHud sharedCMProgressHud]LoadProgress:self.navigationController.view  WithMessage:@"正在刷新..." ];
    if (ABAddressBookGetAuthorizationStatus()  ==  kABAuthorizationStatusAuthorized)
    {
        
            [CMGetAddressBook getOriginalAddressBook:^(NSArray<CMContanct *> *addressBookArray) {
                if (addressBookArray.count!=0) {
                    [[CMProgressHud sharedCMProgressHud]removeProgressHUD];
                    self.peopleArray=addressBookArray;
                    
                    self.contactPeopleDict = [[NSMutableDictionary alloc]initWithDictionary:[self sortDict:self.peopleArray]];
                    //联系人分组按拼音分组的Key值
                    NSArray *nameKeys = [[self.contactPeopleDict allKeys] sortedArrayUsingSelector:@selector(compare:)];
                    self.keys = [NSMutableArray arrayWithArray:nameKeys];
                    
                    [self.plistDict setObject:addressBookArray forKey:@"addressBookArray"];
                    [NSKeyedArchiver  archiveRootObject:self.plistDict toFile:[CMCache getFilePath:@"Contanct.plist"]];
        
                        [self uploadContanctWithData: self.peopleArray];
                        [self isInvationWithData: self.peopleArray];
                      //  [self.myTableView reloadData];
                        
                        
                self.bottomBtn.userInteractionEnabled=YES;
                    
                }
                
                
            } authorizationFailure:^{
                
                
                
            }];
            

            
      
      
            }

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 
    return self.keys.count;
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   

    NSString *key = self.keys[section];
    
    return [self.contactPeopleDict[key] count];
    
}
//- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return _keys[section];
//}
#pragma mark 区头
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
        
   
    static NSString *headReuseIdentifier=@"Header";
    CMHeadSectionView *Header=[tableView dequeueReusableHeaderFooterViewWithIdentifier:headReuseIdentifier];
    if (!Header) {
        Header=[[CMHeadSectionView alloc]initWithReuseIdentifier:headReuseIdentifier];
        
    }
    Header.SetionTitle.text=self.keys[section];
    return Header;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
      return 20;
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 55;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.05;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reuseIdentifier = @"indexPath";
    CMContactCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell)
    {
        cell = [[CMContactCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    NSString *key
         = self.keys[indexPath.section];
    cell.indexPath=indexPath;
    cell.Contanctdelegate=self;
    CMContanct *people= [self.contactPeopleDict[key] objectAtIndexCheack:indexPath.row];
    if(people.headerImage!=nil){
     [cell.headIcon setImage:[UIImage imageWithData:people.headerImage] forState:UIControlStateNormal];
         }else{
             [cell.headIcon setBackgroundColor:people.headerbackColor];
             [cell.headIcon setTitle:[people.Name substringWithRange:NSMakeRange(0, 1)] forState:UIControlStateNormal];
             if ([CMRegularJudement checkTelNumber:people.Name]) {
                 [cell.headIcon setImage:[UIImage imageNamed:@"contanctHeadIcon_3"] forState:UIControlStateNormal];
             }
         }
         
    cell.phoneName.text = people.Name;
    cell.PhoneNum.text=people.Tel;
    if(!self.isAllPeople){
        if (people.isInvation==NO) {
        if (people.isSend) {
            cell.InvatieBtn.userInteractionEnabled=NO;
            [cell.InvatieBtn setTitle:@"已发送" forState:UIControlStateNormal];
            [cell.InvatieBtn setTitleColor:UIColorFromRGB(0x8e8d93) forState:UIControlStateNormal];
            [cell.InvatieBtn setBackgroundColor:[UIColor whiteColor]];
            [cell.InvatieBtn  mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(81/2.0);
            }];
        }else{
            [cell.InvatieBtn setBackgroundColor:RedButtonColor];
            [cell.InvatieBtn setTitle:@"免费送好友588元礼包" forState:UIControlStateNormal];
            [cell.InvatieBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            cell.InvatieBtn.userInteractionEnabled=YES;
            [cell.InvatieBtn  mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@130);
            }];
        }
        }else{
            cell.InvatieBtn.userInteractionEnabled=NO;
            [cell.InvatieBtn setTitle:@"已加入" forState:UIControlStateNormal];
            [cell.InvatieBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cell.InvatieBtn setBackgroundColor:UIColorFromRGB(0x27ad28)];
            [cell.InvatieBtn  mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(81/1.5);
            }];
            
        }
    }
    else{
        if (people.isInvation==NO) {
        cell.InvatieBtn.userInteractionEnabled=NO;
        [cell.InvatieBtn setTitle:@"已发送" forState:UIControlStateNormal];
        [cell.InvatieBtn setTitleColor:UIColorFromRGB(0x8e8d93) forState:UIControlStateNormal];
        [cell.InvatieBtn setBackgroundColor:[UIColor whiteColor]];
        [cell.InvatieBtn  mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(81/2.0);
        }];
           
   
        }else{
            
            cell.InvatieBtn.userInteractionEnabled=NO;
            [cell.InvatieBtn setTitle:@"已加入" forState:UIControlStateNormal];
            [cell.InvatieBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cell.InvatieBtn setBackgroundColor:UIColorFromRGB(0x27ad28)];
            [cell.InvatieBtn  mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(81/1.5);
            }];
        }
    }
    return cell;
         
}

#pragma mark  UISearchBar 协议方法
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = YES;
    for(UIView *view in  [[[searchBar subviews] objectAtIndex:0] subviews]) {
        if([view isKindOfClass:[NSClassFromString(@"UINavigationButton") class]]) {
            UIButton * cancel =(UIButton *)view;
            [cancel setTitle:@"取消" forState:UIControlStateNormal];
            cancel.titleLabel.font = [UIFont systemFontOfSize:14];
            [cancel setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
        }
        
    }
    self.isSearch=YES;
    self.CMindex.hidden=YES;
    self.bottomBtn.hidden=YES;
    
    
    
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
    searchBar.showsCancelButton = NO;
    self.isSearch=NO;
    self.CMindex.hidden=YES;
    self.bottomBtn.hidden=YES;
    [self.searchBar resignFirstResponder];
//    self.contactPeopleDict=[self sortDict:self.peopleArray];
//    NSArray *nameKeys = [[self.contactPeopleDict allKeys] sortedArrayUsingSelector:@selector(compare:)];
//    self.keys = [NSMutableArray arrayWithArray:nameKeys];
//    [self.myTableView reloadData];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
 
    [self.resultArray removeAllObjects];
    for (CMContanct *p in self.peopleArray)
    {
        if (searchText) {
            
            
            if ([self isPureNumandCharacters:searchText]) { //数字
                if ([p.Tel hasPrefix:searchText])
                {
                    [self.resultArray addObject:p];
                }
                
                
            }else{
            

                NSString *pinyin=[NSString transform:p.Name];
        
                //判断人的名字是否以搜索文本内容开头
                if ([[pinyin lowercaseString]hasPrefix:[[NSString transform:searchText] lowercaseString]])
                {
                    [self.resultArray addObject:p];
                    
                }
                
                
                
                
            }
            
            
        }
    }
    
 
    self.contactPeopleDict=[self sortDict:self.resultArray];
    NSArray *nameKeys = [[self.contactPeopleDict allKeys] sortedArrayUsingSelector:@selector(compare:)];
    self.keys = [NSMutableArray arrayWithArray:nameKeys];
    [self.myTableView reloadData];
    
    
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    searchBar.text=@"";
    searchBar.showsCancelButton = NO;
    self.isSearch=NO;
    self.CMindex.hidden=NO;
    self.bottomBtn.hidden=NO;
    [self.searchBar resignFirstResponder];
    self.contactPeopleDict=[self sortDict:self.peopleArray];
    NSArray *nameKeys = [[self.contactPeopleDict allKeys] sortedArrayUsingSelector:@selector(compare:)];
    self.keys = [NSMutableArray arrayWithArray:nameKeys];
    [self.myTableView reloadData];
}

- (BOOL)isPureNumandCharacters:(NSString *)string
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0)
    {
        return NO;
    } 
    return YES;
}

#pragma mark 底部悬浮
-(void)creatBottomView{
    if (!self.isSearch) {
        
    self.bottomBtn.hidden=NO;
   
    [self.view insertSubview:self.bottomBtn aboveSubview:self.CMindex];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.left.right.bottom.equalTo(self.view);
        
    }];
  }
}
-(void)creatSelectIndex{
    if (!self.isSearch) {
        self.CMindex.hidden=NO;
        [self.view addSubview:self.CMindex];
        [self.view bringSubviewToFront:self.CMindex];
        
        [self.CMindex  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.searchBar.mas_bottom);
            make.height.mas_equalTo(self.keys.count*30);
            make.right.equalTo(self.view.mas_right).offset(-2.5);
            make.width.equalTo(@20);
            
        }];
        __weak typeof(self) weakSelf=self;
        self.CMindex.selectIndex=^(NSInteger index){
            
            [weakSelf.myTableView
             scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index]
             atScrollPosition:UITableViewScrollPositionTop animated:YES];
            
        };
    }
}

-(void)sendAllPeople{
    if ([CMRequestManager islogin]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

            NSArray *myContanctArr=self.contactPeopleDict.allValues;
            
            for (NSArray *reArr in myContanctArr) {
                for (CMContanct *p in reArr) {
                    if (p.isInvation==NO) {
                        p.isSend=YES;
                       [self sendMessageWithMobile:p.Tel];
                    }
                    
                }
            }
            
            self.isAllPeople=YES;
      dispatch_async(dispatch_get_main_queue(), ^{
                [self.myTableView reloadData];
                self.bottomBtn.userInteractionEnabled=NO;
                CMSendMsgAlert *alert=[[CMSendMsgAlert alloc]initWithAlert];
                [alert ShowAlert];

            });
            
        });
    }  else{
        CMLoginController *vc=[[CMLoginController alloc]init];
        [self.navigationController pushViewController:vc animated:NO];
        

        
    }
   }
#pragma mark 邀请分享
-(void)invationBtnClickWith:(NSIndexPath *)index{
    if ([CMRequestManager islogin]) {
    NSString *key = self.keys[index.section];
    CMContanct *people= [self.contactPeopleDict[key] objectAtIndexCheack:index.row];
    people.isSend=YES;
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:index.row inSection:index.section];
    [self.myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    DLog(@"CMContactCell---%d---%d---%@---%@---",index.section,index.row,people.Tel,self.UserName);
    [self sendMessageWithMobile:people.Tel];
    }else{
     
        CMLoginController *LoginVc=[[CMLoginController alloc]init];
        [self.navigationController pushViewController:LoginVc animated:NO];
        
    }
}

-(void)sendMessageWithMobile:(NSString*)phone{
    
    [CMRequestHandle CaiMaoshortUrlWithID:[CMUserDefaults objectForKey:@"userID"] andPhone:phone andSuccess:^(id responseObj) {
        if ([[responseObj objectForKey:@"Status"]intValue]==200) {
            NSString *result=[responseObj objectForKey:@"Result"];
            NSString *shortUrl=[[NSString stringWithFormat:@"%@%@",OnLineCode,result]substringFromIndex:7];
            //  DLog(@"++++%@+++%@++%@",responseObj,phone,shortUrl);
            
            NSString *str=nil;
            if (self.UserName.length>0) {
                str=[NSString stringWithFormat:@"%@邀请你加入财猫成为好友,并赠送您588现金红包,点击加入%@【财猫网】",self.UserName ,shortUrl];
            }else{
                str=[NSString stringWithFormat:@"您的好友邀请你加入财猫成为好友,并赠送您588现金红包,点击加入%@【财猫网】",shortUrl];
            }
           
            NSString *url=[NSString stringWithFormat:@"%@/webservice/sms.php?method=Submit",SmsLine];
            NSDictionary *dict=@{@"account":@"cf_caimao",
                                 @"password":@"7fb061e670e093ceb116e56485584ccf",
                                 @"mobile":phone,
                                 @"content":str
                                 };
            // DLog(@"dict--%@",dict);
            [CMHttpTool postMessageURL:url params:dict success:^(id responseObj) {
                // NSData *doubi = responseObj;
                // NSString *shabi =  [[NSString alloc]initWithData:doubi encoding:NSUTF8StringEncoding];
                
                // DLog(@"信息--%@---",[NSJSONSerialization JSONObjectWithData:doubi options:NSJSONReadingAllowFragments error:nil]);
                
            } failure:^(NSError *error) {
                
                DLog(@"错误消息--%@",error);
            }];

        }
        
    }];
    


}
#pragma 设置UISearchBar背景色
- (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}


#pragma mark 返回顶部
-(void)topView{
    
    self.top=[UIButton buttonWithType:UIButtonTypeCustom];
    self.top.userInteractionEnabled=YES;
    self.top.hidden=YES;
    [self.top setImage:[UIImage imageNamed:@"top"] forState:UIControlStateNormal];
    [self.top addTarget:self action:@selector(backToTop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.top];
    [self.view bringSubviewToFront:self.top];
    [self.top mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@25);
        make.bottom.equalTo(self.view.mas_bottom).offset(-50);
        make.right.equalTo(self.view.mas_right).offset(-70);
    }];
}
-(void)backToTop{
    self.myTableView.scrollsToTop=YES;
    self.top.hidden=YES;
    [self.myTableView setContentOffset:CGPointMake(0,0) animated:NO];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y>CMScreenH/2.0) {
        self.top.hidden=NO;
    }
    if (scrollView.contentOffset.y<=0) {
         self.top.hidden=YES;
    }
    
}
#pragma mark 上传接口
-(void)uploadContanctWithData:(NSArray*)contanctArr{
    
    NSMutableArray *arr=[NSMutableArray arrayWithArray:contanctArr];
    NSMutableArray *resultArray=[NSMutableArray  array];
    
    for (CMContanct *p in arr) {
        NSMutableDictionary *dict=[NSMutableDictionary dictionary];
        
        if ([p.Name isEqualToString:@"#"]) {

            [dict setObject:p.Tel forKey:@"Name"];
        }
        // [contanctDict setObject:dict forKey:p.Name];
        [dict setObject:p.Name forKey:@"Name"];
        [dict setObject:p.Tel forKey:@"Tel"];
        [resultArray addObject:dict];
       
        
    }
  //DLog(@"lianxiren----%@++++++",resultArray);
    NSString *upId=nil;
    if ([CMRequestManager islogin]) {
        upId=[CMUserDefaults objectForKey:@"userID"];
    }else{
        
        upId=@"0";
    }
    [CMRequestHandle uploadContanctWithID:upId andArr:resultArray andSuccess:^(id responseObj) {
        
         //DLog(@"++++++%@+%@++%@",responseObj,[responseObj objectForKey:@"Result"],resultArray);
        [[CMProgressHud sharedCMProgressHud]removeProgressHUD];
        if ([[responseObj objectForKey:@"Status"]integerValue]==400) {
            [self refreshData];
        }
        if ([[responseObj objectForKey:@"Status"]integerValue]==200) {
            [self.myTableView reloadData];
        }
        
    }];
    
}


#pragma mark 判断是否注册
-(void)isInvationWithData:(NSArray*)contanctArr {
    if ([self checkNetWork]) {
        // 将耗时操作放到子线程
        dispatch_queue_t queue = dispatch_queue_create("isInvation.queue", DISPATCH_QUEUE_SERIAL);
        
        dispatch_async(queue, ^{
            NSMutableArray *arr=[NSMutableArray arrayWithArray:contanctArr];
            NSMutableArray *resultArray=[NSMutableArray  arrayWithCapacity:0];
            
            for (CMContanct *p in arr) {
                NSMutableDictionary *dict=[NSMutableDictionary dictionary];
                if ([p.Name isEqualToString:@"#"]) {
                    
                    [dict setObject:p.Tel forKey:@"Name"];
                }
                [dict setObject:p.Name forKey:@"Name"];
                [dict setObject:p.Tel forKey:@"Tel"];
                [resultArray addObject:dict];

            }
            
            [CMRequestHandle isRegistWithPhoneArr:resultArray andSuccess:^(id responseObj) {
                
            //   DLog(@"++%@",responseObj);
                NSMutableArray *joinArr=[NSMutableArray arrayWithCapacity:0];
                NSArray *ContanctArr=[responseObj objectForKey:@"List"];
                NSArray *ContanctMode=[CMResultModel objectArrayWithKeyValuesArray:ContanctArr];
                
                for (int i=0; i<arr.count; i++) {
                    CMContanct * ContanctModel=arr[i];
                    for (CMResultModel *ResultModel in ContanctMode) {
                        
                        if ([ContanctModel.Tel isEqualToString:ResultModel.Tel]&&![ResultModel.HYID isEqualToString:@"0"]) {
                            ContanctModel.isInvation=YES;
                            // joinViewLabel.text=@"您还有200位好友待邀请,已有100位好友加入财猫";
                            [joinArr addObject:ContanctModel];
                            [arr replaceObjectAtIndex:i withObject:ContanctModel];
                            
                            self.contactPeopleDict=[self sortDict:arr];
                            
                        }
                        
                    }
                    
                }
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    //回到主线程操作代码块
                    [self.myTableView reloadData];
                    [self.plistDict setObject:arr forKey:@"addressBookArray"];
                    [NSKeyedArchiver  archiveRootObject:self.plistDict toFile:[CMCache getFilePath:@"Contanct.plist"]];
                    
                    self.searchBarBgView.JoinPeopleLabel.text=[NSString stringWithFormat:@"您还有%d位好友待邀请,已有%d位好友加入财猫",resultArray.count-joinArr.count,joinArr.count];
    
                    
                });
                
                
                
                
            }];
            
        });
        
 
    }
    }
#pragma mark  排序
-(NSMutableDictionary*)sortDict:(NSArray*)OrigianArr{
    
    
    NSMutableDictionary *addressBookDict = [NSMutableDictionary dictionary];
    
    for (CMContanct *model in OrigianArr) {
        
        
        //获取到姓名的大写首字母
        NSString *firstLetterString = [NSString getFirstLetterFromString:model.Name];
        //如果该字母对应的联系人模型不为空,则将此联系人模型添加到此数组中
        if (addressBookDict[firstLetterString])
        {
            [addressBookDict[firstLetterString] addObject:model];
        }
        //没有出现过该首字母，则在字典中新增一组key-value
        else
        {
            //创建新发可变数组存储该首字母对应的联系人模型
            NSMutableArray *arrGroupNames = [NSMutableArray arrayWithObject:model];
            //将首字母-姓名数组作为key-value加入到字典中
            [addressBookDict setObject:arrGroupNames forKey:firstLetterString];
        }

    }
    
    return addressBookDict;
    
    
}

checkNet

@end
