#import <Cocoa/Cocoa.h>
#import <QRKit/QRKit.h>

@interface iScanCodingController : NSViewController
@property(nonatomic,weak) IBOutlet QRCodeView* codeView;

- (IBAction) enterCodeString:(id)sender;

@end
