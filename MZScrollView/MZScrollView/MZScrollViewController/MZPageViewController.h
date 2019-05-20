//
//  MZPageViewController.h
//  MyScroll
//
//  Created by gunmm on 2019/5/19.
//  Copyright © 2019 gunmm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PageDidChanged)(UIPageViewController * _Nullable pageViewController, UIViewController *  _Nullable viewController, NSUInteger index);

NS_ASSUME_NONNULL_BEGIN

@interface MZPageViewController : UIPageViewController

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers index:(NSUInteger)index pageDidChanged:(PageDidChanged)pageDidChanged;


@end

NS_ASSUME_NONNULL_END
