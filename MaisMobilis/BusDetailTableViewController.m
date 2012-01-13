//
//  BusDetailTableViewController.m
//  MaisMobilis
//
//  Created by Rita Silva on 1/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BusDetailTableViewController.h"
#import "DataController.h"

#define LINE_SECTION 0
#define NEXTSTOP_SECTION 1
#define ETA_SECTION 2


@implementation BusDetailTableViewController
@synthesize bus;

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

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *name = @"";
    switch (section) {
        case LINE_SECTION:
            name = @"Linha:";
            break;
        case NEXTSTOP_SECTION:
            name = @"Próxima Paragem:";
            break;
        case ETA_SECTION:
            name = @"Tempo estimado:";
            break;
            
        default:
            break;
    }
    
    return name;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *text = @"";
    NSString *eta = [DataController getEtaByBusID:[bus busID]];
    NSString *nextStop = [DataController getNextStopByBusID:bus.busID];
    
    switch (indexPath.section) {
        case LINE_SECTION:
            text = [DataController getLineNameForBusID:bus.busID];
            break;
        case NEXTSTOP_SECTION:
            if([nextStop isEqualToString:@"N/D"])
                text = @"Não disponível";
            else 
                text = nextStop;
                break;
        case ETA_SECTION:
            if([eta isEqualToString:@"0"])
            {
                text = @"Não disponível";
            }
            else
            {
                text = [NSString stringWithFormat:@"%dm %ds", [eta intValue]/60, [eta intValue]%60 ];
            }
        default:
            break;
    }
    cell.textLabel.text = text;
    
    return cell;
}

@end
