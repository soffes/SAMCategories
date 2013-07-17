//
//  DictionaryCategoryTest.m
//  SSToolkit
//
//  Created by Sam Soffes on 4/14/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "NSDictionary+SAMAdditions.h"

@interface SAMDictionaryCategoryTest : SenTestCase
@end

@implementation SAMDictionaryCategoryTest

- (void)testURLEncoding {
	NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
								@"value1", @"key1",
								@"value2", @"key2",
								nil];
	
	NSString *string = [dictionary sam_stringWithFormEncodedComponents];
	STAssertEqualObjects([NSDictionary sam_dictionaryWithFormEncodedString:string], dictionary, nil);
	
	// Go nuts
	dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
				  @"£™¢£∞¢§∞¶•§ª¶º!@#$%^&*()", @"œ∑´∞®†¥¨ˆø",
				  @"ÎÍÏ˝ÓÔÒÚ˜Â¯", @"ç√≈∫˜µ≤∆˚¬˙©",
				  nil];
	
	string = [dictionary sam_stringWithFormEncodedComponents];
	STAssertEqualObjects([NSDictionary sam_dictionaryWithFormEncodedString:string], dictionary, nil);
}


- (void)testMD5Sum {
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
	
	NSString *sum1 = [dictionary1 sam_MD5Sum];
	NSString *sum2 = [dictionary2 sam_MD5Sum];
	STAssertNotNil(sum1, nil);
	STAssertNotNil(sum2, nil);
	STAssertEqualObjects(sum1, sum2, nil);
}


- (void)testSHA1Sum {
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
	
	NSString *sum1 = [dictionary1 sam_SHA1Sum];
	NSString *sum2 = [dictionary2 sam_SHA1Sum];
	STAssertNotNil(sum1, nil);
	STAssertNotNil(sum2, nil);
	STAssertEqualObjects(sum1, sum2, nil);
}

@end
