//
//  BusAnnotation.h
//  MaisMobilis
//
//  Created by tom on 1/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Bus.h"

@interface BusAnnotation: MKAnnotationView <MKAnnotation>
{
    CLLocationCoordinate2D _coordinate;
    NSString *_busID;
}

@property(nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *busID;

- (id) initWithCoordinate:(CLLocationCoordinate2D)coordinate andType:(NSString *)type andBusID:(NSString *) busID;
@end
