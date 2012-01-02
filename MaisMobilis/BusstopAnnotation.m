//
//  BusstopAnnotation.m
//  MaisMobilis
//
//  Created by tom on 1/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BusstopAnnotation.h"

@implementation BusstopAnnotation

@synthesize coordinate=_coordinate;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    self = [super init];
    
    if(self)
    {
        _coordinate = coordinate;
        
        UIImage *image = [UIImage imageNamed:@""];

        if(!image)
        {
            return nil;
        }
        
        self.image = image;
    }
    
    return self;
}

@end
