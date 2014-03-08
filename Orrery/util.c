//
//  util.c
//  Orrery
//
//  Created by Jesse Wolfe on 3/7/14.
//  Copyright (c) 2014 Jesse Wolfe. All rights reserved.
//

#include <math.h>

double radians(double degrees)
{
    return fmod((M_PI * degrees / 180), 2*M_PI);
}
