#import "QRCodeView.h"
#import "QRCoder.h"

@interface QRCodeView ()
@property(nonatomic, retain) QRImage* codeImageStorage;
@property(nonatomic, retain) NSString* codeStringStorage;

@end

#pragma mark -

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

- (void) clearImageCache
{
    self.codeImageStorage = nil;
#if TARGET_OS_IPHONE || TARGET_OS_TV
    [self setNeedsDisplay];
#else
    [self setNeedsDisplay:YES];
#endif

}

#pragma mark - Properties

- (QRImage*) codeImage
{
    if( !self.codeImageStorage) {
        self.codeImageStorage = [QRCoder
            QRCodeFromString:self.codeString
            withAttributes:self.codeAttributes
            withSize:[self insetSquare].size
            codeColor:self.codeColor
            backgroundColor:(self.layer.backgroundColor ? [QRColor colorWithCGColor:self.layer.backgroundColor] : nil)];
    }
    return self.codeImageStorage;
}

- (NSString*) codeString
{
    return [self.codeStringStorage copy];
}

- (void) setCodeString:(NSString *)encodedString
{
    self.codeStringStorage = encodedString;
    [self clearImageCache];
}

- (void) setCodeColor:(QRColor*) codeColor
{
    BOOL changed = (_codeColor != codeColor);
    _codeColor = codeColor;
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
#if TARGET_OS_IPHONE || TARGET_OS_TV
    [self.codeImage drawInRect:[self insetSquare] blendMode:kCGBlendModeNormal alpha:1.0];
#else
    [self.codeImage drawInRect:[self insetSquare]];
#endif
}

#if TARGET_OS_IPHONE || TARGET_OS_TV
#pragma mark - UIView Methods

- (void) layoutSubviews
{
    [self clearImageCache];
    [super layoutSubviews];
}

#else
#pragma mark - NSView Methods

- (void)setFrameSize:(NSSize)newSize
{
    [self clearImageCache];
    [super setFrameSize:newSize];
}
#endif

#endif // TARGET_OS_WATCH

@end

