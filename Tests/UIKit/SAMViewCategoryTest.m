//
//  ViewTest.m
//  SSToolkit
//
//  Created by Sam Soffes on 7/10/11.
//  Copyright (c) 2011-2014. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIView+SAMAdditions.h"

@interface SAMViewCategoryTest : XCTestCase
@end

@implementation SAMViewCategoryTest

- (void)testHide {
	UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
	[view sam_hide];
	XCTAssertTrue(view.alpha == 0.0f, @"");
}


- (void)testShow {
	UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
	view.alpha = 0.0f;
	[view sam_show];
	XCTAssertTrue(view.alpha == 1.0f, @"");
}


- (void)testSuperviews {
	UIView *one = [[UIView alloc] initWithFrame:CGRectZero];
	UIView *two = [[UIView alloc] initWithFrame:CGRectZero];
	UIView *three = [[UIView alloc] initWithFrame:CGRectZero];

	[two addSubview:three];
	[one addSubview:two];
	
	NSArray *superviews = @[two, one];
	
	XCTAssertEqualObjects([three sam_superviews], superviews, @"");
}


- (void)testFirstSuperviewOfClass {
	UIView *one = [[UIButton alloc] initWithFrame:CGRectZero];
	UIView *two = [[UIButton alloc] initWithFrame:CGRectZero];
	UIView *three = [[UIView alloc] initWithFrame:CGRectZero];
	UIView *four = [[UIView alloc] initWithFrame:CGRectZero];
	UIView *five = [[UIView alloc] initWithFrame:CGRectZero];
	
	[four addSubview:five];
	[three addSubview:four];
	[two addSubview:three];
	[one addSubview:two];
	
	XCTAssertEqualObjects([five sam_firstSuperviewOfClass:[UIButton class]], two, @"");
}

@end
