# VCTransitionAnimation

## Introduction
This animation is imitate fisrt ViewController push to second ViewController,and pop to first ViewController

## How to use
```object-c
- (void)gotoNextVC {
    SecondViewController *sec = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:sec animated:YES];
}
```
This is first ViewController's button action,it's push to second ViewController

```object-c
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {

        VCTransitionAnimation *transAni = [VCTransitionAnimation new];
        return transAni;
    }else{
        return nil;
    }
}
```
you should use VCTransitionAnimation in navigationController:animationControllerForOperation:fromViewController:toViewController at first ViewController,second ViewController the same

## Gif
![](https://github.com/Yuzeyang/VCTransitionAnimation/raw/master/VCTransitionAnimation.gif)
