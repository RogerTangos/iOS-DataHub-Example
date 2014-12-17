//
//  PageVC.m
//  GetFit
//
//  Created by Albert Carter on 12/17/14.
//  Copyright (c) 2014 CSAIL Big Data Initiative. All rights reserved.
//

#import "PageVC.h"
#import "GraphView.h"
#import "AboutView.h"

@interface PageVC ()

@property (strong, nonatomic) UIPageViewController *pageController;

@end

@implementation PageVC

- (void) loadView {
    
    [super loadView];
    // set some variables
    self.pageController = [self initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:[[self view] bounds]];
    
    
    
    // create a view
    CGRect frame = [UIScreen mainScreen].bounds;
    GraphView *graphView = [[GraphView alloc] initWithFrame:frame];
    
    
    
    
//    [self.view addSubview:graphView];
    self.view = graphView;
//     ad graphView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIViewController *) pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    return self;
}

- (UIViewController *) pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    return self;
}


@end
