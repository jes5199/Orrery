//
//  POVenus.m
//  Orrery
//
//  Created by Jesse Wolfe on 3/7/14.
//  Copyright (c) 2014 Jesse Wolfe. All rights reserved.
//

#import "POVenus.h"
#import "util.h"

@implementation POVenus
- (double) semiMajorAxisAt:(double) centuries
{
    return (0.72333566 + 0.00000390 * centuries); // Astronomical Units
}

- (double) eccentricity:(double) centuries
{
    return 0.00677672 + -0.00004107 * centuries; // radians
}

- (double)inclinationAngle:(double)centuries
{
    return radians(3.39467605 + -0.00078890 * centuries);
}

- (double)meanLongitude:(double)centuries
{
    return radians(181.97909950 + 58517.81538729 * centuries);
}

- (double)longitudeOfPerihelion:(double)centuries
{
    return radians(131.60246718 + 0.00268329 * centuries);
}

- (double)longitudeOfAscendingNode:(double)centuries
{
    return radians(76.67984255 + -0.27769418 * centuries);
}

- (NSArray *)color
{
    return @[@0.5f, @0.85f, @0.05f];
}

- (double) meanRadius
{
    return 6051.8;
}


@end
