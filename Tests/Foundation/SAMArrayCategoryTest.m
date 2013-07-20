//
//  ArrayCategoryTest.m
//  SAMCategories
//
//  Created by Sam Soffes on 4/14/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "NSArray+SAMAdditions.h"

@interface SAMArrayCategoryTest : SenTestCase
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
	STAssertNotNil(digest1, nil);
	STAssertNotNil(digest2, nil);
	STAssertEqualObjects(digest1, digest2, nil);
}


- (void)testSHA1Digest {
	NSArray *array1 = [NSArray arrayWithObjects:@"value1", @"value2", @"value3", @"value4", @"value5", nil];
	NSMutableArray *array2 = [NSMutableArray arrayWithObjects:@"value1", @"value2", @"value3", @"value4", nil];
	[array2 addObject:@"value5"];
	
	NSString *digest1 = [array1 sam_SHA1Digest];
	NSString *digest2 = [array2 sam_SHA1Digest];
	STAssertNotNil(digest1, nil);
	STAssertNotNil(digest2, nil);
	STAssertEqualObjects(digest1, digest2, nil);
}

@end
