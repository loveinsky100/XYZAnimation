//
//  XYZAnimation.m
//  XYZAnimation
//
//  Created by Leo on 16/3/31.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "XYZAnimation.h"

@implementation XYZAnimation

+ (instancetype)animationWithType:(XYZAnimationType)animationType
{
    XYZAnimation *animation = [[XYZAnimation alloc] init];
    animation.keyPath = [self cp_keyPathWithType:animationType];
    return animation;
}

+ (NSString *)cp_keyPathWithType:(XYZAnimationType)animationType
{
    switch(animationType)
    {
        case XYZAnimationPosition:
            return @"position";
            break;
        case XYZAnimationStrokeEnd:
            return @"strokeEnd";
            break;
        case XYZAnimationStrokeStart:
            return @"strokeStart";
            break;
        case XYZAnimationStrokeLineWidth:
            return @"lineWidth";
            break;
    }
}

/**
 *  生成CAAnimation
 *
 *  @return
 */
- (CAAnimation *)animation
{
    if(self.group || [self.group isKindOfClass: [NSArray class]])
    {
        CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
        if(!self.backToFirstState)
        {
            group.fillMode = kCAFillModeForwards;
            group.removedOnCompletion = NO;
        }
        
        NSMutableArray *animationArray = [NSMutableArray array];
        for(XYZAnimation *model in self.group)
        {
            [animationArray addObject: model.animation];
        }
        
        group.animations = animationArray;
        group.delegate = self.delegate;
        group.duration = [self p_maxDurationInAnimationGroup: group];
        return group;
    }
    else
    {
        CAAnimation *anim;
        if(self.path != NULL)
        {
            anim = [CAKeyframeAnimation animationWithKeyPath:self.keyPath];
            ((CAKeyframeAnimation *)anim).path = self.path;
        }
        else
        {
            anim = [CABasicAnimation animationWithKeyPath: self.keyPath];
            ((CABasicAnimation *)anim).fromValue = self.fromValue;
            ((CABasicAnimation *)anim).toValue   = self.toValue;
        }
        
        anim.duration  = self.duration;
        if(!self.backToFirstState)
        {
            anim.fillMode = kCAFillModeForwards;
            anim.removedOnCompletion = NO;
        }
        
        anim.delegate = self.delegate;
        return anim;
    }
}

/**
 *  获取CAAnimationGroup中最长的执行时间
 *
 *  @param animationGroup
 *
 *  @return
 */
- (CGFloat)p_maxDurationInAnimationGroup:(CAAnimationGroup *)animationGroup
{
    NSArray<CAAnimation *> *animations = animationGroup.animations;
    if(animations.count == 0)
    {
        return 0;
    }
    
    CGFloat maxDuration = 0;
    for(CAAnimation *animation in animations)
    {
        if([animation isKindOfClass: [CAAnimationGroup class]])
        {
            maxDuration = MAX([self p_maxDurationInAnimationGroup: (CAAnimationGroup *)animation], maxDuration);
        }
        else
        {
            maxDuration = MAX(animation.duration, maxDuration);
        }
    }
    
    return maxDuration;
}
@end
