//
//  POOpenGLView.m
//  Orrery
//
//  Created by Jesse Wolfe on 3/6/14.
//  Copyright (c) 2014 Jesse Wolfe. All rights reserved.
//

#import "POOpenGLView.h"
#import <OpenGL/glu.h>


static void drawAnObject ()
{
    glColor3f(1.0f, 0.85f, 0.35f);
    glBegin(GL_TRIANGLES);
    {
        glVertex3f(  0.0,  0.6, 0.0);
        glVertex3f( -0.2, -0.3, 0.0);
        glVertex3f(  0.2, -0.3 ,0.0);
    }
    glEnd();
}

static void sphere(GLdouble x, GLdouble y, GLdouble radius)
{
    GLUquadric *quad = gluNewQuadric();
    gluSphere(quad, radius, 100, 100);
}

static void yellow ()
{
    glColor3f(1.0f, 0.85f, 0.35f);
}

static void blue ()
{
    glColor3f(0.0f, 0.85f, 0.85f);
}

static void sun ()
{
    sphere( 5.0, 20.0, 0.2);
}


static void drawSolarSystem ()
{
    yellow();
    sun();
    blue();
    //earth();
}

@implementation POOpenGLView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


- (void)drawRect:(NSRect)dirtyRect
{
    glClearColor(0, 0, 0, 0);
    glClear(GL_COLOR_BUFFER_BIT);
    drawSolarSystem();
    glFlush();
}

@end
