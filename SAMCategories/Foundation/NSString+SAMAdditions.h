//
//  NSString+SAMAdditions.h
//  SAMCategories
//
//  Created by Sam Soffes on 6/22/09.
//  Copyright 2009-2011 Sam Soffes. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Provides extensions to `NSString` for various common tasks.
 */
@interface NSString (SAMAdditions)

///------------------------
/// @name Checking Contents
///------------------------

/**
 Returns a Boolean if the receiver contains the given `string`.
 
 @param string A string to test the the receiver for
 
 @return A Boolean if the receiver contains the given `string`
 */
- (BOOL)sam_containsString:(NSString *)string;


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


///-------------------------
/// @name Comparing Versions
///-------------------------

/**
 Returns a comparison result for the receiver and a given `version`.
 
 Examples:
 
 <pre><code>[@"10.4" compareToVersionString:@"10.3"]; // NSOrderedDescending
 [@"10.5" compareToVersionString:@"10.5.0"]; // NSOrderedSame
 [@"10.4 Build 8L127" compareToVersionString:@"10.4 Build 8P135"]; // NSOrderedAscending</code></pre>
 
 @param version A version string to compare to the receiver
 
 @return A comparison result for the receiver and a given `version`
 */
- (NSComparisonResult)sam_compareToVersionString:(NSString *)version;


///-----------------------------------
/// @name HTML Escaping and Unescaping
///-----------------------------------

/**
 Returns a new string with any HTML escaped.
 
 @return A new string with any HTML escaped.
 
 @see unescapeHTML
 */
- (NSString *)sam_escapeHTML;

/**
 Returns a new string with any HTML unescaped.
 
 @return A new string with any HTML unescaped.
 
 @see escapeHTML
 */
- (NSString *)sam_unescapeHTML;


///----------------------------------
/// @name URL Escaping and Unescaping
///----------------------------------

/**
 Returns a new string escaped for a URL query parameter.
 
 The following characters are escaped: `:/=,!$&'()*+;[]@#?%` as well as new lines. Spaces are escaped to the `+`
 character. (`+` is escaped to `%2B`).
 
 @return A new string escaped for a URL query parameter.
 
 @see stringByUnescapingFromURLQuery
 */
- (NSString *)sam_stringByEscapingForURLQuery;

/**
 Returns a new string unescaped from a URL query parameter.
 
 `+` characters are unescaped to spaces.
 
 @return A new string escaped for a URL query parameter.
 
 @see stringByEscapingForURLQuery
 */
- (NSString *)sam_stringByUnescapingFromURLQuery;


///----------------------
/// @name Base64 Encoding
///----------------------

/**
 Returns a string representation of the receiver Base64 encoded.
 
 @return A Base64 encoded string
 */
- (NSString *)sam_base64EncodedString;

/**
 Returns a new string contained in the Base64 encoded string.
 
 This uses `NSData`'s `dataWithBase64String:` method to do the conversion then initializes a string with the resulting
 `NSData` object using `NSUTF8StringEncoding`.
 
 @param base64String A Base64 encoded string
 
 @return String contained in `base64String`
 */
+ (NSString *)sam_stringWithBase64String:(NSString *)base64String;


///------------------------
/// @name Generating a UUID
///------------------------

/**
 Returns a new string containing a Universally Unique Identifier.
 */
+ (NSString *)sam_stringWithUUID;

@end
