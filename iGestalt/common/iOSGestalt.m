//
//  iOSGestalt.m
//  iGestalt
//
//  Created by 小林 博久 on 10/07/09.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <sys/sysctl.h>
#import <mach/mach_host.h>
#import "iOSGestalt.h"


static vm_statistics_data_t	sVmstat;


@interface iOSGestalt ()

- (BOOL)sysctl_hw:(int)identifier result:(unsigned int*)ioresult;

@end


@implementation iOSGestalt


- (unsigned int)pageSize
{
	unsigned int result;
	if ([self sysctl_hw:HW_PAGESIZE result:&result]) {
		return result;
	}

	return 0;
}


- (BOOL)resetVmstat
{
	mach_msg_type_number_t count = HOST_VM_INFO_COUNT;
	if (host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&sVmstat, &count) == KERN_SUCCESS) {
		return YES;
	}

	return NO;
}

- (unsigned int)vmstatTotal
{
	return sVmstat.wire_count + sVmstat.active_count + sVmstat.inactive_count + sVmstat.free_count;
}

- (unsigned int)vmstatWired
{
	return sVmstat.wire_count;
}

- (unsigned int)vmstatActive
{
	return sVmstat.active_count;
}

- (unsigned int)vmstatInactive
{
	return sVmstat.inactive_count;
}

- (unsigned int)vmstatFree
{
	return sVmstat.free_count;
}

- (unsigned int)physicalMemory
{
	unsigned int result;
	if ([self sysctl_hw:HW_PHYSMEM result:&result]) {
		return result;
	}

	return 0;
}

- (unsigned int)userMemory
{
	unsigned int result;
	if ([self sysctl_hw:HW_USERMEM result:&result]) {
		return result;
	}

	return 0;
}


- (unsigned int)cpuFrequency
{
	unsigned int result;
	if ([self sysctl_hw:HW_CPU_FREQ result:&result]) {
		return result;
	}

	return 0;
}

- (unsigned int)busFrequency
{
	unsigned int result;
	if ([self sysctl_hw:HW_BUS_FREQ result:&result]) {
		return result;
	}

	return 0;
}


#pragma mark - private methods

- (BOOL)sysctl_hw:(int)identifier result:(unsigned int*)ioresult
{
	int		mib[2]; 
	size_t	length;
	
	mib[0] = CTL_HW;
	mib[1] = identifier;
	length = sizeof(unsigned int);

	return sysctl(mib, 2, ioresult, &length, NULL, 0) == 0;
}



@end
