//
//  CABasicAnimation+XYZ.h
//  XYZAnimation
//
//  Created by Leo on 16/4/1.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CABasicAnimation(XYZ)
- (CABasicAnimation *(^)(NSValue *))from;
- (CABasicAnimation *(^)(NSValue *))to;
- (CABasicAnimation *(^)(NSValue *))by;
@end
