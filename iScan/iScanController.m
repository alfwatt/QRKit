//
//  ViewController.m
//  iScan
//
//  Created by Alf Watt on 10/28/15.
//  Copyright © 2015 iStumbler. All rights reserved.
//

#import "iScanController.h"

@implementation iScanController

- (IBAction) enterCodeString:(id)sender
{
    self.codeView.codeString = [sender stringValue];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
