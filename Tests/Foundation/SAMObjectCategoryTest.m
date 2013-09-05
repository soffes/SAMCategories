//
//  ArrayObjectTest.m
//  SAMCategories
//
//  Created by Sam Soffes on 7/30/13.
//  Copyright 2013 Sam Soffes. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSObject+SAMAdditions.h"

@interface SAMObjectCategoryTest : XCTestCase
@end

@implementation SAMObjectCategoryTest

- (void)testAssociatedData {
	NSObject *object = [[NSObject alloc] init];
	XCTAssertTrue([object sam_associatedData].count == 0, @"");

	[object sam_associatedData][@"foo"] = @"bar";
	XCTAssertEqualObjects([object sam_associatedData][@"foo"], @"bar", @"");

	object = [[NSObject alloc] init];
	XCTAssertNil([object sam_associatedData][@"foo"], @"");
}

@end
