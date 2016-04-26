//
//  CAAnimation+XYZAnimation.h
//  XYZAnimation
//
//  Created by Leo on 16/4/1.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^XYZCAAnimationStateBlock)();

@interface CAAnimation(XYZAnimation)

@property (nonatomic, copy) XYZCAAnimationStateBlock startCallBack;
@property (nonatomic, copy) XYZCAAnimationStateBlock finishCallBack;
@property (nonatomic, assign) BOOL isInGroup;

- (CAAnimation *(^)(CFTimeInterval))    beginAtTime;
- (CAAnimation *(^)(CFTimeInterval))    inDuration;
- (CAAnimation *(^)(float))             withSpeed;
- (CAAnimation *(^)(CFTimeInterval))    withTimeOffset;
- (CAAnimation *(^)(float))             andRepeatCount;
- (CAAnimation *(^)(CFTimeInterval))    andRepeatDuration;
- (CAAnimation *(^)(BOOL))              withAutoreverses;
- (CAAnimation *(^)(NSString *))        withFillMode;
- (CAAnimation *(^)(id))                withDelegate;
- (CAAnimation *(^)(BOOL))              andRemoveOnCompletion;
- (CAAnimation *(^)(XYZCAAnimationStateBlock))withFinishCallBack;
- (CAAnimation *(^)(XYZCAAnimationStateBlock))withStartCallBack;
@end
