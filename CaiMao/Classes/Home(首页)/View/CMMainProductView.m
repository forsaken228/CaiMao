//
//  CMMainProductView.m
//  CaiMao
//
//  Created by WangWei on 2017/6/5.
//  Copyright © 2017年 58cm. All rights reserved.
//

#import "CMMainProductView.h"
#import "CMMainProductCell.h"

@interface CMMainProductView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(strong,nonatomic)NSArray *prTitleArr;
@property(nonatomic,strong)NSArray *PrAdArr;
@property(nonatomic,strong)NSArray *PrPicArr;
@property(nonatomic,strong)UICollectionViewFlowLayout  *PrFlowLayout;
@property(nonatomic,strong)UICollectionView *PrCollectionView;

@property(nonatomic,assign)float height;
@property(nonatomic,assign)float width;
@end

@implementation CMMainProductView


-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        _height=self.frame.size.height;
        _width=self.frame.size.width;
        [self addSubview:self.PrCollectionView];
        
         [self.PrCollectionView registerClass:[CMMainProductCell class] forCellWithReuseIdentifier:@"CMMainProductCell"];
        
    }
    
    return self;
}

-(UICollectionViewFlowLayout*)PrFlowLayout{
    if (!_PrFlowLayout) {
        _PrFlowLayout=[[UICollectionViewFlowLayout alloc]init];
        _PrFlowLayout.itemSize = CGSizeMake(CMScreenW/2.0,_height/2.0);
        _PrFlowLayout.headerReferenceSize = CGSizeMake(0.0, 0.0);
        _PrFlowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _PrFlowLayout.minimumLineSpacing = 0;
        _PrFlowLayout.minimumInteritemSpacing = 0;
        
    }
    return _PrFlowLayout;
}

-(UICollectionView*)PrCollectionView{
    
    if (!_PrCollectionView) {
        _PrCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, _width, _height) collectionViewLayout:self.PrFlowLayout];
        _PrCollectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight |UIViewAutoresizingFlexibleWidth;
        _PrCollectionView.dataSource = self;
        _PrCollectionView.delegate = self;
        _PrCollectionView.showsVerticalScrollIndicator=NO;
        _PrCollectionView.backgroundColor = [UIColor whiteColor];
    }
    return _PrCollectionView;
}


//多少个区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个区单元格个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.prTitleArr.count;
}
//创建CEll
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    

    CMMainProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CMMainProductCell" forIndexPath:indexPath];
    
 
    cell.topTitle.text=self.prTitleArr[indexPath.row];
    cell.detailTitle.text=self.PrAdArr[indexPath.row];
    CGRect rect=[cell.detailTitle.text boundingRectWithSize:CGSizeMake(140, 15) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]} context:nil];
    cell.headIcon.image=[UIImage imageNamed:self.PrPicArr[indexPath.row]];
    
    [cell.detailTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(rect.size.width+2);
    }];
    


    
    if (indexPath.row==2 ||indexPath.row==3) {
        [cell.levelView removeFromSuperview];
        
    }
    if (indexPath.row==1 ||indexPath.row==3) {
        [cell.verticalView removeFromSuperview];
    }
    
    
    
    
       return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (self.delegate &&[self.delegate respondsToSelector:@selector(collectViewDidSelect:)]) {
        [self.delegate collectViewDidSelect:indexPath];
    }
    
}

#pragma mark Source

-(NSArray*)prTitleArr{
    
    return @[@"新客专享",@"我的喵友",@"聚嗨利",@"天天红包"];
}
-(NSArray*)PrAdArr{
    return @[@"注册领取588元大礼包",@"看看朋友,谁在财猫",@"人越多收益越高",@"财猫出钱你当土豪"];
}
-(NSArray*)PrPicArr{
    
    return @[@"sy_xkzx_icon",@"sy_yqhy_icon",@"sy_jhl_icon",@"天天红包"];
}
@end
