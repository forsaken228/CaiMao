//
//  CMMesViewController.m
//  CaiMao
//
//  Created by Fengpj on 16/1/13.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMMesViewController.h"

@interface CMMesViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *MyTablView;

@property(nonatomic,strong)NSMutableArray *DataSourceArr;;

@end

@implementation CMMesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor= ViewBackColor;
    self.title = @"我的消息";
   [CMMessageDao createTable];

    if ([[NSFileManager defaultManager]fileExistsAtPath:[CMDataMessage getFilePath]]) {
        
        self.DataSourceArr=[CMMessageDao selectAllMessage];
    }
    if (self.DataSourceArr.count>0) {
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"清除消息" style:UIBarButtonItemStylePlain target:self action:@selector(clearAllMessage)];
        [self.view addSubview:self.MyTablView];
         self.MyTablView.hidden=NO;
    }else{
        
        [self NoDataView];
    }
   
    
    

}
-(void)clearAllMessage{
    
    [CMMessageDao deleteAllMessage];
    [self.DataSourceArr removeAllObjects];
    self.block();
    [self NoDataView];
    self.MyTablView.hidden=YES;
    [self.MyTablView reloadData];
}


#pragma mark Lazy
-(UITableView*)MyTablView{
    if (!_MyTablView) {
        _MyTablView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _MyTablView.delegate=self;
        _MyTablView.dataSource=self;
        _MyTablView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _MyTablView.autoresizingMask=UIViewAutoresizingFlexibleHeight;
        _MyTablView.backgroundColor= ViewBackColor;

    }
    
    return _MyTablView;
}
-(NSMutableArray*)DataSourceArr{
    if (!_DataSourceArr) {
        _DataSourceArr=[NSMutableArray arrayWithCapacity:0];
    }
    return _DataSourceArr;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.DataSourceArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   static NSString *tCell=@"indexPath";
     CMMessageCell*TableCell=[tableView cellForRowAtIndexPath:indexPath];
    if (!TableCell) {
        TableCell=[[CMMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tCell];
                TableCell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    CMMessage *tMessage=self.DataSourceArr[indexPath.row];
    
    TableCell.messageLabel.text=tMessage.message;
   // TableCell.detailBtn.tag=indexPath.row;
    TableCell.indexpath=indexPath;
    TableCell.delegate=self;
    CGRect rect=[TableCell.messageLabel.text boundingRectWithSize:CGSizeMake(190, MAXFLOAT) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:11.0]} context:nil];
    [TableCell.messageImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(rect.size.height+100);
    }];
    [TableCell.messageLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(rect.size.height+50);
    }];
    
    TableCell.timeLabel.text=tMessage.time;
    //[TableCell.detailBtn addTarget:self action:@selector(cellBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    if (tMessage.isread==1) {
        TableCell.headRightRed.hidden=NO;
    }
    return TableCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    CMMessage *tMessage=self.DataSourceArr[indexPath.row];
    CGRect rect=[tMessage.message boundingRectWithSize:CGSizeMake(190, MAXFLOAT) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:11.0]} context:nil];
    return rect.size.height+150;
}

-(void)detailButtonActionWithIndex:(NSIndexPath*)index{
   // CMProductDetailController *proVc = [[CMProductDetailController alloc] init];
    CMMessage *MesModel=self.DataSourceArr[index.row];
    
    [CMMessageDao setNoReadBecomeIsRead:@"0"andBtnTag:MesModel.messageId];
    self.DataSourceArr=[CMMessageDao selectAllMessage];
    CMMessageCell*MessageCell=[self.MyTablView cellForRowAtIndexPath:index];
   // DLog(@"turl==%d+++%@",index.row,[NSString dictionaryWithJsonString:MesModel.page]);
 NSDictionary *dict=[NSString dictionaryWithJsonString:MesModel.page];
    if ([dict objectForKey:@"ext"]==nil&&[dict objectForKey:@"product"]==nil&&[dict objectForKey:@"page"]==nil) {
                 MessageCell.detailBtn.userInteractionEnabled=NO;
    }else{
       
        [CMPushHandle PushMessageWithDict:dict withController:self];
        
    }
    self.block();
    [self.MyTablView reloadData];
 
    
}
-(void)NoDataView{
    UIImage *image=[UIImage imageNamed:@"MymessageNotData"];
    UIImageView *contentView=[[UIImageView alloc]init];
    contentView.image=image;
    [self.view addSubview:contentView];

    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(30);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(f_i5real(image.size.height));
        make.width.mas_equalTo(f_i5real(image.size.width));
    }];
    
    UILabel *label=[[UILabel alloc]init];
    label.text=@"暂无消息哦~";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:14];
    label.textColor=UIColorFromRGB(0x8e8d93);
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_bottom).offset(10);
        make.centerX.width.equalTo(self.view);
        make.height.mas_equalTo(15);
       
    }];
    
}
//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//   [tableView setEditing:!tableView.editing animated:YES];
//        if (indexPath.row<0) {
//        return;
//    }
//    CMMessage *p=_bgArray[indexPath.row];
//    [CMMessageDao deleteRowAtMessageID:p.messageId];
//    [_bgArray removeObjectAtIndex:indexPath.row];
//    [tableView reloadData];
//   //}

//checkNet
@end
