//
//  UIView+SSToolkitAdditions.m
//  SAMCategories
//
//  Created by Sam Soffes on 2/15/10.
//  Copyright (c) 2010-2014 Sam Soffes. All rights reserved.
//

#import "UIView+SAMAdditions.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (SAMAdditions)

- (UIImage *)sam_imageRepresentation {
	UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0.0f);
	[self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}


- (void)sam_hide {
	self.alpha = 0.0f;
}


- (void)sam_show {
	self.alpha = 1.0f;
}


- (void)sam_fadeOut {
	UIView *view = self;
	[UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
		view.alpha = 0.0f;
	} completion:nil];
}


- (void)sam_fadeOutAndRemoveFromSuperview {
	UIView *view = self;
	[UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
		view.alpha = 0.0f;
	} completion:^(BOOL finished) {
		[view removeFromSuperview];
	}];
}


- (void)sam_fadeIn {
	UIView *view = self;
	[UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
		view.alpha = 1.0f;
	} completion:nil];
}


- (NSArray *)sam_superviews {
	NSMutableArray *superviews = [[NSMutableArray alloc] init];
	
	UIView *view = self;
	UIView *superview = nil;
	while (view) {
		superview = [view superview];
		if (!superview) {
			break;
		}
		
		[superviews addObject:superview];
		view = superview;
	}
	
	return superviews;
}

- (id)sam_firstSuperviewOfClass:(Class)superviewClass {
	for (UIView *view = [self superview]; view != nil; view = [view superview]) {
		if ([view isKindOfClass:superviewClass]) {
			return view;
		}		
	}
	return nil;
}

- (CGPoint)sam_trueCenter {
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    return UIInterfaceOrientationIsLandscape(orientation) ? CGPointMake(self.center.y, self.center.x) : self.center;
}


- (void)sam_resetConstraints {
	[self removeConstraints:[self constraints]];
	[self setNeedsUpdateConstraints];
}

@end
