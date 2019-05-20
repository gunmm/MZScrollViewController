//
//  UIScrollView+MZMorePan.h
//  MyScroll
//
//  Created by gunmm on 2019/5/19.
//  Copyright © 2019 gunmm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef UIScrollView *_Nullable(^InnerScrollViewForCurrentPage)(void);

@interface UIScrollView (MZMorePan)

- (void)setViewControllers:(NSArray <UIViewController *> *)viewControllers scrollViewBlocks:(NSArray <InnerScrollViewForCurrentPage> *)scrollViews selectedIndex:(NSInteger)selectedIndex;

- (void)setSelectedIndex:(NSInteger)selectedIndex;

@end

NS_ASSUME_NONNULL_END
