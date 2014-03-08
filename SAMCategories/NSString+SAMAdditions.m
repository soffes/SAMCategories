//
//  NSString+SSToolkitAdditions.m
//  SAMCategories
//
//  Created by Sam Soffes on 6/22/09.
//  Copyright (c) 2009-2014 Sam Soffes. All rights reserved.
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

	if (length == 0) {
		return nil;
	}

    unsigned char *digest = malloc(length);
    CCHmac(algorithm, cKey, strlen(cKey), cData, strlen(cData), digest);

    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:length * 2];
    for (NSUInteger i = 0; i < length; i++) {
        [string appendFormat:@"%02lx", (unsigned long)digest[i]];
	}

	free(digest);
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
	__block NSRange adjustedRange = NSMakeRange(range.location, range.length);
	NSUInteger length = self.length;

	// Adjust range location for composed characters that appear before the original range.
	[self enumerateSubstringsInRange:NSMakeRange(0, length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
		// Stop if we've past the end of the range to be adjusted
		if (substringRange.location >= adjustedRange.location) {
			*stop = YES;
			return;
		}

		adjustedRange.location += (substringRange.length - 1);
	}];

	// Adjust range length for composed characters that appear within the original range.
	[self enumerateSubstringsInRange:NSMakeRange(adjustedRange.location, length - adjustedRange.location) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
		adjustedRange.length += (substringRange.length - 1);

		// Stop if we're finished
		if (NSMaxRange(substringRange) >= NSMaxRange(adjustedRange)) {
			*stop = YES;
		}
	}];

	// Return the adjusted range
	return adjustedRange;
}


- (NSString *)sam_composedSubstringWithRange:(NSRange)range {
	// Return a substring using a composed range so surrogate unicode pairs (composed characters) count as 1 in the
	// range instead of however many unichars they actually are.
	return [self substringWithRange:[self sam_composedRangeWithRange:range]];
}


- (NSRange)sam_wordRangeAtIndex:(NSUInteger)index {
	NSCharacterSet *whitespace = [NSCharacterSet whitespaceCharacterSet];
	NSInteger beginIndex = index;
    while(beginIndex > 0 && ![whitespace characterIsMember:[self characterAtIndex:beginIndex - 1]]) {
        beginIndex--;
    }

    NSInteger endIndex = index;
    NSInteger lenght = [self length];
    while (endIndex < lenght && ![whitespace characterIsMember:[self characterAtIndex:endIndex]]) {
        endIndex++;
    }
    return NSMakeRange(beginIndex, endIndex - beginIndex);
}

@end


@implementation NSString (SAMPrivateAdditions)

- (NSData *)sam_prehashData {
	const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
	return [NSData dataWithBytes:cstr length:self.length];
}

@end
