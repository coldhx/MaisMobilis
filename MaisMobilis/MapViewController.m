//
//  MapViewController.m
//  MaisMobilis
//
//  Created by Rita Silva on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "MapViewController.h"
#import "BusstopAnnotation.h"
#import "BusStop.h"
#import "ReferencePoint.h"

#define ZOOMLATITUDE 39.74434
#define ZOOMLONGITUDE -8.80725
#define LATITUDEDELTA 0.061
#define LONGITUDEDELTA 0.055

#define MAXLATITUDE 39.76
#define MAXLATITUDEWITHMARGIN 39.755

#define MINLATITUDE 39.73
#define MINLATITUDEWITHMARGIN 39.735

#define MAXLONGITUDE -8.84
#define MAXLONGITUDEWITHMARGIN -8.835

#define MINLONGITUDE -8.77
#define MINLONGITUDEWITHMARGIN -8.775

@implementation MapViewController
@synthesize mapView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //This is the map delegate
    mapView.delegate = self;
    
    //Set to satellite view
    mapView.mapType = MKMapTypeHybrid;
    
    //Load bus stops onto the map
    [self loadBusStops];
    
    [self resetMapZoomWithLatitude:ZOOMLATITUDE andLongitude:ZOOMLONGITUDE];
}

- (void) resetMapZoomWithLatitude:(CLLocationDegrees)latitude andLongitude:(CLLocationDegrees)longitude
{
    CLLocationCoordinate2D zoomlocation;
    zoomlocation.latitude = latitude;
    zoomlocation.longitude = longitude;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomlocation, 4500, 4500);
    
    MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];
    
    [mapView setRegion:adjustedRegion animated:YES];
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [self setMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//Delegate method that forces a maximum out zoom
- (void)mapView:(MKMapView *)_mapView regionDidChangeAnimated:(BOOL)animated
{
    //TODO
    //Regra para quanto lat & lon sao excedidos ao mesmo tempo (ie movimento diagonal)
    //Nao alterar zoom quando se excede lat ou lon
    
    MKCoordinateRegion region = _mapView.region;
    
    if(region.span.latitudeDelta > LATITUDEDELTA || region.span.longitudeDelta > LONGITUDEDELTA)
    {
        [self resetMapZoomWithLatitude:ZOOMLATITUDE andLongitude:ZOOMLONGITUDE];
    }
    
    if(region.center.latitude > MAXLATITUDE)
    {
        [self resetMapZoomWithLatitude:MAXLATITUDEWITHMARGIN andLongitude:region.center.longitude];
    }
    
    if(region.center.latitude < MINLATITUDE)
    {
        [self resetMapZoomWithLatitude:MINLATITUDEWITHMARGIN andLongitude:region.center.longitude];
    }	
    
    if(region.center.longitude < MAXLONGITUDE)
    {
        [self resetMapZoomWithLatitude:region.center.latitude andLongitude:MAXLONGITUDEWITHMARGIN];
    }
    
    if(region.center.longitude > MINLONGITUDE)
    {
        [self resetMapZoomWithLatitude:region.center.latitude andLongitude:MINLONGITUDEWITHMARGIN];
    }
}

- (void)loadBusStops
{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = ZOOMLATITUDE;
    coordinate.longitude = ZOOMLONGITUDE;
    
    BusstopAnnotation *annotation = [[BusstopAnnotation alloc] initWithCoordinate: coordinate andType:@"1"];
    
    [mapView addAnnotation:annotation];
    
    
    
    
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BusStop" inManagedObjectContext:context];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
    
    NSError *error = nil;
    NSMutableArray *results = [[context executeFetchRequest:request error: &error] mutableCopy];
    
    if(results == nil)
    {
        NSLog(@"%@", error.description);
    }
    
    for(int i=0; i<results.count; i++)
    {
        BusStop *busStop = [results objectAtIndex:i];
        
        entity = [NSEntityDescription entityForName:@"ReferencePoint" inManagedObjectContext:context];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"referencePointID = %@", busStop.refPointID];
        
        request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
        [request setPredicate:predicate];
        
        NSMutableArray *refPointResults = [[context executeFetchRequest:request error:&error] mutableCopy];
        
        if(refPointResults == nil)
        {
            return;
        }
        
        ReferencePoint *refPoint = [refPointResults objectAtIndex:0];
        
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = [refPoint.latitude doubleValue];
        coordinate.longitude = [refPoint.longitude doubleValue];
        
        BusstopAnnotation *annotation = [[BusstopAnnotation alloc] initWithCoordinate: coordinate andType:busStop.lineID];
        
        [mapView addAnnotation:annotation];
    }
}

@end
