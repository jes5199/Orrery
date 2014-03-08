//
//  POMars.m
//  Orrery
//
//  Created by Jesse Wolfe on 3/7/14.
//  Copyright (c) 2014 Jesse Wolfe. All rights reserved.
//

#import "POMars.h"
#import "util.h"

@implementation POMars
- (double) semiMajorAxisAt:(double) centuries
{
    return (1.52371034 + 0.00001847 * centuries); // Astronomical Units
}

- (double) eccentricity:(double) centuries
{
    return 0.09339410 + -0.00007882 * centuries; // radians
}

- (double)inclinationAngle:(double)centuries
{
    return radians(1.84969142 + -0.00813131 * centuries);
}

- (double)meanLongitude:(double)centuries
{
    return radians(-4.55343205 + 19140.30268499 * centuries);
}

- (double)longitudeOfPerihelion:(double)centuries
{
    return radians(-23.94362959 +  0.44441088 * centuries);
}

- (double)longitudeOfAscendingNode:(double)centuries
{
    return radians(49.55953891 +  -0.29257343 * centuries);
}

- (NSArray *)color
{
    return @[@1.0f, @0.05f, @0.05f];
}


- (double) meanRadius
{
    return 3390.0;
}


@end
