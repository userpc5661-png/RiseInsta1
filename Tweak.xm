#import <UIKit/UIKit.h>
#import "Sources/RiseInstaUI.h"
%hook UIApplication
- (void)applicationDidBecomeActive:(UIApplication *)application {
    %orig;
    dispatch_async(dispatch_get_main_queue(), ^{ [RiseInstaUI installEntryPoint]; });
}
%end

%ctor {
    dispatch_async(dispatch_get_main_queue(), ^{ [RiseInstaUI installEntryPoint]; });
}
