//
//  UIApplication+SSToolkitAdditions.m
//  SAMCategories
//
//  Created by Sam Soffes on 10/20/10.
//  Copyright (c) 2010-2014 Sam Soffes. All rights reserved.
//

#import "UIApplication+SAMAdditions.h"

@interface UIApplication (SAMPrivateAdditions)
- (void)sam_setNetworkActivityWithNumber:(NSNumber *)number;
- (void)sam_setNetworkActivityIndicatorHidden;
@end


@implementation UIApplication (SAMAdditions)

- (BOOL)sam_isPirated {
	return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"SignerIdentity"] != nil;
}


- (void)sam_setNetworkActivity:(BOOL)inProgress {
	// Ensure we're on the main thread
	if ([NSThread isMainThread] == NO) {
		[self performSelectorOnMainThread:@selector(sam_setNetworkActivityWithNumber:) withObject:[NSNumber numberWithBool:inProgress] waitUntilDone:NO];
		return;
	}
	
	[[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(sam_setNetworkActivityIndicatorHidden) object:nil];
	
	if (inProgress == YES) {
		if (self.networkActivityIndicatorVisible == NO) {
			self.networkActivityIndicatorVisible = inProgress;
		}
	} else {
		[self performSelector:@selector(sam_setNetworkActivityIndicatorHidden) withObject:nil afterDelay:0.3];
	}
}


- (NSURL *)sam_documentsDirectoryURL {
	return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


- (NSURL *)sam_cachesDirectoryURL {
	return [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSURL *)sam_downloadsDirectoryURL {
	return [[[NSFileManager defaultManager] URLsForDirectory:NSDownloadsDirectory inDomains:NSUserDomainMask] lastObject];
}


- (NSURL *)sam_libraryDirectoryURL {
	return [[[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask] lastObject];
}


- (NSURL *)sam_applicationSupportDirectoryURL {
	return [[[NSFileManager defaultManager] URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
}

@end


@implementation UIApplication (SAMPrivateAdditions)

- (void)sam_setNetworkActivityWithNumber:(NSNumber *)number {
	[self sam_setNetworkActivity:[number boolValue]];
}


- (void)sam_setNetworkActivityIndicatorHidden {
	self.networkActivityIndicatorVisible = NO;
}

@end
