//
//  GroupSelectViewController.m
//  iGestalt
//
//  Created by 小林 博久 on 11/06/17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GroupSelectViewController.h"
#import "DeviceDetailViewController.h"
#import "MemoryDetailViewController.h"


enum {
	kSectionGeneral,

	kSectionMax
};

enum {
	kSectionGeneralDevice,
	kSectionGeneralMemory,

	kSectionGeneralMax
};


@implementation GroupSelectViewController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return kSectionMax;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSInteger rows = 0;

	switch (section) {

		case kSectionGeneral:
			rows = kSectionGeneralMax;
			break;

		default:
			break;
	}

    return rows;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	NSString *title = @"";

	switch (section) {

		case kSectionGeneral:
			title = @"General";
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
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

	NSString *title = @"";

	switch (indexPath.section) {

		case kSectionGeneral:
		{
			switch (indexPath.row) {

				case kSectionGeneralDevice:
					title = @"Device";
					break;

				case kSectionGeneralMemory:
					title = @"Memory";
					break;
					
				default:
					break;
			}
		}

		default:
			break;
	}

	cell.textLabel.text = title;

    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UIViewController *vc = nil;

	switch (indexPath.section) {

		case kSectionGeneral:
		{
			switch (indexPath.row) {

				case kSectionGeneralDevice:
					vc = (DeviceDetailViewController *)[[[DeviceDetailViewController alloc] initWithNibName:@"DeviceDetailViewController"
																									 bundle:nil] autorelease];
					break;

				case kSectionGeneralMemory:
					vc = (MemoryDetailViewController *)[[[MemoryDetailViewController alloc] initWithNibName:@"MemoryDetailViewController"
																									 bundle:nil] autorelease];
					break;

				default:
					break;
			}
		}
			
		default:
			break;
	}

	if (vc) {
		[self.navigationController pushViewController:vc animated:YES];
	}
}


@end
