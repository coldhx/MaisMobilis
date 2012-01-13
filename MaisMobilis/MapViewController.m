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
#import "BusAnnotation.h"
#import "BusStop.h"
#import "ReferencePoint.h"
#import "Line.h"
#import "Bus.h"
#import "Webservice/WebEta.h"
#import "Webservice/WebBus.h"
#import "BusesDetailViewController.h"
#import "BStopDetailViewController.h"

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
    
    //Begin refreshing buses
    [self performSelectorInBackground:@selector(refreshBuses) withObject:nil];
    
    //Zoom to interesting area on map
    [self resetMapZoomWithLatitude:ZOOMLATITUDE andLongitude:ZOOMLONGITUDE];
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [self setMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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

//Called for evety annotation on the map
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    //Should be checking the call that the instance belongs to!!
    UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    //[button addTarget:self action:@selector() forControlEvents:UIControlEventTouchUpInside]
    ((BusstopAnnotation *)annotation).rightCalloutAccessoryView = button;
    return (BusstopAnnotation *)annotation;
}

//Called when the arrow in an annotation is touched
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{        
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSEntityDescription *entity;
    NSPredicate *predicate;
    NSFetchRequest *request;
    NSError *error;
    NSMutableArray *results;
    
    if([view class] == [BusAnnotation class])
    {
        BusAnnotation *busAnnotation = (BusAnnotation *)view;
        entity = [NSEntityDescription entityForName:@"Bus" inManagedObjectContext:context];
        predicate = [NSPredicate predicateWithFormat:@"busID = %@", busAnnotation.busID];
        request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
        [request setPredicate:predicate];
        error = nil;
        results = [[context executeFetchRequest:request error: &error] mutableCopy];
        
        Bus *bus = [results objectAtIndex:0];
        
        BusesDetailViewController *busesViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"busDetails"];
        [busesViewController setBus:bus];
        
        [[self navigationController] pushViewController:busesViewController animated:YES];
    }
    else if([view class] == [BusstopAnnotation class])
    {
        BusstopAnnotation *busstopAnnotation = (BusstopAnnotation *)view;
        entity = [NSEntityDescription entityForName:@"BusStop" inManagedObjectContext:context];
        predicate = [NSPredicate predicateWithFormat:@"busStopID = %@", busstopAnnotation.busstopID];
        request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
        [request setPredicate:predicate];
        error = nil;
        results = [[context executeFetchRequest:request error: &error] mutableCopy];
        
        BusStop *busstop = [results objectAtIndex:0];
        
        BStopDetailViewController *busstopViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"busstopDetails"];
        [busstopViewController setBusStop:busstop];
        
        [[self navigationController] pushViewController:busstopViewController animated:YES];
    }
}

//Called when an annotation is selected
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    if([view class] == [BusstopAnnotation class])
    {
        BusstopAnnotation *annotation = (BusstopAnnotation *)view;
        annotation.isSelected = YES;
        
        [self performSelectorInBackground:@selector(refreshBusstopAnnotation:) withObject:annotation];
    }
}

//Called when an annotation is deselected
- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    if([view class] == [BusstopAnnotation class])
    {
        BusstopAnnotation *annotation = (BusstopAnnotation *)view;
        annotation.isSelected = NO;
    }
}

- (void)loadBusStops
{
    //Get context
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    //Fetch bus stops
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BusStop" inManagedObjectContext:context];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
    
    NSError *error = nil;
    NSMutableArray *results = [[context executeFetchRequest:request error: &error] mutableCopy];
    
    if(results == nil)
    {
        NSLog(@"%@", error.description);
    }
    
    //For each bus stop
    for(int i=0; i<results.count; i++)
    {
        BusStop *busStop = [results objectAtIndex:i];
        
        //Fetch reference points
        entity = [NSEntityDescription entityForName:@"ReferencePoint" inManagedObjectContext:context];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"referencePointID = %@", busStop.refPointID];
        
        request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
        [request setPredicate:predicate];
        
        NSMutableArray *refPointResults = [[context executeFetchRequest:request error:&error] mutableCopy];
        
        if(refPointResults == nil)
        {
            return;
        }
        
        //Set coordinate based on reference point
        ReferencePoint *refPoint = [refPointResults objectAtIndex:0];
        
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = [refPoint.latitude doubleValue];
        coordinate.longitude = [refPoint.longitude doubleValue];
        
        //Fetch bus line(s)
        entity = [NSEntityDescription entityForName:@"BusStop_Line" inManagedObjectContext:context];
        
        predicate = [NSPredicate predicateWithFormat:@"busStopID = %@", busStop.busStopID];
        
        request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
        [request setPredicate:predicate];
        
        NSMutableArray *busLinesResult = [[context executeFetchRequest:request error:&error] mutableCopy];
        
        //This should not be hardcoded like this
        NSString *type = @"3";
        
        if(busLinesResult.count == 1)
        {
            if([[[busLinesResult objectAtIndex:0] lineID] isEqualToString:@"1"])
            {
                type = @"1";
            }
            else
            {
                type = @"2";
            }
        }
        
        BusstopAnnotation *annotation = [[BusstopAnnotation alloc] initWithCoordinate: coordinate andType:type andBusstopID:busStop.busStopID];
        
        [annotation setTitle:[NSString stringWithFormat:@"%@", busStop.name]];
        
        [mapView addAnnotation:annotation];
    }
}

- (void)refreshBuses
{
    //Get all buses from server
    [WebBus geAllBuses];
    
    //Array of annotations
    NSMutableDictionary *annotations = [[NSMutableDictionary alloc] init];
    
    //Get context
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    //Fetch buses
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Bus" inManagedObjectContext:context];
    
    NSFetchRequest *request;
    NSError *error = nil;
    NSMutableArray *results;
    
    while(true)
    {
        NSLog(@"REFRESHIIIING!");
        @try
        {
            request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
            results = [[context executeFetchRequest:request error: &error] mutableCopy];
            
            if(results == nil)
            {
                NSLog(@"%@", error.description);
            }
            
            for(int i=0; i<results.count; i++)
            {
                BusAnnotation *annotation;
                
                Bus *bus = [results objectAtIndex:i];
                
                CLLocationCoordinate2D coordinate;
                coordinate.latitude = [bus.latitude doubleValue];
                coordinate.longitude = [bus.longitude doubleValue];
                
                if([annotations objectForKey:bus.busID] == nil)
                {
                    annotation = [[BusAnnotation alloc] initWithCoordinate:coordinate andType:bus.lineID andBusID:[bus busID]];
                
                    [annotations setObject:annotation forKey:bus.busID];
                    [self performSelectorOnMainThread:@selector(addBusAnnotation:) withObject:annotation waitUntilDone:YES];
                }
                else
                {
                    NSString *eta;
                    @try
                    {
                        eta = [WebEta getEtaForBusID:[bus busID]];
                        eta = [NSString stringWithFormat:@"%d:%d", [eta intValue]/60, [eta intValue]%60];
                        
                    }
                    @catch (NSException *exception)
                    {
                        eta = @"N/D";
                    }
                    
                    annotation = [annotations objectForKey:bus.busID];
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                    [dic setValue:annotation forKey:@"annotation"];
                    [dic setValue:[[NSNumber alloc] initWithDouble:coordinate.latitude] forKey:@"latitude"];
                    [dic setValue:[[NSNumber alloc] initWithDouble:coordinate.longitude] forKey:@"longitude"];
                    [dic setValue:[bus meanVelocity] forKey:@"meanVelocity"];
                    [dic setValue:eta forKey:@"eta"];
                    
                    [self performSelectorOnMainThread:@selector(setAnnotationCoordinate:) withObject:dic waitUntilDone:YES];
                }
                
                //Remove buses that are no longer active (NOT WORKING!)
                for (NSString* key in annotations)
                {
                    Boolean del = YES;
                    
                    for(int j=0; j<results.count; j++)
                    {
                        if([key isEqualToString:[[results objectAtIndex:j] busID]])
                        {
                            del = NO;
                        }
                    }
                    
                    if(del)
                    {
                        [self performSelectorOnMainThread:@selector(deleteBusAnnotation:) withObject:[annotations objectForKey:key] waitUntilDone:YES];
                    }
                }
            }
        }
        @catch (id exception)
        {
            NSLog(@"%@", [exception description]);
        }
        
        [NSThread sleepForTimeInterval:3];
    }
}

- (void) refreshBusstopAnnotation:(BusstopAnnotation *)annotation
{    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Bus" inManagedObjectContext:context];
    NSFetchRequest *request;
    NSError *error = nil;
    NSPredicate *predicate;
    Bus *bus;
    NSArray *objects;
    NSString *subtitle = @"";
    NSArray *etas;
    
    while(annotation.isSelected)
    {
        subtitle = @"";
        @try
        {
            etas = [WebEta getETAsForBusstopID:annotation.busstopID];
        }
        @catch (NSException *exception)
        {
            //Do nothing;
            continue;
        }
        
        for(int i=0; i<etas.count; i++)
        {
            request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
            predicate = [NSPredicate predicateWithFormat:@"busID = %@", [[etas objectAtIndex:i] objectForKey:@"idAutocarro"]];
            [request setPredicate: predicate];
            NSMutableArray *results = [[context executeFetchRequest:request error: &error] mutableCopy];
            
            if(results.count > 0)
            {
                bus = [results objectAtIndex:0];
                //Should not be hardcoded like this!!
                if([bus.lineID isEqualToString:@"1"])
                {
                    subtitle = [subtitle stringByAppendingFormat:@"Verde"];
                }
                else
                {
                    subtitle = [subtitle stringByAppendingFormat:@"Vermelho"];
                }
                
                subtitle = [subtitle stringByAppendingFormat:@"(#%@): %d:%d, ", bus.busID, [[[etas objectAtIndex:i] objectForKey:@"eta"] intValue]/60, [[[etas objectAtIndex:i] objectForKey:@"eta"] intValue]%60];
            }
        }
        
        objects = [[NSArray alloc] initWithObjects:annotation, subtitle, nil];
        [self performSelectorOnMainThread:@selector(setBusstopAnnotationSubTitle:) withObject:objects waitUntilDone:YES];
        [NSThread sleepForTimeInterval:3];
    }
}

- (void) setBusstopAnnotationSubTitle:(NSArray *) annotationAndSubtitle
{
    BusstopAnnotation *annotation = [annotationAndSubtitle objectAtIndex:0];
    NSString *subTitle = [annotationAndSubtitle objectAtIndex:1];
    
    [annotation setSubtitle:subTitle];
}

- (void) addBusAnnotation:(BusAnnotation*) annotation
{
    [mapView addAnnotation:annotation];
}

- (void) deleteBusAnnotation:(BusAnnotation *) annotation
{
    [mapView removeAnnotation:annotation];
}

- (void) setAnnotationCoordinate:(NSDictionary *) annotationAndCoordinate
{
    BusAnnotation *annotation = [annotationAndCoordinate objectForKey:@"annotation"];
    [annotation setSubtitle:[[annotationAndCoordinate objectForKey:@"meanVelocity"] stringByAppendingFormat:@" (%@)", [annotationAndCoordinate objectForKey:@"eta"]]];
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [[annotationAndCoordinate objectForKey:@"latitude"] doubleValue];
    coordinate.longitude = [[annotationAndCoordinate objectForKey:@"longitude"] doubleValue];
    
    [annotation setCoordinate:coordinate];
}
@end
