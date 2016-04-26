//
//  CAAnimationGroup+XYZAnimation.h
//  XYZAnimation
//
//  Created by Leo on 16/4/1.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CAAnimationGroup(XYZAnimation)
- (void)addAnimation:(CAAnimation *)animation;
- (void)joinAnimationIntoGroup;
- (CAAnimationGroup *(^)(NSArray<CAAnimation *> *))withAnimations;
@end
