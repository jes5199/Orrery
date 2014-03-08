//
//  POAppDelegate.m
//  Orrery
//
//  Created by Jesse Wolfe on 3/6/14.
//  Copyright (c) 2014 Jesse Wolfe. All rights reserved.
//

#import "POAppDelegate.h"

@interface POAppDelegate()
@end
@implementation POAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [NSTimer scheduledTimerWithTimeInterval:0.1
                                     target:self
                                   selector:@selector(handleSecondsTimer:)
                                   userInfo:nil
                                    repeats:YES];

}

- (void) handleSecondsTimer:(NSTimer*)timer
{
    if ([[self checkboxNow] state]) {
        [[self datePicker] setDateValue:[NSDate date]];
    }
    if ([[self checkboxGoFast] state]) {
        NSDate *was = [[self datePicker] dateValue];
        [[self datePicker] setDateValue:[was dateByAddingTimeInterval: 7*60*60*24]];
    }
    [[self glview] setNeedsDisplay:YES];
}

- (IBAction) handleDateChange:(NSDatePicker*)picker{
    [[self checkboxNow] setState:0];
}

- (IBAction) handleGoFastChange:(NSButton*)gofast{
    if ([[self checkboxGoFast] state]) {
        [[self checkboxNow] setState:0];
    }
}


- (IBAction) handleNowChange:(NSButton*)checkbox{
    if ([checkbox state]) {
        [[self datePicker] setDateValue:[NSDate date]];
        [[self checkboxGoFast] setState:0];
    }
}


- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}


@end
