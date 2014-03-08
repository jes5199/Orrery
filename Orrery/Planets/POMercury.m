//
//  POMercury.m
//  Orrery
//
//  Created by Jesse Wolfe on 3/7/14.
//  Copyright (c) 2014 Jesse Wolfe. All rights reserved.
//

#import "POMercury.h"
#import "util.h"

@implementation POMercury

- (double) semiMajorAxisAt:(double) centuries
{
    return (0.38709927 + 0.00000037 * centuries); // Astronomical Units
}

- (double) eccentricity:(double) centuries
{
    return 0.20563593 + 0.00001906 * centuries; // radians
}

- (double)inclinationAngle:(double)centuries
{
    return radians(7.00497902 + -0.00594749 * centuries);
}

- (double)meanLongitude:(double)centuries
{
    return radians(252.25032350 + 149472.67411175 * centuries);
}

- (double)longitudeOfPerihelion:(double)centuries
{
    return radians(77.45779628 + 0.16047689 * centuries);
}

- (double)longitudeOfAscendingNode:(double)centuries
{
    return radians(48.33076593 + -0.12534081 * centuries);
}

- (NSArray *)color
{
    return @[@0.85f, @0.85f, @0.75f];
}

@end
