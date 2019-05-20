//
//  MyPageViewController.h
//  MyScroll
//
//  Created by gunmm on 2019/5/19.
//  Copyright © 2019 gunmm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyPageViewController : UIPageViewController

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers index:(NSUInteger)index;


@end

NS_ASSUME_NONNULL_END
