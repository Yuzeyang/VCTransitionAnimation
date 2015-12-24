//
//  SecondViewController.m
//  VCTransitionAnimation
//
//  Created by 宫城 on 15/11/3.
//  Copyright © 2015年 宫城. All rights reserved.
//

#import "SecondViewController.h"
#import "VCVertTransitionAnimation.h"

#define kBtnWidth  30

@interface SecondViewController ()<UINavigationControllerDelegate>

@end

@implementation SecondViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    self.navigationController.delegate = self;
    
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btn setFrame:CGRectMake(20 , 20, kBtnWidth, kBtnWidth)];
    _btn.layer.cornerRadius = kBtnWidth/2;
    _btn.backgroundColor = [UIColor blackColor];
    [_btn addTarget:self action:@selector(backToLastVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPop) {
        VCVertTransitionAnimation *vertTrans = [VCVertTransitionAnimation new];
        return vertTrans;
    }else {
        return nil;
    }
}

- (void)backToLastVC {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
