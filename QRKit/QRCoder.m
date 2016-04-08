#import "QRCoder.h"

#import <CoreImage/CIFilter.h>
#import <AVFoundation/AVFoundation.h>

/* http://www.ama-dev.com/iphone-qr-code-library-ios-7/ */

@implementation QRCoder

#if TARGET_OS_IPHONE || TARGET_OS_TV

+ (UIImage*) QRCodeFromString:(NSString*) string withSize:(CGSize) size
{
    CIImage* qrCode = [self QRCodeImageFromString:string withSize:size];
    return [UIImage imageWithCIImage:qrCode];
}

#else

+ (NSImage*) QRCodeFromString:(NSString*) string withSize:(CGSize) size
{
    NSCIImageRep* imageRep = [NSCIImageRep imageRepWithCIImage:[self QRCodeImageFromString:string withSize:size]];
    NSImage* image = [[NSImage alloc] initWithSize:NSSizeFromCGSize(size)];
    imageRep.size = NSSizeFromCGSize(size);
    [image addRepresentation:imageRep];
    return image;
}

#endif

/*

 http://stackoverflow.com/questions/22374971/ios-7-core-image-qr-code-generation-too-blur

*/
+ (CIImage*) QRCodeImageFromString:(NSString*) string withSize:(CGSize) size // TODO expand to support other CIFilter codes
{
    if( !string) { // catch a nil string here
        string = @"";
    }
    
    // setup the QR Code filter
    NSData* stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    CIFilter* qrCodeFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"
                                  withInputParameters:@{@"inputMessage": stringData,
                                                        @"inputCorrectionLevel": @"Q"}];
    CIImage* codeImage = qrCodeFilter.outputImage;
    CGRect codeExtent = CGRectIntegral(codeImage.extent);
    CGFloat scale = fmin(size.width/codeExtent.size.width, size.height/codeExtent.size.height);
    // create a blank CGImageRef to apply the filter to
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceGray();
    CGContextRef contextRef = CGBitmapContextCreate(nil, size.width, size.height, 8, 0, colorSpaceRef, (CGBitmapInfo)kCGImageAlphaNone);
#if TARGET_OS_IPHONE || TARGET_OS_TV
    CIContext* context = [CIContext contextWithOptions:nil];
#else
    CIContext* context = [CIContext contextWithCGContext:contextRef options:nil];
#endif
    
    CGImageRef imageRef = [context createCGImage:codeImage fromRect:codeExtent];
    CGContextSetInterpolationQuality(contextRef, kCGInterpolationNone);
    CGContextScaleCTM(contextRef, scale, scale);
    CGContextDrawImage(contextRef, codeExtent, imageRef);
    CGImageRef scaledImageRef = CGBitmapContextCreateImage(contextRef);
    CIImage* scaledImage = [CIImage imageWithCGImage:scaledImageRef];

    CGContextRelease(contextRef);
    CGImageRelease(imageRef);
    CGImageRelease(scaledImageRef);
    return scaledImage;
}

@end
