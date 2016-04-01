//
//  CAPropertyAnimation+XYZ.h
//  XYZAnimation
//
//  Created by Leo on 16/4/1.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CAPropertyAnimation(XYZ)
- (CAPropertyAnimation * (^)(NSString *))   withKeyPath;
- (CAPropertyAnimation * (^)(BOOL))         andAdditive;
- (CAPropertyAnimation * (^)(BOOL))         andCumulative;
- (CAPropertyAnimation * (^)(CAValueFunction *))withValueFunction;
@end
