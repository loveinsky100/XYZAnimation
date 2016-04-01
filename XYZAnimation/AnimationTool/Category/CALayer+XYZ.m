//
//  CALayer+XYZ.m
//  XYZAnimation
//
//  Created by Leo on 16/3/31.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "CALayer+XYZ.h"
#import "objc/runtime.h"
#import "CAAnimation+XYZ.h"

static void *AnimationArrayKey = "kAnimationArrayKey";

@implementation CALayer(XYZ)

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
    
    [self addAnimation: self.animations.firstObject
                forKey: @"Animation"];
    [self.animations removeObjectAtIndex: 0];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if(self.animations.count == 0)
    {
        return;
    }
    
    NSInteger index = self.animations.count;
    NSString *animationKey = [NSString stringWithFormat: @"Animation%ld", index];
    [self addAnimation:self.animations[0] forKey:animationKey];
    [self.animations removeObjectAtIndex: 0];
    if(anim.finishCallBack)
    {
        anim.finishCallBack();
    }
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
