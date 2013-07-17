//
//  SAMAppDelegate.m
//  SAMCategories
//
//  Created by Sam Soffes on 7/17/13.
//  Copyright (c) 2013 Sam Soffes. All rights reserved.
//

#import "SAMAppDelegate.h"
#import "NSArray+SAMAdditions.h"

@implementation SAMAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.window.backgroundColor = [UIColor whiteColor];
	[self.window makeKeyAndVisible];

	NSArray *message = @[@"Nothing", @"to", @"see", @"here"];
	NSLog(@"%@", [message sam_shuffledArray]);

	return YES;
}

@end
