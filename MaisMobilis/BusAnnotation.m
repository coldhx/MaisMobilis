//
//  BusAnnotation.m
//  MaisMobilis
//
//  Created by tom on 1/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BusAnnotation.h"

@implementation BusAnnotation

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
            image = [UIImage imageNamed:@"greenbus.png"];
            [self setTitle:@"Mobilis Verde"];
        }
        //Line 2 (red)
        else
        {
            image = [UIImage imageNamed:@"redbus.png"];
            [self setTitle:@"Mobilis Vermelho"];
        }
        
        self.image = image;
    }
    
    return self;
}

@end
