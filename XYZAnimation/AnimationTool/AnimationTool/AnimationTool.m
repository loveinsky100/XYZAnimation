//
//  AnimationTool.m
//  XYZAnimation
//
//  Created by Leo on 16/3/31.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "AnimationTool.h"
#import "XYZAnimation.h"
#import "XYZAnimationMaker.h"

@interface AnimationTool()
@property (nonatomic, strong) NSMutableArray<CAAnimation *> *animations;
@property (nonatomic, weak)   CALayer *animationLayer;
@property (nonatomic, strong) XYZAnimationMaker *maker;
@end

@implementation AnimationTool
- (void)showAnimationWithLayer:(CALayer *)animationLayer
{
    self.animationLayer = animationLayer;
    [self p_doAnimations:animationLayer];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if(self.animations.count == 0)
    {
        return;
    }
    
    NSInteger index = self.animations.count;
    NSString *animationKey = [NSString stringWithFormat: @"Animation%ld", index];
    [self.animationLayer addAnimation:self.animations[0] forKey:animationKey];
    
    [self.animations removeObjectAtIndex: 0];
}

- (void)p_doAnimations:(CALayer *)animationLayer
{
    //路径曲线
    CGPoint fromPoint = animationLayer.frame.origin;
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:fromPoint];
    CGPoint toPoint = CGPointMake(30, 360);
    [movePath addQuadCurveToPoint:toPoint
                     controlPoint:CGPointMake(300,0)];
    
    self.maker.strokeEnd.from(@0).to(@1).inDuration(2).
              then.lineWidth.from(@1).to(@10).inDuration(2).
              with.position.withPath(movePath.CGPath).inDuration(3).
              then.strokeStart.from(@0).to(@1).inDuration(2);
    [self p_startAnimationWith: self.maker.animations];
}

- (void)p_startAnimationWith:(NSArray<XYZAnimation *> *)animations
{
    if(!animations || ![animations isKindOfClass:[NSArray class]])
    {
        return;
    }
    
    NSArray<XYZAnimation *> *xyzAnimations = [animations subarrayWithRange: NSMakeRange(1, animations.count - 1)];
    XYZAnimation *animation = animations.firstObject;
    [self.animationLayer addAnimation: animation.animation
                               forKey: @"Animation"];
    [self.animations removeAllObjects];
    for(XYZAnimation *anim in xyzAnimations)
    {
        [self.animations addObject: anim.animation];
    }
}

- (NSMutableArray<CAAnimation *> *)animations
{
    if(!_animations)
    {
        _animations = [[NSMutableArray alloc] initWithCapacity:2];
    }
    
    return _animations;
}

- (XYZAnimationMaker *)maker
{
    if(!_maker)
    {
        _maker = [[XYZAnimationMaker alloc] init];
        _maker.delegate = self;
    }
    
    return _maker;
}

@end
