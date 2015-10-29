#import <Cocoa/Cocoa.h>
#import <QRKit/QRKit.h>

@interface iScanController : NSViewController
@property(nonatomic,weak) IBOutlet QRCodeView* codeView;

- (IBAction) enterCodeString:(id)sender;

@end

