//
//  BusstopAnnotation.h
//  MaisMobilis
//
//  Created by tom on 1/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface BusstopAnnotation : MKAnnotationView <MKAnnotation>
{
    CLLocationCoordinate2D _coordinate;
}

@property CLLocationCoordinate2D coordinate;

- (id) initWithCoordinate:(CLLocationCoordinate2D)coordinate andType:(NSString *)type;

@end
