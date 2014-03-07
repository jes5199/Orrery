//
//  POPlanet.h
//  Orrery
//
//  Created by Jesse Wolfe on 3/7/14.
//  Copyright (c) 2014 Jesse Wolfe. All rights reserved.
//

#import <Foundation/Foundation.h>

static double radians(double degrees);

@interface POPlanet : NSObject
- (NSArray*) coordinatesAtTime: (double)elapsed_time;
- (NSArray*) color;
- (void) drawForTime:(double)years;

- (double) semiMajorAxisAt:(double) centuries;
- (double) eccentricity:(double) centuries;
- (double)inclinationAngle:(double)centuries;
- (double)meanLongitude:(double)centuries;
- (double)longitudeOfPerihelion:(double)centuries;
- (double)longitudeOfAscendingNode:(double)centuries;

@end
