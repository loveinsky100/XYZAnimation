//
//  XYZAnimationMaker.h
//  XYZAnimation
//
//  Created by Leo on 16/3/31.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYZAnimation;
@interface XYZAnimationMaker : NSObject

@property (nonatomic, strong, readonly) NSMutableArray<CAAnimation *> *animations;

- (instancetype)initWithLayer:(CALayer *)layer;

- (CAAnimation *(^)(CAAnimation *))addAnimation;

- (CAAnimationGroup *)startGroup;
- (void (^)())endGroup;

- (CABasicAnimation *)basicAnimation;
- (CAKeyframeAnimation *)keyframeAnimation;
@end
