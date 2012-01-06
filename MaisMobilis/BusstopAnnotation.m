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
@synthesize title;

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
        //Line 2 (red)
        else if([type isEqualToString:@"2"])
        {
            image = [UIImage imageNamed:@"redsquare.png"];
        }
        else
        {
            image = [UIImage imageNamed:@"redandgreensquare.png"];
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
