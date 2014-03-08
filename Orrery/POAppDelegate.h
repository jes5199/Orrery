//
//  POAppDelegate.h
//  Orrery
//
//  Created by Jesse Wolfe on 3/6/14.
//  Copyright (c) 2014 Jesse Wolfe. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "POOpenGLView.h"

@interface POAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet POOpenGLView *glview;
@property (assign) IBOutlet NSDatePicker *datePicker;
@property (assign) IBOutlet NSButton *checkboxNow;
@property (assign) IBOutlet NSButton *checkboxGoFast;

- (void) handleSecondsTimer:(NSTimer*)timer;
- (IBAction) handleDateChange:(NSDatePicker*)picker;
- (IBAction) handleNowChange:(NSButton*)checkbox;
- (IBAction) handleGoFastChange:(NSButton*)gofast;

@end
