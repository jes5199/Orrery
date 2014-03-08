//
//  POOpenGLView.m
//  Orrery
//
//  Created by Jesse Wolfe on 3/6/14.
//  Copyright (c) 2014 Jesse Wolfe. All rights reserved.
//

#import "POOpenGLView.h"
#import "POPlanet.h"
#import "POMars.h"
#import "POVenus.h"
#import "POMercury.h"


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

static void yellow ()
{
    glColor3f(1.0f, 0.85f, 0.35f);
}

static void sun ()
{
    GLUquadric *quad = gluNewQuadric();
    gluSphere(quad, 0.2, 100, 100);
}

@implementation POOpenGLView

// J2000.0 is January 1, 2000, 11:58:55.816 UTC

- (void) drawSolarSystem
{
    double epoch = [[NSDate dateWithString:@"2000-01-01 11:58:56 +0000"] timeIntervalSince1970];
    double nowish = [[datePicker dateValue] timeIntervalSince1970];
    
    double elapsed_seconds = (nowish - epoch);
    double elapsed_days = elapsed_seconds / 86400;
    double elapsed_years = elapsed_days / 365.25;
    
    POPlanet *mercury = [POMercury new];
    POPlanet *venus = [POVenus new];
    POPlanet *earth = [POPlanet new];
    POPlanet *mars = [POMars new];
    
    glEnableClientState(GL_VERTEX_ARRAY);
    glShadeModel (GL_FLAT);
    
    gluLookAt (0.0, 0.0, 0.0, 0.0, 0.0, -100.0, 0.0, 1.0, 0.0);
    glScalef (1, 1, 1);
    
    glPushMatrix();
    glTranslated(0,0,-2);
    
    glBegin(GL_QUAD_STRIP);
    {
        yellow(); sun();
        [mercury drawForTime:elapsed_years];
        [venus drawForTime:elapsed_years];
        [earth drawForTime:elapsed_years];
        [mars drawForTime:elapsed_years];
    }
    glEnd();
    glPopMatrix();
}



- (void)reshape
{
    int w = [self bounds].size.width;
    int h = [self bounds].size.height;
    int max = w; if(h > max){max = h;}
    int min = w; if(h < min){min = h;}
    
    double zoom = 2;
    
    glViewport (0, 0, (GLsizei) w, (GLsizei) h);
    
    glMatrixMode (GL_PROJECTION);
    glEnable(GL_AUTO_NORMAL);
    glEnable(GL_NORMALIZE);

    glEnable(GL_DEPTH_TEST);
    glDepthFunc (GL_LESS);

    glLoadIdentity ();
    
    // this is the interesting part: center the drawing in the window, expand to fit shorter edge
    //gluOrtho2D ((GLdouble) -w/min, (GLdouble) w/min, (GLdouble)-h/min, (GLdouble) h/min);
    glOrtho((GLdouble) -zoom*w/min, (GLdouble) zoom*w/min, (GLdouble)-zoom*h/min, (GLdouble) zoom*h/min, 1, 10);
    
    //glFrustum((GLdouble) -w/min, (GLdouble) w/min, (GLdouble)-h/min, (GLdouble) h/min, 1, 10);
    // redraw the scene
    [self drawRect:[self bounds]];
}

- (void)drawRect:(NSRect)dirtyRect
{
    glClearColor(0, 0, 0, 0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    [self drawSolarSystem];
    glFlush();
}

@end
