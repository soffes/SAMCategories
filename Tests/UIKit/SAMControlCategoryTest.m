//
//  ControlCategoryTest.m
//  SSToolkit
//
//  Created by Sam Soffes on 4/15/11.
//  Copyright (c) 2011-2014. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIControl+SAMAdditions.h"

@interface SAMControlCategoryTest : XCTestCase
@end

@implementation SAMControlCategoryTest

- (void)testRemoveAllTargets {
	NSString *anotherObject = @"hi";
	
	UIControl *control = [[UIControl alloc] initWithFrame:CGRectZero];
	[control addTarget:self action:@selector(description) forControlEvents:UIControlEventTouchUpInside];
	[control addTarget:anotherObject action:@selector(description) forControlEvents:UIControlEventTouchUpInside];
	
	NSSet *targets = [NSSet setWithObjects:self, anotherObject, nil];
	XCTAssertEqualObjects([control allTargets], targets, @"");
	
	[control sam_removeAllTargets];
	
	XCTAssertTrue([[control allTargets] count] == 0, @"");
}

@end
