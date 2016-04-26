//
//  CALayer+XYZAnimation.m
//  XYZAnimation
//
//  Created by Leo on 16/3/31.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "CALayer+XYZAnimation.h"
#import "objc/runtime.h"
#import "CAAnimation+XYZAnimation.h"

static void *AnimationArrayKey = "kAnimationArrayKey";

@implementation CALayer(XYZAnimation)

- (void)makeCAAnimation:(void (^)(XYZAnimationMaker *))makerBlock
{
    if(!self.animations)
    {
        self.animations = [NSMutableArray array];
    }
    
    [self.animations removeAllObjects];
    XYZAnimationMaker *maker = [[XYZAnimationMaker alloc] initWithLayer: self];
    makerBlock(maker);
    self.animations = maker.animations;
    [self showAnimations];
}

- (void)showAnimations
{
    if(!self.animations || ![self.animations isKindOfClass:[NSArray class]])
    {
        return;
    }
    
    if(!self.animations.count)
    {
        return;
    }
    
    CAAnimation *firstAnimation = self.animations.firstObject;
    [self addXYZAnimation:firstAnimation
                   forKey:@"Animation"];
    
    [self.animations removeObjectAtIndex: 0];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if(!flag)
    {
        return;
    }
    
    if(anim.finishCallBack)
    {
        anim.finishCallBack();
    }
    
    if(self.animations.count == 0 || anim.isInGroup)
    {
        return;
    }
    
    NSInteger index = self.animations.count;
    NSString *animationKey = [NSString stringWithFormat: @"Animation%ld", (long)index];
    CAAnimation *animation = self.animations[0];
    [self addXYZAnimation:animation
                   forKey:animationKey];
    [self.animations removeObjectAtIndex: 0];
}

- (void)addXYZAnimation:(CAAnimation *)animation forKey:(NSString *)animationKey
{
    if([animation isKindOfClass: [CAAnimationGroup class]]
       && ((CAAnimationGroup *)animation).animations
       && ((CAAnimationGroup *)animation).animations.count)
    {
        CAAnimationGroup *aniGroup = (CAAnimationGroup *)animation;
        [self addAnimationGroup:aniGroup
                         forKey:animationKey];
    }
    else
    {
        [self addAnimation:animation
                    forKey:animationKey];
    }
}

- (void)addAnimationGroup:(CAAnimationGroup *)animationGroup forKey:(NSString *)animationKey
{
    [self addAnimtions:[self animationsInGroup: animationGroup]
            forBaseKey:animationKey];
    
    animationGroup.animations = nil;
    [self addAnimation:animationGroup
                forKey:animationKey];
}

- (void)addAnimtions:(NSArray<CAAnimation *> *)animations forBaseKey:(NSString *)baseKey
{
    for(CAAnimation *animation in animations)
    {
        NSInteger index = [animations indexOfObject: animation];
        NSString *animationKey = [NSString stringWithFormat:@"%@-inGroup-%ld", baseKey, (long)index];
        animation.isInGroup = YES;
        [self addAnimation: animation
                    forKey: animationKey];
    }
}

- (NSArray<CAAnimation *> *)animationsInGroup:(CAAnimationGroup *)animationGroup
{
    NSMutableArray<CAAnimation *> *animations = [NSMutableArray arrayWithCapacity: 0];
    for(CAAnimation *animation in animationGroup.animations)
    {
        if([animation isKindOfClass: [CAAnimationGroup class]])
        {
            CAAnimationGroup *aniGroup = (CAAnimationGroup *)animation;
            [animations addObject: aniGroup];
            [animations addObjectsFromArray: [self animationsInGroup: aniGroup]];
            aniGroup.animations = nil;
        }
        else
        {
            [animations addObject: animation];
        }
    }

    return animations;
}

- (NSMutableArray *)animations
{
    return objc_getAssociatedObject(self, AnimationArrayKey);
}

- (void)setAnimations:(NSMutableArray *)animations
{
    objc_setAssociatedObject(self, AnimationArrayKey, animations, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
