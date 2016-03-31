//
//  CALayer+XYZ.h
//  XYZAnimation
//
//  Created by Leo on 16/3/31.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XYZAnimationMaker.h"
#import "AnimationTool.h"
#import "XYZAnimation.h"

@interface CALayer(XYZ)
- (void)makeCAAnimation:(void (^)(XYZAnimationMaker *maker))makerBlock;
@end