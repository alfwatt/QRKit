#import <AVFoundation/AVFoundation.h>

#import <QRKit/QRDefines.h>

@protocol QRCodeScannerDelegate;

/** @class QRCodeScanner a view which scans for QR coode with an overlay */
@interface QRCodeScanner : UIViewController <AVCaptureMetadataOutputObjectsDelegate>

@property(nonatomic, assign) id<QRCodeScannerDelegate> delegate;
@property(nonatomic, readonly) NSString* decodedString;
@property(nonatomic, readonly) BOOL cameraIsAvailable;
@property(nonatomic, assign) BOOL cameraLightIsOn;

- (id) initWithView:(UIView*) view delegate:(id<QRCodeScannerDelegate>) delegate;

- (IBAction) startScanning:(id) sender;
- (IBAction) stopScanning:(id) sender;

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
