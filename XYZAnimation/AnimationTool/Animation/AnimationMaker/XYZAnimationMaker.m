//
//  XYZAnimationMaker.m
//  XYZAnimation
//
//  Created by Leo on 16/3/31.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "XYZAnimationMaker.h"
#import "CAAnimation+XYZ.h"
#import "CAAnimationGroup+XYZ.h"
#import "CABasicAnimation+XYZ.h"
#import "CAKeyframeAnimation+XYZ.h"
#import "CAPropertyAnimation+XYZ.h"
#import "CASpringAnimation+XYZ.h"
#import "CATransition+XYZ.h"

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
    if(self.groups && self.groups.count)
    {
        CAAnimationGroup *group = self.groups.lastObject;
        [group addAnimation: animation];
    }
    else
    {
        animation.delegate = self.delegate;
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
