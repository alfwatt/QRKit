#import <UIKit/UIKit.h>

@class QRTVController;

@interface QRTVDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic,strong) UIWindow* window;
@property (nonatomic,assign) QRTVController* controller;

@end

