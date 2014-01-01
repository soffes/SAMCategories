//
//  NSURL+SSToolkitAdditions.m
//  SAMCategories
//
//  Created by Sam Soffes on 4/27/10.
//  Copyright (c) 2010-2014 Sam Soffes. All rights reserved.
//

#import "NSURL+SAMAdditions.h"
#import "NSDictionary+SAMAdditions.h"

@implementation NSURL (SAMAdditions)

+ (id)sam_URLWithFormat:(NSString *)format, ... {
	va_list arguments;
    va_start(arguments, format);
	NSString *string = [[NSString alloc] initWithFormat:format arguments:arguments];
	va_end(arguments);
	
	return [NSURL URLWithString:string];
}


- (NSDictionary *)sam_queryDictionary {
	 return [NSDictionary sam_dictionaryWithFormEncodedString:self.query];
}

@end
