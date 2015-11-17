#import <QRKit/QRDefines.h>

/** @class QRCodeView displays a QRCode for the encodedString provided */
@interface QRCodeView : QRView
{
    QRImage* cachedCodeImage;
    NSString* cachedCodeString;
}
@property(nonatomic,readonly) QRImage* codeImage;
@property(nonatomic,retain) NSString* codeString;

@end
