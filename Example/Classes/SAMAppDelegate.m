//
//  SAMAppDelegate.m
//  SAMCategories
//
//  Created by Sam Soffes on 7/17/13.
//  Copyright (c) 2013 Sam Soffes. All rights reserved.
//

#import "SAMAppDelegate.h"
#import "NSArray+SAMAdditions.h"
#import "NSDate+SAMAdditions.h"

@implementation SAMAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.window.backgroundColor = [UIColor whiteColor];
	[self.window makeKeyAndVisible];

	NSArray *message = @[@"Nothing", @"to", @"see", @"here"];
	NSLog(@"%@", [message sam_shuffledArray]);
	NSLog(@"Now: %@", [[NSDate date] sam_timeInWords]);

	NSBundle *bundle = [NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"SAMCategories.bundle"]];
	NSLog(@"%@", NSLocalizedStringFromTableInBundle(@"less than %d seconds", @"SAMCategories", bundle, nil));

	return YES;
}

@end
