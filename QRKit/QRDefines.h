#include <TargetConditionals.h>

/** Defines for QRKit briding the iOS/MacOS classes */

#ifndef QRDefines_h
#define QRDefines_h

#if TARGET_OS_WATCH
#import <WatchKit/WatchKit.h>
#define QRView WKInterfaceImage
#define QRImage WKImage

#elif TARGET_OS_IPHONE || TARGET_OS_TV
#import <UIKit/UIKit.h>
#define QRView UIView
#define QRImage UIImage
#define QRViewController UIViewController

#elif TARGET_OS_MAC
#import <AppKit/AppKit.h>
#define QRView NSView
#define QRImage NSImage
#define QRViewController NSViewController

#endif

#endif /* QRDefines_h */
