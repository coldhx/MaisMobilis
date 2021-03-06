//
//  RoutesTableViewController.m
//  MaisMobilis
//
//  Created by Rita Silva on 1/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RoutesTableViewController.h"
#import "DataController.h"
#import "RouteDetailTableViewController.h"
#import "NewRouteTableViewController.h"
#import "Route.h"
#import "AppDelegate.h"


@implementation RoutesTableViewController

@synthesize routes = _routes;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _routes = [DataController getAllRoutes];
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [_routes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"routeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Route *r = [_routes objectAtIndex:[indexPath row]];
    cell.textLabel.text = r.desination;
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data sourceeee
        Route * r = [_routes objectAtIndex:indexPath.row];
        [_routes removeObject:r];
        
        [DataController deleteAssociatedAlerts:r.routeID];
        NSManagedObjectContext *context = r.managedObjectContext;
        [context deleteObject:r];
        [context save: nil];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }   
}


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPathhhh
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark - Table view delegate

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showRouteDetail"]) 
    {
        RouteDetailTableViewController *routeDetailVC = [segue destinationViewController];
        NSInteger selectedIndex = [[self.tableView indexPathForSelectedRow] row];
        if(_routes != nil) 
        {
            Route *r = [_routes objectAtIndex:selectedIndex];
            [routeDetailVC setRoute:r];
        }
    }
    else if ([[segue identifier] isEqualToString:@"addRoute"])
    {
        NewRouteTableViewController *newRouteTVC = [segue destinationViewController];
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = delegate.managedObjectContext; 
        Route *newRoute   =[NSEntityDescription insertNewObjectForEntityForName:@"Route" inManagedObjectContext: context];
        newRoute.routeID = [[NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]] stringValue];
        newRouteTVC.route = newRoute;
    }
}

- (void) newRouteTableViewController: (NewRouteTableViewController *) newRouteTableViewController didAddRoute: (Route *) route {
    if(route)
        [self.tableView reloadData];
    
}


@end
