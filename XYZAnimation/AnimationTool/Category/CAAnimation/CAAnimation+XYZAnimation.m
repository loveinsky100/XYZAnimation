//
//  CAAnimation+XYZAnimation.m
//  XYZAnimation
//
//  Created by Leo on 16/4/1.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "CAAnimation+XYZAnimation.h"
#import "objc/runtime.h"

static void *CAAnimationFinishCallBackKey   = "kCAAnimationFinishCallBackKey";
static void *CAAnimationStartCallBackKey    = "kCAAnimationStartCallBackKey";
static void *CAAnimationIsInGroupKey        = "kCAAnimationIsInGroupKey";

@implementation CAAnimation(XYZAnimation)
- (CAAnimation *(^)(CFTimeInterval))beginAtTime
{
    return ^(CFTimeInterval time){
        self.beginTime = time;
        return self;
    };
}

- (CAAnimation *(^)(CFTimeInterval))inDuration
{
    return ^(CFTimeInterval time){
        self.duration = time;
        return self;
    };
}

- (CAAnimation *(^)(float))withSpeed
{
    return ^(float speed){
        self.speed = speed;
        return self;
    };
}

- (CAAnimation *(^)(CFTimeInterval))withTimeOffset
{
    return ^(CFTimeInterval time){
        self.timeOffset = time;
        return self;
    };
}

- (CAAnimation *(^)(float))andRepeatCount
{
    return ^(float count){
        self.repeatCount = count;
        return self;
    };
}

- (CAAnimation *(^)(CFTimeInterval))andRepeatDuration
{
    return ^(CFTimeInterval time){
        self.repeatDuration = time;
        return self;
    };
}

- (CAAnimation *(^)(BOOL))withAutoreverses
{
    return ^(BOOL autoreverses){
        self.autoreverses = autoreverses;
        return self;
    };
}

- (CAAnimation *(^)(NSString *))withFillMode
{
    return ^(NSString *fillMode){
        self.fillMode = fillMode;
        return self;
    };
}

- (CAAnimation *(^)(id))withDelegate
{
    return ^(id delegate){
        self.delegate = delegate;
        return self;
    };
}

- (CAAnimation *(^)(BOOL))andRemoveOnCompletion
{
    return ^(BOOL removedOnCompletion){
        self.removedOnCompletion = removedOnCompletion;
        return self;
    };
}

- (CAAnimation *(^)(XYZCAAnimationStateBlock))withFinishCallBack
{
    return ^(XYZCAAnimationStateBlock finishCallBack){
        self.finishCallBack = finishCallBack;
        [self changeXYZAnimationCopy];
        return self;
    };
}

- (CAAnimation *(^)(XYZCAAnimationStateBlock))withStartCallBack
{
    return ^(XYZCAAnimationStateBlock startCallBack){
        self.startCallBack = startCallBack;
        [self changeXYZAnimationCopy];
        return self;
    };
}

- (void)changeXYZAnimationCopy
{
    static dispatch_once_t xyzDispatchT;
    dispatch_once(&xyzDispatchT, ^{
        Method realCopy = class_getInstanceMethod([self class], @selector(copyWithZone:));
        Method xyzCopy = class_getInstanceMethod([self class], @selector(copyWithZoneAddition:));
        method_exchangeImplementations(realCopy, xyzCopy);
    });
}

- (XYZCAAnimationStateBlock)finishCallBack
{
    return objc_getAssociatedObject(self, CAAnimationFinishCallBackKey);
}

- (void)setFinishCallBack:(XYZCAAnimationStateBlock)finishCallBack
{
    objc_setAssociatedObject(self, CAAnimationFinishCallBackKey, finishCallBack, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (XYZCAAnimationStateBlock)startCallBack
{
    return objc_getAssociatedObject(self, CAAnimationStartCallBackKey);
}

- (void)setStartCallBack:(XYZCAAnimationStateBlock)startCallBack
{
    objc_setAssociatedObject(self, CAAnimationStartCallBackKey, startCallBack, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setIsInGroup:(BOOL)isInGroup
{
    objc_setAssociatedObject(self, CAAnimationIsInGroupKey, @(isInGroup), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isInGroup
{
    NSNumber *isInGroup = objc_getAssociatedObject(self, CAAnimationIsInGroupKey);
    return [isInGroup boolValue];
}

- (id)copyWithZoneAddition:(NSZone *)zone
{
    CAAnimation *animation = [self copyWithZoneAddition: zone];
    animation.finishCallBack = self.finishCallBack;
    animation.isInGroup = self.isInGroup;
    return animation;
}

@end
