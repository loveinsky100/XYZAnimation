//
//  CAKeyframeAnimation+XYZAnimation.h
//  XYZAnimation
//
//  Created by Leo on 16/4/1.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CAKeyframeAnimation(XYZAnimation)
- (CAKeyframeAnimation *(^)(NSArray *))withValues;
- (CAKeyframeAnimation *(^)(CGPathRef))withPath;
- (CAKeyframeAnimation *(^)(NSArray<NSNumber *> *))withKeyTimes;
- (CAKeyframeAnimation *(^)(NSArray<CAMediaTimingFunction *> *))withTimingFunctions;
- (CAKeyframeAnimation *(^)(NSString *))withCalculationMode;
- (CAKeyframeAnimation *(^)(NSArray<NSNumber *> *))withTensionValues;
- (CAKeyframeAnimation *(^)(NSArray<NSNumber *> *))withContinuityValues;
- (CAKeyframeAnimation *(^)(NSArray<NSNumber *> *))withBiasValues;
- (CAKeyframeAnimation *(^)(NSString *))withRotationMode;
@end
