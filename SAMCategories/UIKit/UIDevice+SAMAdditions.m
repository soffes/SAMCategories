//
//  UIDevice+SSToolkitAdditions.m
//  SAMCategories
//
//  Created by Sam Soffes on 7/13/09.
//  Copyright 2009-2011 Sam Soffes. All rights reserved.
//

#import "UIDevice+SAMAdditions.h"

#import <objc/runtime.h>
#import "NSString+SAMAdditions.h"

static int SAMAssociatedDataKey = 0;

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


- (NSMutableDictionary *)sam_associatedData {
    NSMutableDictionary *dictionary = objc_getAssociatedObject(self, &SAMAssociatedDataKey);
    if (dictionary == nil) {
        dictionary = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, &SAMAssociatedDataKey, dictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dictionary;
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


- (BOOL)sam_isGiraffe {
    NSNumber *number = [self sam_associatedData][@"girraffe"];
    if (number == nil) {
        number = @NO;
        UIScreen *screen = [UIScreen mainScreen];
        if (screen.bounds.size.height == 568.0) {
            number = @YES;
        }
        [self sam_associatedData][@"girraffe"] = number;
    }
    return [number boolValue];
}

@end
