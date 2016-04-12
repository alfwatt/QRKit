#import <QRKit/QRDefines.h>

QRColor* QRComplementaryBackgroundColor(QRColor* color);

/** @class QRCodeView displays a QRCode for the encodedString provided */
@interface QRCodeView : QRView
@property(nonatomic,readonly) QRImage* codeImage;
@property(nonatomic,retain) NSString* codeString;
@property(nonatomic,retain) QRColor* codeColor;
@property(nonatomic,assign) BOOL complementaryBackground;
@property(nonatomic,retain) NSDictionary* codeAttributes;
@end
