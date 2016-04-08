#import "QRCodeView.h"
#import "QRCoder.h"

@implementation QRCodeView

#if !TARGET_OS_WATCH
- (CGRect) insetSquare
{
    CGSize viewSize = [self frame].size;
    CGFloat squareSide = floor(fmin(viewSize.width,viewSize.height));
    CGFloat xOffset = floor((viewSize.width - squareSide) / 2);
    CGFloat yOffset = floor((viewSize.height - squareSide) / 2);
    CGRect insetSquare = CGRectMake(xOffset,yOffset,squareSide,squareSide);
//  NSLog(@"QRCodeView insetSquare: %@", NSStringFromCGRect(insetSquare));
    return insetSquare;
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
#if TARGET_OS_IPHONE || TARGET_OS_TV
    [self setNeedsDisplay];
#else
    [self setNeedsDisplay:YES];
#endif
}

#pragma mark - Shared NSView & UIView Methods

- (void)drawRect:(CGRect)rect
{
    [self.codeImage drawInRect:[self insetSquare]];
}

#if TARGET_OS_IPHONE || TARGET_OS_TV
#pragma mark - UIView Methods

- (void) layoutSubviews
{
    cachedCodeImage = nil;
    [self setNeedsDisplay];
    [super layoutSubviews];
}

#else
#pragma mark - NSView Methods

- (void)setFrameSize:(NSSize)newSize
{
    cachedCodeImage = nil; // invalidate the image cache when resizing
    [self setNeedsDisplay:YES];
    [super setFrameSize:newSize];
}
#endif

#endif

@end
