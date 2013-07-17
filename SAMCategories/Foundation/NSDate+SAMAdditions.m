//
//  NSDate+SSToolkitAdditions.m
//  SAMCategories
//
//  Created by Sam Soffes on 5/26/10.
//  Copyright 2010-2013 Sam Soffes. All rights reserved.
//

#import "NSDate+SAMAdditions.h"
#include <time.h>
#include <xlocale.h>

#define ISO8601_MAX_LEN 25

@implementation NSDate (SAMAdditions)

+ (NSDate *)sam_dateFromISO8601String:(NSString *)iso8601 {
	if (!iso8601) {
        return nil;
    }
	
    const char *str = [iso8601 cStringUsingEncoding:NSUTF8StringEncoding];
    char newStr[ISO8601_MAX_LEN];
    bzero(newStr, ISO8601_MAX_LEN);
	
    size_t len = strlen(str);
    if (len == 0) {
        return nil;
    }
	
    // UTC dates ending with Z
    if (len == 20 && str[len - 1] == 'Z') {
        memcpy(newStr, str, len - 1);
	strncpy(newStr + len - 1, "+0000\0", 6);
    }
	
    // Timezone includes a semicolon (not supported by strptime)
    else if (len == 25 && str[22] == ':') { 
        memcpy(newStr, str, 22);    
        memcpy(newStr + 22, str + 23, 2);
    }
	
    // Fallback: date was already well-formatted OR any other case (bad-formatted)
    else { 
        memcpy(newStr, str, len > ISO8601_MAX_LEN - 1 ? ISO8601_MAX_LEN - 1 : len);	
    }
	
  // Add null terminator
  newStr[sizeof(newStr) - 1] = 0;
  
    struct tm tm = {
        .tm_sec = 0,
        .tm_min = 0,
        .tm_hour = 0,
        .tm_mday = 0,
        .tm_mon = 0,
        .tm_year = 0,
        .tm_wday = 0,
        .tm_yday = 0,
        .tm_isdst = -1,
    };
	
    if (strptime_l(newStr, "%FT%T%z", &tm, NULL) == NULL) {
        return nil;
    }

    return [NSDate dateWithTimeIntervalSince1970:mktime(&tm)];
}


- (NSString *)sam_ISO8601String {
	struct tm *timeinfo;
	char buffer[80];
	
	time_t rawtime = (time_t)[self timeIntervalSince1970];
	timeinfo = gmtime(&rawtime);
	
	strftime(buffer, 80, "%Y-%m-%dT%H:%M:%SZ", timeinfo);
	
	return [NSString stringWithCString:buffer encoding:NSUTF8StringEncoding];
}

@end
