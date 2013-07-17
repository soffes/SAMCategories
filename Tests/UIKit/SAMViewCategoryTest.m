//
//  ViewTest.m
//  SSToolkit
//
//  Created by Sam Soffes on 7/10/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "UIView+SAMAdditions.h"

@interface SAMViewCategoryTest : SenTestCase
@end

@implementation SAMViewCategoryTest

- (void)testHide {
	UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
	[view sam_hide];
	STAssertEquals(view.alpha, 0.0f, nil);
}


- (void)testShow {
	UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
	view.alpha = 0.0f;
	[view sam_show];
	STAssertEquals(view.alpha, 1.0f, nil);
}


- (void)testSuperviews {
	UIView *one = [[UIView alloc] initWithFrame:CGRectZero];
	UIView *two = [[UIView alloc] initWithFrame:CGRectZero];
	UIView *three = [[UIView alloc] initWithFrame:CGRectZero];

	[two addSubview:three];
	[one addSubview:two];
	
	NSArray *superviews = @[two, one];
	
	STAssertEqualObjects([three sam_superviews], superviews, nil);
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
	
	STAssertEqualObjects([five sam_firstSuperviewOfClass:[UIButton class]], two, nil);
}

@end
