#import <UIKit/UIKit.h>
#import "Sources/RiseInstaUI.h"

// This bootstrap does not require MobileSubstrate/ElleKit/Logos to execute.
// The binary itself still must be loaded into the Instagram process.
@interface RiseInstaBootstrap : NSObject
+ (instancetype)shared;
- (void)tryInstall:(NSNotification *)notification;
@end

@implementation RiseInstaBootstrap
+ (instancetype)shared {
    static RiseInstaBootstrap *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ instance = [RiseInstaBootstrap new]; });
    return instance;
}
- (void)tryInstall:(NSNotification *)notification {
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{ [self tryInstall:nil]; });
        return;
    }
    [RiseInstaUI installEntryPoint];
}
@end

__attribute__((constructor))
static void RiseInstaInitialize(void) {
    dispatch_async(dispatch_get_main_queue(), ^{
        RiseInstaBootstrap *bootstrap=[RiseInstaBootstrap shared];
        NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
        [center addObserver:bootstrap selector:@selector(tryInstall:)
                      name:UIApplicationDidBecomeActiveNotification object:nil];
        [center addObserver:bootstrap selector:@selector(tryInstall:)
                      name:UIWindowDidBecomeKeyNotification object:nil];
        [bootstrap tryInstall:nil];

        // Catch delayed UIWindow / UIScene creation in Instagram.
        for (NSNumber *seconds in @[@1, @3, @8]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds.doubleValue*NSEC_PER_SEC)),
                           dispatch_get_main_queue(), ^{
                [bootstrap tryInstall:nil];
            });
        }
    });
}
