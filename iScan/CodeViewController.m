#import "CodeViewController.h"

@interface CodeViewController ()

@end

@implementation CodeViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) enterCodeString:(id)sender
{
    [self.textView resignFirstResponder];
    self.codeView.codeString = self.textView.text;
}

#pragma mark - UITextViewDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void) textViewDidEndEditing:(UITextView*) sender
{
    self.codeView.codeString = self.textView.text;
}

@end
