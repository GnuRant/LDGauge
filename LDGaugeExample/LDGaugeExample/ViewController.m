//
//  ViewController.m
//  LDGaugeExample
//
//  Created by Luca D'Incà on 10/08/13.
//  Copyright (c) 2013 Luca D'Incà. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    LDGauges *gauge;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    //Init LDGauge, in this case using standard initialization
    gauge = [[LDGauges alloc]initWithFrame:CGRectMake(60, 30, 200, 200)
                                         startAngle:0
                                       gaugesRadius:100
                                    gaugesThickness:5];
    //Set gauge background color
    [gauge setGaugeBackgroundColor:[UIColor colorWithRed:56/255.0f green:184/255.0f blue:154/255.0f alpha:1.0]];
    //Set gauge color
    [gauge setGaugeColor:[UIColor colorWithRed:209/255.0f green:210/255.0f blue:204/255.0f alpha:1.0]];
    //Set gauge rate (from 0% to 100%)
    [gauge setGaugeRate:73.0f];
    //Set percentage string
    [gauge setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:40]];
    [gauge setFontColor:[UIColor blackColor]];
    //Add gauge view to the container view
    [self.view addSubview:gauge];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Update gauge rate

- (IBAction)updateGauge:(id)sender
{
    [gauge setGaugeRate:(random()%101+1)];
}

@end
