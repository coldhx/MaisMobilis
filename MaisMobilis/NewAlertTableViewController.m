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

-(NSString *) tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    NSString *title = nil;
    
    switch (section) {
        case TIMES_SECTION:
            title = @"Intervalo de tempo durante o qual o alerta está activo";
            break;
        case ROUTE_SECTION:
            title = @"Nome do percurso associado";
            break;
        case NUMBUSSTOPS_SECTION:
            title = @"Número máximo de paragens";
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
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm";
    
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
            switch (indexPath.row)
            {
                case 0:
                    if([alert startTime] != nil)
                    {
                        text = [dateFormatter stringFromDate:[alert startTime]];
                    }
                    else
                        text = @"Hora de início";
                    break;
                case 1:
                    if([alert stopTime] != nil)
                    {
                        text = [dateFormatter stringFromDate:[alert stopTime]];
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
            
        case TIMES_SECTION:
            if(indexPath.row == 0)
            {
                [self showUIDatePickerFor:UIDATEPICKERSTARTTIME];
            }
            else if(indexPath.row == 1)
            {
                [self showUIDatePickerFor:UIDATEPICKERSTOPTIME];
            }
            
            break;
            
        default:
            break;
    }
    
    if(nextViewController) {
        [self.navigationController pushViewController:nextViewController animated:YES];
    }
}

- (void) showUIDatePickerFor:(int) element
{
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
    pickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, 0, 0)];
    pickerView.datePickerMode = UIDatePickerModeTime;
    
    [actionSheet addSubview:pickerView];
    
    UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Guardar"]];
    closeButton.momentary = YES;
    closeButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
    closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
    closeButton.tintColor = [UIColor blackColor];
    
    SEL selector = element == UIDATEPICKERSTARTTIME ? @selector(saveStartTime) : @selector(saveStopTime);
    
    [closeButton addTarget:self action:selector forControlEvents:UIControlEventValueChanged];
    
    [actionSheet addSubview:closeButton];
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    [actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
}

- (void) saveStartTime
{
    [self saveTimeFor:UIDATEPICKERSTARTTIME];
}

- (void) saveStopTime
{
    
    [self saveTimeFor:UIDATEPICKERSTOPTIME];
}

- (void) saveTimeFor:(int) element
{
    if(element == UIDATEPICKERSTARTTIME)
    {
        alert.startTime = pickerView.date;
    }
    else if(element == UIDATEPICKERSTOPTIME)
    {
        alert.stopTime = pickerView.date;
    }
    
    [[self tableView] reloadData];
    
    //Dismiss action sheet
    if(actionSheet != nil)
    {
        [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
    }
}

- (IBAction)save:(id)sender
{
    alert.busStopDelayNumber = [NSNumber numberWithInt:[busStopsNumber.text intValue]];
    
    NSError *error = nil;
    
	if (![alert.managedObjectContext save:&error]) 
    {
		
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		return;
	}
    
    [self.delegate newAlertTableViewController: self didAddAlert:alert];
    [self.navigationController popViewControllerAnimated:YES];
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
