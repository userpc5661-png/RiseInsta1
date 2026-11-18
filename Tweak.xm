#import <UIKit/UIKit.h>
#import "Sources/RiseInstaUI.h"

// Instagram 456.0.0 diagnostic entry. Only runs when the tweak was actually
// injected into the application's process (check the bundle filter).
%hook UIViewController
- (void)viewDidAppear:(BOOL)animated {
    %orig;
    dispatch_async(dispatch_get_main_queue(), ^{
        [RiseInstaUI installEntryPoint];
    });
}
%end

%hook UIWindow
- (void)makeKeyAndVisible {
    %orig;
    dispatch_async(dispatch_get_main_queue(), ^{
        [RiseInstaUI installEntryPoint];
    });
}
%end
