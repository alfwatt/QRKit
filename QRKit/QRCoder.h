#import <Foundation/Foundation.h>
#if TARGET_OS_WATCH
#import <CoreGraphics/CoreGraphics.h>
#else
#import <CoreImage/CoreImage.h>
#endif

#import <QRKit/QRDefines.h>

@interface QRCoder : NSObject

/** @return a QRImage (NSImage, UIImage or WKImage) with a QRCode for the string provided at the size requested */
+ (QRImage*) QRCodeFromString:(NSString*) string withSize:(CGSize) size;

/** @return a CIImage with a QRCode for the string provided at the size requested */
#if TARGET_OS_WATCH
+ (CGImageRef) QRCodeImageFromString:(NSString*) string withSize:(CGSize) size;
#else
+ (CIImage*) QRCodeImageFromString:(NSString*) string withSize:(CGSize) size;
#endif

@end
