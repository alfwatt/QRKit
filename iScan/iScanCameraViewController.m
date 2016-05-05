#import "iScanCameraViewController.h"

@interface iScanCameraViewController ()

@end

@implementation iScanCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scanText.text = @"Setting up Camera";
    self.scanner = [[QRCodeScanner alloc] initWithView:self.scanView delegate:self];
    if (self.scanner.cameraIsAvailable) {
        [self.scanner startScanning:self];
    }
    else {
        NSLog(@"No camera: %@", self.scanner);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -

- (void) scanViewControllerDidStartScanning:(QRCodeScanner*) scanner
{
    NSLog(@"scanViewControllerDidStartScanning: %@", scanner);
    self.scanText.text = @"Scanning";
}

- (void) scanViewController:(QRCodeScanner*) scanner didSetLight:(BOOL) lightStatus
{
    NSLog(@"scanViewController:didSetLight: %@", (lightStatus ? @"On" : @"Off"));
    self.scanText.text = [NSString stringWithFormat:@"Light: %@", (lightStatus ? @"On" : @"Off")];
}

- (void) scanViewController:(QRCodeScanner*) scanner didSuccessfullyScan:(NSString *) aScannedValue
{
    NSLog(@"scanViewController:didSuccessfullyScan: %@", aScannedValue);
    self.scanText.text = aScannedValue;
}

- (void) scanViewController:(QRCodeScanner*) scanner didTapToFocusOnPoint:(CGPoint) aPoint
{
    NSLog(@"scanViewController:didTapToFocusOnPoint: %@", NSStringFromCGPoint(aPoint));
    self.scanText.text = [NSString stringWithFormat:@"Focus: %@", NSStringFromCGPoint(aPoint)];
}

- (void) scanViewControllerDidStopScanning:(QRCodeScanner*) scanner
{
    NSLog(@"scanViewControllerDidStopScanning: %@", scanner);
    self.scanText.text = @"Stopped";
}

@end
