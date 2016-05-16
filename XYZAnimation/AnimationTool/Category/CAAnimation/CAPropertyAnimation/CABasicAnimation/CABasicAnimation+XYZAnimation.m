//
//  CABasicAnimation+XYZAnimation.m
//  XYZAnimation
//
//  Created by Leo on 16/4/1.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "CABasicAnimation+XYZAnimation.h"

@implementation CABasicAnimation(XYZAnimation)
- (CABasicAnimation *(^)(id))from
{
    return ^(id value){
        self.fromValue = value;
        return self;
    };
}

- (CABasicAnimation *(^)(id))to
{
    return ^(id value){
        self.toValue = value;
        return self;
    };
}

- (CABasicAnimation *(^)(NSValue *))by
{
    return ^(NSValue *value){
        self.byValue = value;
        return self;
    };
}
@end
