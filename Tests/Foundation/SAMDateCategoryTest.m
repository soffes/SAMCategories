//
//  DateCategoryTest.m
//  SSToolkit
//
//  Created by Sam Soffes on 4/14/11.
//  Copyright (c) 2011-2014. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDate+SAMAdditions.h"

@interface SAMDateCategoryTest : XCTestCase
@end

@implementation SAMDateCategoryTest

// To test:
//+ (NSString *)timeAgoInWordsFromTimeInterval:(NSTimeInterval)intervalInSeconds includingSeconds:(BOOL)includeSeconds;
//- (NSString *)timeAgoInWords;
//- (NSString *)timeAgoInWordsIncludingSeconds:(BOOL)includeSeconds;
//- (NSString *)briefTimeAgoInWords;

- (void)testDateFromISO8601String {
	NSDate *date = [NSDate dateWithTimeIntervalSince1970:1296502956];
	NSString *string = @"2011-01-31T19:42:36Z";
	XCTAssertEqualObjects(date, [NSDate sam_dateFromISO8601String:string], @"");

	date = [NSDate dateWithTimeIntervalSince1970:1323818220];
	string = @"2011-12-13T17:17:00-06:00";
	XCTAssertEqualObjects(date, [NSDate sam_dateFromISO8601String:string], @"");

	date = [NSDate dateWithTimeIntervalSince1970:1372347572];
	string = @"2013-06-27T15:39:32.508Z";
	XCTAssertEqualObjects(date, [NSDate sam_dateFromISO8601String:string], @"");

	date = [NSDate dateWithTimeIntervalSince1970:1395198000];
	string = @"2014-03-18T20:00:00.000-07:00";
	XCTAssertEqualObjects(date, [NSDate sam_dateFromISO8601String:string], @"");
}


- (void)testISO8601String {
	NSDate *date = [NSDate dateWithTimeIntervalSince1970:1296502956];
	NSString *string = @"2011-01-31T19:42:36Z";
	XCTAssertEqualObjects(string, [date sam_ISO8601String], @"");
	
	date = [NSDate dateWithTimeIntervalSince1970:1336467079];
	string = @"2012-05-08T08:51:19Z";
	XCTAssertEqualObjects(string, [date sam_ISO8601String], @"");
}

@end
