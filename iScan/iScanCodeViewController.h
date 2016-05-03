#import <UIKit/UIKit.h>
#import <QRKit/QRKit.h>

@interface iScanCodeViewController : UIViewController <UITextFieldDelegate>
@property(nonatomic, assign) IBOutlet UITextField* codeText;
@property(nonatomic, assign) IBOutlet QRCodeView* codeView;

@end
