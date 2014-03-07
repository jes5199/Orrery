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
    sphere( 0, 0, 0.2);
}

static void earth ()
{
    sphere( 0.5, 0.5, 0.1);
}


static void drawSolarSystem ()
{
    glBegin(GL_QUAD_STRIP);
    {
        yellow();
        sun();
        blue();
        earth();
    }
    glEnd();
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

- (void)reshape
{
    int w = [self bounds].size.width;
    int h = [self bounds].size.height;
    int max = w; if(h > max){max = h;}
    int min = w; if(h < min){min = h;}
    glViewport (0, 0, (GLsizei) w, (GLsizei) h);
    
    glMatrixMode (GL_PROJECTION);
    glLoadIdentity ();
    
    // this is the interesting part: center the drawing in the window, expand to fit shorter edge
    gluOrtho2D ((GLdouble) -w/min, (GLdouble) w/min, (GLdouble)-h/min, (GLdouble) h/min);
    
    // redraw the scene
    [self drawRect:[self bounds]];
}

- (void)drawRect:(NSRect)dirtyRect
{
    glClearColor(0, 0, 0, 0);
    glClear(GL_COLOR_BUFFER_BIT);
    drawSolarSystem();
    glFlush();
}

@end
