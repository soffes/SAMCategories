//
//  UIScreen+SSToolkitAdditions.m
//  SAMCategories
//
//  Created by Sam Soffes on 2/4/11.
//  Copyright (c) 2011-2014. All rights reserved.
//

#import "UIScreen+SAMAdditions.h"
#import "NSObject+SAMAdditions.h"

@implementation UIScreen (SAMAdditions)

- (CGRect)sam_currentBounds {
	return [self sam_boundsForOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
}


- (CGRect)sam_boundsForOrientation:(UIInterfaceOrientation)orientation {
	CGRect bounds = [self bounds];

	if (UIInterfaceOrientationIsLandscape(orientation)) {
		CGFloat buffer = bounds.size.width;

		bounds.size.width = bounds.size.height;
		bounds.size.height = buffer;
	}
	return bounds;
}


- (BOOL)sam_isRetina {
	static dispatch_once_t predicate;
	static BOOL answer;

	dispatch_once(&predicate, ^{
		answer = ([self respondsToSelector:@selector(scale)] && [self scale] == 2.0f);
	});
	return answer;
}


- (BOOL)sam_isGiraffe {
    NSNumber *number = [self sam_associatedData][@"girraffe"];
    if (number == nil) {
        number = @NO;
        if (self.bounds.size.height == 568.0) {
            number = @YES;
        }
        [self sam_associatedData][@"girraffe"] = number;
    }
    return [number boolValue];
}

@end
