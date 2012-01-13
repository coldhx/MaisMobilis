//
//  NewAlertTableViewController.m
//  MaisMobilis
//
//  Created by Rita Silva on 1/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NewAlertTableViewController.h"
#import "RoutePickerTableViewController.h"
#import "DataController.h"
#import "Alert.h"
#import "Route.h"

@implementation NewAlertTableViewController
@synthesize alert;
@synthesize delegate;
@synthesize busStopsNumber;

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
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    if(section == TIMES_SECTION)
        return 2;
    else
        return 1;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = nil;
    
    switch (section) {
        case TIMES_SECTION:
            title = @"Intervalo de tempo:";
            break;
        case ROUTE_SECTION:
            title = @"Percurso:";
            break;
        case NUMBUSSTOPS_SECTION:
            title = @"Paragens de Antecedência:";
            break;
        default:
            break;
    }
    return title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    CGRect Field1Frame = CGRectMake (10, 10, 290, 70);
    NSString *text = nil;
    
    switch (indexPath.section) {
        case NUMBUSSTOPS_SECTION:
            text =@"";
            if(busStopsNumber == nil){
                busStopsNumber = [[UITextField alloc] initWithFrame:Field1Frame];
                busStopsNumber.keyboardType = UIKeyboardTypeDecimalPad;
                busStopsNumber.tag = 20;
                [cell.contentView addSubview:busStopsNumber];
                busStopsNumber = (UITextField*)[cell.contentView viewWithTag:20];
            }
            break;
        case ROUTE_SECTION:
            if([alert routeID] != nil)
            {
                text = [DataController getRouteNameForRouteID:[alert routeID]];
            }
            else
                text = @"Vazio";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case TIMES_SECTION:
            switch (indexPath.row) {
                case 0:
                    if([alert startTime] != nil)
                    {
#warning program stuffs here
                    }
                    else
                        text = @"Hora de início";
                    break;
                case 1:
                    if([alert stopTime] != nil)
                    {
#warning program stuffs here
                    }
                    else
                        text = @"Hora de fim";
                    
                default:
                    break;
            }
            break;
        default:
            break;
    }
    
    cell.textLabel.text = text;
    
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

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    UIViewController *nextViewController = nil;
    
    switch (section) {
        case ROUTE_SECTION:
            nextViewController = [[RoutePickerTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
            ((RoutePickerTableViewController*) nextViewController).alert = self.alert;
            break;
            
        default:
            break;
    }
    
    if(nextViewController) {
        [self.navigationController pushViewController:nextViewController animated:YES];
    }
}

- (IBAction)save:(id)sender {
}

- (IBAction)cancel:(id)sender {
    [alert.managedObjectContext deleteObject:alert];
    
    NSError *error = nil;
	if (![alert.managedObjectContext save:&error]) 
    {
		
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		return;
	}
    
    [self.delegate newAlertTableViewController: self didAddAlert:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
