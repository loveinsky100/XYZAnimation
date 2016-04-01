# XYZAnimation
Start CAAnimation with Chain programming!

If you want to use CAAnimation to create an Sequential Animation, you may write code like this:
![image](http://c.hiphotos.baidu.com/image/pic/item/55e736d12f2eb938793dd54dd2628535e5dd6f39.jpg)

```
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if(self.animcations.count == 0)
    {
        return;
    }
    
    NSInteger index = self.animations.count;
    NSString *animationKey = [NSString stringWithFormat: @"Animation%ld", index];
    [self.animationLayer addAnimation:self.animcations[0] forKey:animationKey];
    
    [self.animcations removeObjectAtIndex: 0];
}

- (void)p_doAnimations:(CALayer *)animationLayer
{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 2;
    animation.fillMode = kCAFillModeForwards;
    animation.autoreverses = NO;
    animation.removedOnCompletion = NO;
    animation.delegate = self;
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"lineWidth"];
    animation2.fromValue = @1;
    animation2.toValue = @10;
    animation2.duration = 2;
    animation2.fillMode = kCAFillModeForwards;
    animation2.autoreverses = NO;
    animation2.removedOnCompletion = NO;
//    animation2.delegate = self;

    CGPoint fromPoint = animationLayer.frame.origin;
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:fromPoint];
    CGPoint toPoint = CGPointMake(30, 360);
    [movePath addQuadCurveToPoint:toPoint
                     controlPoint:CGPointMake(300,0)];

    CAKeyframeAnimation *animation3 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation3.path = movePath.CGPath;
    animation3.duration = 3;
    animation3.fillMode = kCAFillModeForwards;
    animation3.autoreverses = NO;
    animation3.removedOnCompletion = NO;
    
    CABasicAnimation *animation4 = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    animation4.fromValue = @0;
    animation4.toValue = @1;
    animation4.duration = 2;
    animation4.fillMode = kCAFillModeForwards;
    animation4.removedOnCompletion = NO;
    animation4.delegate = self;
    
    [animationLayer addAnimation:animation
                          forKey:@"positionAnimation"];

    [self.animcations removeAllObjects];

    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = 3;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.removedOnCompletion = NO;
    animationGroup.autoreverses = NO;
    animationGroup.delegate = self;
    animationGroup.animations = @[animation2, animation3];
    
    [self.animcations addObject: animationGroup];
    [self.animcations addObject: animation4]; 
}
```

###But in my project:
    [cirleLayer makeCAAnimation:^(XYZAnimationMaker *maker) {
        maker.basicAnimation
             .from(@0)
             .to(@1)
             .withKeyPath(@"strokeEnd")
             .inDuration(2)
             .withAutoreverses(NO)
             .withFillMode(kCAFillModeForwards)
             .andRemoveOnCompletion(NO);
        maker.startGroup
             .inDuration(3)
             .withAutoreverses(NO)
             .withFillMode(kCAFillModeForwards)
             .andRemoveOnCompletion(NO);
        maker.basicAnimation
             .from(@0)
             .to(@10)
             .withKeyPath(@"lineWidth")
             .inDuration(2)
             .withAutoreverses(NO)
             .withFillMode(kCAFillModeForwards)
             .andRemoveOnCompletion(NO);
        maker.keyframeAnimation
             .withPath(movePath.CGPath)
             .withKeyPath(@"position")
             .inDuration(3)
             .withAutoreverses(NO)
             .withFillMode(kCAFillModeForwards)
             .andRemoveOnCompletion(NO);
        maker.endGroup();
        maker.basicAnimation
             .from(@0)
             .to(@1)
             .withKeyPath(@"strokeStart")
             .inDuration(2)
             .withAutoreverses(NO)
             .withFillMode(kCAFillModeForwards)
             .andRemoveOnCompletion(NO);
    }];