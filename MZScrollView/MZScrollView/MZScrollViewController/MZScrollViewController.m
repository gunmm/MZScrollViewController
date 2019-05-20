//
//  MZScrollViewController.m
//  MyScroll
//
//  Created by gunmm on 2019/5/19.
//  Copyright © 2019 gunmm. All rights reserved.
//

#import "MZScrollViewController.h"
#import "MZPageViewController.h"
#import <HMSegmentedControl/HMSegmentedControl.h>

@interface MZScrollViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet HMSegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UIView *privateFooterView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *privateFooterViewHeight;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, strong) NSArray<NSString *> *sectionTitles;
@property (nonatomic, strong) NSArray<UIViewController *> *viewControllers;
@property (nonatomic, strong) NSArray<InnerScrollViewForCurrentPage> *scrollViewBlocks;

@property (nonatomic, weak) MZPageViewController *pageViewController;



@end

@implementation MZScrollViewController

+ (instancetype)instantiateViewController {
    MZScrollViewController *controller = [[UIStoryboard storyboardWithName:NSStringFromClass([MZScrollViewController class]) bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([MZScrollViewController class])];
    return controller;
}

- (void)setViewControllers:(NSArray <UIViewController *> *)viewControllers
          scrollViewBlocks:(NSArray <InnerScrollViewForCurrentPage> *)scrollViews
             sectionTitles:(nonnull NSArray<NSString *> *)sectionTitles
             selectedIndex:(NSInteger)selectedIndex {
    self.viewControllers = viewControllers;
    self.scrollViewBlocks = scrollViews;
    self.sectionTitles = sectionTitles;
    self.currentIndex = selectedIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.tableHeaderView = self.headerView;
    [self setUpFooterView];
    [self setSegmentedControl];
    [self setPageController];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    UIView *footerView = self.tableView.tableFooterView;
    footerView.frame = self.tableView.bounds;
    self.tableView.tableFooterView = footerView;
}

- (void)setSegmentedControl {
    self.segmentedControl.sectionTitles = self.sectionTitles;
    self.segmentedControl.selectionIndicatorColor = [UIColor redColor];
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    self.segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleDynamic;
    self.segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0, 14, 0, 14);
    
    self.segmentedControl.selectionIndicatorHeight = 2.0f;
    self.segmentedControl.borderType = HMSegmentedControlBorderTypeBottom;
    self.segmentedControl.borderColor = [UIColor greenColor];
    [self.segmentedControl setSelectedSegmentIndex:self.currentIndex animated:NO];

    __weak typeof(self) weakSelf = self;
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        __strong typeof(self) strongSelf = weakSelf;

        UIViewController *destinationViewController = [strongSelf.viewControllers objectAtIndex:index];
        if (strongSelf.currentIndex > index) {
            [strongSelf.pageViewController setViewControllers:@[destinationViewController] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
        }
        else {
            [strongSelf.pageViewController setViewControllers:@[destinationViewController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        }
        strongSelf.currentIndex = index;
        [weakSelf.tableView setSelectedIndex:weakSelf.currentIndex];
    }];
}

- (void)setPageController {
    __weak typeof(self) weakSelf = self;
    [self.pageViewController setViewControllers:self.viewControllers index:self.currentIndex pageDidChanged:^(UIPageViewController *pageViewController, UIViewController *viewController, NSUInteger index) {
        [weakSelf.segmentedControl setSelectedSegmentIndex:index animated:YES];
        weakSelf.currentIndex = index;
        [weakSelf.tableView setSelectedIndex:weakSelf.currentIndex];
    }];
    [self.tableView setViewControllers:self.viewControllers scrollViewBlocks:self.scrollViewBlocks selectedIndex:self.currentIndex];
}

- (void)setUpFooterView {
    if (self.footerView) {
        while (self.privateFooterView.subviews.count) {
            [self.privateFooterView.subviews.lastObject removeFromSuperview];
        }
        [self.privateFooterView addSubview:self.footerView];
        
        self.privateFooterViewHeight.constant = self.footerView.frame.size.height;
        self.footerView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.privateFooterView addConstraints:@[
                                                 [NSLayoutConstraint constraintWithItem:self.footerView
                                                                              attribute:NSLayoutAttributeTop
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self.privateFooterView
                                                                              attribute:NSLayoutAttributeTop
                                                                             multiplier:1
                                                                               constant:0],
                                                 [NSLayoutConstraint constraintWithItem:self.footerView
                                                                              attribute:NSLayoutAttributeLeading
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self.privateFooterView
                                                                              attribute:NSLayoutAttributeLeading
                                                                             multiplier:1
                                                                               constant:0],
                                                 [NSLayoutConstraint constraintWithItem:self.footerView
                                                                              attribute:NSLayoutAttributeBottom
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self.privateFooterView
                                                                              attribute:NSLayoutAttributeBottom
                                                                             multiplier:1
                                                                               constant:0],
                                                 [NSLayoutConstraint constraintWithItem:self.footerView
                                                                              attribute:NSLayoutAttributeTrailing
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self.privateFooterView
                                                                              attribute:NSLayoutAttributeTrailing
                                                                             multiplier:1
                                                                               constant:0]
                                                 ]];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:NSStringFromClass([MZPageViewController class])]) {
        self.pageViewController = [segue destinationViewController];
    }
}

@end
