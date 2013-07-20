//
//  NSArray+SAMAdditions.h
//  SAMCategories
//
//  Created by Sam Soffes on 8/19/09.
//  Copyright 2009-2013 Sam Soffes. All rights reserved.
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


- (NSString *)sam_MD2Sum {
	return [[self sam_prehashData] sam_MD2Sum];
}


- (NSString *)sam_MD4Sum {
	return [[self sam_prehashData] sam_MD4Sum];
}


- (NSString *)sam_SHA224Sum {
	return [[self sam_prehashData] sam_SHA224Sum];
}


- (NSString *)sam_SHA384Sum {
	return [[self sam_prehashData] sam_SHA384Sum];
}


- (NSString *)sam_SHA512Sum {
	return [[self sam_prehashData] sam_SHA512Sum];
}


- (NSString *)sam_MD5Sum {
	return [[self sam_prehashData] sam_MD5Sum];
}


- (NSString *)sam_SHA1Sum {
	return [[self sam_prehashData] sam_SHA1Sum];
}


- (NSString *)sam_SHA256Sum {
	return [[self sam_prehashData] sam_SHA256Sum];
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
