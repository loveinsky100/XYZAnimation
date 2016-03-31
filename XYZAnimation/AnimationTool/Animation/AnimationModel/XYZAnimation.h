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

@interface XYZAnimation : NSObject
@property (nonatomic, copy)     NSString *keyPath;
@property (nonatomic, strong)   NSValue  *fromValue;
@property (nonatomic, strong)   NSValue  *toValue;
@property (nonatomic, assign)   BOOL     backToFirstState; // default is NO
@property (nonatomic, weak)     NSObject *delegate;
@property (nonatomic, assign)   CGFloat  duration;
@property (nonatomic, strong)   NSArray<XYZAnimation *> *group;
@property (nonatomic, assign)   CGPathRef path;

+ (instancetype)animationWithType:(XYZAnimationType)animationType;
- (CAAnimation *)animation;
@end
