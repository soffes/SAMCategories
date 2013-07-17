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

- (void)testMD5Sum {
	NSArray *array1 = [NSArray arrayWithObjects:@"value1", @"value2", @"value3", @"value4", @"value5", nil];
	NSMutableArray *array2 = [NSMutableArray arrayWithObjects:@"value1", @"value2", @"value3", @"value4", nil];
	[array2 addObject:@"value5"];
		
	NSString *sum1 = [array1 sam_MD5Sum];
	NSString *sum2 = [array2 sam_MD5Sum];
	STAssertNotNil(sum1, nil);
	STAssertNotNil(sum2, nil);
	STAssertEqualObjects(sum1, sum2, nil);
}


- (void)testSHA1Sum {
	NSArray *array1 = [NSArray arrayWithObjects:@"value1", @"value2", @"value3", @"value4", @"value5", nil];
	NSMutableArray *array2 = [NSMutableArray arrayWithObjects:@"value1", @"value2", @"value3", @"value4", nil];
	[array2 addObject:@"value5"];
	
	NSString *sum1 = [array1 sam_SHA1Sum];
	NSString *sum2 = [array2 sam_SHA1Sum];
	STAssertNotNil(sum1, nil);
	STAssertNotNil(sum2, nil);
	STAssertEqualObjects(sum1, sum2, nil);
}

@end
