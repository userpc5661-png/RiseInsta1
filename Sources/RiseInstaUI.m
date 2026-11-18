#import "RiseInstaUI.h"
#import "RiseInstaDiagnostics.h"

@interface RiseInstaMenuController : UITableViewController
@property(nonatomic,copy) NSString *screen;
@property(nonatomic,strong) NSArray<NSDictionary *> *items;
- (instancetype)initWithScreen:(NSString *)screen;
@end

@implementation RiseInstaMenuController
- (instancetype)initWithScreen:(NSString *)screen {
    if ((self=[super initWithStyle:UITableViewStyleInsetGrouped])) {
        _screen=[screen copy];
        self.title=[screen isEqualToString:@"root"] ? @"Rise Insta" : screen;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor=UIColor.systemGroupedBackgroundColor;
    if ([self.screen isEqualToString:@"root"]) {
        self.items=@[
            @{@"title":@"Downloads & Media",@"detail":@"Reels, posts, stories and audio"},
            @{@"title":@"Privacy & Ghost",@"detail":@"Activity and privacy"},
            @{@"title":@"Messages & Calls",@"detail":@"DMs, voice and calls"},
            @{@"title":@"Reels & Stories",@"detail":@"Playback and editing"},
            @{@"title":@"Comments & Engagement",@"detail":@"Search, sort and export"},
            @{@"title":@"Profile Tools",@"detail":@"Photo and follower analysis"},
            @{@"title":@"Rise AI",@"detail":@"AI chat and auto replies"},
            @{@"title":@"Customization",@"detail":@"Colors, language and icons"},
            @{@"title":@"Account Features & Updates",@"detail":@"Account capability catalog"},
            @{@"title":@"Developer & Employee Mode",@"detail":@"Internal tools catalog"},
            @{@"title":@"Diagnostics",@"detail":@"Export runtime class names"}
        ];
    } else if ([self.screen isEqualToString:@"Diagnostics"]) {
        self.items=@[@{@"title":@"Export Runtime Classes",@"detail":@"Read-only filtered class/selector report"}];
    } else if ([self.screen isEqualToString:@"Account Features & Updates"]) {
        self.items=@[
            @{@"title":@"Scan Account Features",@"detail":@"Not connected to account eligibility"},
            @{@"title":@"Privacy & Account",@"detail":@"Feature catalog"},
            @{@"title":@"Profile & Account Capabilities",@"detail":@"Feature catalog"},
            @{@"title":@"Direct Messages & Notes",@"detail":@"Feature catalog"},
            @{@"title":@"Reels & Posts",@"detail":@"Feature catalog"},
            @{@"title":@"Stories & Camera",@"detail":@"Feature catalog"},
            @{@"title":@"Comments & Engagement",@"detail":@"Feature catalog"},
            @{@"title":@"Interface & Meta AI",@"detail":@"Feature catalog"}
        ];
    } else if ([self.screen isEqualToString:@"Developer & Employee Mode"]) {
        self.items=@[
            @{@"title":@"Internal Settings",@"detail":@"Not connected to native entry point"},
            @{@"title":@"Shake Menu",@"detail":@"Not connected to native debug menu"},
            @{@"title":@"Dogfooding Assistant",@"detail":@"Requires genuine app eligibility"},
            @{@"title":@"Customize Your Instagram",@"detail":@"Requires matching Instagram UI hook"}
        ];
    } else {
        NSDictionary<NSString *,NSArray<NSString *> *> *catalog=@{
            @"Downloads & Media":@[@"Download Reels",@"Download Posts",@"Download Carousel",@"Download Stories",@"Download Profile Picture",@"Download Voice Messages",@"Save Ordinary DM Media",@"Quality Selector",@"DASH Muxing",@"Save to Photos",@"Download Progress"],
            @"Privacy & Ghost":@[@"Ghost Stories",@"Ghost Messages",@"Ghost Live",@"Hide Typing",@"Ghost Exceptions",@"Ghost Mute",@"Mark Story Seen On Like"],
            @"Messages & Calls":@[@"Keep Deleted Messages",@"Upload Voice Message",@"Voice Recorder",@"Voice Changer",@"Voice Preview",@"Call Recording",@"Auto Record Calls",@"Call Recordings",@"Messaging-Only Mode"],
            @"Reels & Stories":@[@"Reels PiP",@"Reels 2x Speed",@"Reels Fast Forward",@"Copy Reel Caption",@"Copy Reel Comments",@"Hide Reels",@"Video Trim",@"Audio Trim",@"Video Crop",@"Photo Editor",@"QuickSnap / Instants"],
            @"Comments & Engagement":@[@"Search Comments",@"Deep Comment Search",@"Jump to Comment",@"View Comment Likers",@"Sort Newest / Oldest",@"Sort Most / Least Liked",@"Sort Most / Least Replies",@"Copy Comment",@"Copy Username",@"Export Usernames"],
            @"Profile Tools":@[@"Profile Picture Viewer",@"Profile Picture Download",@"Followers Analysis",@"Unfollowers",@"Fans",@"Mutual Followers",@"Recently Unfollowed",@"Visited Profiles (Local)",@"Copy Profile Info",@"Close Friends",@"Golden Profile Theme"],
            @"Rise AI":@[@"Gemini Assistant",@"Gemini Key Setup",@"Chat History",@"Auto Replies",@"Reply to Requests",@"AI Persona",@"Knowledge Base",@"Cooldown",@"AI Test Reply",@"AI Voice"],
            @"Customization":@[@"Theme",@"App Icon",@"Language",@"Sidebar",@"Navigation Buttons",@"Accent Color",@"Liquid Glass Appearance",@"Rise Quick Access"],
            @"Privacy & Account":@[@"Hide Followers & Following",@"Hide My Account From Lists",@"Quiet Mode",@"Threads Notifications"],
            @"Profile & Account Capabilities":@[@"Profile Song",@"Profile Music Tab",@"Modern Highlights",@"Filled Profile Buttons",@"Tall Grid",@"Insights",@"Subscriptions",@"Official Profile Rings",@"Profile Action Button"],
            @"Direct Messages & Notes":@[@"Chat Nicknames",@"Photo Stacks",@"Inbox Folders",@"Scheduled Messages",@"Pinned Messages",@"AI Rewrite",@"AI Stickers",@"Blend Reels",@"HD Media Sending",@"Custom Chat Background",@"Minimize Video Call"],
            @"Reels & Posts":@[@"Trial Reels",@"Longform Reels",@"Flexible Reels Aspect",@"Reels Scheduling",@"Reposts",@"Official PiP",@"Your Algo",@"Reels Translation",@"Video Super Resolution",@"Download Permission Controls",@"Secret Code Reels",@"Spotify Audio Sections",@"Clickable Post Links",@"Send Message Post Button"],
            @"Stories & Camera":@[@"Public Story Comments",@"AI Backdrop",@"AI Camera Effects",@"GenAI Restyle",@"QuickSnap / Instants",@"New Story Fonts",@"Expiring Story Badge",@"Video Stickers"],
            @"Comments & Engagement (Developer)":@[@"Photo Replies",@"GIF & Stickers",@"Reel Replies",@"Auto Translate",@"Pin Comments",@"Share Comment to Story"],
            @"Interface & Meta AI":@[@"Meta AI Live Voice",@"Write With Meta AI",@"AI Imagine",@"Muse AI Agent",@"Broadcast Channels",@"Broadcast Channel Search",@"Visual Search",@"Explore Customization"]
        };
        NSString *key=[self.screen isEqualToString:@"Comments & Engagement"] ? @"Comments & Engagement" : self.screen;
        NSMutableArray *rows=[NSMutableArray array];
        for (NSString *title in catalog[key] ?: @[]) [rows addObject:@{@"title":title,@"detail":@"Not connected — needs an Instagram hook"}];
        self.items=rows;
    }
    [self.tableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { return self.items.count; }
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"rise"];
    if (!cell) cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"rise"];
    NSDictionary *item=self.items[indexPath.row];
    cell.textLabel.text=item[@"title"];
    cell.detailTextLabel.text=item[@"detail"];
    cell.detailTextLabel.textColor=UIColor.secondaryLabelColor;
    cell.textLabel.font=[UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    cell.accessoryType=([self.screen isEqualToString:@"root"] || [self.screen isEqualToString:@"Account Features & Updates"]) ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *name=self.items[indexPath.row][@"title"];
    if ([self.screen isEqualToString:@"root"] ||
        ([self.screen isEqualToString:@"Account Features & Updates"] && ![name isEqualToString:@"Scan Account Features"])) {
        NSString *screen=name;
        if ([name isEqualToString:@"Comments & Engagement"] && [self.screen isEqualToString:@"Account Features & Updates"]) screen=@"Comments & Engagement (Developer)";
        [self.navigationController pushViewController:[[RiseInstaMenuController alloc] initWithScreen:screen] animated:YES];
        return;
    }
    if ([name isEqualToString:@"Export Runtime Classes"]) {
        NSError *error=nil;
        NSURL *file=[RiseInstaDiagnostics exportReport:&error];
        if (file) {
            UIActivityViewController *share=[[UIActivityViewController alloc] initWithActivityItems:@[file] applicationActivities:nil];
            if (share.popoverPresentationController) share.popoverPresentationController.sourceView=self.view;
            [self presentViewController:share animated:YES completion:nil];
            return;
        }
    }
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:name message:@"Listed in Rise Insta, but this action is not connected to a verified Instagram hook yet." preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
@end

@implementation RiseInstaUI
+ (void)presentFrom:(UIViewController *)controller {
    if (!controller || controller.presentedViewController) return;
    RiseInstaMenuController *root=[[RiseInstaMenuController alloc] initWithScreen:@"root"];
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:root];
    root.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:controller action:@selector(riseinsta_dismissMenu)];
    nav.modalPresentationStyle=UIModalPresentationPageSheet;
    if (@available(iOS 15.0, *)) {
        UISheetPresentationController *sheet=nav.sheetPresentationController;
        sheet.detents=@[UISheetPresentationControllerDetent.mediumDetent,UISheetPresentationControllerDetent.largeDetent];
        sheet.prefersGrabberVisible=YES;
    }
    [controller presentViewController:nav animated:YES completion:nil];
}
+ (void)installEntryPoint {
    // No floating button: recognize a 3-finger hold on the foreground Instagram window.
    for (UIScene *scene in UIApplication.sharedApplication.connectedScenes) {
        if (![scene isKindOfClass:[UIWindowScene class]] ||
            scene.activationState != UISceneActivationStateForegroundActive) continue;
        for (UIWindow *window in ((UIWindowScene *)scene).windows) {
            if (!window.isKeyWindow) continue;
            BOOL found=NO;
            for (UIGestureRecognizer *recognizer in window.gestureRecognizers) {
                if ([recognizer.name isEqualToString:@"RiseInstaThreeFingerHold"]) { found=YES; break; }
            }
            if (found) continue;
            UILongPressGestureRecognizer *hold=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(riseinsta_threeFingerHold:)];
            hold.numberOfTouchesRequired=3;
            hold.minimumPressDuration=0.8;
            hold.cancelsTouchesInView=NO;
            hold.name=@"RiseInstaThreeFingerHold";
            [window addGestureRecognizer:hold];
        }
    }
}
+ (UIViewController *)riseinsta_visibleControllerFrom:(UIViewController *)vc {
    if (!vc) return nil;
    if (vc.presentedViewController) return [self riseinsta_visibleControllerFrom:vc.presentedViewController];
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self riseinsta_visibleControllerFrom:((UINavigationController *)vc).visibleViewController] ?: vc;
    }
    if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self riseinsta_visibleControllerFrom:((UITabBarController *)vc).selectedViewController] ?: vc;
    }
    return vc;
}
+ (void)riseinsta_threeFingerHold:(UILongPressGestureRecognizer *)gesture {
    if (gesture.state != UIGestureRecognizerStateBegan) return;
    UIWindow *window=(UIWindow *)gesture.view;
    UIViewController *vc=[self riseinsta_visibleControllerFrom:window.rootViewController];
    if (!vc || [vc isKindOfClass:[RiseInstaMenuController class]] ||
        [vc.navigationController.viewControllers.firstObject isKindOfClass:[RiseInstaMenuController class]]) return;
    [self presentFrom:vc];
}
@end

@interface UIViewController (RiseInstaDismiss)
- (void)riseinsta_dismissMenu;
@end
@implementation UIViewController (RiseInstaDismiss)
- (void)riseinsta_dismissMenu { [self dismissViewControllerAnimated:YES completion:nil]; }
@end
