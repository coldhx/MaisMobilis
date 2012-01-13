//
//  RouteBusStopPickerTVController.m
//  MaisMobilis
//
//  Created by Rita Silva on 1/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InitBusStopPickerTVController.h"
#import "NewRouteTableViewController.h"
#import "DataController.h"

@interface InitBusStopPickerTVController()
@property (nonatomic, retain) NSMutableArray *busStops;
@end

@implementation InitBusStopPickerTVController


@synthesize busStops;
@synthesize route;
@synthesize type;
@synthesize checkedIndexPath;


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
    
    if([route destinBusStopID] != nil)
    {
        busStops = [DataController getBusStopsWithSameLineIdAs:[route destinBusStopID]];
    }
    else
        busStops = [DataController getAllBusStops];
   
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    busStops = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
    return [busStops count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    BusStop *bs = [busStops objectAtIndex:[indexPath row]];
    cell.textLabel.text = bs.name;
    cell.imageView.image = [UIImage imageNamed: [self getImageName:bs]];
    
    if([bs.busStopID isEqualToString: [route initialBusStopID]])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    if([self.checkedIndexPath isEqual:indexPath])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else 
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    } 
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BusStop *bs = [busStops objectAtIndex:[indexPath row]];
    
    /*if([route initialBusStopID] != nil)
    {
        NSInteger index = [busStops indexOfObject:bs];
        NSIndexPath *selectionIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
        UITableViewCell *checkedCell = [tableView cellForRowAtIndexPath:selectionIndexPath];
        checkedCell.accessoryType = UITableViewCellAccessoryNone;
    }*/
    
    if(self.checkedIndexPath)
    {
        UITableViewCell* uncheckCell = [tableView cellForRowAtIndexPath:self.checkedIndexPath];
        uncheckCell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.checkedIndexPath = indexPath;
    route.initialBusStopID = [bs busStopID];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (NSString *) getImageName: (BusStop*) bs
{
    NSArray* lines = [DataController getLineIdsForBusStopID:bs.busStopID];
    NSString* imageName;
    if([lines count] > 1) 
    {
        imageName = @"redandgreensquare.png"; 
    }
    else if([[[lines objectAtIndex:0] lineID]isEqualToString:@"1"])
    {
        imageName = @"greensquare.png";
    }
    else if([[[lines objectAtIndex:0] lineID] isEqualToString:@"2"])
    {
        imageName = @"redsquare.png";
    }
    return imageName;
}

@end
