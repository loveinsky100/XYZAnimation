//
//  XYZAnimation.h
//  XYZAnimation
//
//  Created by Leo on 16/3/31.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XYZAnimationType)
{
    XYZAnimationPosition = 0,
    XYZAnimationStrokeEnd,
    XYZAnimationStrokeStart,
    XYZAnimationStrokeLineWidth
};

@class XYZAnimationMaker;
@interface XYZAnimation : NSObject

@property (nonatomic, weak)     XYZAnimationMaker *maker;
@property (nonatomic, weak)     NSObject *delegate;
@property (nonatomic, weak)     XYZAnimation *animationGroup;
@property (nonatomic, strong)   NSMutableArray<XYZAnimation *> *group;

- (XYZAnimation * (^)(CGPathRef path))withPath;
- (XYZAnimation * (^)(NSValue *fromValue))from;
- (XYZAnimation * (^)(NSValue *toValue))to;
- (XYZAnimation * (^)(CGFloat duration))inDuration;

- (XYZAnimationMaker *)with;
- (XYZAnimationMaker *)then;

+ (instancetype)animationWithType:(XYZAnimationType)animationType;
- (CAAnimation *)animation;
@end
