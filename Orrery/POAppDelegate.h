//
//  POAppDelegate.h
//  Orrery
//
//  Created by Jesse Wolfe on 3/6/14.
//  Copyright (c) 2014 Jesse Wolfe. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "POOpenGLView.h"

@interface POAppDelegate : NSObject <NSApplicationDelegate> {
    NSTimer * timer;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet POOpenGLView *glview;
@property (assign) IBOutlet NSDatePicker *datePicker;
@property (assign) IBOutlet NSButton *checkboxNow;
@property (assign) IBOutlet NSPopUpButton *speedBox;

- (void) handleAnimationTimer:(NSTimer*)timer;
- (IBAction) handleDateChange:(NSDatePicker*)picker;
- (IBAction) handleNowChange:(NSButton*)checkbox;
- (IBAction) handleSpeedChange:(NSButton*)speedbox;
- (void)windowWillClose:(NSNotification *)notification;

@end
