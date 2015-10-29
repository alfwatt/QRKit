
# QRKit

An iOS and MacOS Framework providing Utilites and Views for displaying and scanning QRCodes

## Quick Start

Import the QRKit.framework into your App

    #import <QRKit/QRKit.h>

To display a QRCode use QRCodeView, avaliable for both AppKit and UIKit

    @class MyController : (NS|UI)ViewController
    @property(nonatomic,assign) IBOutlet QRCodeView* codeView;
    @end

---

    @implementation MyController

    - (instancetype) initWithFrame:(CGRect) frame
    {
        self.codeView = @"QRKit";
    }

    @end

TODO QRCodeScanner
