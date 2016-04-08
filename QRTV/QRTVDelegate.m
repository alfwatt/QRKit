#import "QRTVDelegate.h"
#import "QRTVController.h"

@interface QRTVDelegate ()
@end

@implementation QRTVDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.controller = (QRTVController*)self.window.rootViewController;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [self.controller updateQRCode:self];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [self.controller updateQRCode:self];

}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
