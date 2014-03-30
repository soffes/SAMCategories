//
//  NSDate+SSToolkitAdditions.m
//  SAMCategories
//
//  Created by Sam Soffes on 5/26/10.
//  Copyright (c) 2010-2014 Sam Soffes. All rights reserved.
//

#import "NSDate+SAMAdditions.h"
#include <time.h>
#include <xlocale.h>
#import <CoreGraphics/CoreGraphics.h>

#define SAMCategoriesBundle [NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"SAMCategories.bundle"]]
#define SAMCategoriesLocalizedString(key)  NSLocalizedStringFromTableInBundle((key), @"SAMCategories", SAMCategoriesBundle, nil)

@implementation NSDate (SAMAdditions)

+ (NSDate *)sam_dateFromISO8601String:(NSString *)iso8601 {
	// Return nil if nil is given
	if (!iso8601 || [iso8601 isEqual:[NSNull null]]) {
		return nil;
	}

	// Parse number
	if ([iso8601 isKindOfClass:[NSNumber class]]) {
		return [NSDate dateWithTimeIntervalSince1970:[(NSNumber *)iso8601 doubleValue]];
	}

	// Parse string
	else if ([iso8601 isKindOfClass:[NSString class]]) {
		const char *str = [iso8601 cStringUsingEncoding:NSUTF8StringEncoding];
		size_t len = strlen(str);
		if (len == 0) {
			return nil;
		}

		struct tm tm;
		char newStr[25] = "";
		BOOL hasTimezone = NO;

		// 2014-03-30T09:13:00Z
		if (len == 20 && str[len - 1] == 'Z') {
			strncpy(newStr, str, len - 1);
		}

		// 2014-03-30T09:13:00-07:00
		else if (len == 25 && str[22] == ':') {
			strncpy(newStr, str, 19);
			hasTimezone = YES;
		}

		// 2014-03-30T09:13:00.000Z
		else if (len == 24 && str[len - 1] == 'Z') {
			strncpy(newStr, str, 19);
		}

		// 2014-03-30T09:13:00.000-07:00
		else if (len == 29 && str[26] == ':') {
			strncpy(newStr, str, 19);
			hasTimezone = YES;
		}

		// Poorly formatted timezone
		else {
			strncpy(newStr, str, len > 24 ? 24 : len);
		}

		// Timezone
		size_t l = strlen(newStr);
		if (hasTimezone) {
			strncpy(newStr + l, str + len - 6, 3);
			strncpy(newStr + l + 3, str + len - 2, 2);
		} else {
			strncpy(newStr + l, "+0000", 5);
		}

		// Add null terminator
		newStr[sizeof(newStr) - 1] = 0;

		if (strptime(newStr, "%FT%T%z", &tm) == NULL) {
			return nil;
		}

		time_t t;
		t = mktime(&tm);

		return [NSDate dateWithTimeIntervalSince1970:t];
	}

	NSAssert1(NO, @"Failed to parse date: %@", iso8601);
	return nil;
}


- (NSString *)sam_ISO8601String {
	struct tm *timeinfo;
	char buffer[80];
	
	time_t rawtime = (time_t)[self timeIntervalSince1970];
	timeinfo = gmtime(&rawtime);
	
	strftime(buffer, 80, "%Y-%m-%dT%H:%M:%SZ", timeinfo);
	
	return [NSString stringWithCString:buffer encoding:NSUTF8StringEncoding];
}

- (NSString *)sam_briefTimeInWords {
	NSTimeInterval seconds = fabs([self timeIntervalSinceNow]);

	static NSNumberFormatter *numberFormatter = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		numberFormatter = [[NSNumberFormatter alloc] init];
		numberFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
		numberFormatter.currencySymbol = @"";
		numberFormatter.maximumFractionDigits = 0;
	});

	// Seconds
	if (seconds < 60.0) {
		if (seconds < 2.0) {
			return SAMCategoriesLocalizedString(@"1s");
		}
		return [NSString stringWithFormat:SAMCategoriesLocalizedString(@"%ds"), (NSInteger)seconds];
	}

	NSTimeInterval minutes = round(seconds / 60.0);

	// Minutes
	if (minutes >= 0.0 && minutes < 60.0) {
		if (minutes < 2.0) {
			return SAMCategoriesLocalizedString(@"1m");
		}
		return [NSString stringWithFormat:SAMCategoriesLocalizedString(@"%dm"), (NSInteger)minutes];
	}

	// Hours
	else if (minutes >= 60.0 && minutes < 1440.0) {
		NSInteger hours = (NSInteger)((double)minutes / 60.0);
		if (hours < 2) {
			return SAMCategoriesLocalizedString(@"1h");
		}
		return [NSString stringWithFormat:SAMCategoriesLocalizedString(@"%dh"), hours];
	}

	// Days
	else if (minutes >= 1440.0 && minutes < 525600.0) {
		NSInteger days = (NSInteger)((double)minutes / 1440.0);
		if (days < 2) {
			return SAMCategoriesLocalizedString(@"1d");
		}
		return [NSString stringWithFormat:SAMCategoriesLocalizedString(@"%@d"),
				[numberFormatter stringFromNumber:[NSNumber numberWithInteger:days]]];
	}

	// Years
	else if (minutes >= 525600.0) {
		NSInteger years = (NSInteger)((double)minutes / 525600.0);
		if (years < 2) {
			return SAMCategoriesLocalizedString(@"1y");
		}
		return [NSString stringWithFormat:SAMCategoriesLocalizedString(@"%@y"),
				[numberFormatter stringFromNumber:[NSNumber numberWithInteger:years]]];
	}

	return nil;
}


+ (NSString *)sam_timeInWordsFromTimeInterval:(NSTimeInterval)intervalInSeconds includingSeconds:(BOOL)includeSeconds {
	NSTimeInterval intervalInMinutes = round(intervalInSeconds / 60.0f);

	if (intervalInMinutes >= 0 && intervalInMinutes <= 1) {
		if (!includeSeconds) {
			return intervalInMinutes <= 0 ? SAMCategoriesLocalizedString(@"less than a minute") : SAMCategoriesLocalizedString(@"1 minute");
		}
		if (intervalInSeconds >= 0 && intervalInSeconds < 5) {
			return [NSString stringWithFormat:SAMCategoriesLocalizedString(@"less than %d seconds"), 5];
		} else if (intervalInSeconds >= 5 && intervalInSeconds < 10) {
			return [NSString stringWithFormat:SAMCategoriesLocalizedString(@"less than %d seconds"), 10];
		} else if (intervalInSeconds >= 10 && intervalInSeconds < 20) {
			return [NSString stringWithFormat:@"%d seconds", 20];
		} else if (intervalInSeconds >= 20 && intervalInSeconds < 40) {
			return SAMCategoriesLocalizedString(@"half a minute");
		} else if (intervalInSeconds >= 40 && intervalInSeconds < 60) {
			return SAMCategoriesLocalizedString(@"less than a minute");
	 	} else {
			return SAMCategoriesLocalizedString(@"1 minute");
		}
	} else if (intervalInMinutes >= 2 && intervalInMinutes <= 44) {
		return [NSString stringWithFormat:SAMCategoriesLocalizedString(@"%d minutes"), (NSInteger)intervalInMinutes];
	} else if (intervalInMinutes >= 45 && intervalInMinutes <= 89) {
		return SAMCategoriesLocalizedString(@"about 1 hour");
	} else if (intervalInMinutes >= 90 && intervalInMinutes <= 1439) {
		return [NSString stringWithFormat:SAMCategoriesLocalizedString(@"about %d hours"), (NSInteger)ceilf((CGFloat)intervalInMinutes / 60.0f)];
	} else if (intervalInMinutes >= 1440 && intervalInMinutes <= 2879) {
		return SAMCategoriesLocalizedString(@"1 day");
	} else if (intervalInMinutes >= 2880 && intervalInMinutes <= 43199) {
		return [NSString stringWithFormat:SAMCategoriesLocalizedString(@"%d days"), (NSInteger)ceilf((CGFloat)intervalInMinutes / 1440.0f)];
	} else if (intervalInMinutes >= 43200 && intervalInMinutes <= 86399) {
		return SAMCategoriesLocalizedString(@"about 1 month");
	} else if (intervalInMinutes >= 86400 && intervalInMinutes <= 525599) {
		return [NSString stringWithFormat:SAMCategoriesLocalizedString(@"%d months"), (NSInteger)ceilf((CGFloat)intervalInMinutes / 43200.0f)];
	} else if (intervalInMinutes >= 525600 && intervalInMinutes <= 1051199) {
		return SAMCategoriesLocalizedString(@"about 1 year");
	} else {
		return [NSString stringWithFormat:SAMCategoriesLocalizedString(@"over %d years"), (NSInteger)ceilf((CGFloat)intervalInMinutes / 525600.0f)];
	}
	return nil;
}


- (NSString *)sam_timeInWords {
	return [self sam_timeInWordsIncludingSeconds:YES];
}


- (NSString *)sam_timeInWordsIncludingSeconds:(BOOL)includeSeconds {
	return [[self class] sam_timeInWordsFromTimeInterval:fabs([self timeIntervalSinceNow]) includingSeconds:includeSeconds];
}

@end
