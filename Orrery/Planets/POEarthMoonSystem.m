//
//  POEarthMoonSystem.m
//  Orrery
//
//  Created by Jesse Wolfe on 3/8/14.
//  Copyright (c) 2014 Jesse Wolfe. All rights reserved.
//

#import "POEarthMoonSystem.h"
#import "POMoon.h"

@implementation POEarthMoonSystem

- (id) init
{
    self = [super init];
    self->moon = [POMoon new];
    self->earth = [POPlanet new];
    return self;
}

- (void) drawForTime:(double)years atScale:(double)scale spaceScale:(double)space_scale moonScale:(double)moon_scale
{
    [earth drawForTime:years atScale:scale spaceScale:space_scale moonScale:moon_scale];
    
    glPushMatrix();
    
    NSArray *coordinates = [self coordinatesAtTime:years];
    
    double x = [[coordinates objectAtIndex:0] doubleValue] * space_scale;
    double y = [[coordinates objectAtIndex:1] doubleValue] * space_scale;
    double z = [[coordinates objectAtIndex:2] doubleValue] * space_scale;
    
    glTranslated(x, y, z); // translate to earth-moon barycenter
    [moon drawForTime:years atScale:scale spaceScale:moon_scale];

    glPopMatrix();

}

@end
