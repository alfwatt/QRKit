//
//  ViewController.h
//  iScan
//
//  Created by Alf Watt on 10/28/15.
//  Copyright © 2015 iStumbler. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QRKit/QRKit.h>

@interface iScanController : NSViewController
@property(nonatomic,weak) IBOutlet QRCodeView* codeView;

- (IBAction) enterCodeString:(id)sender;

@end

