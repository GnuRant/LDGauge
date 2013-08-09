//
//  LDGauges.h
//
//  Created by Luca D'Incà on 29/06/13.
//  Copyright (c) 2012 Loupe. All rights reserved.
//
//  This code comes with no warranty, free to use for any purpose

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "LDGaugesLayer.h"

@interface LDGauges : UIView

@property (nonatomic, strong) UIColor *fontColor;
@property (nonatomic, strong) UIFont *font;


- (id)initWithFrame:(CGRect)frame startAngle:(CGFloat)startAngle  gaugesRadius:(CGFloat)radius
    gaugesThickness:(CGFloat)Thickness;

- (id)initWithFrame:(CGRect)frame startAngle:(CGFloat)startAngle center:(CGPoint)center
       gaugesRadius:(CGFloat)radius gaugesThickness:(CGFloat)thickness;

- (void)setGaugeRate:(NSInteger)rate;
- (void)setGaugeColor:(UIColor *)color;
- (void)setGaugeBackgroundColor:(UIColor *)color;



@end
