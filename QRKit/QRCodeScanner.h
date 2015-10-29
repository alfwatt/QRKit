#import <AVFoundation/AVFoundation.h>

#import <QRKit/QRDefines.h>

/* https://gist.github.com/Alex04/6976945 */

@protocol QRCodeScannerDelegate;

/** @class QRCodeScanner a view which scans for QR coode with an overlay */

@interface QRCodeScanner : QRViewController <AVCaptureMetadataOutputObjectsDelegate>

@property(nonatomic,retain) NSString* decodedString;
@property(nonatomic,assign) id<QRCodeScannerDelegate> delegate;

#ifdef TARGET_OS_IPHONE
@property (assign, nonatomic) BOOL touchToFocusEnabled;
#endif

- (BOOL) isCameraAvailable;
- (void) startScanning;
- (void) stopScanning;
- (void) setTorch:(BOOL) aStatus;

@end

#pragma mark -

@protocol QRCodeScannerDelegate <NSObject>

@optional

#ifdef TARGET_OS_IPHONE
- (void) scanViewController:(QRCodeScanner*) scanner didTapToFocusOnPoint:(CGPoint) aPoint;
#else
- (void) scanViewController:(QRCodeScanner*) scanner didSuccessfullyScan:(NSString *) aScannedValue;
#endif

@end
