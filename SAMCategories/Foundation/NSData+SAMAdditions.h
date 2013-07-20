//
//  NSData+SAMAdditions.h
//  SAMCategories
//
//  Created by Sam Soffes on 9/29/08.
//  Copyright 2008-2011 Sam Soffes. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Provides extensions to `NSData` for various common tasks.
 */
@interface NSData (SAMAdditions)

///--------------
/// @name Digests
///--------------

/**
 Returns a string of the MD2 sum of the receiver.

 @return The string of the MD2 sum of the receiver.
 */
- (NSString *)sam_MD2Sum;

/**
 Returns a string of the MD4 sum of the receiver.

 @return The string of the MD4 sum of the receiver.
 */
- (NSString *)sam_MD4Sum;

/**
 Returns a string of the MD5 sum of the receiver.
 
 @return The string of the MD5 sum of the receiver.
 */
- (NSString *)sam_MD5Sum;

/**
 Returns a string of the SHA1 sum of the receiver.
 
 @return The string of the SHA1 sum of the receiver.
 */
- (NSString *)sam_SHA1Sum;

/**
 Returns a string of the SHA224 sum of the receiver.

 @return The string of the SHA224 sum of the receiver.
 */
- (NSString *)sam_SHA224Sum;

/**
 Returns a string of the SHA256 sum of the receiver.
 
 @return The string of the SHA256 sum of the receiver.
 */
- (NSString *)sam_SHA256Sum;

/**
 Returns a string of the SHA384 sum of the receiver.

 @return The string of the SHA384 sum of the receiver.
 */
- (NSString *)sam_SHA384Sum;

/**
 Returns a string of the SHA512 sum of the receiver.

 @return The string of the SHA512 sum of the receiver.
 */
- (NSString *)sam_SHA512Sum;


///-----------------------------------
/// @name Base64 Encoding and Decoding
///-----------------------------------

/**
 Returns a string representation of the receiver Base64 encoded.
 
 @return A Base64 encoded string
 */
- (NSString *)sam_base64EncodedString;

/**
 Returns a new data contained in the Base64 encoded string.
 
 @param base64String A Base64 encoded string
 
 @return Data contained in `base64String`
 */
+ (NSData *)sam_dataWithBase64String:(NSString *)base64String;

@end
