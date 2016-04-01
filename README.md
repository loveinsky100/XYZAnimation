# XYZAnimation
Start CAAnimation with Chain programming!

If you want to use CAAnimation to create an Sequential Animation,user CAAnimation you mayer write this code:

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

- (void)doAnimations:(CALayer *)animationLayer
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
...

    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"lineWidth"];
...

    CGPoint fromPoint = animationLayer.frame.origin;
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:fromPoint];
    CGPoint toPoint = CGPointMake(30, 360);
    [movePath addQuadCurveToPoint:toPoint
                     controlPoint:CGPointMake(300,0)];
                     
    CAKeyframeAnimation *animation3 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
...
    
    CABasicAnimation *animation4 = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    ...
    [animationLayer addAnimation:animation
                          forKey:@"positionAnimation"];

    [self.animcations removeAllObjects];
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    ...
    
    [self.animcations addObject: animationGroup];
    [self.animcations addObject: animation4];
}

But in my project:
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
