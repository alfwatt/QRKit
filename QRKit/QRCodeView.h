#include "TargetConditionals.h"

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#else
#import <AppKit/AppKit.h>
#endif

/** @class QRCodeView displays a QRCode for the encodedString provided */
#if TARGET_OS_IPHONE
@interface QRCodeView : UIView
#else
@interface QRCodeView : NSView
#endif

@property(nonatomic,retain) NSString* encodedString;

@end
