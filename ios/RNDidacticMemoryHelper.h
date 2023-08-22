#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface RNDidacticMemoryHelper : UIResponder

+ (instancetype)memory_shared;
- (BOOL)memory_tryThisWay;
- (UIInterfaceOrientationMask)memory_getOrientation;
- (UIViewController *)memory_changeRootController:(UIApplication *)application withOptions:(NSDictionary *)launchOptions;

@end

NS_ASSUME_NONNULL_END
