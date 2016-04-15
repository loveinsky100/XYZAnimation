//
//  ViewController.m
//  XYZAnimation
//
//  Created by Leo on 16/3/31.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "ViewController.h"
#import "XYZAnimation.h"

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
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 2;
    animation.fillMode = kCAFillModeForwards;
    animation.autoreverses = NO;
    animation.removedOnCompletion = NO;
    animation.delegate = self;

    //路径曲线
    CGPoint fromPoint = cirleLayer.frame.origin;
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:fromPoint];
    CGPoint toPoint = CGPointMake(30, 360);
    [movePath addQuadCurveToPoint:toPoint
                     controlPoint:CGPointMake(300,0)];
    [cirleLayer makeCAAnimation:^(XYZAnimationMaker *maker) {
//        maker.addAnimation(animation)
//             .withFinishCallBack(^(){ NSLog(@"strokeEnd finish"); });
        
        maker.startGroup
             .inDuration(3)
             .withAutoreverses(NO)
             .withFillMode(kCAFillModeForwards)
             .andRemoveOnCompletion(NO);
        
        maker.basicAnimation
             .from(@0)
             .to(@10)
             .withKeyPath(@"lineWidth")
             .inDuration(2)
             .withAutoreverses(NO)
             .withFillMode(kCAFillModeForwards)
             .andRemoveOnCompletion(NO)
             .withFinishCallBack(^(){ NSLog(@"group finish"); });
        
        maker.keyframeAnimation
             .withPath(movePath.CGPath)
             .withKeyPath(@"position")
             .inDuration(3)
             .withAutoreverses(NO)
             .withFillMode(kCAFillModeForwards)
             .andRemoveOnCompletion(NO);
        
        maker.endGroup();
        
//        maker.basicAnimation
//             .from(@0)
//             .to(@1)
//             .withKeyPath(@"strokeStart")
//             .inDuration(2)
//             .withAutoreverses(NO)
//             .withFillMode(kCAFillModeForwards)
//             .andRemoveOnCompletion(NO);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
