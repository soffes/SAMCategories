//
//  ArrayObjectTest.m
//  SAMCategories
//
//  Created by Sam Soffes on 7/30/13.
//  Copyright 2013 Sam Soffes. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "NSObject+SAMAdditions.h"

@interface SAMObjectCategoryTest : SenTestCase
@end

@implementation SAMObjectCategoryTest

- (void)testAssociatedData {
	NSObject *object = [[NSObject alloc] init];
	STAssertTrue([object sam_associatedData].count == 0, nil);

	[object sam_associatedData][@"foo"] = @"bar";
	STAssertEqualObjects([object sam_associatedData][@"foo"], @"bar", nil);

	object = [[NSObject alloc] init];
	STAssertNil([object sam_associatedData][@"foo"], nil);
}

@end
