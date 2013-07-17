//
//  StringCategoryTest.m
//  SSToolkit
//
//  Created by Sam Soffes on 4/14/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "NSString+SAMAdditions.h"

@interface SAMStringCategoryTest : SenTestCase
@end

@implementation SAMStringCategoryTest

// To test:
//- (NSString *)URLEncodedString;
//- (NSString *)URLEncodedParameterString;
//- (NSString *)URLDecodedString;

- (void)testContainsString {
	NSString *string = @"alexanderthegreat";
	
	STAssertTrue([string sam_containsString:@"alex"], nil);
	STAssertFalse([string sam_containsString:@"awesome"], nil);
}


- (void)testMD5Sum {
	STAssertEqualObjects([@"sam" sam_MD5Sum], @"332532dcfaa1cbf61e2a266bd723612c", nil);
	
	NSString *lorem = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
	STAssertEqualObjects([lorem sam_MD5Sum], @"fa5c89f3c88b81bfd5e821b0316569af", nil);
}


- (void)testSHA1Sum {
	STAssertEqualObjects([@"sam" sam_SHA1Sum], @"f16bed56189e249fe4ca8ed10a1ecae60e8ceac0", nil);
	
	NSString *lorem = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
	STAssertEqualObjects([lorem sam_SHA1Sum], @"19afa2a4a37462c7b940a6c4c61363d49c3a35f4", nil);
}


- (void)testCompareToVersionString {
	STAssertEquals([@"1.0.0" sam_compareToVersionString:@"0.0.1"], NSOrderedDescending, nil);
	STAssertEquals([@"3.2" sam_compareToVersionString:@"4.2"], NSOrderedAscending, nil);
	STAssertEquals([@"3.2.1" sam_compareToVersionString:@"4.2.1"], NSOrderedAscending, nil);
	
	STAssertEquals([@"10.4" sam_compareToVersionString:@"10.3"], NSOrderedDescending, nil);
	STAssertEquals([@"10.5" sam_compareToVersionString:@"10.5.0"], NSOrderedSame, nil);
	STAssertEquals([@"10.4 Build 8L127" sam_compareToVersionString:@"10.4 Build 8P135"], NSOrderedAscending, nil);
}


- (void)testBase64EncodedString {
	NSString *unencodedString = @"sam";
	NSString *encodedString = @"c2Ft";
	STAssertEqualObjects(encodedString, [unencodedString sam_base64EncodedString], nil);
	STAssertEqualObjects(unencodedString, [NSString sam_stringWithBase64String:encodedString], nil);
	
	unencodedString = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
	encodedString = @"TG9yZW0gaXBzdW0gZG9sb3Igc2l0IGFtZXQsIGNvbnNlY3RldHVyIGFkaXBpc2ljaW5nIGVsaXQsIHNlZCBkbyBlaXVzbW9kIHRlbXBvciBpbmNpZGlkdW50IHV0IGxhYm9yZSBldCBkb2xvcmUgbWFnbmEgYWxpcXVhLiBVdCBlbmltIGFkIG1pbmltIHZlbmlhbSwgcXVpcyBub3N0cnVkIGV4ZXJjaXRhdGlvbiB1bGxhbWNvIGxhYm9yaXMgbmlzaSB1dCBhbGlxdWlwIGV4IGVhIGNvbW1vZG8gY29uc2VxdWF0LiBEdWlzIGF1dGUgaXJ1cmUgZG9sb3IgaW4gcmVwcmVoZW5kZXJpdCBpbiB2b2x1cHRhdGUgdmVsaXQgZXNzZSBjaWxsdW0gZG9sb3JlIGV1IGZ1Z2lhdCBudWxsYSBwYXJpYXR1ci4gRXhjZXB0ZXVyIHNpbnQgb2NjYWVjYXQgY3VwaWRhdGF0IG5vbiBwcm9pZGVudCwgc3VudCBpbiBjdWxwYSBxdWkgb2ZmaWNpYSBkZXNlcnVudCBtb2xsaXQgYW5pbSBpZCBlc3QgbGFib3J1bS4=";
	STAssertEqualObjects(encodedString, [unencodedString sam_base64EncodedString], nil);
	STAssertEqualObjects(unencodedString, [NSString sam_stringWithBase64String:encodedString], nil);
	
	unencodedString = @"http://www.cocoadev.com/index.pl?BaseSixtyFour";
	encodedString = @"aHR0cDovL3d3dy5jb2NvYWRldi5jb20vaW5kZXgucGw/QmFzZVNpeHR5Rm91cg==";
	STAssertEqualObjects(encodedString, [unencodedString sam_base64EncodedString], nil);
	STAssertEqualObjects(unencodedString, [NSString sam_stringWithBase64String:encodedString], nil);
}


- (void)testEscapingAndUnescapingHTML {
	NSString *html = @"<a href=\"http://example.com/?ruby%3F=yes&amp;var=T\">example</a>";
	NSString *escapedHtml = @"&lt;a href=&quot;http://example.com/?ruby%3F=yes&amp;amp;var=T&quot;&gt;example&lt;/a&gt;";
	
	STAssertEqualObjects([html sam_escapeHTML], escapedHtml, nil);
	STAssertEqualObjects([escapedHtml sam_unescapeHTML], html, nil);
}


- (void)testStringByEscapingForURLQuery {
	STAssertEqualObjects([@"I want a 27-inch iMac!" sam_stringByEscapingForURLQuery], @"I+want+a+27-inch+iMac%21", nil);
	STAssertEqualObjects([@"myemail+category@gmail.com" sam_stringByEscapingForURLQuery], @"myemail%2Bcategory%40gmail.com", nil);
}


- (void)testStringByUnescapingFromURLQuery {
	STAssertEqualObjects([@"I+want+a+27-inch+iMac%21" sam_stringByUnescapingFromURLQuery], @"I want a 27-inch iMac!", nil);
	STAssertEqualObjects([@"myemail%2Bcategory%40gmail.com" sam_stringByUnescapingFromURLQuery], @"myemail+category@gmail.com", nil);
}


- (void)testUUID {
	NSString *uuid1 = [NSString sam_stringWithUUID];
	NSString *uuid2 = [NSString sam_stringWithUUID];
	STAssertFalse([uuid1 isEqualToString:uuid2], nil);
}

@end
