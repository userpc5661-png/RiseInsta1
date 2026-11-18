#import <UIKit/UIKit.h>
#import "Sources/RiseInstaUI.h"

// Temporary version-independent entry point while Instagram view hooks are being mapped.
// Install only when an actual Instagram view has appeared.
%hook UIViewController
- (void)viewDidAppear:(BOOL)animated {
    %orig;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [RiseInstaUI installEntryPoint];
        });
    });
}
%end
