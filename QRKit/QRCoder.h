#include "TargetConditionals.h"
#import <Foundation/Foundation.h>

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#else
#import <AppKit/AppKit.h>
#endif

@interface QRCoder : NSObject

#if TARGET_OS_IPHONE

- (NSString*) stringFromQRCode:(UIImage*) image;
- (UIImage*) QRCodeFromString:(NSString*) url;

#else

- (NSString*) stringFromQRCode:(NSImage*) image;
- (NSImage*) QRCodeFromString:(NSString*) url;

#endif

- (NSString*) srringFromImageRef:(CGImageRef) image;
- (CGImageRef) imageRefFromString:(NSString*) string;

@end
