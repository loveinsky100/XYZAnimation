//
//  AnimationTool.m
//  XYZAnimation
//
//  Created by Leo on 16/3/31.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "AnimationTool.h"

@interface AnimationTool()
@property (nonatomic, strong) NSMutableArray<CAAnimation *> *animations;
@property (nonatomic, weak)   CALayer *animationLayer;
@end

@implementation AnimationTool
- (void)showAnimationWithLayer:(CALayer *)animationLayer
{
    [self p_doAnimations:animationLayer];
    self.animationLayer = animationLayer;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if(self.animcations.count == 0)
    {
        return;
    }
    
    NSInteger index = self.animations.count;
    NSString *animationKey = [NSString stringWithFormat: @"Animation%ld", index];
    [self.animationLayer addAnimation:self.animcations[0] forKey:animationKey];
    
    [self.animcations removeObjectAtIndex: 0];
}

- (void)p_doAnimations:(CALayer *)animationLayer
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
//    animation2.delegate = self;
    
    //路径曲线
    CGPoint fromPoint = animationLayer.frame.origin;
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
    
    CABasicAnimation *animation4 = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    animation4.fromValue = @0;
    animation4.toValue = @1;
    animation4.duration = 2;
    animation4.fillMode = kCAFillModeForwards;
    animation4.removedOnCompletion = NO;
    animation4.delegate = self;
    
    [animationLayer addAnimation:animation
                          forKey:@"positionAnimation"];

    [self.animcations removeAllObjects];

    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = 3;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.removedOnCompletion = NO;
    animationGroup.autoreverses = NO;
    animationGroup.delegate = self;
    animationGroup.animations = @[animation2, animation3];
    
    [self.animcations addObject: animationGroup];
    [self.animcations addObject: animation4];
    
    
}

- (NSMutableArray<CAAnimation *> *)animcations
{
    if(!_animations)
    {
        _animations = [[NSMutableArray alloc] initWithCapacity:2];
    }
    
    return _animations;
}


@end
