//
//  LDGaugesLayer.h
//
//  Created by Luca D'Incà on 29/06/13.
//  Copyright (c) 2013 Luca D'Incà. All rights reserved.
//
//  This code comes with no warranty, free to use for any purpose
//  Licensed under the Apache License, Version 2.0 http://www.apache.org/licenses/LICENSE-2.0

#import <QuartzCore/QuartzCore.h>

@interface LDGaugesLayer : CALayer

@property (nonatomic) CGFloat startAngle;
@property (nonatomic) CGFloat stopAngle;
@property (nonatomic) CGFloat radius;  
@property (nonatomic) CGFloat thickness;
@property (nonatomic) CGPoint center;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIColor *backgroudColor;

- (void)initWithFreame:(CGRect)frame center:(CGPoint)center radius:(CGFloat)radius
             thickness:(CGFloat)thickness;


@end
