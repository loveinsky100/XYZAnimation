//
//  XYZAnimationMaker.m
//  XYZAnimation
//
//  Created by Leo on 16/3/31.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "XYZAnimationMaker.h"
#import "XYZAnimation.h"

@interface XYZAnimationMaker()
@property (nonatomic, strong) NSMutableArray<XYZAnimation *> *animations;
@end

@implementation XYZAnimationMaker

- (XYZAnimation *)p_animationWithType:(XYZAnimationType)animationType
{
    XYZAnimation *animation = [XYZAnimation animationWithType: animationType];
    animation.maker = self;
    animation.delegate = self.delegate;
    if(self.isAddLastGroup)
    {
        [self p_addAnimationInLastGroup: animation];
        self.isAddLastGroup = NO;
    }
    else
    {
        [self.animations addObject: animation];
    }
    
    return animation;
}

- (XYZAnimation *)p_creatAnimationGroup
{
    XYZAnimation *animation = [[XYZAnimation alloc] init];
    animation.group = [NSMutableArray array];
    animation.delegate = self.delegate;
    [self.animations addObject: animation];
    return animation;
}

- (void)p_addAnimationInLastGroup:(XYZAnimation *)animation
{
    XYZAnimation *anim = self.animations.lastObject;
    if(!anim)
    {
        XYZAnimation *group = [self p_creatAnimationGroup];
        [group.group addObject: animation];
        animation.animationGroup = group;
        
    }
    else if(anim.animationGroup)
    {
        [animation.animationGroup.group addObject: animation];
        anim.animationGroup = animation.animationGroup;
    }
    else if(!anim.animationGroup)
    {
        XYZAnimation *animationGroup = [[XYZAnimation alloc] init];
        animationGroup.delegate = self.delegate;
        animationGroup.group = [NSMutableArray array];
        [self.animations removeLastObject];
        [self.animations addObject: animationGroup];
        [animationGroup.group addObject: anim];
        [animationGroup.group addObject: animation];
        anim.animationGroup = animationGroup;
        animation.animationGroup = animationGroup;
    }
}

- (void)p_removeAnimation:(XYZAnimation *)animation
{
    [self.animations removeObject: animation];
}

- (XYZAnimation *)position
{
    return [self p_animationWithType: XYZAnimationPosition];
}

- (XYZAnimation *)strokeEnd
{
    return [self p_animationWithType: XYZAnimationStrokeEnd];
}

- (XYZAnimation *)strokeStart
{
   return [self p_animationWithType: XYZAnimationStrokeStart];
}

- (XYZAnimation *)lineWidth
{
    return [self p_animationWithType: XYZAnimationStrokeLineWidth];
}

- (NSMutableArray<XYZAnimation *> *)animations
{
    if(!_animations)
    {
        _animations = [[NSMutableArray alloc] init];
    }
    
    return _animations;
}

@end
