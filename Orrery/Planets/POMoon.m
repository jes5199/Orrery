//
//  POMoon.m
//  Orrery
//
//  Created by Jesse Wolfe on 3/8/14.
//  Copyright (c) 2014 Jesse Wolfe. All rights reserved.
//

#import "POMoon.h"
#import "util.h"

@implementation POMoon

- (NSArray*) coordinatesAtTime: (double)elapsed_time
{
    // based on http://caps.gsfc.nasa.gov/simpson/pubs/slunar.pdf
    // which is based on the Astronomical Almanac from the US Navy
    
    // Apparently this approximates a 3-body solution for the motion of the Moon
    // in the Moon-Earth-Sun system
    // but man it sure is opaque.
    
    double centuries = elapsed_time / 100.0;
    
    
    double ecliptic_longitude = radians(
                                        218.32 + 481267.881 * centuries
                                        + 6.29 * dsin(135.0 + 477198.87 * centuries)
                                        - 1.27 * dsin(259.3 - 413335.36 * centuries)
                                        + 0.66 * dsin(235.7 + 890534.22 * centuries)
                                        + 0.21 * dsin(269.9 + 954397.74 * centuries)
                                        - 0.19 * dsin(357.5 +  35999.05 * centuries)
                                        - 0.11 * dsin(186.5 + 966404.03 * centuries)
                                        );
    double ecliptic_latitude = radians(
                                       + 5.13 * dsin( 93.3 + 483202.03 * centuries)
                                       + 0.28 * dsin(228.2 + 960400.89 * centuries)
                                       - 0.28 * dsin(318.3 +   6003.15 * centuries)
                                       - 0.17 * dsin(217.6 - 407332.21 * centuries)
                                       );
    
    double horizontal_parallax = radians(
                                         + 0.9508
                                         + 0.0518 * dcos(135.0 + 477198.87 * centuries)
                                         + 0.0095 * dcos(259.3 - 413335.36 * centuries)
                                         + 0.0078 * dcos(235.7 + 890534.22 * centuries)
                                         + 0.0028 * dcos(269.9 + 954397.74 * centuries)
                                         );
        
    // I'm skipping the precession correction right now, it's not included in the Almanac
    // and the values are fairly tiny
    //double a = 1.396971 * centuries + 0.0003086 * centuries*centuries;
    //...
    
    double r_earth = 6378.140; // kilometers
    double earth_moon_distance = r_earth / sin(horizontal_parallax); // kilometers
    double earth_moon_distance_au = earth_moon_distance / 149597871;
    double earth_barycenter_distance_au = 0.01215361914 * earth_moon_distance_au; // distance from center of earth
    double moon_barycenter_distance = earth_moon_distance_au - earth_barycenter_distance_au;

    double x = moon_barycenter_distance * cos(ecliptic_latitude) * cos(ecliptic_longitude);
    double y = moon_barycenter_distance * cos(ecliptic_latitude) * sin(ecliptic_longitude);
    double z = moon_barycenter_distance * sin(ecliptic_latitude);
    
    
    NSArray *vector = @[[NSNumber numberWithDouble:x],
                        [NSNumber numberWithDouble:y],
                        [NSNumber numberWithDouble:z]];
    
    return vector;

}

- (NSArray *)color
{
    return @[@0.85f, @0.85f, @0.85f];
}

- (double) meanRadius
{
    return 1737.4;
}

@end
