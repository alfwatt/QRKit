#include "TargetConditionals.h"
#import <CoreImage/CoreImage.h>
#import <Foundation/Foundation.h>

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#else
#import <AppKit/AppKit.h>
#endif

@interface QRCoder : NSObject

#if TARGET_OS_IPHONE

- (UIImage*) QRCodeFromString:(NSString*) string withSize:(CGSize) size;

#else

- (NSImage*) QRCodeFromString:(NSString*) string withSize:(CGSize) size;

#endif

- (CIImage*) QRCodeImageFromString:(NSString*) string;

@end
