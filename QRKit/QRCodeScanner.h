#include "TargetConditionals.h"

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#else
#import <AppKit/AppKit.h>
#endif

/** @class QRCodeScanner a view which scans for QR coode with an overlay */

#if TARGET_OS_IPHONE
@interface QRCodeScanner : UIView
#else
@interface QRCodeScanner : NSView
#endif

@property(nonatomic,retain) NSString* decodedString;

@end
