#import "iCodeController.h"

@implementation iCodeController

- (void) awakeFromNib
{
    self.codeView.codeColor = [[QRColor orangeColor] shadowWithLevel:0.25];
}

- (IBAction) enterCodeString:(id)sender
{
    self.codeView.codeString = [sender stringValue];
}

- (IBAction) saveDocument:(id)sender
{
    if (self.codeView.codeString) {
        NSImage* codeImage = self.codeView.codeImage;
        NSData* tiffData = [codeImage TIFFRepresentation];
        NSString* imagePath = [@"~/Desktop/QR-Code.tiff" stringByExpandingTildeInPath]; // TODO Save Panel
        [tiffData writeToFile:imagePath atomically:YES];
    }
    else {
        NSBeep();
    }
}

@end
