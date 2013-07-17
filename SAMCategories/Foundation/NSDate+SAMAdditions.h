//
//  NSDate+SAMAdditions.h
//  SAMCategories
//
//  Created by Sam Soffes on 5/26/10.
//  Copyright 2010-2013 Sam Soffes. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Provides extensions to `NSDate` for various common tasks.
 */
@interface NSDate (SAMAdditions)

///---------------
/// @name ISO 8601
///---------------

/**
 Returns a new date represented by an ISO8601 string.
 
 @param iso8601String An ISO8601 string
 
 @return Date represented by the ISO8601 string
 */
+ (NSDate *)sam_dateFromISO8601String:(NSString *)iso8601String;

/**
 Returns a string representation of the receiver in ISO8601 format.
 
 @return A string representation of the receiver in ISO8601 format.
 */
- (NSString *)sam_ISO8601String;

@end
