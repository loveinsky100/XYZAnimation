//
//  AnimationTool.m
//  XYZAnimation
//
//  Created by Leo on 16/3/31.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "AnimationTool.h"
#import "XYZAnimation.h"

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
    XYZAnimation *xyzAnimation1 = [XYZAnimation animationWithType:XYZAnimationStrokeEnd];
    xyzAnimation1.fromValue = @0;
    xyzAnimation1.toValue = @1;
    xyzAnimation1.duration = 2;
    xyzAnimation1.delegate = self;
    
    XYZAnimation *xyzAnimation2 = [XYZAnimation animationWithType:XYZAnimationStrokeLineWidth];
    xyzAnimation2.fromValue = @1;
    xyzAnimation2.toValue = @10;
    xyzAnimation2.duration = 2;
    xyzAnimation2.delegate = self;
    
    //路径曲线
    CGPoint fromPoint = animationLayer.frame.origin;
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:fromPoint];
    CGPoint toPoint = CGPointMake(30, 360);
    [movePath addQuadCurveToPoint:toPoint
                     controlPoint:CGPointMake(300,0)];
    
    //关键帧
    XYZAnimation *xyzAnimation3 = [XYZAnimation animationWithType:XYZAnimationPosition];
    xyzAnimation3.path = movePath.CGPath;
    xyzAnimation3.duration = 3;
    xyzAnimation3.delegate = self;
    
    XYZAnimation *xyzAnimation4 = [XYZAnimation animationWithType:XYZAnimationStrokeStart];
    xyzAnimation4.fromValue = @0;
    xyzAnimation4.toValue = @1;
    xyzAnimation4.duration = 2;
    xyzAnimation4.delegate = self;
    
    [animationLayer addAnimation:xyzAnimation1.animation
                          forKey:@"positionAnimation"];

    XYZAnimation *animationGroup = [[XYZAnimation alloc] init];
    animationGroup.group = @[xyzAnimation2, xyzAnimation3];
    animationGroup.delegate = self;
    
    [self.animcations removeAllObjects];
    [self.animcations addObject: animationGroup.animation];
    [self.animcations addObject: xyzAnimation4.animation];
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
