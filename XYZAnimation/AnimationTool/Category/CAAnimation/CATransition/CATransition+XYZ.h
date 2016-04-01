//
//  CATransition+XYZ.h
//  XYZAnimation
//
//  Created by Leo on 16/4/1.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CATransition(XYZ)
- (CATransition *(^)(NSString *))withType;
- (CATransition *(^)(NSString *))withSubtype;
- (CATransition *(^)(float))withStartProgress;
- (CATransition *(^)(float))withEndProgress;
- (CATransition *(^)(id))withFilter;
@end
