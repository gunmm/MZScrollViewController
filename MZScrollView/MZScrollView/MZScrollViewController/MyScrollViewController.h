//
//  MyScrollViewController.h
//  MyScroll
//
//  Created by gunmm on 2019/5/19.
//  Copyright © 2019 gunmm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+MorePan.h"

NS_ASSUME_NONNULL_BEGIN



@interface MyScrollViewController : UIViewController

@property (nonatomic, strong) UIView *headerView;


+ (instancetype)instantiateViewController;

- (void)setViewControllers:(NSArray <UIViewController *> *)viewControllers scrollViewBlocks:(NSArray <InnerScrollViewForCurrentPage> *)scrollViews selectedIndex:(NSInteger)selectedIndex;




@end

NS_ASSUME_NONNULL_END
