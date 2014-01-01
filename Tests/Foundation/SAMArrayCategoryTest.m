//
//  ArrayCategoryTest.m
//  SAMCategories
//
//  Created by Sam Soffes on 4/14/11.
//  Copyright (c) 2011-2014. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSArray+SAMAdditions.h"

@interface SAMArrayCategoryTest : XCTestCase
@end

@implementation SAMArrayCategoryTest

// To test:
//- (id)randomObject
//- (NSArray *)shuffledArray

- (void)testMD5Digest {
	NSArray *array1 = [NSArray arrayWithObjects:@"value1", @"value2", @"value3", @"value4", @"value5", nil];
	NSMutableArray *array2 = [NSMutableArray arrayWithObjects:@"value1", @"value2", @"value3", @"value4", nil];
	[array2 addObject:@"value5"];
		
	NSString *digest1 = [array1 sam_MD5Digest];
	NSString *digest2 = [array2 sam_MD5Digest];
	XCTAssertNotNil(digest1, @"");
	XCTAssertNotNil(digest2, @"");
	XCTAssertEqualObjects(digest1, digest2, @"");
}


- (void)testSHA1Digest {
	NSArray *array1 = [NSArray arrayWithObjects:@"value1", @"value2", @"value3", @"value4", @"value5", nil];
	NSMutableArray *array2 = [NSMutableArray arrayWithObjects:@"value1", @"value2", @"value3", @"value4", nil];
	[array2 addObject:@"value5"];
	
	NSString *digest1 = [array1 sam_SHA1Digest];
	NSString *digest2 = [array2 sam_SHA1Digest];
	XCTAssertNotNil(digest1, @"");
	XCTAssertNotNil(digest2, @"");
	XCTAssertEqualObjects(digest1, digest2, @"");
}

@end
