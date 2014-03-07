//
//  POAppDelegate.m
//  Orrery
//
//  Created by Jesse Wolfe on 3/6/14.
//  Copyright (c) 2014 Jesse Wolfe. All rights reserved.
//

#import "POAppDelegate.h"
#include "POMasterViewController.h"

@interface POAppDelegate()
@property (nonatomic,strong) IBOutlet POMasterViewController *masterViewController;
@end
@implementation POAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.masterViewController = [[POMasterViewController alloc] initWithNibName:@"POMasterViewController" bundle:nil];
    [self.window.contentView addSubview:self.masterViewController.view];
    self.masterViewController.view.frame = ((NSView*)self.window.contentView).bounds;
}

@end
