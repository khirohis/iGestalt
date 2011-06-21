//
//  MemoryDetailViewController.h
//  iGestalt
//
//  Created by 小林 博久 on 11/06/17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class iOSGestalt;

@interface MemoryDetailViewController : UITableViewController {
	iOSGestalt		*__gestalt;

	BOOL			__receivedWarning;
	NSInteger		__recieveCount;

	NSMutableArray	*__allocPool;
}

@end
