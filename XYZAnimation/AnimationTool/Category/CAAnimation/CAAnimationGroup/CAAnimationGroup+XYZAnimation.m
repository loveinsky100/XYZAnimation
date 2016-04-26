//
//  CAAnimationGroup+XYZAnimation.m
//  XYZAnimation
//
//  Created by Leo on 16/4/1.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "CAAnimationGroup+XYZAnimation.h"
#import "objc/runtime.h"

static void *CAAnimationGroupArray = "kCAAnimationGroupArray";

@implementation CAAnimationGroup(XYZAnimation)
- (CAAnimationGroup *(^)(NSArray<CAAnimation *> *))withAnimations
{
    return ^(NSArray<CAAnimation *> *animations){
        self.animations = animations;
        return self;
    };
}

- (void)addAnimation:(CAAnimation *)animation
{
    if(!self.animationGroupArray)
    {
        self.animationGroupArray = [NSMutableArray array];
    }
    
    [self.animationGroupArray addObject: animation];
}

- (void)joinAnimationIntoGroup
{
    self.withAnimations(self.animationGroupArray);
}

- (NSMutableArray *)animationGroupArray
{
    return objc_getAssociatedObject(self, CAAnimationGroupArray);
}

- (void)setAnimationGroupArray:(NSMutableArray *)animationGroupArray
{
    objc_setAssociatedObject(self, CAAnimationGroupArray, animationGroupArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
