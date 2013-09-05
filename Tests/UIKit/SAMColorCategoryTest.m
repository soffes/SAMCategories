//
//  ColorCategoryTest.m
//  SSToolkit
//
//  Created by Sam Soffes on 4/15/11.
//  Copyright 2011 Sam Soffes. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIColor+SAMAdditions.h"

@interface SAMColorCategoryTest : XCTestCase
@end

@implementation SAMColorCategoryTest

- (void)teXCTAlpha {
	UIColor *color = [UIColor blackColor];
	XCTAssertEqual([color sam_alpha], 1.0f, @"");
	
	color = [UIColor colorWithRed:0.3f green:0.4f blue:0.5f alpha:0.6f];
	XCTAssertEqual([color sam_alpha], 0.6f, @"");
}


- (void)testRed {
	UIColor *color = [UIColor redColor];
	XCTAssertEqual([color sam_red], 1.0f, @"");
	
	color = [UIColor colorWithRed:0.3f green:0.4f blue:0.5f alpha:0.6f];
	XCTAssertEqual([color sam_red], 0.3f, @"");
}


- (void)testGreen {
	UIColor *color = [UIColor greenColor];
	XCTAssertEqual([color sam_green], 1.0f, @"");
	
	color = [UIColor colorWithRed:0.3f green:0.4f blue:0.5f alpha:0.6f];
	XCTAssertEqual([color sam_green], 0.4f, @"");
}


- (void)testBlue {
	UIColor *color = [UIColor blueColor];
	XCTAssertEqual([color sam_blue], 1.0f, @"");
	
	color = [UIColor colorWithRed:0.3f green:0.4f blue:0.5f alpha:0.6f];
	XCTAssertEqual([color sam_blue], 0.5f, @"");
}


- (void)testColorWithCSS {
	XCTAssertEqualObjects([UIColor redColor], [UIColor sam_colorWithCSS:@"red"], @"");
	XCTAssertEqualObjects([UIColor greenColor], [UIColor sam_colorWithCSSName:@"lime"], @"");
	XCTAssertEqualObjects([UIColor redColor], [UIColor sam_colorWithCSS:@"rgb(255,0,0)"], @"");
	XCTAssertEqualObjects([UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:0.5f], [UIColor sam_colorWithCSS:@"rgba(255,0,0,0.5)"], @"");
}


- (void)testColorWithHSL {
	XCTAssertEqualObjects([UIColor redColor], [UIColor sam_colorWithHue:0.0f saturation:1.0f lightness:0.5f alpha:1.0f], @"");
	XCTAssertEqualObjects([UIColor redColor], [UIColor sam_colorWithHSL:@"hsl(0,100%,50%)"], @"");
	XCTAssertEqualObjects([UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:0.5f], [UIColor sam_colorWithHSL:@"hsla(0,100%,50%,0.5)"], @"");
}


- (void)testColorWithHex {
	UIColor *red = [UIColor redColor];
	XCTAssertEqualObjects(red, [UIColor sam_colorWithHex:@"f00"], @"");
	XCTAssertEqualObjects(red, [UIColor sam_colorWithHex:@"ff0000"], @"");
	XCTAssertEqualObjects(red, [UIColor sam_colorWithHex:@"ff0000ff"], @"");
	
	UIColor *green = [UIColor greenColor];
	XCTAssertEqualObjects(green, [UIColor sam_colorWithHex:@"0f0"], @"");
	XCTAssertEqualObjects(green, [UIColor sam_colorWithHex:@"00ff00"], @"");
	XCTAssertEqualObjects(green, [UIColor sam_colorWithHex:@"00ff00ff"], @"");
	
	UIColor *blue = [UIColor blueColor];
	XCTAssertEqualObjects(blue, [UIColor sam_colorWithHex:@"00f"], @"");
	XCTAssertEqualObjects(blue, [UIColor sam_colorWithHex:@"0000ff"], @"");
	XCTAssertEqualObjects(blue, [UIColor sam_colorWithHex:@"0000ffff"], @"");
	
	UIColor *bleh = [UIColor colorWithRed:1.0f green:0.2f blue:0.0f alpha:0.2f];
	XCTAssertEqualObjects(bleh, [UIColor sam_colorWithHex:@"ff330033"], @"");
}


- (void)testHexValue {
	UIColor *red = [UIColor redColor];
	XCTAssertEqualObjects([red sam_hexValue], @"ff0000", @"");
	XCTAssertEqualObjects([red sam_hexValueWithAlpha:YES], @"ff0000ff", @"");
	
	UIColor *green = [UIColor greenColor];
	XCTAssertEqualObjects([green sam_hexValue], @"00ff00", @"");
	XCTAssertEqualObjects([green sam_hexValueWithAlpha:YES], @"00ff00ff", @"");
	
	UIColor *blue = [UIColor blueColor];
	XCTAssertEqualObjects([blue sam_hexValue], @"0000ff", @"");
	XCTAssertEqualObjects([blue sam_hexValueWithAlpha:YES], @"0000ffff", @"");
	
	UIColor *white = [UIColor whiteColor];
	XCTAssertEqualObjects([white sam_hexValue], @"ffffff", @"");
	XCTAssertEqualObjects([white sam_hexValueWithAlpha:YES], @"ffffffff", @"");
	XCTAssertEqualObjects([[white colorWithAlphaComponent:0.2f] sam_hexValueWithAlpha:YES], @"ffffff33", @"");
}

@end
