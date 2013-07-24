//
//  NSString+SSToolkitAdditions.m
//  SAMCategories
//
//  Created by Sam Soffes on 6/22/09.
//  Copyright 2009-2011 Sam Soffes. All rights reserved.
//

#import "NSString+SAMAdditions.h"
#import "NSData+SAMAdditions.h"

@interface NSString (SAMPrivateAdditions)
- (NSData *)sam_prehashData;
@end

@implementation NSString (SAMAdditions)

- (BOOL)sam_containsString:(NSString *)string {
	return !NSEqualRanges([self rangeOfString:string], NSMakeRange(NSNotFound, 0));
}

- (NSString *)sam_MD2Digest {
	return [[self sam_prehashData] sam_MD2Digest];
}


- (NSString *)sam_MD4Digest {
	return [[self sam_prehashData] sam_MD4Digest];
}


- (NSString *)sam_SHA224Digest {
	return [[self sam_prehashData] sam_SHA224Digest];
}


- (NSString *)sam_SHA384Digest {
	return [[self sam_prehashData] sam_SHA384Digest];
}


- (NSString *)sam_SHA512Digest {
	return [[self sam_prehashData] sam_SHA512Digest];
}


- (NSString *)sam_MD5Digest {
	return [[self sam_prehashData] sam_MD5Digest];
}


- (NSString *)sam_SHA1Digest {
	return [[self sam_prehashData] sam_SHA1Digest];
}


- (NSString *)sam_SHA256Digest {
	return [[self sam_prehashData] sam_SHA256Digest];
}


- (NSString *)sam_HMACDigestWithKey:(NSString *)key algorithm:(CCHmacAlgorithm)algorithm {
	const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [self cStringUsingEncoding:NSASCIIStringEncoding];

	NSUInteger length = 0;
	switch (algorithm) {
		case kCCHmacAlgSHA1: {
			length = CC_SHA1_DIGEST_LENGTH;
			break;
		}

		case kCCHmacAlgMD5: {
			length = CC_MD5_DIGEST_LENGTH;
			break;
		}

		case kCCHmacAlgSHA224: {
			length = CC_SHA224_DIGEST_LENGTH;
			break;
		}

		case kCCHmacAlgSHA256: {
			length = CC_SHA256_DIGEST_LENGTH;
			break;
		}

		case kCCHmacAlgSHA384: {
			length = CC_SHA384_DIGEST_LENGTH;
			break;
		}

		case kCCHmacAlgSHA512: {
			length = CC_SHA512_DIGEST_LENGTH;
			break;
		}
	}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wvla"
    unsigned char digest[length];
#pragma clang diagnostic pop
	
    CCHmac(algorithm, cKey, strlen(cKey), cData, strlen(cData), digest);

    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:length * 2];
    for (NSUInteger i = 0; i < length; i++) {
        [string appendFormat:@"%02lx", (unsigned long)digest[i]];
	}
	return string;
}


// Adapted from http://snipplr.com/view/2771/compare-two-version-strings
- (NSComparisonResult)sam_compareToVersionString:(NSString *)version {
	// Break version into fields (separated by '.')
	NSMutableArray *leftFields  = [[NSMutableArray alloc] initWithArray:[self  componentsSeparatedByString:@"."]];
	NSMutableArray *rightFields = [[NSMutableArray alloc] initWithArray:[version componentsSeparatedByString:@"."]];
	
	// Implict ".0" in case version doesn't have the same number of '.'
	if ([leftFields count] < [rightFields count]) {
		while ([leftFields count] != [rightFields count]) {
			[leftFields addObject:@"0"];
		}
	} else if ([leftFields count] > [rightFields count]) {
		while ([leftFields count] != [rightFields count]) {
			[rightFields addObject:@"0"];
		}
	}
	
	// Do a numeric comparison on each field
	for (NSUInteger i = 0; i < [leftFields count]; i++) {
		NSComparisonResult result = [[leftFields objectAtIndex:i] compare:[rightFields objectAtIndex:i] options:NSNumericSearch];
		if (result != NSOrderedSame) {
			return result;
		}
	}
	
	return NSOrderedSame;
}


#pragma mark - HTML Methods

- (NSString *)sam_escapeHTML {
	NSMutableString *s = [NSMutableString string];
	
	NSUInteger start = 0;
	NSUInteger len = [self length];
	NSCharacterSet *chs = [NSCharacterSet characterSetWithCharactersInString:@"<>&\""];
	
	while (start < len) {
		NSRange r = [self rangeOfCharacterFromSet:chs options:NSCaseInsensitiveSearch range:NSMakeRange(start, len-start)];
		if (r.location == NSNotFound) {
			[s appendString:[self substringFromIndex:start]];
			break;
		}
		
		if (start < r.location) {
			[s appendString:[self substringWithRange:NSMakeRange(start, r.location-start)]];
		}
		
		switch ([self characterAtIndex:r.location]) {
			case '<':
				[s appendString:@"&lt;"];
				break;
			case '>':
				[s appendString:@"&gt;"];
				break;
			case '"':
				[s appendString:@"&quot;"];
				break;
//			case '…':
//				[s appendString:@"&hellip;"];
//				break;
			case '&':
				[s appendString:@"&amp;"];
				break;
		}
		
		start = r.location + 1;
	}
	
	return s;
}


- (NSString *)sam_unescapeHTML {
	NSMutableString *s = [NSMutableString string];
	NSMutableString *target = [self mutableCopy];
	NSCharacterSet *chs = [NSCharacterSet characterSetWithCharactersInString:@"&"];
	
	while ([target length] > 0) {
		NSRange r = [target rangeOfCharacterFromSet:chs];
		if (r.location == NSNotFound) {
			[s appendString:target];
			break;
		}
		
		if (r.location > 0) {
			[s appendString:[target substringToIndex:r.location]];
			[target deleteCharactersInRange:NSMakeRange(0, r.location)];
		}
		
		if ([target hasPrefix:@"&lt;"]) {
			[s appendString:@"<"];
			[target deleteCharactersInRange:NSMakeRange(0, 4)];
		} else if ([target hasPrefix:@"&gt;"]) {
			[s appendString:@">"];
			[target deleteCharactersInRange:NSMakeRange(0, 4)];
		} else if ([target hasPrefix:@"&quot;"]) {
			[s appendString:@"\""];
			[target deleteCharactersInRange:NSMakeRange(0, 6)];
		} else if ([target hasPrefix:@"&#39;"]) {
			[s appendString:@"'"];
			[target deleteCharactersInRange:NSMakeRange(0, 5)];
		} else if ([target hasPrefix:@"&amp;"]) {
			[s appendString:@"&"];
			[target deleteCharactersInRange:NSMakeRange(0, 5)];
		} else if ([target hasPrefix:@"&hellip;"]) {
			[s appendString:@"…"];
			[target deleteCharactersInRange:NSMakeRange(0, 8)];
		} else {
			[s appendString:@"&"];
			[target deleteCharactersInRange:NSMakeRange(0, 1)];
		}
	}
	
	return s;
}


#pragma mark - URL Escaping and Unescaping

- (NSString *)sam_stringByEscapingForURLQuery {
	NSString *result = self;

	static CFStringRef leaveAlone = CFSTR(" ");
	static CFStringRef toEscape = CFSTR("\n\r:/=,!$&'()*+;[]@#?%");

	CFStringRef escapedStr = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)self, leaveAlone,
																	 toEscape, kCFStringEncodingUTF8);

	if (escapedStr) {
		NSMutableString *mutable = [NSMutableString stringWithString:(__bridge NSString *)escapedStr];
		CFRelease(escapedStr);

		[mutable replaceOccurrencesOfString:@" " withString:@"+" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [mutable length])];
		result = mutable;
	}
	return result;  
}


- (NSString *)sam_stringByUnescapingFromURLQuery {
	NSString *deplussed = [self stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    return [deplussed stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}


#pragma mark - Base64 Encoding

- (NSString *)sam_base64EncodedString  {
    if ([self length] == 0) {
        return nil;
	}
	
	return [[self dataUsingEncoding:NSUTF8StringEncoding] sam_base64EncodedString];
}


+ (NSString *)sam_stringWithBase64String:(NSString *)base64String {
	return [[NSString alloc] initWithData:[NSData sam_dataWithBase64String:base64String] encoding:NSUTF8StringEncoding];
}



#pragma mark - Generating a UUID

+ (NSString *)sam_stringWithUUID {
	CFUUIDRef uuid = CFUUIDCreate(NULL);
	CFStringRef string = CFUUIDCreateString(NULL, uuid);
	CFRelease(uuid);
	return (__bridge_transfer NSString *)string;
}


#pragma mark - Working with Ranges

- (NSRange)sam_composedRangeWithRange:(NSRange)range {
	// We're going to make a new range that takes into account surrogate unicode pairs (composed characters)
	__block NSRange adjustedRange = range;

	// Adjust the location
	[self enumerateSubstringsInRange:NSMakeRange(0, range.location + 1) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
		// If they string the iterator found is greater than 1 in length, add that to range location.
		// This means that there is a composed character before where the range starts who's length is greater than 1.
		adjustedRange.location += substring.length - 1;
	}];


	// Adjust the length
	NSUInteger length = self.length;

	// Count how many times we iterate so we only iterate over what we care about.
	__block NSInteger count = 0;
	[self enumerateSubstringsInRange:NSMakeRange(adjustedRange.location, length - adjustedRange.location) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
		// If they string the iterator found is greater than 1 in length, add that to range length.
		// This means that there is a composed character inside of the range starts who's length is greater than 1.
		adjustedRange.length += substring.length - 1;

		// Add one to the count
		count++;

		// If we have iterated as many times as the original length, stop.
		if (range.length == (NSUInteger)count) {
			*stop = YES;
		}
	}];

	// Make sure we don't make an invalid range. This should never happen, but let's play it safe anyway.
	if (adjustedRange.location + adjustedRange.length > length) {
		adjustedRange.length = length - adjustedRange.location - 1;
	}

	// Return the adjusted range
	return adjustedRange;
}


- (NSString *)sam_composedSubstringWithRange:(NSRange)range {
	// Return a substring using a composed range so surrogate unicode pairs (composed characters) count as 1 in the
	// range instead of however many unichars they actually are.
	return [self substringWithRange:[self sam_composedRangeWithRange:range]];
}

@end


@implementation NSString (SAMPrivateAdditions)

- (NSData *)sam_prehashData {
	const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
	return [NSData dataWithBytes:cstr length:self.length];
}

@end
