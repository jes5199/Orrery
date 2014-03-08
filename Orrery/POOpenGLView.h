//
//  POOpenGLView.h
//  Orrery
//
//  Created by Jesse Wolfe on 3/6/14.
//  Copyright (c) 2014 Jesse Wolfe. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#include <OpenGL/gl.h>

@interface POOpenGLView : NSOpenGLView {
    IBOutlet id datePicker;
}
-(void) drawSolarSystem;

@end
