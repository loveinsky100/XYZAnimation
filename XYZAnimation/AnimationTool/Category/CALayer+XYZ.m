//
//  CALayer+XYZ.m
//  XYZAnimation
//
//  Created by Leo on 16/3/31.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "CALayer+XYZ.h"
#import "objc/runtime.h"

static void *AnimationToolKey = "kAnimationToolKey";

@implementation CALayer(XYZ)

- (void)makeCAAnimation:(void (^)(XYZAnimationMaker *))makerBlock
{
    if(!self.animationTool)
    {
        self.animationTool = [[AnimationTool alloc] init];
    }
    
    XYZAnimationMaker *maker = [[XYZAnimationMaker alloc] init];
    maker.delegate = self.animationTool;
    makerBlock(maker);
    [self.animationTool showAnimationWithLayer:self
                                 andAnimations:maker.animations];
}

- (AnimationTool *)animationTool
{
    return objc_getAssociatedObject(self, AnimationToolKey);
}

- (void)setAnimationTool:(AnimationTool *)animationTool
{
    objc_setAssociatedObject(self, AnimationToolKey, animationTool, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
