#import "QRCoder.h"

#import <CoreImage/CIFilter.h>
#import <AVFoundation/AVFoundation.h>

/* http://www.ama-dev.com/iphone-qr-code-library-ios-7/ */

@implementation QRCoder

#if TARGET_OS_IPHONE

+ (UIImage*) QRCodeFromString:(NSString*) string withSize:(CGSize) size
{
    CIImage* qrCode = [self QRCodeImageFromString:string];
    // TODO size the image
    return [UIImage imageWithCIImage:qrCode];
}

#else

+ (NSImage*) QRCodeFromString:(NSString*) string withSize:(CGSize) size
{
    NSCIImageRep* imageRep = [NSCIImageRep imageRepWithCIImage:[self QRCodeImageFromString:string]];
    NSImage* image = [[NSImage alloc] initWithSize:NSSizeFromCGSize(size)];
    imageRep.size = NSSizeFromCGSize(size);
    [image addRepresentation:imageRep];
    return image;
}

#endif

+ (CIImage*) QRCodeImageFromString:(NSString*) string // TODO expand to support other CIFilter codes
{
    if( !string) { // catch a nil string here
        string = @"";
    }
    NSData* stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    CIFilter* qrCodeFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"
                                  withInputParameters:@{@"inputMessage": stringData,
                                                        @"inputCorrectionLevel": @"Q"}];
    return qrCodeFilter.outputImage;
}

@end
