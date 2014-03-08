//
//  POPlanet.m
//  Orrery
//
//  Created by Jesse Wolfe on 3/7/14.
//  Copyright (c) 2014 Jesse Wolfe. All rights reserved.
//

#import "POPlanet.h"
#import <OpenGL/glu.h>
#import "util.h"

@implementation POPlanet
static double newton_calculate_eccentric_anomaly_with_guess(double mean_anomaly, double eccentricity, double guess, int tries){
    // we must approximate numerically:
    // mean_anomaly = eccentric_anomaly - eccentricity * sin(eccentric_anomaly);
    
    // this is basically newton's method: http://en.wikipedia.org/wiki/Newton%27s_method
    double error = guess - eccentricity * sin(mean_anomaly) - mean_anomaly; // ideally this is zero
    double derivative_error = 1.0-eccentricity * cos(guess); // derivative of above formula
    double new_guess = guess - error/derivative_error; // Newton's approxmiation of a better guess
    
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

static double degrees(double radians)
{
    return (180 * radians / M_PI);
}

- (double) semiMajorAxisAt:(double) centuries
{
    return (1.00000261 + 0.00000562 * centuries); // Astronomical Units
}

- (double) eccentricity:(double) centuries
{
    return 0.01671123 + -0.00004392 * centuries; // radians
}

- (double)inclinationAngle:(double)centuries
{
    return radians(-0.00001531 + -0.01294668 * centuries);
}

- (double)meanLongitude:(double)centuries
{
    return radians(100.46457166 + 35999.37244981 * centuries);
}

- (double)longitudeOfPerihelion:(double)centuries
{
    return radians(102.93768193 +  0.32327364 * centuries);
}

- (double)longitudeOfAscendingNode:(double)centuries
{
    return radians(0 + 0 * centuries);
}

- (NSArray*) coordinatesAtTime: (double)elapsed_time
{
    double centuries = elapsed_time / 100.0;
    
    double semi_major_axis   = [self semiMajorAxisAt:centuries];
    double eccentricity      = [self eccentricity:centuries];
    double inclination_angle = [self inclinationAngle:centuries];
    double mean_longitude    = [self meanLongitude:centuries];
    double longitude_of_perihelion = [self longitudeOfPerihelion:centuries];
    double longitude_of_ascending_node = [self longitudeOfAscendingNode:centuries]; // zeros 'cause earth is special
    
    
    //double period = 1; // years
    //double mean_anomaly = 2 * M_PI * elapsed_time / period;
    
    double argument_of_perihelion = longitude_of_perihelion - longitude_of_ascending_node;
    double mean_anomaly = mean_longitude - longitude_of_perihelion;
    
    double eccentric_anomaly = newton_calculate_eccentric_anomaly(mean_anomaly, eccentricity);
    double true_anomaly = 2 * atan( sqrt((1+eccentricity) / (1-eccentricity)) * tan(eccentric_anomaly/2) );
    double radial_distance = semi_major_axis * ( 1 - eccentricity*eccentricity ) / ( 1 + eccentricity*cos(true_anomaly));
    //NSLog(@"radial distatance: %f", radial_distance);
    //NSLog(@"rotation: %f", degrees(true_anomaly));
    
    // heliocentric coordinates in orbital plane
    double x_ = semi_major_axis * ( cos(eccentric_anomaly) - eccentricity);
    double y_ = semi_major_axis * sqrt(1 - eccentricity*eccentricity) * sin(eccentric_anomaly);
    
    // heliocentric coordinates in ecliptic plane
    double x_ecl = ((
                     cos(argument_of_perihelion) * cos(longitude_of_ascending_node)
                     - sin(argument_of_perihelion) * sin(longitude_of_ascending_node) * cos(inclination_angle)
                     ) * x_
                    + (
                       -sin(argument_of_perihelion) * cos(longitude_of_ascending_node)
                       - cos(argument_of_perihelion) * sin(longitude_of_ascending_node) * cos(inclination_angle)
                       ) * y_
                    );
    
    double y_ecl = ((
                     cos(argument_of_perihelion )* sin(longitude_of_ascending_node)
                     + sin(argument_of_perihelion) * cos(longitude_of_ascending_node) * cos(inclination_angle)
                     ) * x_
                    + (
                       -sin(argument_of_perihelion) * sin(longitude_of_ascending_node)
                       + cos(argument_of_perihelion) * cos(longitude_of_ascending_node) * cos(inclination_angle)
                       ) * y_);
    double z_ecl = (sin(argument_of_perihelion) * sin(inclination_angle) * x_
                    + cos(argument_of_perihelion) * sin(inclination_angle) * y_);
    
    NSArray *vector = @[[NSNumber numberWithDouble:x_ecl],
                        [NSNumber numberWithDouble:y_ecl],
                        [NSNumber numberWithDouble:z_ecl]];

    return vector;
}

- (NSArray *)color
{
    return @[@0.0f, @0.85f, @0.85f];
}

- (double) radius
{
    return 0.1;
}

- (void) drawForTime:(double)years
{
    NSArray *coordinates = [self coordinatesAtTime:years];
    NSArray *color = [self color];

    double x = [[coordinates objectAtIndex:0] doubleValue];
    double y = [[coordinates objectAtIndex:1] doubleValue];
    double z = [[coordinates objectAtIndex:2] doubleValue];
    
    double radius = [self radius];

    double r = [[color objectAtIndex:0] doubleValue];
    double g = [[color objectAtIndex:1] doubleValue];
    double b = [[color objectAtIndex:2] doubleValue];
    glColor3f(r, g, b);
    
    glPushMatrix();
    glTranslated(x, y, z);
    GLUquadric *quad = gluNewQuadric();
    gluSphere(quad, radius, 100, 100);
    glPopMatrix();

}
@end
