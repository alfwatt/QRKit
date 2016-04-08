#import "iCodeController.h"

@implementation iCodeController

- (IBAction) enterCodeString:(id)sender
{
    self.codeView.codeString = [sender stringValue];
}

@end
