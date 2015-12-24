//
//  VCVertTransitionAnimation.m
//  VCTransitionAnimation
//
//  Created by 宫城 on 15/11/4.
//  Copyright © 2015年 宫城. All rights reserved.
//

#import "VCVertTransitionAnimation.h"
#import "SecondViewController.h"
#import "ViewController.h"

@interface VCVertTransitionAnimation ()

@property (nonatomic, strong) id<UIViewControllerContextTransitioning> transitionCtx;

@end

@implementation VCVertTransitionAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.7;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    self.transitionCtx = transitionContext;
    
    SecondViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIButton *btn = toVC.btn;
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:fromVC.view];
    
    CGFloat radius;
    if (btn.frame.origin.x > CGRectGetWidth(fromVC.view.frame)/2) {
        if (CGRectGetMaxY(btn.frame) < CGRectGetHeight(fromVC.view.frame)/2) {
            radius = sqrt(btn.center.x*btn.center.x + (CGRectGetHeight(fromVC.view.frame) - btn.center.y)*(CGRectGetHeight(fromVC.view.frame) - btn.center.y));
        }else {
            radius = sqrt(btn.center.x*btn.center.x + btn.center.y*btn.center.y);
        }
    }else {
        if (CGRectGetMaxY(btn.frame) < CGRectGetHeight(fromVC.view.frame)/2) {
            radius = sqrt((CGRectGetWidth(fromVC.view.frame) - btn.center.x)*(CGRectGetWidth(fromVC.view.frame) - btn.center.x) + (CGRectGetHeight(fromVC.view.frame) - btn.center.y)*(CGRectGetHeight(fromVC.view.frame) - btn.center.y));
        }else {
            radius = sqrt((CGRectGetWidth(fromVC.view.frame) - btn.center.x)*(CGRectGetWidth(fromVC.view.frame) - btn.center.x) + btn.center.y*btn.center.y);
        }
    }
    
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(btn.frame, -radius, -radius)];
    
    UIBezierPath *finalPath = [UIBezierPath bezierPathWithOvalInRect:btn.frame];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = finalPath.CGPath;
    fromVC.view.layer.mask = shapeLayer;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.delegate = self;
    animation.duration = [self transitionDuration:transitionContext];
    animation.fromValue = (__bridge id)startPath.CGPath;
    animation.toValue = (__bridge id)finalPath.CGPath;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [shapeLayer addAnimation:animation forKey:@"animation"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.transitionCtx completeTransition:![self.transitionCtx transitionWasCancelled]];
    [self.transitionCtx viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    [self.transitionCtx viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
}

@end
