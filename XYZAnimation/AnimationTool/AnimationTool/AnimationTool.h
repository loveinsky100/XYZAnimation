//
//  AnimationTool.h
//  XYZAnimation
//
//  Created by Leo on 16/3/31.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class XYZAnimation;
@interface AnimationTool : NSObject
- (void)showAnimationWithLayer:(CALayer *)animationLayer
                 andAnimations:(NSArray<XYZAnimation *> *)animations;
@end
