//
//  CASpringAnimation+XYZ.h
//  XYZAnimation
//
//  Created by Leo on 16/4/1.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CASpringAnimation(XYZ)
- (CASpringAnimation *(^)(CGFloat))withMass;
- (CASpringAnimation *(^)(CGFloat))withStiffness;
- (CASpringAnimation *(^)(CGFloat))withDamping;
- (CASpringAnimation *(^)(CGFloat))withInitialVelocity;

@end
