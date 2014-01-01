//
//  URLCategoryTest.m
//  SSToolkit
//
//  Created by Sam Soffes on 4/14/11.
//  Copyright (c) 2011-2014. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSURL+SAMAdditions.h"

@interface SAMURLCategoryTest : XCTestCase
@end

@implementation SAMURLCategoryTest

- (void)testURLWithFormat {
	NSURL *url1 = [NSURL URLWithString:@"http://soff.es/my-dna"];
	NSURL *url2 = [NSURL sam_URLWithFormat:@"%@://soff.es/%@", @"http", @"my-dna"];
	XCTAssertNotNil(url2, @"");
	XCTAssertEqualObjects(url1, url2, @"");
	
	url2 = [NSURL sam_URLWithFormat:@"http://soff.es/my-dna"];
	XCTAssertNotNil(url2, @"");
	XCTAssertEqualObjects(url1, url2, @"");
}


- (void)testQueryDictionary {
	NSURL *url = [[NSURL alloc] initWithString:@"http://sstoolk.it/test?foo=bar&awesome=true"];
	NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
								@"bar", @"foo",
								@"true", @"awesome",
								nil];
	
	XCTAssertEqualObjects([url sam_queryDictionary], dictionary, @"");
}

@end
