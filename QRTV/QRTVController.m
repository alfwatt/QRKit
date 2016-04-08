#import "QRTVController.h"

@interface QRTVController ()

@end

@implementation QRTVController

- (IBAction) updateQRCode:(id)sender
{
    NSString* userCodeString = [[NSUserDefaults standardUserDefaults] stringForKey:@"QRTVCodeString"];
    self.codeView.codeString = (userCodeString ? userCodeString : @"http://istumbler.net/labs/qrtv.html");
}

#pragma mark - UIView

- (void)viewDidLoad {
    [super viewDidLoad];

    // TODO recoginze a tap and put up a text view
    UITapGestureRecognizer* recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(recognizeTap:)];
    recognizer.allowedPressTypes = @[@(UIPressTypeSelect)];
    [self.codeView addGestureRecognizer:recognizer];

    [self updateQRCode:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UIGestureRecognizers

-  (void) recognizeTap:(UITapGestureRecognizer*) tap
{
    NSLog(@"recognizeTap: %@", tap);
}

@end
