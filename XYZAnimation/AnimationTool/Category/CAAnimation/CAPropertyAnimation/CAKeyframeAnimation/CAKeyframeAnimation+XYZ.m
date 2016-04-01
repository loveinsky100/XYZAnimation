//
//  CAKeyframeAnimation+XYZ.m
//  XYZAnimation
//
//  Created by Leo on 16/4/1.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "CAKeyframeAnimation+XYZ.h"

@implementation CAKeyframeAnimation(XYZ)
- (CAKeyframeAnimation *(^)(NSArray *))withValues
{
    return ^(NSArray *values){
        self.values = values;
        return self;
    };
}

- (CAKeyframeAnimation *(^)(CGPathRef))withPath
{
    return ^(CGPathRef path){
        self.path = path;
        return self;
    };
}

- (CAKeyframeAnimation *(^)(NSArray<NSNumber *> *))withKeyTimes
{
    return ^(NSArray<NSNumber *> *keyTimes){
        self.keyTimes = keyTimes;
        return self;
    };
}

- (CAKeyframeAnimation *(^)(NSArray<CAMediaTimingFunction *> *))withTimingFunctions
{
    return ^(NSArray<CAMediaTimingFunction *> *timingFunctions){
        self.timingFunctions = timingFunctions;
        return self;
    };
}

- (CAKeyframeAnimation *(^)(NSString *))withCalculationMode
{
    return ^(NSString *calculationMode){
        self.calculationMode = calculationMode;
        return self;
    };
}

- (CAKeyframeAnimation *(^)(NSArray<NSNumber *> *))withTensionValues
{
    return ^(NSArray<NSNumber *> *tensionValues){
        self.tensionValues = tensionValues;
        return self;
    };
}

- (CAKeyframeAnimation *(^)(NSArray<NSNumber *> *))withContinuityValues
{
    return ^(NSArray<NSNumber *> *continuityValues){
        self.continuityValues = continuityValues;
        return self;
    };
}

- (CAKeyframeAnimation *(^)(NSArray<NSNumber *> *))withBiasValues
{
    return ^(NSArray<NSNumber *> *biasValues){
        self.biasValues = biasValues;
        return self;
    };
}

- (CAKeyframeAnimation *(^)(NSString *))withRotationMode
{
    return ^(NSString *rotationMode){
        self.rotationMode = rotationMode;
        return self;
    };
}
@end
