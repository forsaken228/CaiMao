//
//  CMVIPController.m
//  CaiMao
//
//  Created by MAC on 16/11/5.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMVIPController.h"

@interface CMVIPController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *MyTableView;
@property(nonatomic,strong)NSArray *DataSourceArr;

@property(nonatomic,assign)int productCount;
@end

@implementation CMVIPController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"VIP专享";
    self.view.backgroundColor=ViewBackColor;
    
    [self.view addSubview:self.MyTableView];
    
    
   [self requestVipProduct];    
    self.MyTableView.mj_header=[CMRefreshHeader headerWithRefreshingBlock:^{
     
        [self requestVipProduct];
    }];
       // [self.MyTableView.mj_header beginRefreshing];
    
    self.productCount=1;
}
-(void)setUI{
    UIImage *image=[UIImage imageNamed:@"VIPProduct"];
    CMVipHeadView *headView=[[CMVipHeadView alloc]init];
    headView.frame=CGRectMake(0, 0, CMScreenW, 40+f_i5real(image.size.height));
    self.MyTableView.tableHeaderView=headView;
    CMFootView *footView=[[CMFootView alloc]init];
    footView.frame=CGRectMake(0, 0, CMScreenW,600);
    footView.delegate=self;
    self.MyTableView.tableFooterView=footView;
}
-(void)GoChengzhangZhi{
    
    DLog(@"成长值");
    
    CMChengzhangController *vc=[[CMChengzhangController alloc]init];
    CMPush(vc);
}
#pragma mark Lazy
-(UITableView*)MyTableView{
    if (!_MyTableView) {
        _MyTableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _MyTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _MyTableView.dataSource=self;
        _MyTableView.delegate=self;
    }
    
    return _MyTableView;
}
-(NSArray*)DataSourceArr{
    if (!_DataSourceArr) {
        _DataSourceArr=[NSArray array];
    }
    return _DataSourceArr;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.DataSourceArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *Tcell=@"indexPath";
    CMVIPProductCell *cell=[tableView dequeueReusableCellWithIdentifier:Tcell];
    if (!cell) {
        cell=[[CMVIPProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Tcell];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    CMVIPModel *VIPModel=self.DataSourceArr[indexPath.section];
    VIPModel.productCount=1;
    cell.indexPath=indexPath;
    cell.delegate=self;
    cell.productTitle.text=VIPModel.title;
       cell.QIShiShouYiLV.text=[NSString stringWithFormat:@"%.2f%%",VIPModel.nlv];
   float shouyi = [VIPModel.nlv_max floatValue];
   int x = (int)shouyi;
   cell.ShouYILvZheng.text = [NSString stringWithFormat:@"%.0f",floorf(shouyi)];
    if ((shouyi-(float)x)*100 == 0) {
        cell.ShouYILvXiao.text = [[NSString stringWithFormat:@".00"] stringByAppendingString:@"%"];
    } else {
        cell.ShouYILvXiao.text = [[NSString stringWithFormat:@".%.f",(shouyi-(float)x)*100] stringByAppendingString:@"%"];
    }
    
    cell.buttonView.textField.text=[NSString stringWithFormat:@"%d",VIPModel.productCount];
    
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:cell.QIShiShouYiLV.text attributes:attribtDic];  cell.QIShiShouYiLV.attributedText = attribtStr;
 
    [self  liViJiSuan:cell andModel:VIPModel];
#pragma mark设置期限
    
    int QiXian=[VIPModel.jkqx_dw  intValue];
    if (QiXian == 1) {    // 期限->天
        cell.QIXian.text = [NSString stringWithFormat:@"期限%d天",VIPModel.jkqx];
        [NSString DoubleStringChangeColer: cell.QIXian andFromStr:@"限" ToStr:@"天" withColor:RedButtonColor];

        
    } else if (QiXian == 2) { // 期限->月
        cell.QIXian.text = [NSString stringWithFormat:@"期限%d个月",VIPModel.jkqx];
        [NSString DoubleStringChangeColer: cell.QIXian andFromStr:@"限" ToStr:@"个" withColor:RedButtonColor];
        
    } else {                            // 期限->年
        cell.QIXian.text = [NSString stringWithFormat:@"期限%d年",VIPModel.jkqx];
        [NSString DoubleStringChangeColer: cell.QIXian andFromStr:@"限" ToStr:@"年" withColor:RedButtonColor];
    }
   
    
    [NSString  DoubleStringChangeColer:cell.productFenE andFromStr:@"计" ToStr:@"," withColor:RedButtonColor];
    [self loneStringChangeColer:cell.JiSuanShouYi andFromStr:@"赚"];
    CGRect rect=[ cell.productFenE.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 15) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil];
    [cell.productFenE mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(rect.size.width+2);
    }];
    
#pragma mark 产品类型
    
    if(VIPModel.hkfs==1){
        cell.ProductLeiXing.text=@"按月等额本息";
        
    }else if (VIPModel.hkfs==2){
       cell.ProductLeiXing.text=@"按月付息到期还本";
        
    }
    else if (VIPModel.hkfs==3){
         cell.ProductLeiXing.text=@"到期还本付息";
        
    }
    else if (VIPModel.hkfs==4){
        cell.ProductLeiXing.text=@"每月付息,到期还本";
        
    }
    else if (VIPModel.hkfs==5){
         cell.ProductLeiXing.text=@"按季付息,到期还本";
        
    }else if (VIPModel.hkfs==6){
         cell.ProductLeiXing.text=@"半年付息,到期还本";
        
    }
    else if (VIPModel.hkfs==7){
        
         cell.ProductLeiXing.text=@"到期还本付息";
    }

    
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 222;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.01f;
    }else{
    return 10.0f;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
    
}
#pragma mark  CMVIPProductCellDelegate

- (void)addProductCountActionWithIndex:(NSIndexPath *)indexPath{
    
    DLog(@"add++++%d+++%d",indexPath.row,indexPath.section);
    
    CMVIPProductCell *cell=[self.MyTableView cellForRowAtIndexPath:indexPath];
    CMVIPModel *VIPModel = self.DataSourceArr[indexPath.section];
    VIPModel.productCount++;
    cell.buttonView.textField.text=[NSString stringWithFormat:@"%d", VIPModel.productCount];
    
    
    if(VIPModel.productCount>=[self productNumWithModel:VIPModel]){
        
        VIPModel.productCount=[self productNumWithModel:VIPModel];
        cell.buttonView.textField.text=[NSString  stringWithFormat:@"%d",[self productNumWithModel:VIPModel]];
        
    }
  [self liViJiSuan:cell andModel:VIPModel];
}


- (void)contentDidChanged:(NSString *)text forIndexPath:(NSIndexPath *)indexPath{
    
     CMVIPProductCell *cell=[self.MyTableView cellForRowAtIndexPath:indexPath];
    CMVIPModel *VIPModel = self.DataSourceArr[indexPath.section];
    VIPModel.productCount=[cell.buttonView.textField.text intValue];
   
    if(VIPModel.productCount>[self productNumWithModel:VIPModel]){
        
        VIPModel.productCount=[self productNumWithModel:VIPModel];
       cell.buttonView.textField.text=[NSString  stringWithFormat:@"%d",[self productNumWithModel:VIPModel]];
      // [self liViJiSuan:cell andModel:VIPModel];
    }
    [self liViJiSuan:cell andModel:VIPModel];
    DLog(@"text++++%d++%d+++%d+%d",VIPModel.productCount,indexPath.row,indexPath.section,[self productNumWithModel:VIPModel]);
}
- (void)subProductCountActionWithIndex:(NSIndexPath *)indexPath{
    DLog(@"sub++++++%d+++%d",indexPath.row,indexPath.section);
    
     CMVIPProductCell *cell=[self.MyTableView cellForRowAtIndexPath:indexPath];
    CMVIPModel *VIPModel = self.DataSourceArr[indexPath.section];
    
    if (VIPModel.productCount<=1) {
        
        return;
    }
    VIPModel.productCount--;
    cell.buttonView.textField.text=[NSString stringWithFormat:@"%d",VIPModel.productCount];
 
    [self liViJiSuan:cell andModel:VIPModel];
}

-(void)BugProductCountActionWithIndex:(NSIndexPath *)indexPath{
    CMVIPProductCell *cell=[self.MyTableView cellForRowAtIndexPath:indexPath];
    CMVIPModel *VIPModel = self.DataSourceArr[indexPath.section];
    NSString *pid=[NSString stringWithFormat:@"%d",VIPModel.pid];
  
        [CMRequestHandle getProductListWithUserID:[CMUserDefaults objectForKey:@"userID"] andProductId:pid andSuccess:^(id responseObj) {
           // DLog(@"+++%@",responseObj);
            if ([[responseObj objectForKey:@"Status"]intValue]==200) {
                CMPayViewController *vc=[[CMPayViewController alloc]init];
                vc.ProuctListDict=[responseObj objectForKey:@"t"];
                if ([cell.buttonView.textField.text intValue]==0) {
                    vc.countNum=1;
                }else{
                    
                    vc.countNum=[cell.buttonView.textField.text intValue];
                }

                CMPush(vc);
                
            }else{
                
                CMTiShi([responseObj objectForKey:@"Result"]);
            }
            
            
        } andFailure:^(id error) {
            
        }];
        

}

-(void)IntoProductDetailPageActionWithIndex:(NSIndexPath*)indexPath{
    
    NSArray *arr=[CMVIPModel keyValuesArrayWithObjectArray:self.DataSourceArr];
    
    CMLiCaiDetailController *vc=[[CMLiCaiDetailController alloc]init];
    vc.productListArr=[arr objectAtIndex:indexPath.section];
    [self.navigationController pushViewController:vc animated:YES];

}




-(void)requestVipProduct{
    
    [CMRequestHandle getVIPProductListandSuccess:^(id responseObj) {
        [self setUI];
        [self.MyTableView.mj_header endRefreshing];
        DLog(@"+++%@",responseObj);
        if ([[responseObj objectForKey:@"Status"]intValue]==200) {
            
           NSArray  *result=[[responseObj objectForKey:@"t"]objectForKey:@"list"];
            
             self.DataSourceArr = [CMVIPModel objectArrayWithKeyValuesArray:result];
            
            
            [self.MyTableView  reloadData];
            
        }
        
        
        
    } andFailure:^(id error) {
        
    }];
}

-(void)loneStringChangeColer:(UILabel *)mainStr andFromStr:(NSString *)aFromStr  {
    
    NSMutableAttributedString *Pay=[[NSMutableAttributedString alloc]initWithString: mainStr.text];
    NSRange PayFromRang1 = [mainStr.text rangeOfString:aFromStr];
    
    [Pay addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x4d4d4d) range:NSMakeRange(PayFromRang1.location,1)];
    mainStr.attributedText = Pay;
    
}
#pragma mark 利率
-(void)liViJiSuan:(CMVIPProductCell*)cell andModel:(CMVIPModel*)VIPModel {
    float lilv=[VIPModel.nlv_max floatValue]/100;
    int QiXian=[VIPModel.jkqx_dw  intValue];
    if (QiXian == 1) {    // 期限->天
        
        VIPModel.Lixi =(VIPModel.cpfe  *lilv *VIPModel.jkqx)/365.0;
     
        
        
    } else if (QiXian == 2) { // 期限->月
  
         VIPModel.Lixi =(VIPModel.cpfe  *lilv *VIPModel.jkqx)/12.0;
    } else {                            // 期限->年
       VIPModel.Lixi =(VIPModel.cpfe  *lilv *VIPModel.jkqx)/1.0;
    }
    cell.productFenE.text=[NSString stringWithFormat:@"计%d,",VIPModel.cpfe*VIPModel.productCount];
    cell.JiSuanShouYi.text=[NSString stringWithFormat:@"赚%.2f",VIPModel.Lixi*VIPModel.productCount];
    
    [NSString  DoubleStringChangeColer:cell.productFenE andFromStr:@"计" ToStr:@"," withColor:RedButtonColor];
    [self loneStringChangeColer:cell.JiSuanShouYi andFromStr:@"赚"];
    CGRect rect=[ cell.productFenE.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 15) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil];
    [cell.productFenE mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(rect.size.width+2);
    }];
    
    CGRect rectSec=[ cell.JiSuanShouYi.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 15) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil];
    [cell.JiSuanShouYi mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(rectSec.size.width+2);
    }];
}
#pragma mark 产品剩余份数
-(int)productNumWithModel:(CMVIPModel*)model{
    
    
    return [model.zjfs intValue]-model.jbfs;
}
@end
