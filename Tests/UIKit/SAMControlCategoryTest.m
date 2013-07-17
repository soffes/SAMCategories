//
//  ControlCategoryTest.m
//  SSToolkit
//
//  Created by Sam Soffes on 4/15/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "UIControl+SAMAdditions.h"

@interface SAMControlCategoryTest : SenTestCase
@end

@implementation SAMControlCategoryTest

- (void)testRemoveAllTargets {
	NSString *anotherObject = @"hi";
	
	UIControl *control = [[UIControl alloc] initWithFrame:CGRectZero];
	[control addTarget:self action:@selector(description) forControlEvents:UIControlEventTouchUpInside];
	[control addTarget:anotherObject action:@selector(description) forControlEvents:UIControlEventTouchUpInside];
	
	NSSet *targets = [NSSet setWithObjects:self, anotherObject, nil];
	STAssertEqualObjects([control allTargets], targets, nil);
	
	[control sam_removeAllTargets];
	
	STAssertTrue([[control allTargets] count] == 0, nil);
}

@end
