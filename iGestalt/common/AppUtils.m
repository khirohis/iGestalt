//
//  AppUtils.m
//  iGestalt
//
//  Created by 小林 博久 on 11/06/21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AppUtils.h"


@implementation AppUtils

+ (NSString *)stringWithBytes:(unsigned int)bytes
{
    if (bytes < 10000) {
        if (bytes < 1000) {
            return [NSString stringWithFormat:@"%u B", bytes];
        } else {
            return [NSString stringWithFormat:@"%u,%03u B", bytes / 1000, bytes % 1000];
        }
    }

    bytes >>= 10;
    if (bytes < 10000) {
        if (bytes < 1000) {
            return [NSString stringWithFormat:@"%u KB", bytes];
        } else {
            return [NSString stringWithFormat:@"%u,%03u KB", bytes / 1000, bytes % 1000];
        }
    }

    bytes >>= 10;
    if (bytes < 10000) {
        if (bytes < 1000) {
            return [NSString stringWithFormat:@"%u MB", bytes];
        } else {
            return [NSString stringWithFormat:@"%u,%03u MB", bytes / 1000, bytes % 1000];
        }
    }

    bytes >>= 10;
	return [NSString stringWithFormat:@"%u GB", bytes];
}

@end
