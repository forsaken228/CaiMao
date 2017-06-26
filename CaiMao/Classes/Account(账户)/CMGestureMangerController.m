//
//  CMGestureMangerController.m
//  CaiMao
//
//  Created by MAC on 16/8/24.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMGestureMangerController.h"
#import "CMGestureViewCell.h"
@interface CMGestureMangerController ()
{
    NSMutableArray *arr;
}
@end

@implementation CMGestureMangerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // DLog(@"viewdiLoad==%@",[CMUserDefaults objectForKey:@"switNo"]);
    self.tableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.title=@"手势管理";
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
     arr=[[NSMutableArray alloc]init];
    NSArray *first=@[@"手势密码"];
    [arr addObject:first];
    if ([CMUserDefaults objectForKey:@"switNo"]
) {
        NSArray *second=@[@"修改手势密码"];
        [arr insertObject:second atIndex:1];
        
    }
    self.block();
   
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return arr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
         return 10;
    }else{
        return 0.05f;
    }
   
}
#pragma clang diagnostic ignored"-Wint-conversion"
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   // DLog(@"tableView==%@",[CMUserDefaults objectForKey:@"switNo"]);
 static NSString *cellID=@"indexpath";
    CMGestureViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell=[[CMGestureViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
       
            }
    cell.GTitle.text=arr[indexPath.section][0];
    
    if(indexPath.section==0){
          cell.gSwitch.hidden=NO;
       
            [cell.gSwitch setOn:[CMUserDefaults objectForKey:@"switNo"]];
    [cell.gSwitch addTarget:self action:@selector(OpenOrClose:) forControlEvents:UIControlEventValueChanged];
         cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }else{
        
        cell.listOpen.hidden=NO;
    }
    return cell;
    
    
}


-(void)OpenOrClose:(UISwitch*)swit{
    
    
    

    if (swit.isOn) {
      
        GestureViewController *gestureVc = [[GestureViewController alloc] init];
        NSLog(@"开");
               gestureVc.type = GestureViewControllerTypeSetting;
        gestureVc.block=^{
            
            [swit setOn:NO];
    
            [arr removeObjectAtIndex:1];

            [self.tableView reloadData];
     [CMUserDefaults removeObjectForKey:@"switNo"];
            
        };
        [CMUserDefaults setBool:swit.on forKey:@"switNo"];
        [CMUserDefaults synchronize];
        
        [self.navigationController pushViewController:gestureVc animated:YES];
        NSArray *second=@[@"修改手势密码"];
        [arr insertObject:second atIndex:1];
        [self.tableView reloadData];
        
      
    }else{
        //关闭手势
        GestureVerifyViewController *gestureVerifyVc = [[GestureVerifyViewController alloc] init];
        gestureVerifyVc.isToSwitch=YES;
        gestureVerifyVc.block=^{
            
                      [PCCircleViewConst removeGesture:gestureOneSaveKey];
                    [PCCircleViewConst removeGesture:gestureFinalSaveKey];
                     [CMUserDefaults removeObjectForKey:@"switNo"];
                    [arr removeObjectAtIndex:1];
                    [self.tableView reloadData];
 
        };
      
        [self.navigationController pushViewController:gestureVerifyVc animated:YES];

       
        NSLog(@"关");
       
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==1) {
        GestureVerifyViewController *gestureVerifyVc = [[GestureVerifyViewController alloc] init];
        gestureVerifyVc.isToSetNewGesture = YES;
        [self.navigationController pushViewController:gestureVerifyVc animated:YES];
        
        
        
    }
    
}
@end
