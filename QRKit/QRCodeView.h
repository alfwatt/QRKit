#include "TargetConditionals.h"

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>

@interface QRCodeView : UIView
#else
#import <AppKit/AppKit.h>

@interface QRCodeView : NSView
#endif



@end
