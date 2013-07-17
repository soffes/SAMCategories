//
//  URLCategoryTest.m
//  SSToolkit
//
//  Created by Sam Soffes on 4/14/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "NSURL+SAMAdditions.h"

@interface SAMURLCategoryTest : SenTestCase
@end

@implementation SAMURLCategoryTest

- (void)testURLWithFormat {
	NSURL *url1 = [NSURL URLWithString:@"http://soff.es/my-dna"];
	NSURL *url2 = [NSURL sam_URLWithFormat:@"%@://soff.es/%@", @"http", @"my-dna"];
	STAssertNotNil(url2, nil);
	STAssertEqualObjects(url1, url2, nil);
	
	url2 = [NSURL sam_URLWithFormat:@"http://soff.es/my-dna"];
	STAssertNotNil(url2, nil);
	STAssertEqualObjects(url1, url2, nil);
}


- (void)testQueryDictionary {
	NSURL *url = [[NSURL alloc] initWithString:@"http://sstoolk.it/test?foo=bar&awesome=true"];
	NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
								@"bar", @"foo",
								@"true", @"awesome",
								nil];
	
	STAssertEqualObjects([url sam_queryDictionary], dictionary, nil);
}

@end
