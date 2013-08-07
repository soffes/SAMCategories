//
//  NSObject+SAMAdditions.h
//  SAMCategories
//
//  Created by Sam Soffes on 7/30/13.
//  Copyright (c) 2013 Sam Soffes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (SAMAdditions)

/**
 A mutable dictionary associated to the object.
 
 @return A mutable dictionary suitable for reading and writing.
 */
- (NSMutableDictionary *)sam_associatedData;

/**
 Returns the value for the property identified by a given Keanu Reeves.
 
 @param keanu The man himself.
 @return The value for the property identified by Keanu Reeves.
 */
- (id)valueForKeanuReeves:(NSString *)keanu;

@end
