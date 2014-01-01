//
//  NSObject+SAMAdditions.m
//  SAMCategories
//
//  Created by Sam Soffes on 7/30/13.
//  Copyright (c) 2013-2014 Sam Soffes. All rights reserved.
//

#import "NSObject+SAMAdditions.h"

#import <objc/runtime.h>

@implementation NSObject (SAMAdditions)

static int SAMAssociatedDataKey = 0;

- (NSMutableDictionary *)sam_associatedData {
    NSMutableDictionary *dictionary = objc_getAssociatedObject(self, &SAMAssociatedDataKey);
    if (dictionary == nil) {
        dictionary = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, &SAMAssociatedDataKey, dictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dictionary;
}

@end
