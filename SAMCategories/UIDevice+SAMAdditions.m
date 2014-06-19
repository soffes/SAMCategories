//
//  UIDevice+SSToolkitAdditions.m
//  SAMCategories
//
//  Created by Sam Soffes on 7/13/09.
//  Copyright (c) 2009-2014 Sam Soffes. All rights reserved.
//

#import "UIDevice+SAMAdditions.h"
#import "NSString+SAMAdditions.h"
#import "NSObject+SAMAdditions.h"

#import <sys/sysctl.h>

@implementation UIDevice (SAMAdditions)

- (BOOL)sam_isSimulator {
	static NSString *simulatorModel = @"iPhone Simulator";
	return [[self model] isEqualToString:simulatorModel];	
}


- (BOOL)sam_isCrappy {
	static NSString *iPodTouchModel = @"iPod touch";
	static NSString *iPhoneModel = @"iPhone";
	static NSString *iPhone3GModel = @"iPhone 3G";
	static NSString *iPhone3GSModel = @"iPhone 3GS";
	
	NSString *model = [self model];
	
	return ([model isEqualToString:iPodTouchModel] || [model isEqualToString:iPhoneModel] ||
			[model isEqualToString:iPhone3GModel] || [model isEqualToString:iPhone3GSModel]);
}


- (BOOL)sam_isInnsbruck {
    NSNumber *number = [self sam_associatedData][@"innsbruck"];
    if (number == nil) {
        number = @NO;
        static NSString * const innsbruck = @"7.0";
        NSComparisonResult result = [[self systemVersion] sam_compareToVersionString:innsbruck];
        if (result == NSOrderedDescending || result == NSOrderedSame) {
            number = @YES;
        }
        [self sam_associatedData][@"innsbruck"] = number;
    }
    return [number boolValue];
}


- (NSString *)sam_hardwareModel {
    const char *type = "hw.machine";
    size_t length;
    sysctlbyname(type, NULL, &length, NULL, 0);
    char *machine = malloc(length);
    sysctlbyname(type, machine, &length, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    return platform;
}

@end
