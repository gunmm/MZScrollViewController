//
//  MyPageViewController.m
//  MyScroll
//
//  Created by gunmm on 2019/5/19.
//  Copyright © 2019 gunmm. All rights reserved.
//

#import "MyPageViewController.h"

@interface MyPageViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource>
@property (copy, nonatomic) NSArray *myViewControllers;

@end

@implementation MyPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    self.dataSource = self;
}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers index:(NSUInteger)index {
    if (viewControllers.count == 0) {
        return;
    }
    if (index >= viewControllers.count) {
        return;
    }
    self.myViewControllers = viewControllers;

    UIViewController *controller = [viewControllers objectAtIndex:index];
    
    
    [self setViewControllers:@[controller]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:NO
                  completion:^(BOOL finished) {
                      
                  }];
}







- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    //    if (_pageAnimationFinished == NO) {
    //        // we are still animating don't return a next view controller too soon
    //        return nil;
    //    }
    
    
    NSUInteger index = [self.myViewControllers indexOfObject:viewController];
    if (index > 0) {
        return [self.myViewControllers objectAtIndex:index - 1];
    } else {
        return nil;
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    //    if (_pageAnimationFinished == NO) {
    //        // we are still animating don't return a previous view controller too soon
    //        return nil;
    //    }
    
    NSUInteger index = [self.myViewControllers indexOfObject:viewController];
    
    if (index < (self.myViewControllers.count - 1)) {
        return [self.myViewControllers objectAtIndex:index + 1];
    } else {
        return nil;
    }
}


@end
