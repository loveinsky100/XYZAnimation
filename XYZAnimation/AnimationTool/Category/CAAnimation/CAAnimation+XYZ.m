//
//  CAAnimation+XYZ.m
//  XYZAnimation
//
//  Created by Leo on 16/4/1.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "CAAnimation+XYZ.h"
#import "objc/runtime.h"

static void *CAAnimationFinishCallBackKey = "kCAAnimationFinishCallBackKey";

@implementation CAAnimation(XYZ)
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

- (CAAnimation *(^)(XYZCAAnimationFinishBlock))withFinishCallBack
{
    return ^(XYZCAAnimationFinishBlock finishCallBack){
        self.finishCallBack = finishCallBack;
        Method realCopy = class_getInstanceMethod([self class], @selector(copyWithZone:));
        Method xyzCopy = class_getInstanceMethod([self class], @selector(copyWithZoneAddition:));
        method_exchangeImplementations(realCopy, xyzCopy);
        return self;
    };
}

- (XYZCAAnimationFinishBlock)finishCallBack
{
    return objc_getAssociatedObject(self, CAAnimationFinishCallBackKey);
}

- (void)setFinishCallBack:(XYZCAAnimationFinishBlock)finishCallBack
{
    objc_setAssociatedObject(self, CAAnimationFinishCallBackKey, finishCallBack, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (id)copyWithZoneAddition:(NSZone *)zone
{
    CAAnimation *animation = [self copyWithZoneAddition: zone];
    animation.finishCallBack = self.finishCallBack;
    return animation;
}

@end
