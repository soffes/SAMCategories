//
//  UIViewController+SSToolkitAdditions.m
//  SAMCategories
//
//  Created by Sam Soffes on 6/21/10.
//  Copyright (c) 2010-2014 Sam Soffes. All rights reserved.
//

#import "UIViewController+SAMAdditions.h"

@implementation UIViewController (SAMAdditions)

- (void)sam_displayError:(NSError *)error {
	if (!error) {
		return;
	}
	
	[self sam_displayErrorString:[error localizedDescription]];
}


- (void)sam_displayErrorString:(NSString *)string {
	if (!string || [string length] < 1) {
		return;
	}
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:string delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
}


- (UIViewController *)sam_firstParentViewControllerOfClass:(Class)klass {
    for (UIViewController *controller = self.parentViewController; controller != nil; controller = controller.parentViewController) {
		if ([controller isKindOfClass:klass]) {
			return controller;
		}
	}
	return nil;
}

@end
