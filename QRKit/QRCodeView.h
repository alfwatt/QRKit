#import <QRKit/QRDefines.h>

/** @class QRCodeView displays a QRCode for the encodedString provided */
@interface QRCodeView : QRView
@property(nonatomic, retain) NSString* codeString;
@property(nonatomic, retain) NSDictionary* codeAttributes;
@property(nonatomic, retain) QRColor* codeColor;
@property(nonatomic, readonly) QRImage* codeImage;

@end
