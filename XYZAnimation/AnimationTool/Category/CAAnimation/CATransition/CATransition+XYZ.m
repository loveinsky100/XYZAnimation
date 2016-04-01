//
//  CATransition+XYZ.m
//  XYZAnimation
//
//  Created by Leo on 16/4/1.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "CATransition+XYZ.h"

@implementation CATransition(XYZ)
- (CATransition *(^)(NSString *))withType
{
    return ^(NSString *type){
        self.type = type;
        return self;
    };
}

- (CATransition *(^)(NSString *))withSubtype
{
    return ^(NSString *subtype){
        self.subtype = subtype;
        return self;
    };
}

- (CATransition *(^)(float))withStartProgress
{
    return ^(float startProgress){
        self.startProgress = startProgress;
        return self;
    };
}

- (CATransition *(^)(float))withEndProgress
{
    return ^(float endProgress){
        self.endProgress = endProgress;
        return self;
    };
}

- (CATransition *(^)(id))withFilter
{
    return ^(id filter){
        self.filter = filter;
        return self;
    };
}
@end
