#import "QRTVController.h"

@implementation QRTVController

- (IBAction) updateQRCode:(id)sender
{
    NSString* userCodeString = [[NSUserDefaults standardUserDefaults] stringForKey:@"QRTVCodeString"];
    self.codeView.codeString = (userCodeString ? userCodeString : @"http://istumbler.net/labs/qrtv.html");
}

#pragma mark - UIView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateQRCode:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
