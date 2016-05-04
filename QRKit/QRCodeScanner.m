#import "QRCodeScanner.h"
#import "QRCoder.h"

@interface QRCodeScanner ()

@property(nonatomic, retain) NSString* decodedStringStorage;
@property(nonatomic, retain) AVCaptureDevice* device;
@property(nonatomic, retain) AVCaptureDeviceInput* input;
@property(nonatomic, retain) AVCaptureSession* session;
@property(nonatomic, retain) AVCaptureVideoPreviewLayer* preview;
@property(nonatomic, retain) AVCaptureMetadataOutput* output;

- (void) initView;
- (void) updatePreviewFrameAndOrientation;

@end

@implementation QRCodeScanner

#pragma mark - Properties

- (NSString*) decodedString
{
    return self.decodedStringStorage;
}

- (BOOL) cameraIsAvailable
{
    NSArray *videoDevices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    return [videoDevices count] > 0;
}

- (BOOL) cameraLightIsOn
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    return (device.torchMode == AVCaptureTorchModeOn);
}

- (void) setCameraLightIsOn:(BOOL) aStatus
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    [device lockForConfiguration:nil];
    if ( [device hasTorch] ) {
        if ( aStatus ) {
            [device setTorchMode:AVCaptureTorchModeOn];
        } else {
            [device setTorchMode:AVCaptureTorchModeOff];
        }
    }
    [device unlockForConfiguration];

    if ([self.delegate respondsToSelector:@selector(scanViewController:didSetLight:)]) {
        [self.delegate scanViewController:self didSetLight:self.cameraLightIsOn];
    }
}

#pragma mark - Initilizers


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self initView];
    }

    return self;
}

- (id) initWithView:(UIView*) view delegate:(id<QRCodeScannerDelegate>) delegate
{
    if (self = [super initWithNibName:nil bundle:[NSBundle bundleForClass:[self class]]]) {
        self.view = view;
        self.delegate = delegate;
        [self initView];
    }

    return self;
}

#pragma mark - Private Methods

- (void) initView
{
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    self.session = [[AVCaptureSession alloc] init];
    
    self.output = [[AVCaptureMetadataOutput alloc] init];
    [self.session addOutput:self.output];
    [self.session addInput:self.input];
    
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    self.output.metadataObjectTypes = @[
        AVMetadataObjectTypeUPCECode,
        AVMetadataObjectTypeCode39Code,
        AVMetadataObjectTypeCode39Mod43Code,
        AVMetadataObjectTypeEAN13Code,
        AVMetadataObjectTypeEAN8Code,
        AVMetadataObjectTypeCode93Code,
        AVMetadataObjectTypeCode128Code,
        AVMetadataObjectTypePDF417Code,
        AVMetadataObjectTypeQRCode,
        AVMetadataObjectTypeAztecCode,
        AVMetadataObjectTypeInterleaved2of5Code,
        AVMetadataObjectTypeITF14Code,
        AVMetadataObjectTypeDataMatrixCode];
    
    self.preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self updatePreviewFrameAndOrientation];
    [self.view.layer insertSublayer:self.preview atIndex:0];

    UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleFocusTap:)];
    tapRecognizer.numberOfTapsRequired = 1;
    tapRecognizer.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tapRecognizer];

    UITapGestureRecognizer* twoFinderTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleLightTap:)];
    twoFinderTapRecognizer.numberOfTapsRequired = 1;
    twoFinderTapRecognizer.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer:twoFinderTapRecognizer];
}

- (void) updatePreviewFrameAndOrientation
{
    self.preview.frame = self.view.frame;

    AVCaptureVideoOrientation captureOrientation = AVCaptureVideoOrientationPortrait;

    switch ([UIDevice currentDevice].orientation) {
        case UIDeviceOrientationPortraitUpsideDown:
            captureOrientation = AVCaptureVideoOrientationPortraitUpsideDown;
            break;
        case UIDeviceOrientationLandscapeLeft:
            captureOrientation = AVCaptureVideoOrientationLandscapeRight;
            break;
        case UIDeviceOrientationLandscapeRight:
            captureOrientation = AVCaptureVideoOrientationLandscapeLeft;
            break;
        case UIDeviceOrientationUnknown:
        case UIDeviceOrientationPortrait:
        case UIDeviceOrientationFaceUp:
        case UIDeviceOrientationFaceDown:
        default:
            captureOrientation = AVCaptureVideoOrientationPortrait;
            break;
    }

    self.preview.connection.videoOrientation = captureOrientation;
}

- (void) focus:(CGPoint) aPoint
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if([device isFocusPointOfInterestSupported] &&
       [device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        double screenWidth = screenRect.size.width;
        double screenHeight = screenRect.size.height;
        double focus_x = aPoint.x/screenWidth;
        double focus_y = aPoint.y/screenHeight;
        if([device lockForConfiguration:nil]) {
            if([self.delegate respondsToSelector:@selector(scanViewController:didTapToFocusOnPoint:)]) {
                [self.delegate scanViewController:self didTapToFocusOnPoint:aPoint];
            }
            [device setFocusPointOfInterest:CGPointMake(focus_x,focus_y)];
            [device setFocusMode:AVCaptureFocusModeAutoFocus];
            if ([device isExposureModeSupported:AVCaptureExposureModeAutoExpose]){
                [device setExposureMode:AVCaptureExposureModeAutoExpose];
            }
            [device unlockForConfiguration];
        }
    }
}

#pragma mark - Public Methods

- (void)startScanning;
{
    [self.session startRunning];
    if ([self.delegate respondsToSelector:@selector(scanViewControllerDidStartScanning:)]) {
        [self.delegate scanViewControllerDidStartScanning:self];
    }
}

- (void) stopScanning;
{
    [self.session stopRunning];
    if ([self.delegate respondsToSelector:@selector(scanViewControllerDidStartScanning:)]) {
        [self.delegate scanViewControllerDidStartScanning:self];
    }
}

#pragma mark - UIView

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self updatePreviewFrameAndOrientation];
}

#pragma mark - UIGestureRecognizers

- (void) handleFocusTap:(UITapGestureRecognizer*) tap
{
    [self focus:[tap locationInView:self.view]];
}

- (void) handleLightTap:(UITapGestureRecognizer*) tap
{
    self.cameraLightIsOn = !(self.cameraLightIsOn); // toggle the torch
}

#pragma mark - NoCamAvailable

- (void) setupNoCameraView
{
    UILabel *labelNoCam = [[UILabel alloc] init];
    labelNoCam.text = @"No Camera available";
    labelNoCam.textColor = [UIColor blackColor];
    [self.view addSubview:labelNoCam];
    [labelNoCam sizeToFit];
    labelNoCam.center = self.view.center;
}

#pragma mark -
#pragma mark AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects
       fromConnection:(AVCaptureConnection *)connection
{
    for(AVMetadataObject *current in metadataObjects) {
        if([current isKindOfClass:[AVMetadataMachineReadableCodeObject class]]) {
            if([self.delegate respondsToSelector:@selector(scanViewController:didSuccessfullyScan:)]) {
                NSString *scannedValue = [((AVMetadataMachineReadableCodeObject *) current) stringValue];
                if (![scannedValue isEqualToString:self.decodedString]) { // only notify once
                    self.decodedStringStorage = scannedValue;
                    [self.delegate scanViewController:self didSuccessfullyScan:scannedValue];
                }
            }
        }
    }
}

@end
