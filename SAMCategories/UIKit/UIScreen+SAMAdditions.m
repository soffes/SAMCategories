//
//  UIScreen+SSToolkitAdditions.m
//  SAMCategories
//
//  Created by Sam Soffes on 2/4/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import "UIScreen+SAMAdditions.h"

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

@end
