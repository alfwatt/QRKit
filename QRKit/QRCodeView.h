#include "TargetConditionals.h"

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#else
#import <AppKit/AppKit.h>
#endif

/** @class QRCodeView displays a QRCode for the encodedString provided */
#if TARGET_OS_IPHONE
@interface QRCodeView : UIView
{
    UIImage* cachedCodeImage;
    NSString* cachedCodeString;
}
@property(nonatomic,readonly) UIImage* codeImage;
#else
@interface QRCodeView : NSView
{
    NSImage* cachedCodeImage;
    NSString* cachedCodeString;
}
@property(nonatomic,readonly) NSImage* codeImage;
#endif

@property(nonatomic,retain) NSString* codeString;

@end
