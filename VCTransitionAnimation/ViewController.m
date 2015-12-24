//
//  ViewController.m
//  VCTransitionAnimation
//
//  Created by 宫城 on 15/11/2.
//  Copyright © 2015年 宫城. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "VCTransitionAnimation.h"

#define kBtnWidth  30

@interface ViewController ()<UINavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.delegate  = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btn setFrame:CGRectMake(CGRectGetWidth(self.view.frame) - 20 -kBtnWidth, 20, kBtnWidth, kBtnWidth)];
    _btn.layer.cornerRadius = kBtnWidth/2;
    _btn.backgroundColor = [UIColor blackColor];
    [_btn addTarget:self action:@selector(gotoNextVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)gotoNextVC {
    SecondViewController *sec = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:sec animated:YES];
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    if (operation == UINavigationControllerOperationPush) {
        
        VCTransitionAnimation *transAni = [VCTransitionAnimation new];
        return transAni;
    }else{
        return nil;
    }
}

@end
