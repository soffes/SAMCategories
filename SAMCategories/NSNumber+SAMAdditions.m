//
//  NSNumber+SSToolkitAdditions.m
//  SAMCategories
//
//  Created by Alexander Zats on 5/22/12.
//  Copyright (c) 2012-2014 Sam Soffes. All rights reserved.
//

#import "NSNumber+SAMAdditions.h"

@implementation NSNumber (SAMAdditions)

- (NSDate *)sam_dateValue {
	return [NSDate dateWithTimeIntervalSince1970:[self doubleValue]];
}

@end
