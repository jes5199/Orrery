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

static double newton_calculate_eccentric_anomaly_with_guess(double mean_anomaly, double eccentricity, double guess, int tries){
    // we must approximate numerically:
    // mean_anomaly = eccentric_anomaly - eccentricity * sin(eccentric_anomaly);
    
    // this is basically newton's method: http://en.wikipedia.org/wiki/Newton%27s_method
    double error = guess - eccentricity * sin(mean_anomaly) - mean_anomaly; // ideally this is zero
    double derivative_error = 1.0-eccentricity * cos(guess); // derivative of above formula
    double new_guess = error - error/derivative_error; // Newton's approxmiation of a better guess
    
    if(tries > 0){
        return newton_calculate_eccentric_anomaly_with_guess(mean_anomaly, eccentricity, new_guess, tries - 1);
    } else {
        return new_guess;
    }
}

static double newton_calculate_eccentric_anomaly(double mean_anomaly, double eccentricity){
    double guess = (eccentricity<0.8) ? mean_anomaly : M_PI; // some random internet person suggested this
    return newton_calculate_eccentric_anomaly_with_guess(mean_anomaly, eccentricity, guess, 100);
}


static void earth ()
{
    // TODO: planet class
    double period = 1; // years
    double eccentricity = 0.0167;
    double elapsed_time = 0; // years ; FIXME: calculate this from actual date parameter
    double mean_anomaly = 2 * M_PI * elapsed_time / period;
    double eccentric_anomaly = newton_calculate_eccentric_anomaly(mean_anomaly, eccentricity);
    
    glPushMatrix();
    glTranslated(0.2,0,0);
    sphere( 0.5, 0.5, 0.15);
    glPopMatrix();
}


static void drawSolarSystem ()
{
    glEnableClientState(GL_VERTEX_ARRAY);
    glShadeModel (GL_FLAT);
    
    gluLookAt (0.0, 0.0, 0.0, 0.0, 0.0, -100.0, 0.0, 1.0, 0.0);
    glScalef (1.0, 1.0, 1.0);
    
    glPushMatrix();
    glTranslated(0,0,-2);
    
    glBegin(GL_QUAD_STRIP);
    {
        yellow();
        sun();
        blue();
        earth();
    }
    glEnd();
    glPopMatrix();
}


@implementation POOpenGLView

- (void)reshape
{
    int w = [self bounds].size.width;
    int h = [self bounds].size.height;
    int max = w; if(h > max){max = h;}
    int min = w; if(h < min){min = h;}
    glViewport (0, 0, (GLsizei) w, (GLsizei) h);
    
    glMatrixMode (GL_PROJECTION);
    glEnable(GL_AUTO_NORMAL);
    glEnable(GL_NORMALIZE);

    glEnable(GL_DEPTH_TEST);
    glDepthFunc (GL_LESS);

    glLoadIdentity ();
    
    // this is the interesting part: center the drawing in the window, expand to fit shorter edge
    //gluOrtho2D ((GLdouble) -w/min, (GLdouble) w/min, (GLdouble)-h/min, (GLdouble) h/min);
    glOrtho((GLdouble) -w/min, (GLdouble) w/min, (GLdouble)-h/min, (GLdouble) h/min, 1, 10);
    
    //glFrustum((GLdouble) -w/min, (GLdouble) w/min, (GLdouble)-h/min, (GLdouble) h/min, 1, 10);
    // redraw the scene
    [self drawRect:[self bounds]];
}

- (void)drawRect:(NSRect)dirtyRect
{
    glClearColor(0, 0, 0, 0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    drawSolarSystem();
    glFlush();
}

@end
