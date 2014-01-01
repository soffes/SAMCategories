//
//  UIViewController+SAMAdditions.h
//  SAMCategories
//
//  Created by Sam Soffes on 6/21/10.
//  Copyright (c) 2010-2014 Sam Soffes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 Provides extensions to `UIViewController` for various common tasks.
 */
@interface UIViewController (SAMAdditions)

///------------------------
/// @name Presenting Errors
///------------------------

/**
 Present a `UIAlertView` with an error messagae.
 
 @param error Error to present.
 */
- (void)sam_displayError:(NSError *)error;

/**
 Present a `UIAlertView` with an error messagae.
 
 @param string Error string to present.
 */
- (void)sam_displayErrorString:(NSString *)string;

@end
