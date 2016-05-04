#import <AVFoundation/AVFoundation.h>

#import <QRKit/QRDefines.h>

/* based on https://gist.github.com/Alex04/6976945 */

@protocol QRCodeScannerDelegate;

/** @class QRCodeScanner a view which scans for QR coode with an overlay */
@interface QRCodeScanner : UIViewController <AVCaptureMetadataOutputObjectsDelegate>

@property(nonatomic, readonly) NSString* decodedString;
@property(nonatomic, assign) id<QRCodeScannerDelegate> delegate;
@property(assign, nonatomic) BOOL touchToFocusEnabled;

- (id) initWithView:(UIView*) view delegate:(id<QRCodeScannerDelegate>) delegate;

- (BOOL) isCameraAvailable;
- (void) startScanning;
- (void) stopScanning;
- (void) setLight:(BOOL) aStatus;

@end

#pragma mark -

/*! @protocol QRCodeScannerDelegate is notifited durring various stages of the scanning process */
@protocol QRCodeScannerDelegate <NSObject>
@optional

- (void) scanViewControllerDidStartScanning:(QRCodeScanner*) scanner;
- (void) scanViewController:(QRCodeScanner*) scanner didSetLight:(BOOL) lightStatus;
- (void) scanViewController:(QRCodeScanner*) scanner didSuccessfullyScan:(NSString*) aScannedValue;
- (void) scanViewController:(QRCodeScanner*) scanner didTapToFocusOnPoint:(CGPoint) aPoint;
- (void) scanViewControllerDidStopScanning:(QRCodeScanner*) scanner;

@end
