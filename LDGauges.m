//
//  LDGauges.m
//
//  Created by Luca D'Incà on 29/06/13.
//  Copyright (c) 2013 Luca D'Incà. All rights reserved.
//
//  This code comes with no warranty, free to use for any purpose
//  Licensed under the Apache License, Version 2.0 http://www.apache.org/licenses/LICENSE-2.0

#import "LDGauges.h"

#define DEGRESS_TO_RADIUS(degress) ((M_PI * degress)/ 180)

@implementation LDGauges
{
    CALayer     *_containerLayer;
    CGPoint     _center;
    CGFloat     _startAngle;
    NSInteger   _percentage;
    LDGaugesLayer *_gauges;
}

#pragma mark Inizialization methods

- (id)initWithFrame:(CGRect)frame startAngle:(CGFloat)startAngle  gaugesRadius:(CGFloat)radius
    gaugesThickness:(CGFloat)thickness
{
    if ((self = [super initWithFrame:frame])) {
        [self doInitialSetup];
        _startAngle = startAngle;
        _center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        _gauges = [LDGaugesLayer layer];
        
        [_gauges setStartAngle:DEGRESS_TO_RADIUS(_startAngle)];
        [_gauges setStopAngle:DEGRESS_TO_RADIUS(_startAngle)];
        [_containerLayer addSublayer:_gauges];
        [_gauges initWithFreame:self.bounds
                        center:_center
                        radius:radius
                     thickness:thickness];
        [_gauges setNeedsDisplay];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame startAngle:(CGFloat)startAngle center:(CGPoint)center gaugesRadius:(CGFloat)radius
    gaugesThickness:(CGFloat)thickness
{
    if (self = [super initWithFrame:frame]) {
        [self doInitialSetup];
        _startAngle = startAngle;
        _center = center;
        _gauges = [LDGaugesLayer layer];
        
        [_gauges setStartAngle:DEGRESS_TO_RADIUS(_startAngle)];
        [_gauges setStopAngle:DEGRESS_TO_RADIUS(_startAngle)];
        [_containerLayer addSublayer:_gauges];
        [_gauges initWithFreame:self.bounds
                        center:_center
                        radius:radius
                     thickness:thickness];
        [_gauges setNeedsDisplay];
    }
    return self;
}

- (void)doInitialSetup
{
    //Impsoto il colore della UIVIew a transparente
    self.backgroundColor = [UIColor clearColor];
    //Istanzio il layer
    _containerLayer = [CALayer layer];
    _containerLayer.frame = self.bounds;
    //Aggiungo il layer dove saranno disegnate tutte le componenti
    [self.layer addSublayer:_containerLayer];
}

- (CGFloat)convertPercentageToDegrees:(NSInteger)rate
{
    return (360.0f/100*rate)+_startAngle;
}

#pragma mark Draw text methods

- (void)drawString:(NSString *)string withFont:(UIFont *)font
{
    CGSize fontSize = [string sizeWithFont:font];
    CGFloat yOffset = ((_center.y - fontSize.height/2));
    CGFloat xOffset = ((_center.x - fontSize.width/2));
    
    CGRect textRect = CGRectMake(xOffset, yOffset, fontSize.width, fontSize.height);
    
    [string drawInRect:textRect withFont:font];
}

- (void)drawRect:(CGRect)rect
{
    [_fontColor set];
    NSString *text = [NSString stringWithFormat:@"%d%%", _percentage];
    
    [self drawString:text
            withFont:_font];
}

#pragma mark Set/Update methods

- (void)setGaugeRate:(NSInteger)rate
{
    _gauges.stopAngle = DEGRESS_TO_RADIUS([self convertPercentageToDegrees:rate]);
    _percentage = rate;
    [self setNeedsDisplay];
}

- (void)setGaugeColor:(UIColor *)color
{
    [_gauges setBackgroudColor:color];
}

- (void)setGaugeBackgroundColor:(UIColor *)color{
    [_gauges setColor:color];
}


@end
