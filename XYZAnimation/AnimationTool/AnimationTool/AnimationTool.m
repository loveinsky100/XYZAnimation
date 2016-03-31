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

- (void)showAnimationWithLayer:(CALayer *)animationLayer andAnimations:(NSArray<XYZAnimation *> *)animations
{
    self.animationLayer = animationLayer;
    [self p_startAnimationWith: animations];
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


@end
