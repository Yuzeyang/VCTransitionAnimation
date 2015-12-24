//
//  VCTransitionAnimation.m
//  VCTransitionAnimation
//
//  Created by 宫城 on 15/11/2.
//  Copyright © 2015年 宫城. All rights reserved.
//

#import "VCTransitionAnimation.h"
#import "ViewController.h"
#import "SecondViewController.h"

@interface VCTransitionAnimation ()

@property (nonatomic, strong) id<UIViewControllerContextTransitioning> transitionCtx;

@end

@implementation VCTransitionAnimation

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.7f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    self.transitionCtx = transitionContext;
    
    ViewController *fromVC = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    SecondViewController *toVC = (SecondViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIButton *btn = fromVC.btn;
    
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:btn.frame];
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];
    
    CGFloat radius;
    if (btn.frame.origin.x > toVC.view.frame.size.width/2) {
        if (CGRectGetMaxY(btn.frame) < toVC.view.frame.size.height / 2) { //第一象限
            radius = sqrt(btn.center.x * btn.center.x + (CGRectGetHeight(toVC.view.frame) - btn.center.y) * (CGRectGetHeight(toVC.view.frame) - btn.center.y));
        }else { //第四象限
            radius = sqrt(btn.center.x * btn.center.x + btn.center.y * btn.center.y);
        }
    }else {
        if (CGRectGetMaxY(btn.frame) < toVC.view.frame.size.height / 2) { //第二象限
            radius = sqrt((CGRectGetWidth(toVC.view.frame) - btn.center.x) * (CGRectGetWidth(toVC.view.frame) - btn.center.x) + (CGRectGetHeight(toVC.view.frame) - btn.center.y) * (CGRectGetHeight(toVC.view.frame) - btn.center.y));
        }else { //第三象限
            radius = sqrt((CGRectGetWidth(toVC.view.frame) - btn.center.x) * (CGRectGetWidth(toVC.view.frame) - btn.center.x) + btn.center.y * btn.center.y);
        }
    }
    
    UIBezierPath *finalPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(btn.frame, -radius, -radius)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = finalPath.CGPath;
    toVC.view.layer.mask = shapeLayer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue = (__bridge id)startPath.CGPath;
    animation.toValue = (__bridge id)finalPath.CGPath;
    animation.duration = [self transitionDuration:transitionContext];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.delegate = self;
    
    [shapeLayer addAnimation:animation forKey:@"transitionAnimation"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.transitionCtx completeTransition:![self.transitionCtx transitionWasCancelled]];
    [self.transitionCtx viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    [self.transitionCtx viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
}

@end
