#import <CoreImage/CoreImage.h>
#import <Foundation/Foundation.h>

#import <QRKit/QRDefines.h>

@interface QRCoder : NSObject

/** @return a QRImage (NSImage or UIImage) with a QRCode for the string provided at the size requested */
+ (QRImage*) QRCodeFromString:(NSString*) string withSize:(CGSize) size;

/** @return a CIImage with a QRCode for the string provided at the size requested */
+ (CIImage*) QRCodeImageFromString:(NSString*) string withSize:(CGSize) size;

@end
