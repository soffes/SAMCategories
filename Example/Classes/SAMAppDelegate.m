//
//  SAMAppDelegate.m
//  SAMCategories
//
//  Created by Sam Soffes on 7/17/13.
//  Copyright (c) 2013 Sam Soffes. All rights reserved.
//

#import "SAMAppDelegate.h"
#import "SAMCategories.h"

@implementation SAMAppDelegate

@synthesize window = _window;

// Nothing to see here yet.
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.window.backgroundColor = [UIColor whiteColor];
	[self.window makeKeyAndVisible];

	NSString *message = @"Super secret stuff.";
	NSString *key = @"AwesomeKey";

	NSData *encrypted = [[message dataUsingEncoding:NSUTF8StringEncoding] sam_encryptWithKey:key algorithm:kCCAlgorithmAES128 options:kNilOptions error:nil];
	NSLog(@"Encrypted: %@ \n\n %@", encrypted, [encrypted sam_base64EncodedString]);

	return YES;
}

@end
