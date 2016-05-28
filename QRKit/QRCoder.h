#import <Foundation/Foundation.h>
#if TARGET_OS_WATCH
#import <CoreGraphics/CoreGraphics.h>
#else
#import <CoreImage/CoreImage.h>
#endif

#import <QRKit/QRDefines.h>

#pragma mark - QRCodeAttributes

static NSString* const QRInputMessage = @"inputMessage";

static NSString* const QRInputCorrectionLevel = @"inputCorrectionLevel";
static NSString* const QRInputCorrectionLevelL = @"L"; // 7%
static NSString* const QRInputCorrectionLevelM = @"M"; // 15%
static NSString* const QRInputCorrectionLevelQ = @"Q"; // 25%
static NSString* const QRInputCorrectionLevelH = @"H"; // 30%

static NSString* const QRCICode128BarcodeGenerator = @"CICode128BarcodeGenerator";
static NSString* const QRInputQuietSpace = @"inputQuietSpace"; // Def 7, Min 0, Max 20

static NSString* const QRCIAztecCodeGenerator = @"CIAztecCodeGenerator";
static NSString* const QRCIPDF417BarcodeGenerator = @"CIPDF417BarcodeGenerator";

@interface QRCoder : NSObject

/** @return a QRImage (NSImage, UIImage or WKImage) with a QRCode for the string provided at the size requested */
+ (QRImage*) QRCodeFromString:(NSString*) string withAttributes:(NSDictionary*) attrs withSize:(CGSize) size codeColor:(QRColor*) color;
+ (QRImage*) QRCodeFromString:(NSString*) string withAttributes:(NSDictionary*) attrs withSize:(CGSize) size codeColor:(QRColor*) color backgroundColor:(QRColor*) background;

/** @return a CIImage with a QRCode for the string provided at the size requested */
#if TARGET_OS_WATCH
+ (CGImageRef) QRCodeImageFromString:(NSString*) string withAttributes:(NSDictionary*) attributes withSize:(CGSize) size codeColor:(CGColorRef) color
#else
+ (CIImage*) QRCodeImageFromString:(NSString*) string withAttributes:(NSDictionary*) attrs withSize:(CGSize) size codeColor:(CIColor*) color;
+ (CIImage*) QRCodeImageFromString:(NSString*) string withAttributes:(NSDictionary*) attrs withSize:(CGSize) size codeColor:(CIColor*) color backgroundColor:(CIColor*) background;
#endif

@end
