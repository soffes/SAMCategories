//
//  DictionaryCategoryTest.m
//  SSToolkit
//
//  Created by Sam Soffes on 4/14/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDictionary+SAMAdditions.h"

@interface SAMDictionaryCategoryTest : XCTestCase
@end

@implementation SAMDictionaryCategoryTest

- (void)testURLEncoding {
	NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
								@"value1", @"key1",
								@"value2", @"key2",
								nil];
	
	NSString *string = [dictionary sam_stringWithFormEncodedComponents];
	XCTAssertEqualObjects([NSDictionary sam_dictionaryWithFormEncodedString:string], dictionary, @"");
	
	// Go nuts
	dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
				  @"£™¢£∞¢§∞¶•§ª¶º!@#$%^&*()", @"œ∑´∞®†¥¨ˆø",
				  @"ÎÍÏ˝ÓÔÒÚ˜Â¯", @"ç√≈∫˜µ≤∆˚¬˙©",
				  nil];
	
	string = [dictionary sam_stringWithFormEncodedComponents];
	XCTAssertEqualObjects([NSDictionary sam_dictionaryWithFormEncodedString:string], dictionary, @"");
}


- (void)testMD5Digest {
	NSDictionary *dictionary1 = [NSDictionary dictionaryWithObjectsAndKeys:
								 @"value1", @"key1",
								 @"value2", @"key2",
								 @"value3", @"key3",
								 @"value4", @"key4",
								 @"value5", @"key5",
								 nil];
	
	NSMutableDictionary *dictionary2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
										@"value3", @"key3",
										@"value4", @"key4",
										@"value5", @"key5",
										@"value1", @"key1",
										nil];
	[dictionary2 setObject:@"value2" forKey:@"key2"];
	
	NSString *digest1 = [dictionary1 sam_MD5Digest];
	NSString *digest2 = [dictionary2 sam_MD5Digest];
	XCTAssertNotNil(digest1, @"");
	XCTAssertNotNil(digest2, @"");
	XCTAssertEqualObjects(digest1, digest2, @"");
}


- (void)testSHA1Digest {
	NSDictionary *dictionary1 = [NSDictionary dictionaryWithObjectsAndKeys:
								 @"value1", @"key1",
								 @"value2", @"key2",
								 @"value3", @"key3",
								 @"value4", @"key4",
								 @"value5", @"key5",
								 nil];
	
	NSMutableDictionary *dictionary2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
										@"value3", @"key3",
										@"value4", @"key4",
										@"value5", @"key5",
										@"value1", @"key1",
										nil];
	[dictionary2 setObject:@"value2" forKey:@"key2"];
	
	NSString *digest1 = [dictionary1 sam_SHA1Digest];
	NSString *digest2 = [dictionary2 sam_SHA1Digest];
	XCTAssertNotNil(digest1, @"");
	XCTAssertNotNil(digest2, @"");
	XCTAssertEqualObjects(digest1, digest2, @"");
}

@end
