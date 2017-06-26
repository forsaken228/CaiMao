
#import "PCCircleViewConst.h"

@implementation PCCircleViewConst

+ (void)saveGesture:(NSString *)gesture Key:(NSString *)key
{

    [CMUserDefaults setObject:gesture forKey:key];
    [CMUserDefaults synchronize];
}

+ (NSString *)getGestureWithKey:(NSString *)key
{
    return [CMUserDefaults objectForKey:key];
}
+(void)removeGesture:(NSString*)key{
    
    [CMUserDefaults removeObjectForKey:key];
}
@end
