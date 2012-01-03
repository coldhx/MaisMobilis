//
//  MapViewController.h
//  MaisMobilis
//
//  Created by Rita Silva on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "BusAnnotation.h"

@interface MapViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (void) resetMapZoomWithLatitude:(CLLocationDegrees)latitude andLongitude:(CLLocationDegrees)longitude;
- (void) loadBusStops;
- (void) refreshBuses;
- (void) addBusAnnotation:(BusAnnotation *) annotation;
- (void) setAnnotationCoordinate:(NSDictionary *) annotationAndCoordinate;
- (void) deleteBusAnnotation:(BusAnnotation *) annotation;

@end
