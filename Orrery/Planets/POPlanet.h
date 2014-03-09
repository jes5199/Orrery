//
//  POPlanet.h
//  Orrery
//
//  Created by Jesse Wolfe on 3/7/14.
//  Copyright (c) 2014 Jesse Wolfe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface POPlanet : NSObject

- (NSArray*) coordinatesAtTime: (double)elapsed_time;
- (NSArray*) color;
- (void) drawForTime:(double)years atScale:(double)scale;
- (void) drawForTime:(double)years atScale:(double)scale spaceScale:(double)space_scale;
- (void) drawForTime:(double)years atScale:(double)scale moonScale:(double)moon_scale;
- (void) drawForTime:(double)years atScale:(double)scale spaceScale:(double)space_scale moonScale:(double)moon_scale;

- (double) semiMajorAxisAt:(double) centuries;
- (double) eccentricity:(double) centuries;
- (double)inclinationAngle:(double)centuries;
- (double)meanLongitude:(double)centuries;
- (double)longitudeOfPerihelion:(double)centuries;
- (double)longitudeOfAscendingNode:(double)centuries;

@end
