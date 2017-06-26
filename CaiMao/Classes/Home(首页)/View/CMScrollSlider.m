

#define dialColorGrayscale 0.789 //刻度的颜色灰度
#define textColorGrayscale 0.629 //文字的颜色灰度
#define textRulerFont [UIFont systemFontOfSize:9]

#define dialGap 6
#define dialLong 20
#define dialShort 10

#import "CMScrollSlider.h"

#pragma mark - -------------------------------蛋疼的分割线--------------------------------

@interface CMRulerView : UIView
@property (nonatomic, assign) int minValue;
@property (nonatomic, assign) int maxValue;

@end

@implementation CMRulerView

/**
 *  绘制标尺view
 *
 *  @param rect rect
 */
-(void)drawRect:(CGRect)rect
{
    //计算位置
    CGFloat startX = 0;
    
    CGFloat lineCenterX = dialGap;
    CGFloat shortLineY = rect.size.height - dialShort;
    CGFloat longLineY = rect.size.height - dialLong;
    CGFloat bottomY = rect.size.height;
    
    CGFloat step = (_maxValue-_minValue)/10;

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, UIColorFromRGB(0xe6e6e6).CGColor);
    //CGContextSetRGBStrokeColor(context, dialColorGrayscale, dialColorGrayscale, dialColorGrayscale, 1);//设置线的颜色, 如果不设置默认是黑色的
    CGContextSetLineWidth(context, 0.5);//设置线的宽度, 默认是1像素
    CGContextSetLineCap(context, kCGLineCapButt);
    for (int i = 0; i<=10; i++)
    {
        if (i%10 == 0)
        {
            CGContextMoveToPoint(context,startX + lineCenterX*i, longLineY);//起使点
            NSString *Num = [NSString stringWithFormat:@"%.f",i*step+_minValue];
            //DLog(@"+++%@",Num);
            
            if ([Num isEqualToString:@"10"]) {
                Num=@"15";
            }
            else if  ([Num isEqualToString:@"20"]) {
                Num=@"30";
            }
           else if  ([Num isEqualToString:@"30"]) {
                Num=@"58";
            }else if  ([Num isEqualToString:@"40"]) {
                Num=@"98";
            }
            else if  ([Num isEqualToString:@"50"]) {
                Num=@"180";
            }
            else if  ([Num isEqualToString:@"60"]) {
                Num=@"360";
            }
            NSDictionary *attribute = @{NSFontAttributeName:textRulerFont,NSForegroundColorAttributeName:UIColorFromRGB(0x999999)};
            CGFloat width = [Num boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:0 attributes:attribute context:nil].size.width;
            [Num drawInRect:CGRectMake(startX + lineCenterX*i-width/2, longLineY-14, width, 14) withAttributes:attribute];
        }
        else
        {
            CGContextMoveToPoint(context,startX +  lineCenterX*i, shortLineY);//起使点
        }
        CGContextAddLineToPoint(context,startX +  lineCenterX*i, bottomY);
        CGContextStrokePath(context);//开始绘制
    }
}

@end

#pragma mark - -------------------------------蛋疼的分割线---------------------------
@interface CMFooterRulerView : UIView
@property (nonatomic, assign) int maxValue;
@end

@implementation CMFooterRulerView

-(void)drawRect:(CGRect)rect
{
    CGFloat longLineY = rect.size.height - dialLong;
    CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetStrokeColorWithColor(context, UIColorFromRGB(0xe6e6e6).CGColor);
    CGContextSetLineCap(context, kCGLineCapButt);

    CGContextMoveToPoint(context,0, longLineY);//起使点
    NSString *Num = [NSString stringWithFormat:@"%d",_maxValue];
   
    NSDictionary *attribute = @{NSFontAttributeName:textRulerFont,NSForegroundColorAttributeName:[UIColor colorWithWhite:textColorGrayscale alpha:1]};
    CGFloat width = [Num boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:0 attributes:attribute context:nil].size.width;
    [Num drawInRect:CGRectMake(0-width/2+3, longLineY-14, width, 14) withAttributes:attribute];
    CGContextAddLineToPoint(context,0, rect.size.height);
    CGContextStrokePath(context);//开始绘制
}

@end

#pragma mark - -------------------------------蛋疼的分割线--------------------------------
@interface CMHeaderRulerView : UIView
@property (nonatomic, assign) int minValue;
@end

@implementation CMHeaderRulerView

-(void)drawRect:(CGRect)rect
{
    CGFloat longLineY = rect.size.height - dialLong;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, UIColorFromRGB(0xe6e6e6).CGColor);
    //        CGContextSetLineWidth(context, 2.0);//设置线的宽度, 默认是1像素
    CGContextSetLineCap(context, kCGLineCapButt);

    CGContextMoveToPoint(context,rect.size.width, longLineY);//起使点
    NSString *Num = [NSString stringWithFormat:@"%d",_minValue];

    
    NSDictionary *attribute = @{NSFontAttributeName:textRulerFont,NSForegroundColorAttributeName:[UIColor colorWithWhite:textColorGrayscale alpha:1]};
    CGFloat width = [Num boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:0 attributes:attribute context:nil].size.width;
    [Num drawInRect:CGRectMake(rect.size.width-width/2, longLineY-14, width, 14) withAttributes:attribute];
    CGContextAddLineToPoint(context,rect.size.width, rect.size.height);
    CGContextStrokePath(context);//开始绘制
}

@end

#pragma mark - -------------------------------蛋疼的分割线--------------------------------

@interface CMScrollSlider ()<UIScrollViewDelegate,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>



@property (nonatomic, assign) int              stepNum;
@property (nonatomic, assign) float              yield;
@property (nonatomic, strong) UIImageView      *lineImage;
@property (nonatomic, assign) int scrollHeight;
@end

@implementation CMScrollSlider

-(instancetype)initWithFrame:(CGRect)frame MinValue:(int)minValue MaxValue:(int)maxValue Step:(int)step
{
    if(self = [super initWithFrame:frame])
    {
        
        CGFloat width=self.frame.size.width;
        _scrollHeight=self.frame.size.height/2.0;
        _minValue = minValue;
        _maxValue = maxValue;
        _step = step;
        _stepNum = (_maxValue-_minValue)/_step/10;
       // _scrollByHand = NO;
        self.backgroundColor=[UIColor whiteColor];
       
        UILabel *allGoOut=[[UILabel alloc]init];
        allGoOut.text=@"滑动标尺选定期限>>>";
        allGoOut.textAlignment=NSTextAlignmentCenter;
        allGoOut.frame=CGRectMake(0,0,width,12);
        
        allGoOut.font=[UIFont systemFontOfSize:10.5];
        allGoOut.textColor=UIColorFromRGB(0x999999);
        [self addSubview:allGoOut];
      
 
        //输入框
        UILabel *value = [[UILabel alloc]initWithFrame:CGRectMake(0,12,width, _scrollHeight-15)];//
        value.text=@"0天";
    
        self.valueTF=value;
        value.textColor=[UIColor redColor];
        CGRect rect=CGRectNull;
        if (self.fromHome) {
            value.font=[UIFont systemFontOfSize:25.0];
            rect=[ self.valueTF.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:25.0]} context:nil];
        }else{
           value.font=[UIFont systemFontOfSize:30.0];
            rect=[ self.valueTF.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:30.0]} context:nil];
        }
        
        value.textAlignment= NSTextAlignmentCenter;
        [self addSubview:value];
        [self attributedString:@"天"];
        
 
        // 画虚线
        _lineImage = [[UIImageView alloc] init];
        _lineImage.frame=CGRectMake(value.bounds.size.width/2.0-(rect.size.width+5)/2.0,CGRectGetMaxY(value.frame), rect.size.width+5, 1);
        _lineImage.image = [self drawLineByImageView:_lineImage];

        [self addSubview:_lineImage];
    
        //标尺
        UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        [flowLayout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        _collectionView  =[[UICollectionView alloc]initWithFrame:CGRectMake(0, _scrollHeight, width, _scrollHeight) collectionViewLayout:flowLayout];

        _collectionView.backgroundColor = [UIColor whiteColor];
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"systemCell"];
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"custemCell"];
        _collectionView.bounces = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [self addSubview:_collectionView];
        
        _redLine = [[UIImageView alloc] initWithFrame:CGRectMake(width/2.0-0.5, _scrollHeight+10, 1.5,_scrollHeight-10)];
        _redLine.backgroundColor = [UIColor redColor];
        [self addSubview:_redLine];
        UIView *bottom=[UIView new];
        bottom.backgroundColor=UIColorFromRGB(0xe6e6e6);
        bottom.frame=CGRectMake(0, self.frame.size.height, width, 1);
        [self addSubview:bottom];
        

    }
    return self;
}


#pragma setter

-(void)setRealValue:(float)realValue
{
    _realValue = realValue;
  
    
    CGRect rect=CGRectNull;
    if (self.fromHome) {
        _valueTF.font=[UIFont systemFontOfSize:25.0];
        rect=[  _valueTF.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:25.0]} context:nil];
    }else{
        _valueTF.font=[UIFont systemFontOfSize:30.0];
        rect=[  _valueTF.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:30.0]} context:nil];
    }
    
      _valueTF.text = [NSString stringWithFormat:@"%d天",(int)(_realValue*_step)];
    [self attributedString:@"天"];
    
    

    _lineImage.frame=CGRectMake(_valueTF.bounds.size.width/2.0-(rect.size.width+5)/2.0,CGRectGetMaxY(_valueTF.frame), rect.size.width+5, 1);
    if (realValue==15) {
       realValue=10;
        self.yield=5.50;
    } else if(realValue==30) {
        realValue=20;
        self.yield=6.30;
    }
    else if(realValue==58) {
        realValue=30;
        self.yield=7.20;
    }
    else if(realValue==98) {
        realValue=40;
        self.yield=7.70;
    }
    else if(realValue==180) {
        realValue=50;
        self.yield=8.80;
    }
    else if(realValue==360) {
        realValue=60;
        self.yield=10.80;
    }
    
    [_collectionView setContentOffset:CGPointMake((int)realValue*dialGap, 0) animated:NO];
    if (self.delegate && [self.delegate respondsToSelector:@selector(CMScrollSlider:ValueChange:andYield:)])
    {
        [self.delegate CMScrollSlider:self ValueChange:_realValue*_step andYield:self.yield];
    }
}



-(void)attributedString:(NSString*)string{
    
    NSMutableAttributedString *qixianStr = [[NSMutableAttributedString alloc] initWithString:_valueTF.text];
    NSRange qiFromRang = [_valueTF.text rangeOfString:string];
    [qixianStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0] range:NSMakeRange(qiFromRang.location,1)];
    _valueTF.attributedText = qixianStr;
}

#pragma mark UICollectionViewDataSource & Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2+_stepNum;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == 0 || indexPath.item == _stepNum+1)
    {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"systemCell" forIndexPath:indexPath];
        
        UIView *halfView = [cell.contentView viewWithTag:9527];
        if (!halfView)
        {
            if (indexPath.item == 0)
            {
                halfView = [[CMHeaderRulerView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/2, _scrollHeight)];
                CMHeaderRulerView *header = (CMHeaderRulerView *)halfView;
                header.backgroundColor = [UIColor whiteColor];
                header.minValue = _minValue;
           
                [cell.contentView addSubview:header];
            }
            else
            {
                halfView = [[CMFooterRulerView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/2, _scrollHeight)];
                CMFooterRulerView *footer = (CMFooterRulerView *)halfView;
                footer.backgroundColor = [UIColor whiteColor];
                footer.maxValue = _maxValue;
        
                [cell.contentView addSubview:footer];
            }
        }
        
        return cell;
    }
    else
    {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"custemCell" forIndexPath:indexPath];
        CMRulerView *ruleView = [cell.contentView viewWithTag:9527];
        if (!ruleView)
        {
            ruleView                 = [[CMRulerView alloc]initWithFrame:CGRectMake(0, 0, dialGap*10, _scrollHeight)];
            ruleView.backgroundColor = [UIColor whiteColor];
            ruleView.tag             = 9527;
            [cell.contentView addSubview:ruleView];
        }
        ruleView.minValue = _step*10.f*(indexPath.item-1);
        ruleView.maxValue = _step*10.f*indexPath.item;
        [ruleView setNeedsDisplay];
        
        return cell;
    }
}

-(CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == 0 || indexPath.item == _stepNum+1)
    {
        return CGSizeMake(self.frame.size.width/2, _scrollHeight);
    }
    else
    {
        return CGSizeMake(dialGap*10.f, _scrollHeight);
    }
}



- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.f;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.f;
}


#pragma mark UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
        int value = scrollView.contentOffset.x/(dialGap);
        if (value ==10) {
            value=15;
            self.yield=5.50;
        }
        else if  (value==20) {
            value=30;
             self.yield=6.30;
        }
        else if (value==30) {
            value=58;
             self.yield=7.20;
        }else if (value==40) {
            value=98;
             self.yield=7.70;
        }
        else if (value ==50) {
            value=180;
             self.yield=8.80;
        }
        else if  (value==60) {
            value=360;
            self.yield=10.80;
        }
   
    
    CGRect rect=CGRectNull;
    if (self.fromHome) {
        _valueTF.font=[UIFont systemFontOfSize:25.0];
        rect=[  _valueTF.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:25.0]} context:nil];
    }else{
        _valueTF.font=[UIFont systemFontOfSize:30.0];
        rect=[  _valueTF.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:30.0]} context:nil];
    }
         _valueTF.text = [NSString stringWithFormat:@"%d天",value*_step];
         [self attributedString:@"天"];
    
   // CGRect rect=[ _valueTF.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:30.0]} context:nil];
    _lineImage.frame=CGRectMake(_valueTF.bounds.size.width/2.0-(rect.size.width+5)/2.0,CGRectGetMaxY(_valueTF.frame), rect.size.width+5, 1);
          if (self.delegate && [self.delegate respondsToSelector:@selector(CMScrollSliderMove:ValueChange:andYield:)])
        {
            [self.delegate CMScrollSliderMove:self ValueChange:value*_step andYield:self.yield];
        }

    

}


// 返回虚线image的方法
- (UIImage *)drawLineByImageView:(UIImageView *)imageView
{
    UIGraphicsBeginImageContext(imageView.frame.size);   //开始画线 划线的frame
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    //设置线条终点形状
  // CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
     CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1);
    // 5是每个虚线的长度  1是高度
    CGFloat lengths[] = {3,5};
    CGContextRef line = UIGraphicsGetCurrentContext();
    // 设置颜色
    CGContextSetStrokeColorWithColor(line, UIColorFromRGB(0xcccccc).CGColor);
    
    CGContextSetLineDash(line, 0, lengths, 1);  //画虚线
    CGContextMoveToPoint(line, 0.0, 0.0);    //开始画线
    CGContextAddLineToPoint(line,imageView.frame.size.width, 1.0);
    CGContextStrokePath(line);
    // UIGraphicsGetImageFromCurrentImageContext()返回的就是image
    return UIGraphicsGetImageFromCurrentImageContext();
}

@end
