//
//  MyScrollViewController.m
//  MyScroll
//
//  Created by gunmm on 2019/5/19.
//  Copyright © 2019 gunmm. All rights reserved.
//

#import "MyScrollViewController.h"
#import "MyPageViewController.h"

@interface MyScrollViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, strong) NSArray<NSString *> *sectionTitles;
@property (nonatomic, strong) NSArray<UIViewController *> *viewControllers;
@property (nonatomic, strong) NSArray<InnerScrollViewForCurrentPage> *scrollViewBlocks;

@property (nonatomic, weak) MyPageViewController *pageViewController;



@end

@implementation MyScrollViewController

+ (instancetype)instantiateViewController {
    MyScrollViewController *controller = [[UIStoryboard storyboardWithName:@"MyScrollStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([MyScrollViewController class])];
    return controller;
}

- (void)setViewControllers:(NSArray <UIViewController *> *)viewControllers scrollViewBlocks:(NSArray <InnerScrollViewForCurrentPage> *)scrollViews selectedIndex:(NSInteger)selectedIndex {
    self.viewControllers = viewControllers;
    self.scrollViewBlocks = scrollViews;
    self.currentIndex = selectedIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.tableHeaderView = self.headerView;
    [self setPageController];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    UIView *footerView = self.tableView.tableFooterView;
    footerView.frame = self.tableView.bounds;
    self.tableView.tableFooterView = footerView;
    
}

- (void)setPageController {
    [self.pageViewController setViewControllers:self.viewControllers index:self.currentIndex];
    [self.tableView setPageViewController:self.pageViewController viewControllers:self.viewControllers scrollViewBlocks:self.scrollViewBlocks selectedIndex:self.currentIndex];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:NSStringFromClass([MyPageViewController class])]) {
        self.pageViewController = [segue destinationViewController];
    }
}



@end
