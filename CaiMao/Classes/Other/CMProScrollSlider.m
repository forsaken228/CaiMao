

#define dialColorGrayscale 0.789 //刻度的颜色灰度
#define textColorGrayscale 0.629 //文字的颜色灰度
#define textRulerFont [UIFont systemFontOfSize:9]

#define dialGap 6
#define dialLong 20
#define dialShort 10

#import "CMProScrollSlider.h"

#pragma mark - -------------------------------蛋疼的分割线--------------------------------

@interface CMProRulerView : UIView
@property (nonatomic, assign) int minValue;
@property (nonatomic, assign) int maxValue;
@property (nonatomic, copy) NSString *unit;
@end

@implementation CMProRulerView

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
    
    if (_maxValue == 0)
    {
        _maxValue = 1000;
    }
    CGFloat step = (_maxValue-_minValue)/10;

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor darkGrayColor].CGColor);
    //CGContextSetRGBStrokeColor(context, dialColorGrayscale, dialColorGrayscale, dialColorGrayscale, 1);//设置线的颜色, 如果不设置默认是黑色的
    CGContextSetLineWidth(context, 0.5);//设置线的宽度, 默认是1像素
    CGContextSetLineCap(context, kCGLineCapButt);
    for (int i = 0; i<=10; i++)
    {
        if (i%10 == 0)
        {
            CGContextMoveToPoint(context,startX + lineCenterX*i, longLineY);//起使点
            NSString *Num = [NSString stringWithFormat:@"%.f%@",i*step+_minValue,_unit];
//            if ([Num floatValue]>1000000)
//            {
//                Num = [NSString stringWithFormat:@"%.f万%@",[Num floatValue]/10000.f,_unit];
//            }
//            
            NSDictionary *attribute = @{NSFontAttributeName:textRulerFont,NSForegroundColorAttributeName:[UIColor colorWithWhite:textColorGrayscale alpha:1]};
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
@interface CMProFooterRulerView : UIView
@property (nonatomic, assign) int maxValue;
@property (nonatomic, copy) NSString *unit;
@end

@implementation CMProFooterRulerView

-(void)drawRect:(CGRect)rect
{
    CGFloat longLineY = rect.size.height - dialLong;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, dialColorGrayscale, dialColorGrayscale, dialColorGrayscale, 1);//设置线的颜色, 如果不设置默认是黑色的
    //        CGContextSetLineWidth(context, 2.0);//设置线的宽度, 默认是1像素
    CGContextSetLineCap(context, kCGLineCapButt);

    CGContextMoveToPoint(context,0, longLineY);//起使点
    NSString *Num = [NSString stringWithFormat:@"%d%@",_maxValue,_unit];
    
    NSDictionary *attribute = @{NSFontAttributeName:textRulerFont,NSForegroundColorAttributeName:[UIColor colorWithWhite:textColorGrayscale alpha:1]};
    CGFloat width = [Num boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:0 attributes:attribute context:nil].size.width;
    [Num drawInRect:CGRectMake(0-width/2, longLineY-14, width, 14) withAttributes:attribute];
    CGContextAddLineToPoint(context,0, rect.size.height);
    CGContextStrokePath(context);//开始绘制
}

@end

#pragma mark - -------------------------------蛋疼的分割线--------------------------------
@interface CMProHeaderRulerView : UIView
@property (nonatomic, assign) int minValue;
@property (nonatomic, copy) NSString *unit;
@end

@implementation CMProHeaderRulerView

-(void)drawRect:(CGRect)rect
{
    CGFloat longLineY = rect.size.height - dialLong;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, dialColorGrayscale, dialColorGrayscale, dialColorGrayscale, 1);//设置线的颜色, 如果不设置默认是黑色的
    //        CGContextSetLineWidth(context, 2.0);//设置线的宽度, 默认是1像素
    CGContextSetLineCap(context, kCGLineCapButt);

    CGContextMoveToPoint(context,rect.size.width, longLineY);//起使点
    NSString *Num = [NSString stringWithFormat:@"%d%@",_minValue,_unit];

    
    NSDictionary *attribute = @{NSFontAttributeName:textRulerFont,NSForegroundColorAttributeName:[UIColor colorWithWhite:textColorGrayscale alpha:1]};
    CGFloat width = [Num boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:0 attributes:attribute context:nil].size.width;
    [Num drawInRect:CGRectMake(rect.size.width-width/2, longLineY-14, width, 14) withAttributes:attribute];
    CGContextAddLineToPoint(context,rect.size.width, rect.size.height);
    CGContextStrokePath(context);//开始绘制
}

@end

#pragma mark - -------------------------------蛋疼的分割线--------------------------------

@interface CMProScrollSlider ()<UIScrollViewDelegate,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>



@property (nonatomic, assign) int              stepNum;
@property (nonatomic, assign) int              value;
@property (nonatomic, assign) BOOL             scrollByHand;

@end

@implementation CMProScrollSlider

-(instancetype)initWithFrame:(CGRect)frame MinValue:(int)minValue MaxValue:(int)maxValue Step:(int)step Unit:(NSString *)unit
{
    if(self = [super initWithFrame:frame])
    {
        //readOnly设置
        //_title = title;
        _minValue = minValue;
        _maxValue = maxValue;
        _step = step;
        _stepNum = (_maxValue-_minValue)/_step/10;
        _unit = unit;
        _scrollByHand = NO;
        self.backgroundColor=[UIColor whiteColor];
       
        
 
        //输入框
        UITextField *value = [[UITextField alloc]initWithFrame:CGRectMake(CMScreenW/2.0-80,0,150, 30)];//
        value.userInteractionEnabled=NO;
        self.valueTF=value;
        value.defaultTextAttributes    = @{
//                                           NSUnderlineColorAttributeName:UIColorFromRGB(0xcccccc),
//                                           NSUnderlineStyleAttributeName:@(1
//                                               ),
                                
                                           NSFontAttributeName:[UIFont systemFontOfSize:30],
                                           NSForegroundColorAttributeName:RedButtonColor};
        value.textAlignment            = NSTextAlignmentCenter;
        value.delegate                 = self;
        value.keyboardType             = UIKeyboardTypeNumberPad;
//        
//        value.attributedPlaceholder    = [[NSAttributedString alloc]initWithString:@"滑动标尺或输入"attributes:@{NSUnderlineColorAttributeName:[UIColor lightGrayColor],
//            NSUnderlineStyleAttributeName:@(1),
//                    NSFontAttributeName:[UIFont systemFontOfSize:12],
//     NSForegroundColorAttributeName:[UIColor grayColor]}];
        [self addSubview:value];

        UILabel *allGoOut=[[UILabel alloc]init];
        allGoOut.text=@"滑动标尺选定金额>>>";
        allGoOut.textAlignment=NSTextAlignmentRight;
        //allGoOut.frame=CGRectMake(CMScreenW/2.0+40,2,120, 20);
        
        allGoOut.font=[UIFont systemFontOfSize:10.5];
        allGoOut.textColor=UIColorFromRGB(0x3a3836);
        [self addSubview:allGoOut];
        [allGoOut mas_makeConstraints:^(MASConstraintMaker *make) {
           make.right.equalTo(self);
           make.bottom.equalTo(value);
           make.width.equalTo(@115);
           make.height.equalTo(@20);
       }];
        
        // 画虚线

       
        UIImageView *_lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(value.center.x-50,28, value.bounds.size.width-50, 2)];
        _lineImg.image = [self drawLineByImageView:_lineImg];

        [self addSubview:_lineImg];
    
        //标尺
        UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        [flowLayout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        _collectionView  =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 35, self.bounds.size.width, 50) collectionViewLayout:flowLayout];

        _collectionView.backgroundColor = [UIColor whiteColor];
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"systemCell"];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"custemCell"];
        
        _collectionView.bounces = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [self addSubview:_collectionView];
        
        _redLine = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width/2-0.5, 35, 1.5, 50)];
        _redLine.backgroundColor = RedButtonColor;
        [self addSubview:_redLine];
        UILabel *lineView=[UILabel new];
        lineView.backgroundColor=UIColorFromRGB(0xcccccc);
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_collectionView.mas_bottom);
            make.height.mas_equalTo(0.5);
            make.width.left.equalTo(self);
        }];

    }
    return self;
}


#pragma setter
-(void)setRealValue:(float)realValue
{
    [self setRealValue:realValue Animated:NO];
}



-(void)setRealValue:(float)realValue Animated:(BOOL)animated
{
    _realValue = realValue;
    _valueTF.text = [NSString stringWithFormat:@"%d",(int)(_realValue*_step)];
    [_collectionView setContentOffset:CGPointMake((int)realValue*dialGap, 0) animated:animated];
    if (self.delegate && [self.delegate respondsToSelector:@selector(CMProScrollSlider:ValueChange:)])
    {
        [self.delegate CMProScrollSlider:self ValueChange:realValue*_step];
    }
}

#pragma UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString *newStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if ([newStr intValue] > _maxValue)
    {
        _valueTF.text = [NSString stringWithFormat:@"%d",_maxValue];
        [self performSelector:@selector(didChangeValue) withObject:nil afterDelay:0];
        return NO;
    }
    else
    {
        _scrollByHand = NO;
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [self performSelector:@selector(didChangeValue) withObject:nil afterDelay:1];
        return YES;
    }
}
-(void)didChangeValue
{
    [self setRealValue:[_valueTF.text floatValue]/(float)_step Animated:YES];
}

-(void)deleteAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(CMProScrollSliderDidDelete:)])
    {
        [self.delegate CMProScrollSliderDidDelete:self];
    }
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
                halfView = [[CMProHeaderRulerView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/2, 50)];
                CMProHeaderRulerView *header = (CMProHeaderRulerView *)halfView;
                header.backgroundColor = [UIColor whiteColor];
                header.minValue = _minValue;
                header.unit = _unit;
                [cell.contentView addSubview:header];
            }
            else
            {
                halfView = [[CMProFooterRulerView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/2, 50)];
                CMProFooterRulerView *footer = (CMProFooterRulerView *)halfView;
                footer.backgroundColor = [UIColor whiteColor];
                footer.maxValue = _maxValue;
                footer.unit = _unit;
                [cell.contentView addSubview:footer];
            }
        }
        
        return cell;
    }
    else
    {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"custemCell" forIndexPath:indexPath];
        CMProRulerView *ruleView = [cell.contentView viewWithTag:9527];
        if (!ruleView)
        {
            ruleView                 = [[CMProRulerView alloc]initWithFrame:CGRectMake(0, 0, dialGap*10, 50)];
            ruleView.backgroundColor = [UIColor whiteColor];
            ruleView.tag             = 9527;
            ruleView.unit            = _unit;
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
        return CGSizeMake(self.frame.size.width/2, 50.f);
    }
    else
    {
        return CGSizeMake(dialGap*10.f, 50.f);
    }
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.f;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.f;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    if (point.y < self.frame.size.height-50-20)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(CMProScrollSliderDidTouch:)])
        {
            [self.delegate CMProScrollSliderDidTouch:self];
        }
    }
}

#pragma mark UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (_scrollByHand)
    {
        int value = scrollView.contentOffset.x/(dialGap);
        _valueTF.text = [NSString stringWithFormat:@"%d",value*_step];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(CMProScrollSliderMove:ValueChange:)])
        {
            [self.delegate CMProScrollSliderMove:self ValueChange:value*_step];
        }

        
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
    CGContextSetStrokeColorWithColor(line, [UIColor colorWithWhite:0.789 alpha:1.000].CGColor);
    
    CGContextSetLineDash(line, 0, lengths, 1);  //画虚线
    CGContextMoveToPoint(line, 0.0, 0.0);    //开始画线
    CGContextAddLineToPoint(line,imageView.frame.size.width, 1.0);
    CGContextStrokePath(line);
    // UIGraphicsGetImageFromCurrentImageContext()返回的就是image
    return UIGraphicsGetImageFromCurrentImageContext();
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _scrollByHand = YES;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)//拖拽时没有滑动动画
    {
        [self setRealValue:round(scrollView.contentOffset.x/(dialGap)) Animated:YES];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self setRealValue:round(scrollView.contentOffset.x/(dialGap)) Animated:YES];
}
@end
