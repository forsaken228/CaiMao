
#import <UIKit/UIKit.h>

@class CMProScrollSlider;

@protocol CMProScrollSliderDelegate <NSObject>

-(void)CMProScrollSlider:(CMProScrollSlider *)slider ValueChange:(int )value;
-(void)CMProScrollSliderMove:(CMProScrollSlider *)slider ValueChange:(int )value;
@optional
-(void)CMProScrollSliderDidDelete:(CMProScrollSlider *)slider;
-(void)CMProScrollSliderDidTouch:(CMProScrollSlider *)slider;

@end

@interface CMProScrollSlider : UIView
//@property (nonatomic, copy ) NSString *title;
@property (nonatomic, copy ,  readonly) NSString *unit;
@property (nonatomic, assign ,readonly) int minValue;
@property (nonatomic, assign ,readonly) int maxValue;
@property (nonatomic, assign ,readonly) int step;
@property (nonatomic, weak) id<CMProScrollSliderDelegate> delegate;

//@property (nonatomic, strong) UILabel          *titleLabel;
@property (nonatomic, strong) UITextField      *valueTF;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIImageView      *redLine;
@property (nonatomic, strong) UIView      *bottomLine;
@property (nonatomic, assign) float realValue;
@property(nonatomic,strong)UIButton *allCharge;
-(void)setRealValue:(float)realValue Animated:(BOOL)animated;

-(instancetype)initWithFrame:(CGRect)frame MinValue:(int)minValue MaxValue:(int)maxValue Step:(int)step Unit:(NSString *)unit ;

@end
