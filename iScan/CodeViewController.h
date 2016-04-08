#import <UIKit/UIKit.h>
#import <QRKit/QRKit.h>

@interface CodeViewController : UIViewController <UITextViewDelegate>
@property(nonatomic,assign) IBOutlet UITextField* textView;
@property(nonatomic,assign) IBOutlet QRCodeView* codeView;

- (IBAction) enterCodeString:(id)sender;

@end
