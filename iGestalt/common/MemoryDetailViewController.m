//
//  MemoryDetailViewController.m
//  iGestalt
//
//  Created by 小林 博久 on 11/06/17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MemoryDetailViewController.h"
#import "iOSGestalt.h"
#import "AppUtils.h"


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

enum {
	kAllocOnceLength			= 1024 * 1024
};


@interface MemoryDetailViewController ()

@property (nonatomic, retain) iOSGestalt		*gestalt;

@property (nonatomic, assign) BOOL				receivedWarning;
@property (nonatomic, assign) NSInteger			receiveCount;

@property (nonatomic, retain) NSMutableArray	*allocPool;

- (void)resetInfo;

- (UITableViewCell *)memoryInfoSectionCell:(NSInteger)row;
- (UITableViewCell *)allocTestSectionCell:(NSInteger)row;
- (NSDictionary *)memoryInfoDictionary:(NSInteger)index;

- (void)allocateOnce:(id)obj;

@end


@implementation MemoryDetailViewController

@synthesize gestalt				= __gestalt;

@synthesize receivedWarning		= __receivedWarning;
@synthesize receiveCount		= __recieveCount;

@synthesize allocPool			= __allocPool;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }

    return self;
}

- (void)dealloc
{
	[__gestalt release];
	[__allocPool release];

    [super dealloc];
}


- (iOSGestalt *)gestalt
{
	if (__gestalt == nil) {
		__gestalt = [[iOSGestalt alloc] init];
	}

	return __gestalt;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

	self.receivedWarning = YES;
	self.receiveCount++;
	self.allocPool = nil;
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

	[self resetInfo];
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
	switch (indexPath.section) {
		case kSectionAllocTest:
			[self performSelector:@selector(allocateOnce:) withObject:nil afterDelay:0.0];
			break;
			
		default:
			break;
	}
}


#pragma mark - private methods

- (void)resetInfo
{
	[self.gestalt resetVmstat];
	
	[self.tableView reloadData];
}


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
		cell.textLabel.textAlignment = UITextAlignmentCenter;
	}

	cell.textLabel.text = @"Allocation Test";

	return cell;
}

- (NSDictionary *)memoryInfoDictionary:(NSInteger)index
{
	NSString *title = @"";
	NSString *value = @"";

	unsigned int pageSize = [self.gestalt pageSize];

	switch (index) {

		case kSectionMemoryInfoPageSize:
			title = @"Page Size";
			value = [NSString stringWithFormat:@"%u", pageSize];
			break;

		case kSectionMemoryInfoTotal:
			title = @"Total";
			value = [AppUtils stringWithBytes:[self.gestalt vmstatTotal] * pageSize];
			break;

		case kSectionMemoryInfoWired:
			title = @"Wired";
			value = [AppUtils stringWithBytes:[self.gestalt vmstatWired] * pageSize];
			break;

		case kSectionMemoryInfoActive:
			title = @"Active";
			value = [AppUtils stringWithBytes:[self.gestalt vmstatActive] * pageSize];
			break;

		case kSectionMemoryInfoInactive:
			title = @"Inactive";
			value = [AppUtils stringWithBytes:[self.gestalt vmstatInactive] * pageSize];
			break;

		case kSectionMemoryInfoFree:
			title = @"Free";
			value = [AppUtils stringWithBytes:[self.gestalt vmstatFree] * pageSize];
			break;

		case kSectionMemoryInfoPhysicalMemory:
			title = @"Physical Memory";
			value = [AppUtils stringWithBytes:[self.gestalt physicalMemory]];
			break;

		case kSectionMemoryInfoUserMemory:
			title = @"User Memory";
			value = [AppUtils stringWithBytes:[self.gestalt userMemory]];
			break;

		default:
			break;
	}

	return [NSDictionary dictionaryWithObjectsAndKeys:
			title, @"title",
			value, @"value",
			nil];
}


- (void)allocateOnce:(id)obj
{
	if (self.receivedWarning) {
		[self resetInfo];
		self.receivedWarning = NO;
		return;
	}

	if (self.allocPool == nil) {
		self.allocPool = [NSMutableArray array];
	}

	NSData *data = [NSMutableData dataWithCapacity:kAllocOnceLength];
	if (data == nil) {
		[self resetInfo];
		return;
	}

	[self.allocPool addObject:data];

	[self performSelector:@selector(allocateOnce:) withObject:nil afterDelay:0.0];
}


@end
