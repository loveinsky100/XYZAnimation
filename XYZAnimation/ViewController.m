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
@property (nonatomic, strong) CAShapeLayer *circleLayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _circleLayer = [[CAShapeLayer alloc] init];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(600, 300)
                                                        radius:100
                                                    startAngle:3 * M_PI_2
                                                      endAngle:M_PI * 2 + 3 * M_PI_2
                                                     clockwise:YES];
    _circleLayer.path = path.CGPath;
    _circleLayer.fillColor = [UIColor clearColor].CGColor;
    _circleLayer.strokeColor = [UIColor blueColor].CGColor;
    [self.view.layer addSublayer: _circleLayer];

}

- (IBAction)startAnimation:(id)sender {
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 2;
    animation.fillMode = kCAFillModeForwards;
    animation.autoreverses = NO;
    animation.removedOnCompletion = NO;
    animation.delegate = self;
    
    //路径曲线
    CGPoint fromPoint = _circleLayer.frame.origin;
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:fromPoint];
    CGPoint toPoint = CGPointMake(30, 360);
    [movePath addQuadCurveToPoint:toPoint
                     controlPoint:CGPointMake(300,0)];
    
    
    CGColorRef originColor = [UIColor redColor].CGColor;
    CGColorRef darkGray = [UIColor greenColor].CGColor;
    
    [_circleLayer makeCAAnimation:^(XYZAnimationMaker *make) {
        make.addAnimation(animation)
        .withFinishCallBack(^(){ NSLog(@"strokeEnd finish"); });
        
        make.startGroup
        .inDuration(3)
        .withAutoreverses(NO)
        .withFillMode(kCAFillModeForwards)
        .andRemoveOnCompletion(NO)
        .withFinishCallBack(^(){ NSLog(@"group all finish"); });;
        
        make.basicAnimation
        .from(@1)
        .to(@20)
        .withKeyPath(@"lineWidth")
        .inDuration(2)
        .andRepeatCount(NSIntegerMax)
        .withAutoreverses(YES)
        .withFillMode(kCAFillModeForwards)
        .andRemoveOnCompletion(NO)
        .withFinishCallBack(^(){ NSLog(@"group firstAnimation finish"); });
        
        make.basicAnimation
        .from((__bridge id)(originColor))
        .to((__bridge id)(darkGray))
        .withKeyPath(@"strokeColor")
        .inDuration(2)
        .andRepeatCount(NSIntegerMax)
        .withAutoreverses(YES)
        .withFillMode(kCAFillModeForwards)
        .andRemoveOnCompletion(NO)
        .withFinishCallBack(^(){ NSLog(@"group firstAnimation finish"); });
        
//        make.keyframeAnimation
//        .withPath(movePath.CGPath)
//        .withKeyPath(@"position")
//        .inDuration(3)
//        .withAutoreverses(NO)
//        .withFillMode(kCAFillModeForwards)
//        .andRemoveOnCompletion(NO);
        
        make.endGroup();
        
//        make.basicAnimation
//        .from(@0)
//        .to(@1)
//        .withKeyPath(@"strokeStart")
//        .inDuration(2)
//        .withAutoreverses(NO)
//        .withFillMode(kCAFillModeForwards)
//        .andRemoveOnCompletion(NO);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
