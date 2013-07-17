//
//  NSArray+SAMAdditions.h
//  SAMCategories
//
//  Created by Sam Soffes on 8/19/09.
//  Copyright 2009-2013 Sam Soffes. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Provides extensions to `NSArray` for various common tasks.
 */
@interface NSArray (SAMAdditions)

///------------------------
/// @name Querying an Array
///------------------------

/**
 Returns the object in the array with a random index value.
 
 @return The object in the array with a random index value. If the array is empty, returns `nil`.
 */
- (id)sam_randomObject;


///--------------------------
/// @name Deriving New Arrays
///--------------------------

/**
 Returns a new array with its elements shuffled.
 
 @return A new array containing the receiving array's elements rearranged in a random order.
 */
- (NSArray *)sam_shuffledArray;

/**
 Returns the object returned by `mutableCopyWithZone:` where the zone is `nil`.
 
 This differs from `mutableCopy` in that it makes any contained `NSArray` objects or `NSDictionary` objects mutable as
 well. The returned dictionary follows standard memory management conventions for copied objects. You are responsible
 for releasing it.
 
 @return The object returned by the `NSMutableCopying` protocol method `mutableCopyWithZone:`, where the zone is `nil`.
 */
- (NSMutableArray *)sam_deepMutableCopy NS_RETURNS_RETAINED;

///--------------
/// @name Hashing
///--------------

/**
 Returns a string of the MD5 sum of the receiver.
 
 @return The string of the MD5 sum of the receiver.
 
 Internally, `NSPropertyListSerialization` is used to created the hash. Only objects that can be serialized should be
 contained in the receiver when calling this method.
 */
- (NSString *)sam_MD5Sum;

/**
 Returns a string of the SHA1 sum of the receiver.
 
 @return The string of the SHA1 sum of the receiver.
 
 Internally, `NSPropertyListSerialization` is used to created the hash. Only objects that can be serialized should be
 contained in the receiver when calling this method.
 */
- (NSString *)sam_SHA1Sum;

@end


/**
 Provides extensions to `NSMutableArray` for various common tasks.
 */
@interface NSMutableArray (SAMAdditions)

///--------------------------
/// @name Changing the Array
///--------------------------

/**
 Shuffles the elements of this array in-place using the Fisher-Yates algorithm.
 */
- (void)sam_shuffle;

@end
