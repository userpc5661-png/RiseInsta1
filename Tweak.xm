#import <UIKit/UIKit.h>
#import "Sources/RiseInstaUI.h"

// Retry on view appearances, since the first UIKit controller can appear before
// Instagram has a foreground UIWindow. Installation is idempotent per window.
%hook UIViewController
- (void)viewDidAppear:(BOOL)animated {
    %orig;
    dispatch_async(dispatch_get_main_queue(), ^{
        [RiseInstaUI installEntryPoint];
    });
}
%end
