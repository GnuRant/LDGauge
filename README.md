LDGauges v0.1
========
This iOS UI element provides a customizable gauge, you can customize  size, color, thickness and many other cool things.

Project tested under iOS 5.x and 6.x, requires ARC

Demo
====

![Alt text](http://s13.postimg.org/yggr3rlx3/gif_1.gif)


Quick Start
===========
* Copy __LDGauges.h/.m__, __LDGaugesLayer.h/.m__ in your project
* Include __QuarzCore.framework__ and __CoreGraphics.framework__ 


Basic Example
==============

Init gauges in a frame with start angle, radius and thickness
```objc
    LDGauge gauge = [[LDGauges alloc]initWithFrame:CGRectMake(30, 0, 250, 250) 
                                        startAngle:0
                                      gaugesRadius:100 
                                   gaugesThickness:5];
```
Set gauge color
```objc
    [gauge setColor:[UIColor colorWithRed:209/255.0f green:210/255.0f blue:204/255.0f alpha:1.0]];
```
Set gauge background color
```objc
    [gauge setBackgroundColor:[UIColor colorWithRed:56/255.0f green:184/255.0f blue:154/255.0f alpha:1.0]];
```   
Add gauge to the main view
```objc
    [self.view addSubview:_gaugesView];
```
Customization
=============

### Update percentage

This method require a percentage value, (change value automatically trigger component animation)
```objc
    [gauges setGaugesRate:30];
```
### Change font 
```objc
    [gauge setFont:[UIFont fontWithName:@"Helvetica" size:40]];
```
### Change font color 
```objc
    [gauge setFontColor:[UIColor blackColor]];
```

License
=======

Licensed under the Apache License, Version 2.0 http://www.apache.org/licenses/LICENSE-2.0
