//
//  iScanCameraViewController.m
//  QRKit
//
//  Created by Alf Watt on 5/3/16.
//  Copyright © 2016 iStumbler. All rights reserved.
//

#import "iScanCameraViewController.h"

@interface iScanCameraViewController ()

@end

@implementation iScanCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scanText.text = @"Setting up Camera";
    self.scanner = [[QRCodeScanner alloc] initWithNibName:nil bundle:[NSBundle mainBundle]];
    self.scanner.delegate = self;
    self.scanner.view = self.scanView;
    if (self.scanner.isCameraAvailable) {
        [self.scanner viewDidLoad];
        [self.scanner startScanning];
        self.scanText.text = @"Scanning";
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

- (void) scanViewController:(QRCodeScanner*) scanner didSuccessfullyScan:(NSString *) aScannedValue
{
    NSLog(@"scanViewController:didSuccessfullyScan: %@", aScannedValue);
    self.scanText.text = aScannedValue;

}

- (void) scanViewController:(QRCodeScanner*) scanner didTapToFocusOnPoint:(CGPoint) aPoint
{
    NSLog(@"scanViewController:didTapToFocusOnPoint: %@", NSStringFromCGPoint(aPoint));
}


@end
