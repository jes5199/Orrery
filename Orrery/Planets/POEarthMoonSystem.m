//
//  POEarthMoonSystem.m
//  Orrery
//
//  Created by Jesse Wolfe on 3/8/14.
//  Copyright (c) 2014 Jesse Wolfe. All rights reserved.
//

#import "POEarthMoonSystem.h"
#import "POMoon.h"
#import "POEarth.h"

@implementation POEarthMoonSystem

- (id) init
{
    self = [super init];
    self->moon = [POMoon new];
    self->earth = [POEarth new];
    return self;
}

- (void) drawForTime:(double)years atScale:(double)scale spaceScale:(double)space_scale moonScale:(double)moon_scale
{
    // FIXME: Earth should actually be offset slightly to the other side of the barycenter
    
    glPushMatrix();
    
    // I'm relying on the default implementation of POPlanet
    // which uses the Earth-Moon barycenter's kepler values 
    NSArray *coordinates = [self coordinatesAtTime:years];
    
    double x = [[coordinates objectAtIndex:0] doubleValue] * space_scale;
    double y = [[coordinates objectAtIndex:1] doubleValue] * space_scale;
    double z = [[coordinates objectAtIndex:2] doubleValue] * space_scale;
    
    glTranslated(x, y, z); // translate to earth-moon barycenter
    
    [earth drawForTime:years atScale:scale spaceScale:moon_scale];
    [moon drawForTime:years atScale:scale spaceScale:moon_scale];

    glPopMatrix();

}

@end
