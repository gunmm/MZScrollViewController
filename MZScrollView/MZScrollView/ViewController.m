//
//  ViewController.m
//  MZScrollView
//
//  Created by minzhe on 2019/5/20.
//  Copyright © 2019 minzhe. All rights reserved.
//

#import "ViewController.h"
#import "ListViewController.h"
#import "MZScrollViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MZScrollViewController *innerScrollViewController = [MZScrollViewController instantiateViewController];
    
    //header
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 200)];
    headView.backgroundColor = [UIColor redColor];
    innerScrollViewController.headerView = headView;
    
    //footer
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    footerView.backgroundColor = [UIColor greenColor];
    innerScrollViewController.footerView = footerView;
    
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    NSMutableArray<InnerScrollViewForCurrentPage> *scrollViews = [[NSMutableArray alloc] init];
    
    NSArray *titles = @[@"全部", @"文章", @"文章2"];
    NSUInteger selectedIndex = 2;
    
    //全部
    ListViewController *tableViewController0 = [[ListViewController alloc] init];
    [viewControllers addObject:tableViewController0];
    [scrollViews addObject:^() {
        return tableViewController0.tableView;
    }];
    //文章
    ListViewController *tableViewController1 = [[ListViewController alloc] init];
    [viewControllers addObject:tableViewController1];
    [scrollViews addObject:^() {
        return tableViewController1.tableView;
    }];
    
    //文章
    ListViewController *tableViewController2 = [[ListViewController alloc] init];
    [viewControllers addObject:tableViewController2];
    [scrollViews addObject:^() {
        return tableViewController2.tableView;
    }];
    
    
    [innerScrollViewController setViewControllers:viewControllers scrollViewBlocks:scrollViews sectionTitles:titles selectedIndex:selectedIndex];
    
    
    [self addChildViewController:innerScrollViewController];
    [self.view addSubview:innerScrollViewController.view];
    innerScrollViewController.view.frame = self.view.bounds;
    innerScrollViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [innerScrollViewController didMoveToParentViewController:self];
}


@end
