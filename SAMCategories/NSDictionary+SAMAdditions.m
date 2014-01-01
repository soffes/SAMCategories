//
//  NSDictionary+SSToolkitAdditions.m
//  SAMCategories
//
//  Created by Sam Soffes on 9/21/10.
//  Copyright (c) 2010-2014 Sam Soffes. All rights reserved.
//

#import "NSDictionary+SAMAdditions.h"
#import "NSData+SAMAdditions.h"
#import "NSString+SAMAdditions.h"

@interface NSDictionary (SAMPrivateAdditions)
- (NSData *)sam_prehashData;
@end

@implementation NSDictionary (SAMAdditions)

+ (NSDictionary *)sam_dictionaryWithFormEncodedString:(NSString *)encodedString {
	if (!encodedString) {
		return nil;
	}
	
	NSMutableDictionary *result = [NSMutableDictionary dictionary];
	NSArray *pairs = [encodedString componentsSeparatedByString:@"&"];
	
	for (NSString *kvp in pairs) {
		if ([kvp length] == 0) {
			continue;
		}
		
		NSRange pos = [kvp rangeOfString:@"="];
		NSString *key;
		NSString *val;
		
		if (pos.location == NSNotFound) {
			key = [kvp sam_stringByUnescapingFromURLQuery];
			val = @"";
		} else {
			key = [[kvp substringToIndex:pos.location] sam_stringByUnescapingFromURLQuery];
			val = [[kvp substringFromIndex:pos.location + pos.length] sam_stringByUnescapingFromURLQuery];
		}
		
		if (!key || !val) {
			continue;
		}
		
		[result setObject:val forKey:key];
	}
	return result;
}


- (NSString *)sam_stringWithFormEncodedComponents {
	NSMutableArray *arguments = [NSMutableArray arrayWithCapacity:[self count]];
	[self enumerateKeysAndObjectsUsingBlock:^(id key, id object, BOOL *stop) {
		[arguments addObject:[NSString stringWithFormat:@"%@=%@",
							  [key sam_stringByEscapingForURLQuery],
							  [[object description] sam_stringByEscapingForURLQuery]]];
	}];
	
	return [arguments componentsJoinedByString:@"&"];
}


- (NSMutableDictionary *)sam_deepMutableCopy {
	return (__bridge_transfer NSMutableDictionary *)CFPropertyListCreateDeepCopy(kCFAllocatorDefault, (__bridge CFDictionaryRef)self, kCFPropertyListMutableContainers);
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


- (id)sam_safeObjectForKey:(id)key {
	id object = [self objectForKey:key];
	if (object == [NSNull null]) {
		return nil;
	}
	return object;
}

@end


@implementation NSDictionary (SAMPrivateAdditions)

- (NSData *)sam_prehashData {
	return [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListBinaryFormat_v1_0 options:kNilOptions error:nil];
}

@end
