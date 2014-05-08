//
//  UIColor+SSToolkitAdditions.m
//  SAMCategories
//
//  Created by Sam Soffes on 4/19/10.
//  Copyright (c) 2010-2014 Sam Soffes. All rights reserved.
//

#import "UIColor+SAMAdditions.h"
#import <CoreGraphics/CoreGraphics.h>

@interface NSString (SAMPrivateAdditions)
- (NSUInteger)sam_hexValue;
@end

@implementation NSString (SAMPrivateAdditions)
- (NSUInteger)sam_hexValue {
	NSUInteger result = 0;
	sscanf([self UTF8String], "%lx", (unsigned long *)&result);
	return result;
}
@end

@implementation UIColor (SAMAdditions)

// Adapted from https://gist.github.com/xpansive/1337890
+ (instancetype)sam_colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness alpha:(CGFloat)alpha {
	saturation *= lightness < 0.5f ? lightness : 1.0f - lightness;
    return [self colorWithHue:hue saturation:2.0f * saturation / (lightness + saturation) brightness:lightness + saturation alpha:alpha];
}


+ (instancetype)sam_colorWithCSS:(NSString *)css {
	// RGB
	if ([css hasPrefix:@"rgb"]) {
		return [self sam_colorWithRGB:css];
	}

	// HSL
	if ([css hasPrefix:@"hsl"]) {
		return [self sam_colorWithHSL:css];
	}

	// Hex
	if ([css hasPrefix:@"#"]) {
		return [self sam_colorWithHex:css];
	}

	// Named color
	return [self sam_colorWithCSSName:css];
}


+ (instancetype)sam_colorWithCSSName:(NSString *)name {
	name = [name lowercaseString];

	// Transparent
	if ([name isEqualToString:@"transparent"]) {
		return [self clearColor];
	}

	static NSDictionary *namedColors = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		namedColors = @{
						// Basic color keywords
						@"black": @"rgb(0,0,0)",
						@"silver": @"rgb(192,192,192)",
						@"gray": @"rgb(128,128,128)",
						@"white": @"rgb(255,255,255)",
						@"maroon": @"rgb(128,0,0)",
						@"red": @"rgb(255,0,0)",
						@"purple": @"rgb(128,0,128)",
						@"fuchsia": @"rgb(255,0,255)",
						@"green": @"rgb(0,128,0)",
						@"lime": @"rgb(0,255,0)",
						@"olive": @"rgb(128,128,0)",
						@"yellow": @"rgb(255,255,0)",
						@"navy": @"rgb(0,0,128)",
						@"blue": @"rgb(0,0,255)",
						@"teal": @"rgb(0,128,128)",
						@"aqua": @"rgb(0,255,255)",

						// Extended color keywords
						@"aliceblue": @"rgb(240,248,255)",
						@"antiquewhite": @"rgb(250,235,215)",
						@"aqua": @"rgb(0,255,255)",
						@"aquamarine": @"rgb(127,255,212)",
						@"azure": @"rgb(240,255,255)",
						@"beige": @"rgb(245,245,220)",
						@"bisque": @"rgb(255,228,196)",
						@"black": @"rgb(0,0,0)",
						@"blanchedalmond": @"rgb(255,235,205)",
						@"blue": @"rgb(0,0,255)",
						@"blueviolet": @"rgb(138,43,226)",
						@"brown": @"rgb(165,42,42)",
						@"burlywood": @"rgb(222,184,135)",
						@"cadetblue": @"rgb(95,158,160)",
						@"chartreuse": @"rgb(127,255,0)",
						@"chocolate": @"rgb(210,105,30)",
						@"coral": @"rgb(255,127,80)",
						@"cornflowerblue": @"rgb(100,149,237)",
						@"cornsilk": @"rgb(255,248,220)",
						@"crimson": @"rgb(220,20,60)",
						@"cyan": @"rgb(0,255,255)",
						@"darkblue": @"rgb(0,0,139)",
						@"darkcyan": @"rgb(0,139,139)",
						@"darkgoldenrod": @"rgb(184,134,11)",
						@"darkgray": @"rgb(169,169,169)",
						@"darkgreen": @"rgb(0,100,0)",
						@"darkgrey": @"rgb(169,169,169)",
						@"darkkhaki": @"rgb(189,183,107)",
						@"darkmagenta": @"rgb(139,0,139)",
						@"darkolivegreen": @"rgb(85,107,47)",
						@"darkorange": @"rgb(255,140,0)",
						@"darkorchid": @"rgb(153,50,204)",
						@"darkred": @"rgb(139,0,0)",
						@"darksalmon": @"rgb(233,150,122)",
						@"darkseagreen": @"rgb(143,188,143)",
						@"darkslateblue": @"rgb(72,61,139)",
						@"darkslategray": @"rgb(47,79,79)",
						@"darkslategrey": @"rgb(47,79,79)",
						@"darkturquoise": @"rgb(0,206,209)",
						@"darkviolet": @"rgb(148,0,211)",
						@"deeppink": @"rgb(255,20,147)",
						@"deepskyblue": @"rgb(0,191,255)",
						@"dimgray": @"rgb(105,105,105)",
						@"dimgrey": @"rgb(105,105,105)",
						@"dodgerblue": @"rgb(30,144,255)",
						@"firebrick": @"rgb(178,34,34)",
						@"floralwhite": @"rgb(255,250,240)",
						@"forestgreen": @"rgb(34,139,34)",
						@"fuchsia": @"rgb(255,0,255)",
						@"gainsboro": @"rgb(220,220,220)",
						@"ghostwhite": @"rgb(248,248,255)",
						@"gold": @"rgb(255,215,0)",
						@"goldenrod": @"rgb(218,165,32)",
						@"gray": @"rgb(128,128,128)",
						@"green": @"rgb(0,128,0)",
						@"greenyellow": @"rgb(173,255,47)",
						@"grey": @"rgb(128,128,128)",
						@"honeydew": @"rgb(240,255,240)",
						@"hotpink": @"rgb(255,105,180)",
						@"indianred": @"rgb(205,92,92)",
						@"indigo": @"rgb(75,0,130)",
						@"ivory": @"rgb(255,255,240)",
						@"khaki": @"rgb(240,230,140)",
						@"lavender": @"rgb(230,230,250)",
						@"lavenderblush": @"rgb(255,240,245)",
						@"lawngreen": @"rgb(124,252,0)",
						@"lemonchiffon": @"rgb(255,250,205)",
						@"lightblue": @"rgb(173,216,230)",
						@"lightcoral": @"rgb(240,128,128)",
						@"lightcyan": @"rgb(224,255,255)",
						@"lightgoldenrodyellow": @"rgb(250,250,210)",
						@"lightgray": @"rgb(211,211,211)",
						@"lightgreen": @"rgb(144,238,144)",
						@"lightgrey": @"rgb(211,211,211)",
						@"lightpink": @"rgb(255,182,193)",
						@"lightsalmon": @"rgb(255,160,122)",
						@"lightseagreen": @"rgb(32,178,170)",
						@"lightskyblue": @"rgb(135,206,250)",
						@"lightslategray": @"rgb(119,136,153)",
						@"lightslategrey": @"rgb(119,136,153)",
						@"lightsteelblue": @"rgb(176,196,222)",
						@"lightyellow": @"rgb(255,255,224)",
						@"lime": @"rgb(0,255,0)",
						@"limegreen": @"rgb(50,205,50)",
						@"linen": @"rgb(250,240,230)",
						@"magenta": @"rgb(255,0,255)",
						@"maroon": @"rgb(128,0,0)",
						@"mediumaquamarine": @"rgb(102,205,170)",
						@"mediumblue": @"rgb(0,0,205)",
						@"mediumorchid": @"rgb(186,85,211)",
						@"mediumpurple": @"rgb(147,112,219)",
						@"mediumseagreen": @"rgb(60,179,113)",
						@"mediumslateblue": @"rgb(123,104,238)",
						@"mediumspringgreen": @"rgb(0,250,154)",
						@"mediumturquoise": @"rgb(72,209,204)",
						@"mediumvioletred": @"rgb(199,21,133)",
						@"midnightblue": @"rgb(25,25,112)",
						@"mintcream": @"rgb(245,255,250)",
						@"mistyrose": @"rgb(255,228,225)",
						@"moccasin": @"rgb(255,228,181)",
						@"navajowhite": @"rgb(255,222,173)",
						@"navy": @"rgb(0,0,128)",
						@"oldlace": @"rgb(253,245,230)",
						@"olive": @"rgb(128,128,0)",
						@"olivedrab": @"rgb(107,142,35)",
						@"orange": @"rgb(255,165,0)",
						@"orangered": @"rgb(255,69,0)",
						@"orchid": @"rgb(218,112,214)",
						@"palegoldenrod": @"rgb(238,232,170)",
						@"palegreen": @"rgb(152,251,152)",
						@"paleturquoise": @"rgb(175,238,238)",
						@"palevioletred": @"rgb(219,112,147)",
						@"papayawhip": @"rgb(255,239,213)",
						@"peachpuff": @"rgb(255,218,185)",
						@"peru": @"rgb(205,133,63)",
						@"pink": @"rgb(255,192,203)",
						@"plum": @"rgb(221,160,221)",
						@"powderblue": @"rgb(176,224,230)",
						@"purple": @"rgb(128,0,128)",
						@"red": @"rgb(255,0,0)",
						@"rosybrown": @"rgb(188,143,143)",
						@"royalblue": @"rgb(65,105,225)",
						@"saddlebrown": @"rgb(139,69,19)",
						@"salmon": @"rgb(250,128,114)",
						@"sandybrown": @"rgb(244,164,96)",
						@"seagreen": @"rgb(46,139,87)",
						@"seashell": @"rgb(255,245,238)",
						@"sienna": @"rgb(160,82,45)",
						@"silver": @"rgb(192,192,192)",
						@"skyblue": @"rgb(135,206,235)",
						@"slateblue": @"rgb(106,90,205)",
						@"slategray": @"rgb(112,128,144)",
						@"slategrey": @"rgb(112,128,144)",
						@"snow": @"rgb(255,250,250)",
						@"springgreen": @"rgb(0,255,127)",
						@"steelblue": @"rgb(70,130,180)",
						@"tan": @"rgb(210,180,140)",
						@"teal": @"rgb(0,128,128)",
						@"thistle": @"rgb(216,191,216)",
						@"tomato": @"rgb(255,99,71)",
						@"turquoise": @"rgb(64,224,208)",
						@"violet": @"rgb(238,130,238)",
						@"wheat": @"rgb(245,222,179)",
						@"white": @"rgb(255,255,255)",
						@"whitesmoke": @"rgb(245,245,245)",
						@"yellow": @"rgb(255,255,0)",
						@"yellowgreen": @"rgb(154,205,50)"
						};
	});

	NSString *rgb = namedColors[name];
	if (rgb) {
		return [self sam_colorWithRGB:rgb];
	}
	return nil;
}


+ (instancetype)sam_colorWithRGB:(NSString *)rgb {
	rgb = [rgb lowercaseString];

	if (![rgb hasPrefix:@"rgb"]) {
		return nil;
	}

	rgb = [rgb stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"rgba( )"]];

	NSArray *values = [rgb componentsSeparatedByString:@","];
	BOOL hasAlpha = values.count == 4;
	if (values.count == 3 || hasAlpha) {
		CGFloat alpha = hasAlpha ? [values[3] floatValue] : 1.0f;
		return [self colorWithRed:[values[0] floatValue] / 255.0f green:[values[1] floatValue] / 255.0f blue:[values[2] floatValue] / 255.0f alpha:alpha];
	}

	return nil;
}


+ (instancetype)sam_colorWithHSL:(NSString *)hsl {
	hsl = [hsl lowercaseString];

	if (![hsl hasPrefix:@"hsl"]) {
		return nil;
	}

	hsl = [hsl stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"hsla(%) "]];

	NSArray *values = [hsl componentsSeparatedByString:@","];
	BOOL hasAlpha = values.count == 4;
	if (values.count == 3 || hasAlpha) {
		CGFloat alpha = hasAlpha ? [values[3] floatValue] : 1.0f;
		return [self sam_colorWithHue:[values[0] floatValue] / 255.0f saturation:[values[1] floatValue] / 100.0f lightness:[values[2] floatValue] / 100.0f alpha:alpha];
	}

	return nil;
}


+ (instancetype)sam_colorWithHex:(NSString *)hex {
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
		hex = [NSString stringWithFormat:@"%02lx%02lx%02lx", (unsigned long)white, (unsigned long)white, (unsigned long)white];
	}

	// RGB
	else if (count == 4) {
		hex = [NSString stringWithFormat:@"%02lx%02lx%02lx", (unsigned long)(components[0] * 255.0f),
			   (unsigned long)(components[1] * 255.0f), (unsigned long)(components[2] * 255.0f)];
	}

	// Add alpha
	if (hex && includeAlpha) {
		hex = [hex stringByAppendingFormat:@"%02lx", (unsigned long)([self sam_alpha] * 255.0f)];
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


- (instancetype)sam_colorByInterpolatingToColor:(UIColor *)nextColor progress:(CGFloat)progress {
	progress = fminf(1.0f, fmaxf(0.0f, progress));

	CGFloat startRed, startGreen, startBlue, startAlpha;
	[self getRed:&startRed green:&startGreen blue:&startBlue alpha:&startAlpha];

	CGFloat endRed, endGreen, endBlue, endAlpha;
	[nextColor getRed:&endRed green:&endGreen blue:&endBlue alpha:&endAlpha];

	return [[self class] colorWithRed:startRed + (endRed - startRed) * progress
								green:startGreen + (endGreen - startGreen) * progress
								 blue:startBlue + (endBlue - startBlue) * progress
								alpha:startAlpha + (endAlpha - startAlpha) * progress];
}

@end
