//
//  BusesDetailViewController.m
//  MaisMobilis
//
//  Created by Rita Silva on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BusesDetailViewController.h"
#import "AppDelegate.h"
#import "Line.h"
#import "BusStop.h"
#import "WebEta.h"

@implementation BusesDetailViewController

@synthesize bus = _bus;

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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    [lineLabel setText:[self loadline]];
    //[nextStopLabel setText:[self loadNextStop]];
    //[estimatedTimeLabel setText:[self loadEta]];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - data loading

- (NSString*) loadline
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Line" inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"lineID = %@",_bus.lineID];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error: &error] ;
    Line *linha = [results objectAtIndex:0];
    
    return linha.name;
}

- (NSString*) loadNextStop
{
    NSString *nextStopID = [WebEta getBusStopForBusstopID: _bus.busID];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BusStop" inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"busStopID = %@",nextStopID];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error: &error] ;
    BusStop *paragem = [results objectAtIndex:0];
    
    return paragem.name;
}

- (NSString *) loadEta
{
    return [WebEta getEtaForBusstopID: _bus.busID];
}


@end
