//
//  UIColor+SAMAdditions.h
//  SAMCategories
//
//  Created by Sam Soffes on 4/19/10.
//  Copyright 2010-2013 Sam Soffes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 Provides extensions to `UIColor` for various common tasks.
 */
@interface UIColor (SAMAdditions)

/**
 Creates and returns an UIColor object containing a given value.
 
 @param hex The value for the new color. The `#` sign is not required.
 
 @return An UIColor object containing a value.
 
 You can specify hex values in the following formats: `rgb`, `rrggbb`, or `rrggbbaa`.
 
 The default alpha value is `1.0`.
 
 */
+ (UIColor *)sam_colorWithHex:(NSString *)hex;

/**
 Returns the receiver's value as a hex string.
 
 @return The receiver's value as a hex string.
 
 The value will be `nil` if the color is in a color space other than Grayscale or RGB. The `#` sign is omitted. Alpha
 will be omitted.
 */
- (NSString *)sam_hexValue;

/**
 Returns the receiver's value as a hex string.
 
 @param includeAlpha `YES` if alpha should be included. `NO` if it should not.
 
 @return The receiver's value as a hex string.
 
 The value will be `nil` if the color is in a color space other than Grayscale or RGB. The `#` sign is omitted. Alpha is
 included if `includeAlpha` is `YES`.
 */
- (NSString *)sam_hexValueWithAlpha:(BOOL)includeAlpha;

/**
 The receiver's red component value.
 
 The value of this property is a floating-point number in the range `0.0` to `1.0`. `-1.0` is returned if the color is
 not in the RGB colorspace.
 */
- (CGFloat)sam_red;

/**
 The receiver's green component value.
 
 The value of this property is a floating-point number in the range `0.0` to `1.0`. `-1.0` is returned if the color is
 not in the RGB colorspace.
 */
- (CGFloat)sam_green;

/**
 The receiver's blue component value.
 
 The value of this property is a floating-point number in the range `0.0` to `1.0`. `-1.0` is returned if the color is
 not in the RGB colorspace.
 */
- (CGFloat)sam_blue;

/**
 The receiver's alpha value.
 
 The value of this property is a floating-point number in the range `0.0` to `1.0`, where `0.0` represents totally
 transparent and `1.0` represents totally opaque.
 */
- (CGFloat)sam_alpha;

@end
