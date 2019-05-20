//
//  MZPageViewController.m
//  MyScroll
//
//  Created by gunmm on 2019/5/19.
//  Copyright © 2019 gunmm. All rights reserved.
//

#import "MZPageViewController.h"

@interface MZPageViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic, copy) NSArray *myViewControllers;
@property (nonatomic, assign) NSUInteger index;


@property (nonatomic, copy) PageDidChanged pageDidChanged;

@end

@implementation MZPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    self.dataSource = self;
}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers index:(NSUInteger)index pageDidChanged:(PageDidChanged)pageDidChanged {
    self.pageDidChanged = pageDidChanged;
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


- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers direction:(UIPageViewControllerNavigationDirection)direction animated:(BOOL)animated completion:(void (^)(BOOL))completion {
    
    UIViewController *controller = viewControllers.firstObject;
    if (!controller) {
        return;
    }
    NSUInteger index = [self.myViewControllers indexOfObject:viewControllers.firstObject];
    if (index == NSNotFound) {
        return;
    }
    if (index == self.index) {
        return;
    }
    self.index = index;
    
    [super setViewControllers:viewControllers direction:direction animated:NO completion:^(BOOL finished) {
       
    }];
}


#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self.myViewControllers indexOfObject:viewController];
    if (index > 0) {
        return [self.myViewControllers objectAtIndex:index - 1];
    } else {
        return nil;
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self.myViewControllers indexOfObject:viewController];
    
    if (index < (self.myViewControllers.count - 1)) {
        return [self.myViewControllers objectAtIndex:index + 1];
    } else {
        return nil;
    }
}

#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    UIViewController *controller = self.viewControllers.firstObject;
    if (!controller) {
        return;
    }
    NSUInteger index = [self.myViewControllers indexOfObject:self.viewControllers.firstObject];
    if (index == NSNotFound || index == self.index) {
        return;
    }
    self.index = index;
    if (finished && completed) {
        if (self.pageDidChanged) {
            self.pageDidChanged(pageViewController, [self.myViewControllers objectAtIndex:self.index], self.index);
        }
    }
}

@end
