//
//  iOSGestalt.h
//  iGestalt
//
//  Created by 小林 博久 on 10/07/09.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface iOSGestalt : NSObject {
}

- (unsigned int)pageSize;

- (BOOL)resetVmstat;
- (unsigned int)vmstatTotal;
- (unsigned int)vmstatWired;
- (unsigned int)vmstatActive;
- (unsigned int)vmstatInactive;
- (unsigned int)vmstatFree;

- (unsigned int)physicalMemory;
- (unsigned int)userMemory;

- (unsigned int)cpuFrequency;
- (unsigned int)busFrequency;

@end
