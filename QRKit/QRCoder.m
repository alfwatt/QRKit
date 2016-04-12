#import "QRCoder.h"

#if !TARGET_OS_WATCH
#import <CoreImage/CIFilter.h>
#import <AVFoundation/AVFoundation.h>
#endif

/* http://www.ama-dev.com/iphone-qr-code-library-ios-7/ */

@implementation QRCoder

#if TARGET_OS_WATCH

+ (WKImage*) QRCodeFromString:(NSString *)string withSize:(CGSize)size
{
    return nil;
}

#elif TARGET_OS_IPHONE || TARGET_OS_TV

+ (UIImage*) QRCodeFromString:(NSString*) string withAttributes:(NSDictionary*) attrs withSize:(CGSize) size codeColor:(UIColor*)color
{
    CIImage* qrCode = [self QRCodeImageFromString:string withAttributes:attrs withSize:size codeColor:color.CGColor];
    return [UIImage imageWithCIImage:qrCode];
}

#else

+ (NSImage*) QRCodeFromString:(NSString*) string withAttributes:(NSDictionary*) attrs withSize:(CGSize) size codeColor(NSColor*)color
{
    NSCIImageRep* imageRep = [NSCIImageRep imageRepWithCIImage:[self QRCodeImageFromString:string withAttributes:attrs withSize:size] color:color.CGColor];
    NSImage* image = [[NSImage alloc] initWithSize:NSSizeFromCGSize(size)];
    imageRep.size = NSSizeFromCGSize(size);
    [image addRepresentation:imageRep];
    return image;
}

#endif

#if TARGET_OS_WATCH

+ (CGImageRef) QRCodeImageFromString:(NSString*) string withSize:(CGSize) size
{
    return NULL;
}

#else
/*

 http://stackoverflow.com/questions/22374971/ios-7-core-image-qr-code-generation-too-blur

 // TODO expand to support other CIFilter codes

*/

static NSString* const QRCIFalseColor = @"CIFalseColor";
static NSString* const QRCIInputColor0 = @"inputColor0";
static NSString* const QRCIInputColor1 = @"inputColor1";

+ (CIImage*) QRCodeImageFromString:(NSString*) string withAttributes:(NSDictionary*) attrs withSize:(CGSize) size codeColor:(CGColorRef) color
{
    if( !string) { // catch a nil string here
        string = @"";
    }
    CIColor* codeColor = (color ? [CIColor colorWithCGColor:color] : [CIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0]);
    CIColor* clearColor = [CIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0];
    // setup the QR Code filter
    NSData* stringData = [string dataUsingEncoding:NSISOLatin1StringEncoding];
    NSString* correctionLevel = QRInputCorrectionLevelM;
    NSString* attrsCorrectionLevel = [attrs objectForKey:QRInputCorrectionLevel];
    static NSArray* correctionLevels;
    if (!correctionLevels) {
        correctionLevels = @[QRInputCorrectionLevelL, QRInputCorrectionLevelM, QRInputCorrectionLevelQ, QRInputCorrectionLevelH];
    }

    if (attrsCorrectionLevel && [correctionLevels indexOfObject:attrsCorrectionLevel] != NSNotFound) {
        correctionLevel = attrsCorrectionLevel;
    }

    CIFilter* qrCodeFilter = [CIFilter filterWithName:QRCIQRCodeGenerator withInputParameters:@{
        QRInputMessage: stringData,
        QRInputCorrectionLevel: correctionLevel}];
    CIImage* codeImage = qrCodeFilter.outputImage;

    // convert the image to the color provided
    CIFilter* codeColorFilter = [CIFilter filterWithName:QRCIFalseColor withInputParameters:@{
        kCIInputImageKey:codeImage,
        QRCIInputColor0:codeColor,
        QRCIInputColor1:clearColor
    }];
    CIImage* coloredImage = codeColorFilter.outputImage;

    // scale the image
    CIImage* finalImage = coloredImage;
    CGRect finalExtent = CGRectIntegral(finalImage.extent);
    CGFloat scale = fmin(size.width/finalExtent.size.width, size.height/finalExtent.size.height);
    // create a blank CGImageRef to apply the filter to
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGContextRef contextRef = CGBitmapContextCreate(NULL, size.width, size.height, 8, (size.width*8*4), colorSpaceRef, kCGImageAlphaPremultipliedLast);
#if TARGET_OS_IPHONE || TARGET_OS_TV
    CIContext* context = [CIContext contextWithOptions:nil];
#else
    CIContext* context = [CIContext contextWithCGContext:contextRef options:nil];
#endif
    
    CGImageRef imageRef = [context createCGImage:finalImage fromRect:finalExtent];
    CGContextSetInterpolationQuality(contextRef, kCGInterpolationNone);
    CGContextScaleCTM(contextRef, scale, scale);
    CGContextDrawImage(contextRef, finalExtent, imageRef);
    CGImageRef scaledImageRef = CGBitmapContextCreateImage(contextRef);
    CIImage* scaledImage = [CIImage imageWithCGImage:scaledImageRef];

    CGContextRelease(contextRef);
    CGImageRelease(imageRef);
    CGImageRelease(scaledImageRef);
    return scaledImage;
}

#endif

@end
