# XYZAnimation
Start CAAnimation with Chain programming!

If you want to use CAAnimation to create an Sequential Animation, you may write code like this:

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 2;
    animation.fillMode = kCAFillModeForwards;
    animation.autoreverses = NO;
    animation.removedOnCompletion = NO;
    animation.delegate = self;

    CGPoint fromPoint = cirleLayer.frame.origin;
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:fromPoint];
    CGPoint toPoint = CGPointMake(30, 360);
    [movePath addQuadCurveToPoint:toPoint
                     controlPoint:CGPointMake(300,0)];
    [cirleLayer makeCAAnimation:^(XYZAnimationMaker *maker) {
        maker.addAnimation(animation)
             .withFinishCallBack(^(){ NSLog(@"strokeEnd finish"); });
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
``
![image](http://c.hiphotos.baidu.com/image/pic/item/55e736d12f2eb938793dd54dd2628535e5dd6f39.jpg)