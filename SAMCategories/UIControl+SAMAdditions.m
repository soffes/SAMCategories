//
//  UIControl+SSToolkitAdditions.m
//  SAMCategories
//
//  Created by Sam Soffes on 4/19/10.
//  Copyright (c) 2010-2014 Sam Soffes. All rights reserved.
//

#import "UIControl+SAMAdditions.h"

@implementation UIControl (SAMAdditions)

- (void)sam_removeAllTargets {
	[[self allTargets] enumerateObjectsUsingBlock:^(id object, BOOL *stop) {
		[self removeTarget:object action:NULL forControlEvents:UIControlEventAllEvents];
	}];
}


- (void)sam_setTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
	NSSet *targets = [self allTargets];
	for (id currentTarget in targets) {
		NSArray *actions = [self actionsForTarget:currentTarget forControlEvent:controlEvents];
		for (NSString *currentAction in actions) {
			[self removeTarget:currentTarget action:NSSelectorFromString(currentAction) forControlEvents:controlEvents];
		}
	}
	[self addTarget:target action:action forControlEvents:controlEvents];
}

@end
