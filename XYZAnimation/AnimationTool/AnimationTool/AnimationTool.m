//
//  AnimationTool.m
//  XYZAnimation
//
//  Created by Leo on 16/3/31.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "AnimationTool.h"

@interface AnimationTool()
@property (nonatomic, strong) NSMutableArray<CAAnimation *> *animcations;
@property (nonatomic, weak)   CALayer *animcationLayer;
@end

@implementation AnimationTool
- (void)showAnimationWithLayer:(CALayer *)animcationLayer
{
    [self p_doAnimations:animcationLayer];
    self.animcationLayer = animcationLayer;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if(self.animcations.count == 0)
    {
        return;
    }
    
    NSString *animcationKey = [NSString stringWithFormat: @"Animcation%lu", (unsigned long)self.animcations.count];
    [self.animcationLayer addAnimation:self.animcations[0] forKey:animcationKey];
    [self.animcations removeObjectAtIndex: 0];
}

- (void)p_doAnimations:(CALayer *)animcationLayer
{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 2;
    animation.fillMode = kCAFillModeForwards;
    animation.autoreverses = NO;
    animation.removedOnCompletion = NO;
    animation.delegate = self;
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"lineWidth"];
    animation2.fromValue = @1;
    animation2.toValue = @10;
    animation2.duration = 2;
    animation2.fillMode = kCAFillModeForwards;
    animation2.autoreverses = NO;
    animation2.removedOnCompletion = NO;
    animation2.delegate = self;
    
    //路径曲线
    CGPoint fromPoint = animcationLayer.frame.origin;
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:fromPoint];
    CGPoint toPoint = CGPointMake(30, 360);
    [movePath addQuadCurveToPoint:toPoint
                     controlPoint:CGPointMake(300,0)];
    
    //关键帧
    CAKeyframeAnimation *animation3 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation3.path = movePath.CGPath;
    animation3.duration = 3;
    animation3.fillMode = kCAFillModeForwards;
    animation3.autoreverses = NO;
    animation3.removedOnCompletion = NO;
    animation3.delegate = self;
    
    CABasicAnimation *animation4 = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    animation4.fromValue = @0;
    animation4.toValue = @1;
    animation4.duration = 2;
    animation4.fillMode = kCAFillModeForwards;
    animation4.removedOnCompletion = NO;
    
    [animcationLayer addAnimation:animation
                           forKey:@"positionAnimation"];

    [self.animcations removeAllObjects];
    [self.animcations addObject: animation2];
    [self.animcations addObject: animation3];
    [self.animcations addObject: animation4];
}

- (NSMutableArray<CAAnimation *> *)animcations
{
    if(!_animcations)
    {
        _animcations = [[NSMutableArray alloc] initWithCapacity:2];
    }
    
    return _animcations;
}


@end
