#import "QRCoder.h"

/* http://www.ama-dev.com/iphone-qr-code-library-ios-7/ */

@implementation QRCoder

#if TARGET_OS_IPHONE

- (NSString*) stringFromQRCode:(UIImage*) image
{
    return nil;
}

- (UIImage*) QRCodeFromString:(NSString*) url
{
    return nil;
}

#else

- (NSString*) stringFromQRCode:(NSImage*) image
{
    return nil;
}

- (NSImage*) QRCodeFromString:(NSString*) url
{
    return nil;
}

#endif

- (NSString*) srringFromImageRef:(CGImageRef) image
{
    return nil;
}

- (CGImageRef) imageRefFromString:(NSString*) string
{
    return nil;
}

@end
