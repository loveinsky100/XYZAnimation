//
//  CALayer+XYZAnimation.h
//  XYZAnimation
//
//  Created by Leo on 16/3/31.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XYZAnimationMaker.h"

@interface CALayer(XYZAnimation)
- (void)makeCAAnimation:(void (^)(XYZAnimationMaker *make))makerBlock;
@end
