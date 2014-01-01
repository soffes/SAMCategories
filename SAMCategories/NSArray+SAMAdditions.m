//
//  NSArray+SAMAdditions.h
//  SAMCategories
//
//  Created by Sam Soffes on 8/19/09.
//  Copyright (c) 2009-2014 Sam Soffes. All rights reserved.
//

#import "NSArray+SAMAdditions.h"
#import "NSData+SAMAdditions.h"

@interface NSArray (SAMPrivateAdditions)
- (NSData *)sam_prehashData;
@end

@implementation NSArray (SAMAdditions)

- (id)sam_randomObject {
	if ([self count] == 0) {
	    return nil;
	}
	
	return [self objectAtIndex:arc4random_uniform((u_int32_t)[self count])];
}


- (NSArray *)sam_shuffledArray {
    NSMutableArray *array = [self mutableCopy];
    [array sam_shuffle];
    return array;
}


- (NSMutableArray *)sam_deepMutableCopy {
	return (__bridge_transfer NSMutableArray *)CFPropertyListCreateDeepCopy(kCFAllocatorDefault, (__bridge CFArrayRef)self, kCFPropertyListMutableContainers);
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

@end


@implementation NSArray (SAMPrivateAdditions)

- (NSData *)sam_prehashData {
	return [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListBinaryFormat_v1_0 options:kNilOptions error:nil];
}

@end


@implementation NSMutableArray (SAMAdditions)

- (void)sam_shuffle {
	for (NSInteger i = [self count] - 1; i > 0; i--) {
		[self exchangeObjectAtIndex:arc4random_uniform((u_int32_t)i + 1) withObjectAtIndex:i];
	}
}

@end
