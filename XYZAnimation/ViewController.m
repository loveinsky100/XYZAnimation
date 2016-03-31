//
//  ViewController.m
//  XYZAnimation
//
//  Created by Leo on 16/3/31.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "ViewController.h"
#import "AnimationTool.h"
#import "CALayer+XYZ.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
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

    //路径曲线
    CGPoint fromPoint = cirleLayer.frame.origin;
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:fromPoint];
    CGPoint toPoint = CGPointMake(30, 360);
    [movePath addQuadCurveToPoint:toPoint
                     controlPoint:CGPointMake(300,0)];
    
    [cirleLayer makeCAAnimation:^(XYZAnimationMaker *maker) {
        maker.strokeEnd.from(@0).to(@1).inDuration(2).
        then.lineWidth.from(@1).to(@10).inDuration(2).
        with.position.withPath(movePath.CGPath).inDuration(3).
        then.strokeStart.from(@0).to(@1).inDuration(2);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
