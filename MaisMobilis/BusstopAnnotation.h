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
    NSString *_busstopID;
    Boolean _isSelected;
}

@property(nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *busstopID;
@property (nonatomic) Boolean isSelected;
@property (nonatomic, copy) NSString* subtitle;

- (id) initWithCoordinate:(CLLocationCoordinate2D)coordinate andType:(NSString *)type andBusstopID:(NSString *) busstopID;

@end
