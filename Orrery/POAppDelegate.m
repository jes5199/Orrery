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
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                     target:self
                                     selector:@selector(handleAnimationTimer:)
                                     userInfo:nil
                                     repeats:YES];

}

- (void) handleAnimationTimer:(NSTimer*)timer
{
    if ([[self checkboxNow] state]) {
        [[self datePicker] setDateValue:[NSDate date]];
        
    } else if([[self speedBox] indexOfSelectedItem]){
        NSDate *old_time = [[self datePicker] dateValue];
        NSDate *new_time;
        
        switch([[self speedBox] indexOfSelectedItem]){
            case 1:new_time = [old_time dateByAddingTimeInterval: 0.1]; break;
            case 2:new_time = [old_time dateByAddingTimeInterval: 60*60*0.1]; break;
            case 3:new_time = [old_time dateByAddingTimeInterval: 60*60*24*0.1]; break;
            case 4:new_time = [old_time dateByAddingTimeInterval: 60*60*24*7*0.1]; break;
        }
        [[self datePicker] setDateValue:new_time];

    }
    [[self glview] setNeedsDisplay:YES];
}

- (IBAction) handleDateChange:(NSDatePicker*)picker{
    [[self checkboxNow] setState:0];
}

- (IBAction) handleSpeedChange:(NSButton*)gofast{
    [[self checkboxNow] setState:0];
}


- (IBAction) handleNowChange:(NSButton*)checkbox{
    if ([checkbox state]) {
        [[self datePicker] setDateValue:[NSDate date]];
        [[self speedBox] selectItemAtIndex:1];
    } else {
        [[self speedBox] selectItemAtIndex:0];
    }
}

- (void)windowWillClose:(NSNotification *)notification
{
    [timer invalidate];
    timer = nil;
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}



@end
