#import <UIKit/UIKit.h>
#import <QRKit/QRKit.h>

@interface iScanCameraViewController : UIViewController <QRCodeScannerDelegate>
@property(nonatomic, retain) QRCodeScanner* scanner;
@property(nonatomic, assign) IBOutlet UILabel* scanText;
@property(nonatomic, assign) IBOutlet UIView* scanView;

@end
