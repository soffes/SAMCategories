//
//  UIColor+SSToolkitAdditions.m
//  SAMCategories
//
//  Created by Sam Soffes on 4/19/10.
//  Copyright 2010-2013 Sam Soffes. All rights reserved.
//

#import "UIColor+SAMAdditions.h"
#import <CoreGraphics/CoreGraphics.h>

@interface NSString (SAMPrivateAdditions)
- (NSUInteger)sam_hexValue;
@end

@implementation NSString (SAMPrivateAdditions)
- (NSUInteger)sam_hexValue {
	NSUInteger result = 0;
	sscanf([self UTF8String], "%x", &result);
	return result;
}
@end

@implementation UIColor (SAMAdditions)

// Adapted from https://gist.github.com/xpansive/1337890
+ (UIColor *)sam_colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness alpha:(CGFloat)alpha {
	saturation *= lightness < 0.5f ? lightness : 1.0f - lightness;
    return [self colorWithHue:hue saturation:2.0f * saturation / (lightness + saturation) brightness:lightness + saturation alpha:alpha];
}


+ (UIColor *)sam_colorWithCSS:(NSString *)css {
	// RGBA
	if ([css hasPrefix:@"rgba("]) {
		return [self sam_colorWithRGBA:css];
	}

	// RGB
	if ([css hasPrefix:@"rgb("]) {
		return [self sam_colorWithRGB:css];
	}

	// HSLA
	if ([css hasPrefix:@"hsla("]) {
		return [self sam_colorWithHSLA:css];
	}

	// HSL
	if ([css hasPrefix:@"hsl("]) {
		return [self sam_colorWithHSL:css];
	}

	// Hex
	if ([css hasPrefix:@"#"] && (css.length == 3 || css.length == 6 || css.length == 8)) {
		return [self sam_colorWithHex:css];
	}

	// Named color
	static NSDictionary *namedColors = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		namedColors = @{
			@"aliceblue": @"#f0f8ff",
			@"antiquewhite": @"#faebd7",
			@"aqua": @"#00ffff",
			@"aquamarine": @"#7fffd4",
			@"azure": @"#f0ffff",
			@"beige": @"#f5f5dc",
			@"bisque": @"#ffe4c4",
			@"black": @"#000000",
			@"blanchedalmond": @"#ffebcd",
			@"blue": @"#0000ff",
			@"blueviolet": @"#8a2be2",
			@"brown": @"#a52a2a",
			@"burlywood": @"#deb887",
			@"cadetblue": @"#5f9ea0",
			@"chartreuse": @"#7fff00",
			@"chocolate": @"#d2691e",
			@"coral": @"#ff7f50",
			@"cornflowerblue": @"#6495ed",
			@"cornsilk": @"#fff8dc",
			@"crimson": @"#dc143c",
			@"cyan": @"#00ffff",
			@"darkblue": @"#00008b",
			@"darkcyan": @"#008b8b",
			@"darkgoldenrod": @"#b8860b",
			@"darkgray": @"#a9a9a9",
			@"darkgreen": @"#006400",
			@"darkkhaki": @"#bdb76b",
			@"darkmagenta": @"#8b008b",
			@"darkolivegreen": @"#556b2f",
			@"darkorange": @"#ff8c00",
			@"darkorchid": @"#9932cc",
			@"darkred": @"#8b0000",
			@"darksalmon": @"#e9967a",
			@"darkseagreen": @"#8fbc8f",
			@"darkslateblue": @"#483d8b",
			@"darkslategray": @"#2f4f4f",
			@"darkturquoise": @"#00ced1",
			@"darkviolet": @"#9400d3",
			@"deeppink": @"#ff1493",
			@"deepskyblue": @"#00bfff",
			@"dimgray": @"#696969",
			@"dodgerblue": @"#1e90ff",
			@"firebrick": @"#b22222",
			@"floralwhite": @"#fffaf0",
			@"forestgreen": @"#228b22",
			@"fuchsia": @"#ff00ff",
			@"gainsboro": @"#dcdcdc",
			@"ghostwhite": @"#f8f8ff",
			@"gold": @"#ffd700",
			@"goldenrod": @"#daa520",
			@"gray": @"#808080",
			@"green": @"#008000",
			@"greenyellow": @"#adff2f",
			@"honeydew": @"#f0fff0",
			@"hotpink": @"#ff69b4",
			@"indianred": @"#cd5c5c",
			@"indigo": @"  #4b0082",
			@"ivory": @"#fffff0",
			@"khaki": @"#f0e68c",
			@"lavender": @"#e6e6fa",
			@"lavenderblush": @"#fff0f5",
			@"lawngreen": @"#7cfc00",
			@"lemonchiffon": @"#fffacd",
			@"lightblue": @"#add8e6",
			@"lightcoral": @"#f08080",
			@"lightcyan": @"#e0ffff",
			@"lightgoldenrodyellow": @"#fafad2",
			@"lightgray": @"#d3d3d3",
			@"lightgreen": @"#90ee90",
			@"lightpink": @"#ffb6c1",
			@"lightsalmon": @"#ffa07a",
			@"lightseagreen": @"#20b2aa",
			@"lightskyblue": @"#87cefa",
			@"lightslategray": @"#778899",
			@"lightsteelblue": @"#b0c4de",
			@"lightyellow": @"#ffffe0",
			@"lime": @"#00ff00",
			@"limegreen": @"#32cd32",
			@"linen": @"#faf0e6",
			@"magenta": @"#ff00ff",
			@"maroon": @"#800000",
			@"mediumaquamarine": @"#66cdaa",
			@"mediumblue": @"#0000cd",
			@"mediumorchid": @"#ba55d3",
			@"mediumpurple": @"#9370db",
			@"mediumseagreen": @"#3cb371",
			@"mediumslateblue": @"#7b68ee",
			@"mediumspringgreen": @"#00fa9a",
			@"mediumturquoise": @"#48d1cc",
			@"mediumvioletred": @"#c71585",
			@"midnightblue": @"#191970",
			@"mintcream": @"#f5fffa",
			@"mistyrose": @"#ffe4e1",
			@"moccasin": @"#ffe4b5",
			@"navajowhite": @"#ffdead",
			@"navy": @"#000080",
			@"oldlace": @"#fdf5e6",
			@"olive": @"#808000",
			@"olivedrab": @"#6b8e23",
			@"orange": @"#ffa500",
			@"orangered": @"#ff4500",
			@"orchid": @"#da70d6",
			@"palegoldenrod": @"#eee8aa",
			@"palegreen": @"#98fb98",
			@"paleturquoise": @"#afeeee",
			@"palevioletred": @"#db7093",
			@"papayawhip": @"#ffefd5",
			@"peachpuff": @"#ffdab9",
			@"peru": @"#cd853f",
			@"pink": @"#ffc0cb",
			@"plum": @"#dda0dd",
			@"powderblue": @"#b0e0e6",
			@"purple": @"#800080",
			@"red": @"#ff0000",
			@"rosybrown": @"#bc8f8f",
			@"royalblue": @"#4169e1",
			@"saddlebrown": @"#8b4513",
			@"salmon": @"#fa8072",
			@"sandybrown": @"#f4a460",
			@"seagreen": @"#2e8b57",
			@"seashell": @"#fff5ee",
			@"sienna": @"#a0522d",
			@"silver": @"#c0c0c0",
			@"skyblue": @"#87ceeb",
			@"slateblue": @"#6a5acd",
			@"slategray": @"#708090",
			@"snow": @"#fffafa",
			@"springgreen": @"#00ff7f",
			@"steelblue": @"#4682b4",
			@"tan": @"#d2b48c",
			@"teal": @"#008080",
			@"thistle": @"#d8bfd8",
			@"tomato": @"#ff6347",
			@"turquoise": @"#40e0d0",
			@"violet": @"#ee82ee",
			@"wheat": @"#f5deb3",
			@"white": @"#ffffff",
			@"whitesmoke": @"#f5f5f5",
			@"yellow": @"#ffff00",
			@"yellowgreen": @"#9acd32"
		};
	});

	NSString *hex = namedColors[css.lowercaseString];
	if (hex) {
		return [self sam_colorWithHex:hex];
	}

	return nil;
}


+ (UIColor *)sam_colorWithRGB:(NSString *)rgb {
	if (![rgb hasPrefix:@"rgb("]) {
		return nil;
	}

	rgb = [rgb stringByReplacingOccurrencesOfString:@"rgb(" withString:@""];
	rgb = [rgb stringByReplacingOccurrencesOfString:@")" withString:@""];
	rgb = [rgb stringByReplacingOccurrencesOfString:@" " withString:@""];

	NSArray *values = [rgb componentsSeparatedByString:@","];
	if (values.count != 3) {
		return nil;
	}

	return [self colorWithRed:[values[0] floatValue] / 255.0f green:[values[1] floatValue] / 255.0f blue:[values[2] floatValue] / 255.0f alpha:1.0f];
}


+ (UIColor *)sam_colorWithRGBA:(NSString *)rgba {
	if (![rgba hasPrefix:@"rgba("]) {
		return nil;
	}

	rgba = [rgba stringByReplacingOccurrencesOfString:@"rgba(" withString:@""];
	rgba = [rgba stringByReplacingOccurrencesOfString:@")" withString:@""];
	rgba = [rgba stringByReplacingOccurrencesOfString:@" " withString:@""];

	NSArray *values = [rgba componentsSeparatedByString:@","];
	if (values.count != 4) {
		return nil;
	}

	return [self colorWithRed:[values[0] floatValue] / 255.0f green:[values[1] floatValue] / 255.0f blue:[values[2] floatValue] / 255.0f alpha:[values[3] floatValue]];
}


+ (UIColor *)sam_colorWithHSL:(NSString *)hsl {
	if (![hsl hasPrefix:@"hsl("]) {
		return nil;
	}

	hsl = [hsl stringByReplacingOccurrencesOfString:@"hsl(" withString:@""];
	hsl = [hsl stringByReplacingOccurrencesOfString:@"%" withString:@""];
	hsl = [hsl stringByReplacingOccurrencesOfString:@")" withString:@""];
	hsl = [hsl stringByReplacingOccurrencesOfString:@" " withString:@""];

	NSArray *values = [hsl componentsSeparatedByString:@","];
	if (values.count != 3) {
		return nil;
	}

	return [self sam_colorWithHue:[values[0] floatValue] / 255.0f saturation:[values[1] floatValue] / 100.0f lightness:[values[2] floatValue] / 100.0f alpha:1.0f];
}


+ (UIColor *)sam_colorWithHSLA:(NSString *)hsla {
	if (![hsla hasPrefix:@"hsla("]) {
		return nil;
	}

	hsla = [hsla stringByReplacingOccurrencesOfString:@"hsla(" withString:@""];
	hsla = [hsla stringByReplacingOccurrencesOfString:@"%" withString:@""];
	hsla = [hsla stringByReplacingOccurrencesOfString:@")" withString:@""];
	hsla = [hsla stringByReplacingOccurrencesOfString:@" " withString:@""];

	NSArray *values = [hsla componentsSeparatedByString:@","];
	if (values.count != 4) {
		return nil;
	}

	return [self sam_colorWithHue:[values[0] floatValue] / 255.0f saturation:[values[1] floatValue] / 100.0f lightness:[values[2] floatValue] / 100.0f alpha:[values[3] floatValue]];
}


+ (UIColor *)sam_colorWithHex:(NSString *)hex {
	// Remove `#` and `0x`
	if ([hex hasPrefix:@"#"]) {
		hex = [hex substringFromIndex:1];
	} else if ([hex hasPrefix:@"0x"]) {
		hex = [hex substringFromIndex:2];
	}
	
	// Invalid if not 3, 6, or 8 characters
	NSUInteger length = [hex length];
	if (length != 3 && length != 6 && length != 8) {
		return nil;
	}
	
	// Make the string 8 characters long for easier parsing
	if (length == 3) {
		NSString *r = [hex substringWithRange:NSMakeRange(0, 1)];
		NSString *g = [hex substringWithRange:NSMakeRange(1, 1)];
		NSString *b = [hex substringWithRange:NSMakeRange(2, 1)];
		hex = [NSString stringWithFormat:@"%@%@%@%@%@%@ff",
			   r, r, g, g, b, b];
	} else if (length == 6) {
		hex = [hex stringByAppendingString:@"ff"];
	}
	
	CGFloat red = [[hex substringWithRange:NSMakeRange(0, 2)] sam_hexValue] / 255.0f;
	CGFloat green = [[hex substringWithRange:NSMakeRange(2, 2)] sam_hexValue] / 255.0f;
	CGFloat blue = [[hex substringWithRange:NSMakeRange(4, 2)] sam_hexValue] / 255.0f;
	CGFloat alpha = [[hex substringWithRange:NSMakeRange(6, 2)] sam_hexValue] / 255.0f;
		
	return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}


- (NSString *)sam_hexValue {	
	return [self sam_hexValueWithAlpha:NO];
}


- (NSString *)sam_hexValueWithAlpha:(BOOL)includeAlpha {
	CGColorRef color = self.CGColor;
	size_t count = CGColorGetNumberOfComponents(color);
	const CGFloat *components = CGColorGetComponents(color);
	
	NSString *hex = nil;
	
	// Grayscale
	if (count == 2) {
		NSUInteger white = (NSUInteger)(components[0] * 255.0f);
		hex = [NSString stringWithFormat:@"%02x%02x%02x", white, white, white];
	}
	
	// RGB
	else if (count == 4) {
		hex = [NSString stringWithFormat:@"%02x%02x%02x", (NSUInteger)(components[0] * 255.0f),
				(NSUInteger)(components[1] * 255.0f), (NSUInteger)(components[2] * 255.0f)];
	}
	
	// Add alpha
	if (hex && includeAlpha) {
		hex = [hex stringByAppendingFormat:@"%02x", (NSUInteger)([self sam_alpha] * 255.0f)];
	}
	
	// Unsupported color space
	return hex;
}


- (CGFloat)sam_red {
	CGColorRef color = self.CGColor;
	if (CGColorSpaceGetModel(CGColorGetColorSpace(color)) != kCGColorSpaceModelRGB) {
		return -1.0f;
	}
	CGFloat const *components = CGColorGetComponents(color);
	return components[0];
}


- (CGFloat)sam_green {
	CGColorRef color = self.CGColor;
	if (CGColorSpaceGetModel(CGColorGetColorSpace(color)) != kCGColorSpaceModelRGB) {
		return -1.0f;
	}
	CGFloat const *components = CGColorGetComponents(color);
	return components[1];
}


- (CGFloat)sam_blue {
	CGColorRef color = self.CGColor;
	if (CGColorSpaceGetModel(CGColorGetColorSpace(color)) != kCGColorSpaceModelRGB) {
		return -1.0f;
	}
	CGFloat const *components = CGColorGetComponents(color);
	return components[2];
}


- (CGFloat)sam_alpha {
	return CGColorGetAlpha(self.CGColor);
}

@end
