#include "TargetConditionals.h"

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#else
#import <AppKit/AppKit.h>
#endif

/* view which scans for QR coode with an overlay */

#if TARGET_OS_IPHONE
@interface QRCodeScanner : UIView
#else
@interface QRCodeScanner : NSView
#endif

@end
