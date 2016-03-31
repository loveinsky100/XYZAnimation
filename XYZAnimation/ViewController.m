//
//  ViewController.m
//  XYZAnimation
//
//  Created by Leo on 16/3/31.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "ViewController.h"
#import "AnimationTool.h"

@interface ViewController ()
@property (nonatomic, strong) AnimationTool *animationTool;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _animationTool = [[AnimationTool alloc] init];
    
    CAShapeLayer *cirleLayer = [[CAShapeLayer alloc] init];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(600, 300)
                                                        radius:100
                                                    startAngle:3 * M_PI_2
                                                      endAngle:M_PI * 2 + 3 * M_PI_2
                                                     clockwise:YES];
    cirleLayer.path = path.CGPath;
    cirleLayer.fillColor = [UIColor clearColor].CGColor;
    cirleLayer.strokeColor = [UIColor blueColor].CGColor;
    [self.view.layer addSublayer: cirleLayer];
    [_animationTool showAnimationWithLayer:cirleLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
