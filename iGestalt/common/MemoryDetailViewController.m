//
//  MemoryDetailViewController.m
//  iGestalt
//
//  Created by 小林 博久 on 11/06/17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MemoryDetailViewController.h"
#import "iOSGestalt.h"


enum {
	kSectionMemoryInfo,
	kSectionAllocTest,

	kSectionMax
};

enum {
	kSectionMemoryInfoPageSize,
	kSectionMemoryInfoTotal,
	kSectionMemoryInfoWired,
	kSectionMemoryInfoActive,
	kSectionMemoryInfoInactive,
	kSectionMemoryInfoFree,
	kSectionMemoryInfoPhysicalMemory,
	kSectionMemoryInfoUserMemory,

	kSectionMemoryInfoMax
};


@interface MemoryDetailViewController ()

- (UITableViewCell *)memoryInfoSectionCell:(NSInteger)row;
- (UITableViewCell *)allocTestSectionCell:(NSInteger)row;
- (NSDictionary *)memoryInfoDictionary:(NSInteger)index;

@end


@implementation MemoryDetailViewController


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

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
	NSInteger rows = 0;

	switch (section) {

		case kSectionMemoryInfo:
			rows = kSectionMemoryInfoMax;
			break;

		case kSectionAllocTest:
			rows = 1;
			break;

		default:
			break;
	}

    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = nil;

	switch (indexPath.section) {

		case kSectionMemoryInfo:
			cell = [self memoryInfoSectionCell:indexPath.row];
			break;

		case kSectionAllocTest:
			cell = [self allocTestSectionCell:indexPath.row];
			break;
	}

	return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView
 didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


#pragma mark - private methods

- (UITableViewCell *)memoryInfoSectionCell:(NSInteger)row
{
	static NSString *CellIdentifier = @"memoryInfoCell";

	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}

	NSDictionary *info = [self memoryInfoDictionary:row];
	cell.textLabel.text = [info objectForKey:@"title"];
	cell.detailTextLabel.text = [info objectForKey:@"value"];

	return cell;
}

- (UITableViewCell *)allocTestSectionCell:(NSInteger)row
{
	static NSString *CellIdentifier = @"allocTestCell";

	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		//cell.textLabel.textAlignment = 
	}

	cell.textLabel.text = @"Allocation Test";

	return cell;
}

- (NSDictionary *)memoryInfoDictionary:(NSInteger)index
{
	NSString *title = @"";
	NSString *value = @"";

	iOSGestalt *gestalt = [[[iOSGestalt alloc] init] autorelease];
	[gestalt resetVmstat];

	switch (index) {

		case kSectionMemoryInfoPageSize:
			title = @"Page Size";
			value = [NSString stringWithFormat:@"%u", [gestalt pageSize]];
			break;

		case kSectionMemoryInfoTotal:
			title = @"Total";
			value = [NSString stringWithFormat:@"%u", [gestalt vmstatTotal]];
			break;

		case kSectionMemoryInfoWired:
			title = @"Wired";
			value = [NSString stringWithFormat:@"%u", [gestalt vmstatWired]];
			break;

		case kSectionMemoryInfoActive:
			title = @"Active";
			value = [NSString stringWithFormat:@"%u", [gestalt vmstatActive]];
			break;

		case kSectionMemoryInfoInactive:
			title = @"Inactive";
			value = [NSString stringWithFormat:@"%u", [gestalt vmstatInactive]];
			break;

		case kSectionMemoryInfoFree:
			title = @"Free";
			value = [NSString stringWithFormat:@"%u", [gestalt vmstatFree]];
			break;

		case kSectionMemoryInfoPhysicalMemory:
			title = @"Physical Memory";
			value = [NSString stringWithFormat:@"%u", [gestalt physicalMemory]];
			break;

		case kSectionMemoryInfoUserMemory:
			title = @"User Memory";
			value = [NSString stringWithFormat:@"%u", [gestalt userMemory]];
			break;

		default:
			break;
	}

	return [NSDictionary dictionaryWithObjectsAndKeys:
			title, @"title",
			value, @"value",
			nil];
}


@end
