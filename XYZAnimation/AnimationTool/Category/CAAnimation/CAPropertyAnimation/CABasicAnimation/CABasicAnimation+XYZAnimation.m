//
//  CABasicAnimation+XYZAnimation.m
//  XYZAnimation
//
//  Created by Leo on 16/4/1.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "CABasicAnimation+XYZAnimation.h"

@implementation CABasicAnimation(XYZAnimation)
- (CABasicAnimation *(^)(NSValue *))from
{
    return ^(NSValue *value){
        self.fromValue = value;
        return self;
    };
}

- (CABasicAnimation *(^)(NSValue *))to
{
    return ^(NSValue *value){
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