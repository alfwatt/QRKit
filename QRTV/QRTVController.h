#import <UIKit/UIKit.h>
#import <QRKit/QRKit.h>

@interface QRTVController : UIViewController

@property (nonatomic, assign) IBOutlet QRCodeView* codeView;

- (IBAction) updateQRCode:(id)sender;

@end

