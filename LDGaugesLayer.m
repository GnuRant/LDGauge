//
//  LDGaugesLayer.m
//
//  Created by Luca D'Incà on 29/06/13.
//  Copyright (c) 2012 Loupe. All rights reserved.
//
//  This code comes with no warranty, free to use for any purpose

#import "LDGaugesLayer.h"

#define START_ANGLE_BACKGROUND 0.f
#define STOP_ANGLE_BACKGROUND 360.f
#define ANIMATION_DURATION 1.f
#define DEGRESS_TO_RADIUS(degress) ((M_PI * degress)/ 180.f)

@implementation LDGaugesLayer

@dynamic startAngle, stopAngle;

#pragma mark Inizialization method

- (id)initWithLayer:(id)layer
{
    if (self = [super initWithLayer:layer]) {
        if ([layer isKindOfClass:[LDGaugesLayer class]]) {
            LDGaugesLayer *previous = (LDGaugesLayer *)layer;
            [self doInizialSetup:previous];
        }
    }
    
    return self;
}

- (void)initWithFreame:(CGRect)frame center:(CGPoint)center radius:(CGFloat)radius
             thickness:(CGFloat)thickness;
{
    [self setContentsScale:[[UIScreen mainScreen] scale]];
    self.frame = frame;
    self.center = center;
    self.radius = radius;
    self.thickness = thickness;
}

- (void)doInizialSetup:(LDGaugesLayer *)previous
{
    self.center = previous.center;
    self.stopAngle = previous.stopAngle;
    self.radius = previous.radius;
    self.thickness = previous.thickness;
    self.color = previous.color;
    self.backgroudColor = previous.backgroudColor;
}

//Return true if "startAngle" or "stopAngle"
//change their values 
+(BOOL)needsDisplayForKey:(NSString *)key
{
    if ([key isEqualToString:@"startAngle"] ||
        [key isEqualToString:@"stopAngle"])  {
        return YES;
    }
    return [super needsDisplayForKey:key];
}

-(id<CAAction>)actionForKey:(NSString *)event
{
    if ([event isEqualToString:@"startAngle"] ||
        [event isEqualToString:@"stopAngle"]) {
        //if startAngle or stopAngle change their values,
        //the system automatically invokes a method to create the animation
        return [self makeAnimationForKey:event];
    }
    return [super actionForKey:event];
}

-(CAAnimation *)makeAnimationForKey:(NSString *)key
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:key];
    
    animation.fromValue = [[self presentationLayer] valueForKey:key];
    //Set animation type, the animation to begin quickly, and then slow as it completes
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.duration = ANIMATION_DURATION;
    
    return animation;
}

#pragma mark Create gauge form

-(CGMutablePathRef)creteGaugesBackGroundForm:(CGFloat)radius thickness:(CGFloat)thickness
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPoint center = self.center;
    
    //External circle
    CGPathAddArc(path, NULL, center.x, center.y, radius, START_ANGLE_BACKGROUND ,
                 DEGRESS_TO_RADIUS(STOP_ANGLE_BACKGROUND), YES);
    CGPathCloseSubpath(path);
    //Internal circle
    CGPathAddArc(path, NULL, center.x, center.y, radius- thickness, START_ANGLE_BACKGROUND ,
                 DEGRESS_TO_RADIUS(STOP_ANGLE_BACKGROUND), YES);
    CGPathCloseSubpath(path);
    
    return path;
}

-(CGMutablePathRef)createStartStopBlock:(CGPoint)startLinePoint angle:(CGFloat)angle
{
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, startLinePoint.x, startLinePoint.y);

    CGPathAddLineToPoint(path, NULL, (self.center.x + (self.radius) * cosf(angle)),
                         self.center.y + (self.radius) * sinf(angle));
    
    return path;
}

-(CGMutablePathRef)createGauges:(CGPoint)startPoint
{

    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, startPoint.x, startPoint.y);
    //External arch
    CGPathAddLineToPoint(path, NULL, (self.center.x + (self.radius) * cosf(self.startAngle)),
                         self.center.y + (self.radius) * sinf(self.startAngle));
    //Draw external arch
    CGPathAddArc(path, NULL, self.center.x, self.center.y, self.radius, self.startAngle, self.stopAngle, NO);
    
    CGPathAddLineToPoint(path, NULL, (self.center.x + (self.radius - self.thickness) * cosf(self.stopAngle)),
                         self.center.y + (self.radius - self.thickness) * sinf(self.stopAngle));
    //Draw internal arch
    CGPathAddArc(path, NULL, self.center.x, self.center.y, (self.radius - self.thickness) ,
                 self.stopAngle, self.startAngle, YES);
    
    return path;
}

#pragma mark Draw forms in the layer

-(void)drawInContext:(CGContextRef)ctx
{
    //Starting point
    CGPoint startPoint = CGPointMake((self.center.x + (self.radius - self.thickness) * cosf(self.startAngle)),
                                     self.center.y + (self.radius - self.thickness) * sinf(self.startAngle));
    //Ending point
    //CGPoint endPoint = CGPointMake((self.center.x + (self.radius - self.thickness) * cosf(self.stopAngle)),
                                   //self.center.y + (self.radius - self.thickness) * sinf(self.stopAngle));
    
    //Enable Antialias
    CGContextSetShouldAntialias(ctx, YES);
    
    //Draw the gauge background
    CGContextSetFillColorWithColor(ctx, self.backgroudColor.CGColor);
    CGContextAddPath(ctx, [self creteGaugesBackGroundForm:self.radius thickness:self.thickness]);
    //Fill the form in EO mode
    CGContextEOFillPath(ctx);
    
    //Create the gauge path
    CGContextAddPath(ctx, [self createGauges:startPoint]);
    //Fill with color the main form
    CGContextSetFillColorWithColor(ctx, self.color.CGColor);
    //Draw the gauge
    CGContextDrawPath(ctx, kCGPathFill);
}

@end
