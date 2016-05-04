
# QRKit.framework

An iOS, MacOS and tvOS Framework providing Views and Controlers for displaying and scanning QRCodes

## Quick Start

Import the QRKit.framework into your App:

    #import <QRKit/QRKit.h>

To display a QRCode on iOS, MacOS or tvOS use QRCodeView, avaliable for both AppKit and UIKit:

    @class MyController : QRViewController
    @property(nonatomic,assign) IBOutlet QRCodeView* codeView;
    @end

---

    @implementation MyController

    - (void) viewDidLoad
    {
        self.codeView.codString = @"QRKit";
    }

    @end

To scan a QR Code on iOS use QRCodeScanner, avaliable for UIKit:

    @class MyScanner : UIViewControer <QRCodeScannerDelegate>
    @property(nonatomic, retain) QRCodeScanner* scanner;
    @property(nonatomic, assingn) IBOutlet UIView* scanView;
    
    @end
    
---
    
    @implementation MyScanner
    
    - (void) viewDidLoad
    {
        self.scaner = [[QRCodeScanner alloc] initWithView:self.scanView delegate:self]];
        [self.scanner startScanning];
    }
    
    #pragma mark - QRCodeScannerDelegate
    
    - (void) scanViewController:(QRCodeScanner*) scanner didSuccessfullyScan:(NSString*) aScannedValue
    {
        NSLog(@"scanned: %@", aScannedValue):
    }

    @end


## License

    The MIT License (MIT)

    Copyright (c) 2014-2016 Alf Watt

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
