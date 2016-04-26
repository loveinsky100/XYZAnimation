//
//  CAPropertyAnimation+XYZAnimation.m
//  XYZAnimation
//
//  Created by Leo on 16/4/1.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "CAPropertyAnimation+XYZAnimation.h"

@implementation CAPropertyAnimation(XYZAnimation)
- (CAPropertyAnimation * (^)(NSString *))withKeyPath
{
    return ^(NSString *keyPath){
        self.keyPath = keyPath;
        return self;
    };
}

- (CAPropertyAnimation * (^)(BOOL))andAdditive
{
    return ^(BOOL additive){
        self.additive = additive;
        return self;
    };
}

- (CAPropertyAnimation * (^)(BOOL))andCumulative
{
    return ^(BOOL cumulative){
        self.cumulative = cumulative;
        return self;
    };
}

- (CAPropertyAnimation * (^)(CAValueFunction *))withValueFunction
{
    return ^(CAValueFunction *valueFunction){
        self.valueFunction = valueFunction;
        return self;
    };
}

@end
