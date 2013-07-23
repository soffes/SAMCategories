//
//  ColorCategoryTest.m
//  SSToolkit
//
//  Created by Sam Soffes on 4/15/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "UIColor+SAMAdditions.h"

@interface SAMColorCategoryTest : SenTestCase
@end

@implementation SAMColorCategoryTest

- (void)testAlpha {
	UIColor *color = [UIColor blackColor];
	STAssertEquals([color sam_alpha], 1.0f, nil);
	
	color = [UIColor colorWithRed:0.3f green:0.4f blue:0.5f alpha:0.6f];
	STAssertEquals([color sam_alpha], 0.6f, nil);
}


- (void)testRed {
	UIColor *color = [UIColor redColor];
	STAssertEquals([color sam_red], 1.0f, nil);
	
	color = [UIColor colorWithRed:0.3f green:0.4f blue:0.5f alpha:0.6f];
	STAssertEquals([color sam_red], 0.3f, nil);
}


- (void)testGreen {
	UIColor *color = [UIColor greenColor];
	STAssertEquals([color sam_green], 1.0f, nil);
	
	color = [UIColor colorWithRed:0.3f green:0.4f blue:0.5f alpha:0.6f];
	STAssertEquals([color sam_green], 0.4f, nil);
}


- (void)testBlue {
	UIColor *color = [UIColor blueColor];
	STAssertEquals([color sam_blue], 1.0f, nil);
	
	color = [UIColor colorWithRed:0.3f green:0.4f blue:0.5f alpha:0.6f];
	STAssertEquals([color sam_blue], 0.5f, nil);
}


- (void)testColorWithCSS {
	STAssertEqualObjects([UIColor redColor], [UIColor sam_colorWithCSS:@"red"], nil);
	STAssertEqualObjects([UIColor redColor], [UIColor sam_colorWithCSS:@"rgb(255,0,0)"], nil);
	STAssertEqualObjects([UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:0.5f], [UIColor sam_colorWithCSS:@"rgba(255,0,0,0.5)"], nil);
}


- (void)testColorWithHSL {
	STAssertEqualObjects([UIColor redColor], [UIColor sam_colorWithHue:0.0f saturation:1.0f lightness:0.5f alpha:1.0f], nil);
	STAssertEqualObjects([UIColor redColor], [UIColor sam_colorWithHSL:@"hsl(0,100%,50%)"], nil);
	STAssertEqualObjects([UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:0.5f], [UIColor sam_colorWithHSLA:@"hsla(0,100%,50%,0.5)"], nil);
}


- (void)testColorWithHex {
	UIColor *red = [UIColor redColor];
	STAssertEqualObjects(red, [UIColor sam_colorWithHex:@"f00"], nil);
	STAssertEqualObjects(red, [UIColor sam_colorWithHex:@"ff0000"], nil);
	STAssertEqualObjects(red, [UIColor sam_colorWithHex:@"ff0000ff"], nil);
	
	UIColor *green = [UIColor greenColor];
	STAssertEqualObjects(green, [UIColor sam_colorWithHex:@"0f0"], nil);
	STAssertEqualObjects(green, [UIColor sam_colorWithHex:@"00ff00"], nil);
	STAssertEqualObjects(green, [UIColor sam_colorWithHex:@"00ff00ff"], nil);
	
	UIColor *blue = [UIColor blueColor];
	STAssertEqualObjects(blue, [UIColor sam_colorWithHex:@"00f"], nil);
	STAssertEqualObjects(blue, [UIColor sam_colorWithHex:@"0000ff"], nil);
	STAssertEqualObjects(blue, [UIColor sam_colorWithHex:@"0000ffff"], nil);
	
	UIColor *bleh = [UIColor colorWithRed:1.0f green:0.2f blue:0.0f alpha:0.2f];
	STAssertEqualObjects(bleh, [UIColor sam_colorWithHex:@"ff330033"], nil);
}


- (void)testHexValue {
	UIColor *red = [UIColor redColor];
	STAssertEqualObjects([red sam_hexValue], @"ff0000", nil);
	STAssertEqualObjects([red sam_hexValueWithAlpha:YES], @"ff0000ff", nil);
	
	UIColor *green = [UIColor greenColor];
	STAssertEqualObjects([green sam_hexValue], @"00ff00", nil);
	STAssertEqualObjects([green sam_hexValueWithAlpha:YES], @"00ff00ff", nil);
	
	UIColor *blue = [UIColor blueColor];
	STAssertEqualObjects([blue sam_hexValue], @"0000ff", nil);
	STAssertEqualObjects([blue sam_hexValueWithAlpha:YES], @"0000ffff", nil);
	
	UIColor *white = [UIColor whiteColor];
	STAssertEqualObjects([white sam_hexValue], @"ffffff", nil);
	STAssertEqualObjects([white sam_hexValueWithAlpha:YES], @"ffffffff", nil);
	STAssertEqualObjects([[white colorWithAlphaComponent:0.2f] sam_hexValueWithAlpha:YES], @"ffffff33", nil);
}

@end
