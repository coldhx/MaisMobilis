//
//  BusAnnotation.h
//  MaisMobilis
//
//  Created by tom on 1/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface BusAnnotation: MKAnnotationView <MKAnnotation>
{
    CLLocationCoordinate2D _coordinate;
}

@property(nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;

- (id) initWithCoordinate:(CLLocationCoordinate2D)coordinate andType:(NSString *)type;

@end
