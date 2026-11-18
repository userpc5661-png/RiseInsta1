#import "RiseInstaDiagnostics.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
@implementation RiseInstaDiagnostics
+ (NSURL *)exportReport:(NSError **)error {
    unsigned int count = 0;
    Class *classes = objc_copyClassList(&count);
    if (!classes) return nil;
    NSArray<NSString *> *filters = @[@"IG", @"Instagram", @"Reel", @"Sundial", @"Story", @"Direct", @"Profile", @"Feed", @"Comment", @"Media", @"Settings"];
    NSMutableArray<NSString *> *names = [NSMutableArray array];
    for (unsigned int i=0; i<count; i++) {
        const char *raw = class_getName(classes[i]);
        if (!raw) continue;
        NSString *name=[NSString stringWithUTF8String:raw];
        for (NSString *needle in filters) {
            if ([name rangeOfString:needle options:NSCaseInsensitiveSearch].location != NSNotFound) {
                [names addObject:name]; break;
            }
        }
    }
    free(classes);
    [names sortUsingSelector:@selector(compare:)];
    NSUInteger limit=MIN((NSUInteger)1200,names.count);
    NSMutableString *report=[NSMutableString stringWithFormat:@"Rise Insta Runtime Class Report\nGenerated: %@\nMatching classes: %lu\nExported: %lu\nNames alone do not prove working hooks or server permissions.\n", [NSDate date],(unsigned long)names.count,(unsigned long)limit];
    for (NSUInteger i=0;i<limit;i++) {
        NSString *name=names[i];
        [report appendFormat:@"\n[%@]\n",name];
        Class cls=objc_getClass(name.UTF8String);
        unsigned int methodsCount=0;
        Method *methods=class_copyMethodList(cls,&methodsCount);
        for (unsigned int j=0;methods && j<MIN(methodsCount,(unsigned int)60);j++) {
            [report appendFormat:@"- %@\n",NSStringFromSelector(method_getName(methods[j]))];
        }
        if (methods) free(methods);
    }
    // Report class names and view geometry only. Do not read UILabel text,
    // message contents, accessibility labels, account names or image data.
    [report appendString:@"\\n\\n=== Foreground UIView hierarchy (class + bounds only) ===\\n"];
    for (UIScene *scene in UIApplication.sharedApplication.connectedScenes) {
        if (![scene isKindOfClass:[UIWindowScene class]] ||
            scene.activationState != UISceneActivationStateForegroundActive) continue;
        for (UIWindow *window in ((UIWindowScene *)scene).windows) {
            if (!window.isKeyWindow) continue;
            NSMutableArray<NSDictionary *> *pending=[NSMutableArray arrayWithObject:@{@"view":window,@"depth":@0}];
            NSUInteger exported=0;
            while (pending.count && exported<350) {
                NSDictionary *entry=pending.lastObject;
                [pending removeLastObject];
                UIView *view=entry[@"view"];
                NSUInteger depth=[entry[@"depth"] unsignedIntegerValue];
                [report appendFormat:@"%@%@ frame=%@ hidden=%@\\n",
                     [@"" stringByPaddingToLength:MIN(depth,15)*2 withString:@" " startingAtIndex:0],
                     NSStringFromClass([view class]), NSStringFromCGRect(view.frame),
                     view.hidden ? @"YES" : @"NO"];
                exported++;
                if (depth>=14) continue;
                for (UIView *child in [view.subviews reverseObjectEnumerator]) {
                    [pending addObject:@{@"view":child,@"depth":@(depth+1)}];
                }
            }
            if (pending.count) [report appendString:@"[truncated at 350 views]\\n"];
        }
    }
    NSString *path=[NSTemporaryDirectory() stringByAppendingPathComponent:@"RiseInsta-Runtime-Classes.txt"];
    return [report writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:error] ? [NSURL fileURLWithPath:path] : nil;
}
@end
