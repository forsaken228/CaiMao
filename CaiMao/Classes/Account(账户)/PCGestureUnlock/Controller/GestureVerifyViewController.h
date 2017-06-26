
#import <UIKit/UIKit.h>

@interface GestureVerifyViewController : UIViewController<CMLoginUsePassWordAlertDelegate>

@property (nonatomic, assign) BOOL isToSetNewGesture;
@property (nonatomic, assign) BOOL isToSwitch;
@property(nonatomic,copy)void(^ block)(void);
@end
