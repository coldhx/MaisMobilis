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

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate andType:(NSString *)type
{
    self = [super initWithAnnotation:self reuseIdentifier:@"BusStopAnnotation"];
    self.canShowCallout = YES;
    
    UIImage *image;
    
    if(self)
    {
        _coordinate = coordinate;
        
        //This should not be hard coded like this
        //Line 1 (Green)
        if([type isEqualToString:@"1"])
        {
            image = [UIImage imageNamed:@"greensquare.png"];
        }
        //Everything else, we just have two lines so this is Line 2 (red)
        else
        {
            image = [UIImage imageNamed:@"redsquare.png"];
        }
        
        if(!image)
        {
            return nil;
        }
        
        self.image = image;
    }
    
    return self;
}

@end
