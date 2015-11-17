#import <AVFoundation/AVFoundation.h>

#import <QRKit/QRDefines.h>

/* based on https://gist.github.com/Alex04/6976945 */

@protocol QRCodeScannerDelegate;

/** @class QRCodeScanner a view which scans for QR coode with an overlay */

@interface QRCodeScanner : UIViewController <AVCaptureMetadataOutputObjectsDelegate>

@property(nonatomic,readonly) NSString* decodedString;
@property(nonatomic,assign) id<QRCodeScannerDelegate> delegate;
@property (assign, nonatomic) BOOL touchToFocusEnabled;

- (BOOL) isCameraAvailable;
- (void) startScanning;
- (void) stopScanning;
- (void) setLight:(BOOL) aStatus;

@end

#pragma mark -

@protocol QRCodeScannerDelegate <NSObject>
@optional

- (void) scanViewController:(QRCodeScanner*) scanner didSuccessfullyScan:(NSString *) aScannedValue;
- (void) scanViewController:(QRCodeScanner*) scanner didTapToFocusOnPoint:(CGPoint) aPoint;

@end
