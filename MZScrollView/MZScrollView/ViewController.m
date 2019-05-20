//
//  ViewController.m
//  MZScrollView
//
//  Created by minzhe on 2019/5/20.
//  Copyright © 2019 minzhe. All rights reserved.
//

#import "ViewController.h"
#import "ListViewController.h"
#import "MyScrollViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MyScrollViewController *innerScrollViewController = [MyScrollViewController instantiateViewController];
    
    //header
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 200)];
    headView.backgroundColor = [UIColor redColor];
    innerScrollViewController.headerView = headView;
    
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    NSMutableArray<InnerScrollViewForCurrentPage> *scrollViews = [[NSMutableArray alloc] init];
    
    NSArray *titles = @[@"全部", @"文章"];
    NSUInteger selectedIndex = 0;
    
    //全部
    ListViewController *tableViewController0 = [[ListViewController alloc] init];
    [viewControllers addObject:tableViewController0];
    [scrollViews addObject:^(UIPageViewController *pageViewController, UIViewController *viewController) {
        return tableViewController0.tableView;
    }];
    //文章
    ListViewController *tableViewController1 = [[ListViewController alloc] init];
    [viewControllers addObject:tableViewController1];
    [scrollViews addObject:^(UIPageViewController *pageViewController, UIViewController *viewController) {
        return tableViewController1.tableView;
    }];
    
    
    [innerScrollViewController setViewControllers:viewControllers scrollViewBlocks:scrollViews selectedIndex:0];
    
    
    [self addChildViewController:innerScrollViewController];
    [self.view addSubview:innerScrollViewController.view];
    innerScrollViewController.view.frame = self.view.bounds;
    innerScrollViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [innerScrollViewController didMoveToParentViewController:self];
}


@end
