# VCTransitionAnimation

## Introduction
This animation is imitate fisrt ViewController push to second ViewController,and pop to first ViewController

## How to use

first you should follow the `UINavigationControllerDelegate`  in your transition view  controller

and implementation the delegate

```objective-c
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0);
```

in the from view controller, you just need judge the opration wether is push or not, and then  new a  `VCTransitionAnimation`, and return it

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
in the to view controller,  you just need judge the opration wether is pop or not, and then  new a  `VCTransitionAnimation`, and return it

```objective-c
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPop) {
        VCVertTransitionAnimation *vertTrans = [VCVertTransitionAnimation new];
        return vertTrans;
    }else {
        return nil;
    }
}
```

## Gif

![](https://github.com/Yuzeyang/VCTransitionAnimation/raw/master/VCTransitionAnimation.gif)
