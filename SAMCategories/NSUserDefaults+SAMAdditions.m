//
//  NSUserDefaults+SAMAdditions.m
//  SAMCategories
//
//  Created by Sam Soffes on 4/22/14.
//  Copyright (c) 2014 Sam Soffes. All rights reserved.
//

#import "NSUserDefaults+SAMAdditions.h"
#import "NSString+SAMAdditions.h"
#import "NSArray+SAMAdditions.h"
#import "NSDictionary+SAMAdditions.h"
#import "NSData+SAMAdditions.h"

@implementation NSUserDefaults (SAMAdditions)

#pragma mark - Salt

static NSString *SAMUserDefaultsSalt = nil;

+ (void)sam_setSignatureSalt:(NSString *)salt {
	NSParameterAssert(salt);
	SAMUserDefaultsSalt = salt;
}


+ (NSString *)sam_signatureSalt {
	return SAMUserDefaultsSalt;
}


#pragma mark - Primary

- (id)sam_signedObjectForKey:(NSString *)defaultName {
	NSParameterAssert(defaultName);

	id value = [self objectForKey:defaultName];
	if (!value) {
		return nil;
	}

	NSString *signatureKey = [self sam_signatureKeyForKey:defaultName];
	NSString *savedSignature = [self stringForKey:signatureKey];
	if (!savedSignature) {
		return nil;
	}

	NSString *validSignature = [self sam_signatureForObject:value key:defaultName];
	if (![savedSignature isEqualToString:validSignature]) {
		return nil;
	}

	return value;
}


- (void)sam_setSignedObject:(id)value forKey:(NSString *)defaultName {
	NSParameterAssert(value);
	NSParameterAssert(defaultName);

	NSString *signature = [self sam_signatureForObject:value key:defaultName];
	NSString *signatureKey = [self sam_signatureKeyForKey:defaultName];

	[self setObject:value forKey:defaultName];
	[self setObject:signature forKey:signatureKey];
}


- (void)sam_removeSignedObjectForKey:(NSString *)defaultName {
	NSParameterAssert(defaultName);

	NSString *signatureKey = [self sam_signatureKeyForKey:defaultName];

	[self removeObjectForKey:defaultName];
	[self removeObjectForKey:signatureKey];
}


#pragma mark - Getters

- (NSArray *)sam_signedArrayForKey:(NSString *)defaultName {
	return (NSArray *)[self sam_signedObjectForKey:defaultName];
}


- (NSDictionary *)sam_signedDictionaryForKey:(NSString *)defaultName {
	return (NSDictionary *)[self sam_signedObjectForKey:defaultName];
}


- (NSData *)sam_signedDataForKey:(NSString *)defaultName {
	return (NSData *)[self sam_signedObjectForKey:defaultName];
}


- (NSString *)sam_signedStringForKey:(NSString *)defaultName {
	return (NSString *)[self sam_signedObjectForKey:defaultName];
}


- (NSInteger)sam_signedIntegerForKey:(NSString *)defaultName {
	id value = [self sam_signedObjectForKey:defaultName];
	if ([value respondsToSelector:@selector(integerValue)]) {
		return [value integerValue];
	}

	return 0;
}


- (float)sam_signedFloatForKey:(NSString *)defaultName {
	id value = [self sam_signedObjectForKey:defaultName];
	if ([value respondsToSelector:@selector(floatValue)]) {
		return [value floatValue];
	}

	return 0.0f;
}


- (double)sam_signedDoubleForKey:(NSString *)defaultName {
	id value = [self sam_signedObjectForKey:defaultName];
	if ([value respondsToSelector:@selector(doubleValue)]) {
		return [value doubleValue];
	}

	return 0.0;
}


- (BOOL)sam_signedBoolForKey:(NSString *)defaultName {
	id value = [self sam_signedObjectForKey:defaultName];
	if ([value respondsToSelector:@selector(boolValue)]) {
		return [value boolValue];
	}

	return NO;
}


- (NSURL *)sam_signedURLForKey:(NSString *)defaultName {
	NSString *string = [self sam_signedObjectForKey:defaultName];
	if (!string) {
		return nil;
	}

	return [[NSURL alloc] initWithString:string];
}


#pragma mark - Setters

- (void)sam_setSignedInteger:(NSInteger)value forKey:(NSString *)defaultName {
	[self sam_setSignedObject:@(value) forKey:defaultName];
}


- (void)sam_setSignedFloat:(float)value forKey:(NSString *)defaultName {
	[self sam_setSignedObject:@(value) forKey:defaultName];
}


- (void)sam_setSignedDouble:(double)value forKey:(NSString *)defaultName {
	[self sam_setSignedObject:@(value) forKey:defaultName];
}


- (void)sam_setSignedBool:(BOOL)value forKey:(NSString *)defaultName {
	[self sam_setSignedObject:@(value) forKey:defaultName];
}


- (void)sam_setSignedURL:(NSURL *)url forKey:(NSString *)defaultName {
	[self sam_setSignedObject:[url absoluteString] forKey:defaultName];
}


#pragma mark - Private

- (NSString *)sam_signatureForObject:(id)object key:(NSString *)key {
	NSParameterAssert(object);
	NSParameterAssert(key);
	NSAssert([object isKindOfClass:[NSArray class]] || [object isKindOfClass:[NSDictionary class]] || [object isKindOfClass:[NSData class]] ||  [object isKindOfClass:[NSString class]] || [object isKindOfClass:[NSNumber class]] || [object isKindOfClass:[NSURL class]], @"Invalid object class. No signature generated.");

	NSString *salt = [[self class] sam_signatureSalt];
	NSAssert(salt != nil, @"A salt is required.");

	// The salt is the regular salt and the key combined. This ensures that whatever is set for a given key only works
	// for that key and cannot be moved to another key.
	salt = [salt stringByAppendingString:key];

	// Array
	if ([object isKindOfClass:[NSArray class]]) {
		return [[(NSArray *)object arrayByAddingObject:salt] sam_SHA512Digest];
	}

	// Dictionary
	if ([object isKindOfClass:[NSDictionary class]]) {
		// TODO: No copy
		NSMutableDictionary *dictionary = [(NSDictionary *)object mutableCopy];
		[dictionary setObject:salt forKey:@"__SAMSignature"];
		return [dictionary sam_SHA512Digest];
	}

	// Data
	if ([object isKindOfClass:[NSData class]]) {
		// TODO: No copy
		NSMutableData *data = [(NSData *)object mutableCopy];
		[data appendData:[salt dataUsingEncoding:NSUTF8StringEncoding]];
		return [data sam_SHA512Digest];
	}

	// String
	if ([object isKindOfClass:[NSString class]]) {
		return [[(NSString *)object stringByAppendingString:salt] sam_SHA512Digest];
	}

	// Integer, Float, Double, Bool
	if ([object isKindOfClass:[NSNumber class]]) {
		return [[[(NSNumber *)object description] stringByAppendingString:salt] sam_SHA512Digest];
	}

	// URL
	if ([object isKindOfClass:[NSURL class]]) {
		return [[[(NSURL *)object absoluteString] stringByAppendingString:salt] sam_SHA512Digest];
	}

	return nil;
}


- (NSString *)sam_signatureKeyForKey:(NSString *)key {
	return [NSString stringWithFormat:@"__%@Signature", key];
}

@end