//
//  XYZAnimationMaker.m
//  XYZAnimation
//
//  Created by Leo on 16/3/31.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "XYZAnimationMaker.h"
#import "CAAnimation+XYZAnimation.h"
#import "CAAnimationGroup+XYZAnimation.h"
#import "CABasicAnimation+XYZAnimation.h"
#import "CAKeyframeAnimation+XYZAnimation.h"
#import "CAPropertyAnimation+XYZAnimation.h"
#import "CASpringAnimation+XYZAnimation.h"
#import "CATransition+XYZAnimation.h"

@interface XYZAnimationMaker()
@property (nonatomic, weak) id delegate;
@property (nonatomic, strong) NSMutableArray<CAAnimation *> *animations;
@property (nonatomic, strong) NSMutableArray<CAAnimationGroup *> *groups;
@end

@implementation XYZAnimationMaker

- (instancetype)initWithLayer:(CALayer *)layer
{
    if(self = [super init])
    {
        self.delegate = layer;
    }
    
    return self;
}

- (void)addCAAnimation:(CAAnimation *)animation
{
    animation.delegate = self.delegate;
    if(self.groups && self.groups.count)
    {
        CAAnimationGroup *group = self.groups.lastObject;
        [group addAnimation: animation];
    }
    else
    {
        [self.animations addObject: animation];
    }
}

- (CAAnimationGroup *)startGroup
{
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.delegate = self.delegate;
    [self addCAAnimation: group];
    [self.groups addObject: group];
    return group;
}

- (void (^)())endGroup
{
    return ^(){
        if(self.groups && self.groups.count)
        {
            CAAnimationGroup *group = self.groups.lastObject;
            [group joinAnimationIntoGroup];
            [self.groups removeLastObject];
        }
    };
}

- (CAAnimation *(^)(CAAnimation *))addAnimation
{
    return ^(CAAnimation *animation){
        [self addCAAnimation: animation];
        return animation;
    };
}

- (CABasicAnimation *)basicAnimation
{
    CABasicAnimation *basicAnimation = [[CABasicAnimation alloc] init];
    [self addCAAnimation: basicAnimation];
    return basicAnimation;
}

- (CAKeyframeAnimation *)keyframeAnimation
{
    CAKeyframeAnimation *keyframeAnimation = [[CAKeyframeAnimation alloc] init];
    [self addCAAnimation: keyframeAnimation];
    return keyframeAnimation;
}

- (NSMutableArray<CAAnimation *> *)animations
{
    if(!_animations)
    {
        _animations = [[NSMutableArray alloc] init];
    }
    
    return _animations;
}

- (NSMutableArray<CAAnimationGroup *> *)groups
{
    if(!_groups)
    {
        _groups = [[NSMutableArray alloc] init];
    }
    
    return _groups;
}

@end
