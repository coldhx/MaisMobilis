//
//  BuseStopDetailTableViewController.m
//  MaisMobilis
//
//  Created by Rita Silva on 1/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BuseStopDetailTableViewController.h"
#import "DataController.h"

#define STOPNAME_SECTION 0
#define LINES_SECTION 1
#define NEXTBUSES_SECTION 2


@implementation BuseStopDetailTableViewController
{
    NSArray *nextBuses;
}

@synthesize busStop;

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

    nextBuses = [DataController getEtaByBusstopID:[busStop busStopID]];
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
    NSInteger ret = 0;
    switch (section) {
        case STOPNAME_SECTION:
        case LINES_SECTION:
            ret = 1;
            break;
        case NEXTBUSES_SECTION:
            ret = [nextBuses count];
            break;
        default:
            break;
    }
    return ret;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *name = @"";
    switch (section) {
        case STOPNAME_SECTION:
            name = @"Paragem:";
            break;
        case LINES_SECTION:
            name = @"Linhas:";
            break;
        case NEXTBUSES_SECTION:
            name = @"Próximos autocarros";
            break;
            
        default:
            break;
    }
    
    return name;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *text = @"";
    NSString *lineName = @"";
    NSString *eta = [[nextBuses objectAtIndex:indexPath.row] objectForKey:@"eta"];
    
    switch (indexPath.section) {
        case STOPNAME_SECTION:
            text = busStop.name;
            break;
        case LINES_SECTION:
            text = [@"Mobilis " stringByAppendingFormat: @"%@", [DataController getLineIdsStringForBusStop:busStop]];
            break;
        case NEXTBUSES_SECTION:
            if([eta isEqualToString:@"0"])
            {
                text = @"Não disponível";
            }
            else
            {
            lineName = [DataController getLineNameForBusID: [[nextBuses objectAtIndex:indexPath.row] objectForKey:@"idAutocarro"]];
                eta = [NSString stringWithFormat:@"%dm %ds", [eta intValue]/60, [eta intValue]%60 ];
            text = [lineName stringByAppendingFormat:@" (%@)", eta];
            }
        default:
            break;
    }
    cell.textLabel.text = text;
    
    return cell;
}

@end
