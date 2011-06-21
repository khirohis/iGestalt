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
	unsigned int kb = bytes >> 10;
	if (kb < 10) {
		return [NSString stringWithFormat:@"%u B", bytes];
	}

	unsigned int mb = kb >> 10;
	if (mb < 10) {
		return [NSString stringWithFormat:@"%u KB", kb];
	}

	unsigned int gb = mb >> 10;
	if (gb < 10) {
		return [NSString stringWithFormat:@"%u MB", mb];
	}

	return [NSString stringWithFormat:@"%u GB", gb];
}

@end
