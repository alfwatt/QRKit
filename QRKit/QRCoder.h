//
//  QRCodeReader.h
//  QRKit
//
//  Created by alf on 9/22/14.
//  Copyright (c) 2014 iStumbler. All rights reserved.
//

#import <Foundation/Foundation.h>

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#else
#import <AppKit/AppKit.h>
#endif

@interface QRCoder : NSObject

#if TARGET_OS_IPHONE

- (NSString*) stringFromQRCode:(UIImage*) image;
- (UIImage*) QRCodeFromString:(NSString*) url;

#else

- (NSString*) stringFromQRCode:(NSImage*) image;
- (NSImage*) QRCodeFromString:(NSString*) url;

#endif

- (NSString*) srringFromCoreImage:(CGImageRef) image;
- (CGImageRef) imageRefFromString:(NSString*) string;

@end
