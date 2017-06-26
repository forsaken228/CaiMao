
#import <UIKit/UIKit.h>
#import "CMLoginUsePassWordAlert.h"
typedef enum{
    GestureViewControllerTypeSetting = 1,
    GestureViewControllerTypeLogin
}GestureViewControllerType;

typedef enum{
    buttonTagReset = 1,
    buttonTagManager,
    buttonTagForget
    
}buttonTag;

@interface GestureViewController : UIViewController
/**
 *  控制器来源类型
 */
@property (nonatomic, assign) GestureViewControllerType type;
@property (nonatomic, assign) BOOL isYanZheng;
@property (nonatomic, assign) BOOL isFirst;
@property (nonatomic, assign) BOOL FromRenZheng;

@property(nonatomic,copy)void(^ block)(void);
@property(nonatomic,strong)NSDictionary *userDict;

@end
