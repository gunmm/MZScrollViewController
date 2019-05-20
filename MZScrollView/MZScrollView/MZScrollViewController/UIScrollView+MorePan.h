//
//  UIScrollView+MorePan.h
//  MyScroll
//
//  Created by gunmm on 2019/5/19.
//  Copyright © 2019 gunmm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef UIScrollView *(^InnerScrollViewForCurrentPage)(UIPageViewController *pageViewController, UIViewController *viewController);

@interface UIScrollView (MorePan)

- (void)setPageViewController:(UIPageViewController *)pageViewController viewControllers:(NSArray <UIViewController *> *)viewControllers scrollViewBlocks:(NSArray <InnerScrollViewForCurrentPage> *)scrollViews selectedIndex:(NSInteger)selectedIndex;


@end

NS_ASSUME_NONNULL_END
