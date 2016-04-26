//
//  CASpringAnimation+XYZAnimation.m
//  XYZAnimation
//
//  Created by Leo on 16/4/1.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "CASpringAnimation+XYZAnimation.h"

@implementation CASpringAnimation(XYZAnimation)

- (CASpringAnimation *(^)(CGFloat))withMass
{
    return ^(CGFloat mass){
        self.mass = mass;
        return self;
    };
}

- (CASpringAnimation *(^)(CGFloat))withStiffness
{
    return ^(CGFloat stiffness){
        self.stiffness = stiffness;
        return self;
    };
}

- (CASpringAnimation *(^)(CGFloat))withDamping
{
    return ^(CGFloat damping){
        self.damping = damping;
        return self;
    };
}

- (CASpringAnimation *(^)(CGFloat))withInitialVelocity
{
    return ^(CGFloat initialVelocity){
        self.initialVelocity = initialVelocity;
        return self;
    };
}

@end
