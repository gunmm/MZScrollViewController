//
//  UIScrollView+MorePan.m
//  MyScroll
//
//  Created by gunmm on 2019/5/19.
//  Copyright © 2019 gunmm. All rights reserved.
//

#import "UIScrollView+MorePan.h"
#import <objc/runtime.h>


typedef NS_ENUM(NSInteger, MoerScrollViewType) {
    MoerScrollViewTypeDefault,
    MoerScrollViewTypeInner,
    MoerScrollViewTypeOutter
};

static const char *scrollViewTypeKey = "scrollViewType";
static const char *currentIndexKey = "currentIndex";
static const char *enableScrollKey = "enableScroll";
static const char *scrollViewBlocksKey = "scrollViewBlocks";
static const char *viewControllersKey = "viewControllers";
static const char *outScrollViewKey = "outScrollView";
static const char *innerScrollViewKey = "innerScrollView";


@interface UIScrollView (MyScrollViewPrivate)

@property (nonatomic, assign) MoerScrollViewType scrollViewType;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) BOOL enableScroll;

@property (nonatomic, strong) NSArray<InnerScrollViewForCurrentPage> *scrollViewBlocks;
@property (nonatomic, strong) NSArray<UIViewController *> *viewControllers;

@property (nonatomic, weak) UIScrollView *outScrollView;
@property (nonatomic, weak) UIScrollView *innerScrollView;


@end

@implementation UIScrollView (MyScrollViewPrivate)

- (void)setScrollViewType:(MoerScrollViewType)scrollViewType {
    objc_setAssociatedObject(self, scrollViewTypeKey, @(scrollViewType), OBJC_ASSOCIATION_ASSIGN);
}

- (MoerScrollViewType)scrollViewType {
    return [(objc_getAssociatedObject(self, scrollViewTypeKey)) integerValue];
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    objc_setAssociatedObject(self, currentIndexKey, @(currentIndex), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)currentIndex {
    return [(objc_getAssociatedObject(self, currentIndexKey)) integerValue];
}

- (void)setEnableScroll:(BOOL)enableScroll {
    objc_setAssociatedObject(self, enableScrollKey, @(enableScroll), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)enableScroll {
    return [(objc_getAssociatedObject(self, enableScrollKey)) boolValue];
}

- (void)setScrollViewBlocks:(NSArray<InnerScrollViewForCurrentPage> *)scrollViewBlocks {
    objc_setAssociatedObject(self, scrollViewBlocksKey, scrollViewBlocks, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray<InnerScrollViewForCurrentPage> *)scrollViewBlocks {
    return objc_getAssociatedObject(self, scrollViewBlocksKey);
}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers {
    objc_setAssociatedObject(self, viewControllersKey, viewControllers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray<UIViewController *> *)viewControllers {
    return objc_getAssociatedObject(self, viewControllersKey);
}

- (void)setOutScrollView:(UIScrollView *)outScrollView {
    objc_setAssociatedObject(self, outScrollViewKey, outScrollView, OBJC_ASSOCIATION_ASSIGN);
}

- (UIScrollView *)outScrollView {
    return objc_getAssociatedObject(self, outScrollViewKey);
}

- (void)setInnerScrollView:(UIScrollView *)innerScrollView {
    objc_setAssociatedObject(self, innerScrollViewKey, innerScrollView, OBJC_ASSOCIATION_ASSIGN);
}

- (UIScrollView *)innerScrollView {
    return objc_getAssociatedObject(self, innerScrollViewKey);
}

@end



#pragma mark UIScrollView + MoerInnerScrollViewProxy && UITableView + MoerInnerScrollViewProxy

@interface UIScrollView (SetScroll)

@end

@implementation UIScrollView (SetScroll)

+ (void)load {
    SEL _Nonnull originalSel = @selector(setContentOffset:);
    SEL _Nonnull newSel = @selector(moerInnerScrollViewProxyScrollViewSetContentOffset:);

    Method originalMethod = class_getInstanceMethod(self, originalSel);
    Method newMethod = class_getInstanceMethod(self, newSel);
    if (!originalMethod || !newMethod) return;
    
    class_addMethod(self,
                    originalSel,
                    class_getMethodImplementation(self, originalSel),
                    method_getTypeEncoding(originalMethod));
    class_addMethod(self,
                    newSel,
                    class_getMethodImplementation(self, newSel),
                    method_getTypeEncoding(newMethod));
    
    method_exchangeImplementations(class_getInstanceMethod(self, originalSel),
                                   class_getInstanceMethod(self, newSel));
    
}


- (void)moerInnerScrollViewProxyScrollViewSetContentOffset:(CGPoint)contentOffset {
    
    [self moerInnerScrollViewProxyScrollViewSetContentOffset:contentOffset];
    

    if (self.scrollViewType == MoerScrollViewTypeOutter) {
        if (!self.enableScroll) {
            [self moerInnerScrollViewProxyScrollViewSetContentOffset:CGPointMake(0, 200)];

        } else {
            if (self.contentOffset.y >= 200) {
                self.enableScroll = NO;
                [self moerInnerScrollViewProxyScrollViewSetContentOffset:CGPointMake(0, 200)];
                self.innerScrollView.enableScroll = YES;
            }
        }

    } else if (self.scrollViewType == MoerScrollViewTypeInner) {
        if (!self.enableScroll) {
            [self moerInnerScrollViewProxyScrollViewSetContentOffset:CGPointZero];

        }

        if (self.contentOffset.y <= 0) {
            [self moerInnerScrollViewProxyScrollViewSetContentOffset:CGPointZero];
            self.outScrollView.enableScroll = YES;
            self.enableScroll = NO;

        }
    }
   
}

@end



@implementation UIScrollView (MorePan)

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)setPageViewController:(UIPageViewController *)pageViewController viewControllers:(NSArray <UIViewController *> *)viewControllers scrollViewBlocks:(NSArray <InnerScrollViewForCurrentPage> *)scrollViews selectedIndex:(NSInteger)selectedIndex {
    self.scrollViewType = MoerScrollViewTypeOutter;
    self.enableScroll = YES;
    self.currentIndex = selectedIndex;
    self.viewControllers = viewControllers;
    self.scrollViewBlocks = scrollViews;
    InnerScrollViewForCurrentPage innerScrollViewForCurrentPage = scrollViews[selectedIndex];
    UIScrollView *currentInScrollView = innerScrollViewForCurrentPage(pageViewController, viewControllers[selectedIndex]);
    currentInScrollView.scrollViewType = MoerScrollViewTypeInner;
    currentInScrollView.outScrollView = self;
    self.innerScrollView = currentInScrollView;
}

@end
