//
//  iGestaltAppDelegate_iPhone.m
//  iGestalt
//
//  Created by 小林 博久 on 11/06/16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "iGestaltAppDelegate_iPhone.h"

@implementation iGestaltAppDelegate_iPhone

@synthesize navigationController	= __navigationController;


- (void)dealloc
{
	[__navigationController release];

	[super dealloc];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[self.window addSubview:self.navigationController.view];
	return [super application:application didFinishLaunchingWithOptions:launchOptions];
}


@end
