//
//  MemoryDetailViewController.h
//  iGestalt
//
//  Created by 小林 博久 on 11/06/17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MemoryDetailViewController : UITableViewController {
	BOOL			__receivedWarning;
	NSInteger		__recieveCount;

	NSMutableArray	*__allocPool;
}

@end
