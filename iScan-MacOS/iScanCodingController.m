#import "iScanCodingController.h"

@implementation iScanCodingController

- (IBAction) enterCodeString:(id)sender
{
    self.codeView.codeString = [sender stringValue];
}

@end
