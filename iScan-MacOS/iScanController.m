#import "iScanController.h"

@implementation iScanController

- (IBAction) enterCodeString:(id)sender
{
    self.codeView.codeString = [sender stringValue];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setRepresentedObject:(id)representedObject
{
    [super setRepresentedObject:representedObject];
}

@end
