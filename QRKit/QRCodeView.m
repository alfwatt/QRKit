#import "QRCodeView.h"
#import "QRCoder.h"

@implementation QRCodeView

- (CGRect) insetSquare
{
    CGSize viewSize = [self frame].size;
    CGFloat squareSide = floor(fmin(viewSize.width,viewSize.height));
    CGFloat xOffset = floor((viewSize.width - squareSide) / 2);
    CGFloat yOffset = floor((viewSize.height - squareSide) / 2);
    return CGRectMake(xOffset,yOffset,squareSide,squareSide);
}

- (QRImage*) codeImage
{
    if( !cachedCodeImage) {
        cachedCodeImage = [QRCoder QRCodeFromString:self.codeString withSize:[self insetSquare].size];
    }
    return cachedCodeImage;
}

- (NSString*) codeString
{
    return cachedCodeString;
}

- (void) setCodeString:(NSString *)encodedString
{
    cachedCodeString = encodedString;
    cachedCodeImage = nil;
    [self setNeedsDisplay:YES];
}

#pragma mark - Shared NSView & UIView Methods

- (void)drawRect:(CGRect)rect
{
    [self.codeImage drawInRect:[self insetSquare]];
}

#if TARGET_OS_IPHONE
#pragma mark - UIView Methods

// TODO UIView resizing methods

#else
#pragma mark - NSView Methods

- (void)setFrameSize:(NSSize)newSize
{
    cachedCodeImage = nil; // invalidate the image cache when resizing
    [self setNeedsDisplay:YES];
    [super setFrameSize:newSize];
}
#endif

@end
