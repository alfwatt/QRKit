#import "QRTVDelegate.h"
#import "QRTVController.h"

@interface QRTVDelegate ()
@end

@implementation QRTVDelegate

static NSString* const QRColorName = @"ColorName";
static NSString* const QRColorNameWhite = @"White";
static NSString* const QRColorNameBlack = @"Black";
static NSString* const QRColorNameRed = @"Red";
static NSString* const QRColorNameOrange = @"Orange";
static NSString* const QRColorNameYellow = @"Yellow";
static NSString* const QRColorNameGreen = @"Green";
static NSString* const QRColorNameBlue = @"Blue";
static NSString* const QRColorNameIndigo = @"Indigo";
static NSString* const QRColorNameViolet = @"Violet";
static NSString* const QRColorNameCustom = @"Custom";
static NSString* const QRCustomColorRedComponent = @"CustomColorRedComponent";
static NSString* const QRCustomColorGreenComponent = @"CustomColorGreenComponent";
static NSString* const QRCustomColorBlueComponent = @"CustomColorBlueComponent";
static NSString* const QRLockColor = @"LockColor";

static NSString* const QRBackgroundColor = @"BackgroundColor";
static NSString* const QRWhiteBackground = @"WhiteBackground";
static NSString* const QRGrayBackground = @"GrayBackground";
static NSString* const QRBlackBackground = @"BlackBackground";
static NSString* const QRComplementaryBackground = @"ComplementaryBackground";

static NSString* const QRCorrectionLevel = @"CorrectionLevel";
static NSString* const QRResetApplication = @"ResetApplication";

- (QRColor*) prefsColor {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString* colorName = [defaults stringForKey:QRColorName];
    QRColor* prefsColor = [QRColor blackColor];

    if ([colorName isEqualToString:QRColorNameWhite]) {
        prefsColor = [QRColor whiteColor];
    }
    else if ([colorName isEqualToString:QRColorNameRed]) {
        prefsColor = [QRColor redColor];
    }
    else if ([colorName isEqualToString:QRColorNameOrange]) {
        prefsColor = [QRColor orangeColor];
    }
    else if ([colorName isEqualToString:QRColorNameYellow]) {
        prefsColor = [QRColor yellowColor];
    }
    else if ([colorName isEqualToString:QRColorNameGreen]) {
        prefsColor = [QRColor greenColor];
    }
    else if ([colorName isEqualToString:QRColorNameBlue]) {
        prefsColor = [QRColor blueColor];
    }
    else if ([colorName isEqualToString:QRColorNameIndigo]) {
        prefsColor = [QRColor colorWithRed:0.0 green:0.0 blue:0.5 alpha:1.0];
    }
    else if ([colorName isEqualToString:QRColorNameViolet]) {
        prefsColor = [QRColor colorWithHue:0.8 saturation:0.4 brightness:0.8 alpha:1.0];
    }
    else if ([colorName isEqualToString:QRColorNameCustom]) {
        CGFloat redComponent = 0.5;
        CGFloat greenComponent = 0.5;
        CGFloat blueComponent = 0.5;

        if ([defaults valueForKey:QRCustomColorRedComponent]) {
            redComponent = [defaults doubleForKey:QRCustomColorRedComponent];
        }

        if ([defaults valueForKey:QRCustomColorGreenComponent]) {
            greenComponent = [defaults doubleForKey:QRCustomColorGreenComponent];
        }

        if ([defaults valueForKey:QRCustomColorBlueComponent]) {
            blueComponent = [defaults doubleForKey:QRCustomColorBlueComponent];
        }

        // NSLog(@"Custom Color: %f %f %f \n%@", redComponent, greenComponent, blueComponent, [defaults dictionaryRepresentation]);

        prefsColor = [UIColor colorWithRed:redComponent green:greenComponent blue:blueComponent alpha:1.0];
    }
    return prefsColor;
}

- (void) updatePrefs
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];

    if ([defaults boolForKey:QRResetApplication]) {
        [defaults removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]];
    }

    NSString* defaultsCorrectionLevel = [defaults stringForKey:QRCorrectionLevel];
    if (defaultsCorrectionLevel) {
        self.controller.codeView.codeAttributes = @{
            QRInputCorrectionLevel:defaultsCorrectionLevel
        };
    }

    QRColor* prefsColor = [self prefsColor];
    NSString* backgroundColor = [defaults stringForKey:QRBackgroundColor];
    if ([backgroundColor isEqualToString:QRComplementaryBackground]) {
        self.controller.codeView.complementaryBackground = YES;
        self.window.rootViewController.view.backgroundColor = QRComplementaryBackgroundColor(prefsColor);
    }
    else if ([backgroundColor isEqualToString:QRBlackBackground]) {
        self.controller.codeView.complementaryBackground = NO;
        self.controller.codeView.backgroundColor = [QRColor blackColor];
        self.window.rootViewController.view.backgroundColor = [QRColor blackColor];
    }
    else if ([backgroundColor isEqualToString:QRGrayBackground]) {
        self.controller.codeView.complementaryBackground = NO;
        self.controller.codeView.backgroundColor = [QRColor grayColor];
        self.window.rootViewController.view.backgroundColor = [QRColor grayColor];
    }
    else { // if ([backgroundColor isEqualToString:QRWhiteBackground])
        self.controller.codeView.complementaryBackground = NO;
        self.controller.codeView.backgroundColor = [QRColor whiteColor];
        self.window.rootViewController.view.backgroundColor = [QRColor whiteColor];
    }
    [self.controller.codeView setCodeColor:prefsColor];
}

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{
        QRBackgroundColor: QRComplementaryBackground
    }];

    self.controller = (QRTVController*)self.window.rootViewController;
    application.idleTimerDisabled = YES;

    // TODO recoginze a tap and put up a text view
    UITapGestureRecognizer* recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(recognizeTap:)];
    recognizer.allowedPressTypes = @[@(UIPressTypeSelect)];
    [self.window addGestureRecognizer:recognizer];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [self updatePrefs];
    [self.controller updateQRCode:self];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [self updatePrefs];
    [self.controller updateQRCode:self];
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

#pragma mark - UIGestureRecognizers

-  (void) recognizeTap:(UITapGestureRecognizer*) tap
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults boolForKey:QRLockColor]) {
        NSArray* colors = @[QRColorNameWhite,
                            QRColorNameBlack,
                            QRColorNameRed,
                            QRColorNameOrange,
                            QRColorNameYellow,
                            QRColorNameGreen,
                            QRColorNameBlue,
                            QRColorNameIndigo,
                            QRColorNameViolet,
                            QRColorNameCustom];
        NSString* colorName = [defaults stringForKey:QRColorName];
        NSUInteger nextIndex = 0;
        NSUInteger colorIndex = [colors indexOfObject:colorName];
        if (colorIndex < (colors.count - 1)) {
            nextIndex = colorIndex + 1;
        }
        // else it's NSNotFound or 0, in which case, 0
        NSString* nextColorName = [colors objectAtIndex:nextIndex];
        [defaults setObject:nextColorName forKey:QRColorName];
        [self updatePrefs];
    }
    // else TODO flash the screen
}

@end
