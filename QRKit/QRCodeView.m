#import "QRCodeView.h"
#import "QRCoder.h"

#if !TARGET_OS_WATCH
QRColor* QRComplementaryBackgroundColor(QRColor* color) {
    if ([color isEqual:[QRColor whiteColor]]
        || [color isEqual:[QRColor lightGrayColor]]) {
        return [QRColor blackColor];
    }
    else if ([color isEqual:[QRColor blackColor]]
             || [color isEqual:[QRColor grayColor]]) {
        return [QRColor whiteColor];
    }
    else if ([color isEqual:[QRColor blueColor]]) {
        UIColor* orange = [QRColor orangeColor];
        CGFloat hue, saturation, brightness, alpha = 0;
        [orange getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
        return [QRColor colorWithHue:hue saturation:(saturation*0.7) brightness:brightness alpha:alpha];
    }
    else { // return a hue-wise complement at the same luminance
        CGFloat hue, saturation, brightness, alpha, compliment = 0;
        [color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
        compliment = (hue > 0.5 ? hue - 0.5 : hue + 0.5);
        CGFloat desaturated = (saturation*0.7);
        CGFloat luminance = ((brightness >= 0.6) ? 0.4 : 0.9);
        return [QRColor colorWithHue:compliment saturation:desaturated brightness:luminance alpha:alpha];
    }
}
#endif

@implementation QRCodeView
{
    QRImage* cachedCodeImage;
    NSString* cachedCodeString;
}

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

- (void) clearImageCache
{
    cachedCodeImage = nil;
#if TARGET_OS_IPHONE || TARGET_OS_TV
    [self setNeedsDisplay];
#else
    [self setNeedsDisplay:YES];
#endif

}

#pragma mark - Properties

- (QRImage*) codeImage
{
    if( !cachedCodeImage) {
        cachedCodeImage = [QRCoder QRCodeFromString:self.codeString withAttributes:self.codeAttributes withSize:[self insetSquare].size codeColor:self.codeColor];
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
    [self clearImageCache];
}

- (void) setCodeColor:(QRColor*) codeColor
{
    BOOL changed = (_codeColor != codeColor);
    _codeColor = codeColor;
    if (changed) {
        if (self.complementaryBackground) {
            self.backgroundColor = QRComplementaryBackgroundColor(self.codeColor);
        }
        [self clearImageCache];
    }
}

- (void) setComplementaryBackground:(BOOL)complementaryBackground
{
    BOOL changed = (_complementaryBackground != complementaryBackground);
    _complementaryBackground = complementaryBackground;
    if (changed) {
        [self clearImageCache];
    }
}

- (void) setCodeAttributes:(NSDictionary *)codeAttributes
{
    _codeAttributes = codeAttributes;
    [self clearImageCache];
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
