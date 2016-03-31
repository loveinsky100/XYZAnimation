//
//  XYZAnimationMaker.h
//  XYZAnimation
//
//  Created by Leo on 16/3/31.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XYZAnimation;
@interface XYZAnimationMaker : NSObject
@property (nonatomic, weak) id delegate;
@property (nonatomic, assign) BOOL isAddLastGroup;
@property (nonatomic, strong, readonly) NSMutableArray<XYZAnimation *> *animations;

- (XYZAnimation *)position;
- (XYZAnimation *)strokeEnd;
- (XYZAnimation *)strokeStart;
- (XYZAnimation *)lineWidth;
@end
