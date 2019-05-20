//
//  MZScrollViewController.h
//  MyScroll
//
//  Created by gunmm on 2019/5/19.
//  Copyright © 2019 gunmm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+MZMorePan.h"

NS_ASSUME_NONNULL_BEGIN

@interface MZScrollViewController : UIViewController

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;


+ (instancetype)instantiateViewController;

- (void)setViewControllers:(NSArray <UIViewController *> *)viewControllers
          scrollViewBlocks:(NSArray <InnerScrollViewForCurrentPage> *)scrollViews
             sectionTitles:(NSArray <NSString *> *)sectionTitles
             selectedIndex:(NSInteger)selectedIndex;

@end

NS_ASSUME_NONNULL_END
