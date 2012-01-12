//
//  NewRouteTableViewController.m
//  MaisMobilis
//
//  Created by Rita Silva on 1/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NewRouteTableViewController.h"
#import "InitBusStopPickerTVController.h"
#import "DestBusStopPickerTVController.h"
#import "RoutesTableViewController.h"
#import "DataController.h"

#define DESIGNATION_SECTION 0
#define ORIGSTOP_SECTION 1
#define DESTSTOP_SECTION 2


@implementation NewRouteTableViewController
@synthesize route;
@synthesize textField;
@synthesize delegate;

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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = nil;
    
    switch (section) {
        case DESIGNATION_SECTION:
            title = @"Designação:";
            break;
        case ORIGSTOP_SECTION:
            title = @"Paragem de origem:";
            break;
        case DESTSTOP_SECTION:
            title = @"Paragem de destino:";
            break;
        default:
            break;
    }
    return title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"newRouteCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
   
    CGRect Field1Frame = CGRectMake (10, 10, 290, 70);
    NSString *text = nil;
    BusStop *bs = nil;
    
    switch (indexPath.section) {
        case DESIGNATION_SECTION:
            text = @"";
            if(textField == nil) 
            {
                textField = [[UITextField alloc] initWithFrame:Field1Frame];
                textField.tag = 20;
                [cell.contentView addSubview:textField];
                textField = (UITextField *)[cell.contentView viewWithTag:20];
            }
            
            break;
        case ORIGSTOP_SECTION:
            if([route initialBusStopID] != nil)
            {
                bs = [DataController getBusStopByBusStopID:[route initialBusStopID]];
                text = bs.name;
            }
            else
            {
                text = @"Vazio";
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
            
        case DESTSTOP_SECTION:
            if([route destinBusStopID] != nil)
            {
                bs = [DataController getBusStopByBusStopID:[route destinBusStopID]];
                text = bs.name;
            }
            else
            {
                text = @"Vazio"; 
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
            
        default:
            break;
    }
    
    cell.textLabel.text = text;
    
    return cell;
}



#pragma mark - Table view delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    UIViewController *nextViewController = nil;
    
    switch (section) {
        case ORIGSTOP_SECTION:
            nextViewController = [[InitBusStopPickerTVController alloc] initWithStyle:UITableViewStyleGrouped];
            ((InitBusStopPickerTVController*) nextViewController).route = self.route;
            break;
        case DESTSTOP_SECTION:
            nextViewController = [[DestBusStopPickerTVController alloc] initWithStyle:UITableViewStyleGrouped];
            ((DestBusStopPickerTVController*) nextViewController).route = self.route;
            break;
            
        default:
            break;
    }
    
    if(nextViewController) {
        [self.navigationController pushViewController:nextViewController animated:YES];
    }
}

- (IBAction)save:(id)sender {
    route.desination = textField.text;
    
    NSError *error = nil;
	if (![route.managedObjectContext save:&error]) 
    {
		
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		return;
	}
    
    [self.delegate newRouteTableViewController: self didAddRoute:route];
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancel:(id)sender {
    [route.managedObjectContext deleteObject:route];
    
    NSError *error = nil;
	if (![route.managedObjectContext save:&error]) 
    {
		
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		return;
	}
    
    [self.delegate newRouteTableViewController: self didAddRoute:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
