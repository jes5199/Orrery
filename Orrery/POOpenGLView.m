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

static void sun (double scale)
{
    // the sun glows yellow
    GLfloat color[] = { 1.0, 0.85, 0.35, 1.0 };
    glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION, color);
    
    // the sun is yellow anyway
    glColor3f(1.0f, 0.85f, 0.35f);

    // the sun is a big sphere
    GLUquadric *quad = gluNewQuadric();
    double radius = 696000.0 / (149597871.0/scale);
    gluSphere(quad, radius, 100, 100);
    
    // the sun casts light on the planets
    GLfloat light_position[] = { 0.0, 0.0, 0.0, 1.0 };
    glLightfv(GL_LIGHT0, GL_POSITION, light_position);
    
    // don't leak the emission setting
    GLfloat black[] = { 0.0, 0.0, 0.0, 1.0 };
    glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION, black);
}

int animateTowardDesiredScale(int scale, int desired_scale){
    if (scale < desired_scale) {
        scale += desired_scale / 10;
    } else if (scale > desired_scale){
        scale -= scale / 10;
        scale -= 1;
        if(scale < desired_scale){ scale = desired_scale; };
    }

    return scale;
}

@implementation POOpenGLView

- (void) drawSolarSystem
{
    static int tilt = 0;
    static int sun_scale = 50;
    static int planet_scale = 50;
    double epoch = [[NSDate dateWithString:@"2000-01-01 11:58:56 +0000"] timeIntervalSince1970];
    double nowish = [[datePicker dateValue] timeIntervalSince1970];
    
    double elapsed_seconds = (nowish - epoch);
    double elapsed_days = elapsed_seconds / 86400;
    double elapsed_years = elapsed_days / 365.25;
    
    POPlanet *mercury = [POMercury new];
    POPlanet *venus = [POVenus new];
    POPlanet *earth = [POPlanet new];
    POPlanet *mars = [POMars new];
    NSArray *planets = @[ mercury, venus, earth, mars ];
    
    glEnableClientState(GL_VERTEX_ARRAY);
    glShadeModel (GL_FLAT);

    gluLookAt (0.0, 0.0, 0.0, 0.0, 0.0, -100.0, 0.0, 1.0, 0.0);
    glScalef (1, 1, 1);

    glPushMatrix();
    
    glTranslated(0,0,-80);

    int target_tilt = 0;
    if( [[[popup selectedItem] title] isEqualToString:@"Side"] ){
        target_tilt = 90;
    }
    if(target_tilt > tilt){
        tilt += 5;
    }
    if(target_tilt < tilt){
        tilt -= 5;
    }
    glRotated(tilt,1,0,0);
    

    sun_scale = animateTowardDesiredScale(sun_scale, [[sunZoomPicker selectedItem] tag]);
    planet_scale = animateTowardDesiredScale(planet_scale, [[planetZoomPicker selectedItem] tag]);

    sun(sun_scale);
    
    for (POPlanet* planet in planets){
        [planet drawForTime:elapsed_years atScale:planet_scale];
    }    

    glPopMatrix();
    

}



- (void)reshape
{
    int w = [self bounds].size.width;
    int h = [self bounds].size.height;
    int max = w; if(h > max){max = h;}
    int min = w; if(h < min){min = h;}
    
    double zoom = 1.7;
    
    glViewport (0, 0, (GLsizei) w, (GLsizei) h);
    
    glEnable(GL_AUTO_NORMAL);
    glEnable(GL_NORMALIZE);
    glEnable(GL_COLOR_MATERIAL);
    glShadeModel (GL_SMOOTH);
    
    glEnable(GL_DEPTH_TEST);
    glDepthFunc (GL_LESS);

    glMatrixMode (GL_PROJECTION);
    glLoadIdentity ();
    // this is the interesting part: center the drawing in the window, expand to fit shorter edge
    glOrtho((GLdouble) -zoom*w/min, (GLdouble) zoom*w/min, (GLdouble)-zoom*h/min, (GLdouble) zoom*h/min, 1, 100);

    glMatrixMode (GL_MODELVIEW);
    glLoadIdentity ();

    glEnable(GL_LIGHTING);
    glEnable(GL_LIGHT0);
    

}

- (void)drawRect:(NSRect)dirtyRect
{
    glClearColor(0, 0, 0, 0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    [self drawSolarSystem];
    glFlush();
}

@end
