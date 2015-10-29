#include "TargetConditionals.h"

/** Defines for QRKit briding the iOS/MacOS classes */

#ifndef QRDefines_h
#define QRDefines_h

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#define QRView UIView
#define QRImage UIImage
#define QRViewController UIViewController
#else
#import <AppKit/AppKit.h>
#define QRView NSView
#define QRImage NSImage
#define QRViewController NSViewController
#endif

#endif /* QRDefines_h */
