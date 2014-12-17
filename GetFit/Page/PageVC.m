//
//  PageVC.m
//  GetFit
//
//  Created by Albert Carter on 12/17/14.
//  Copyright (c) 2014 CSAIL Big Data Initiative. All rights reserved.
//

#import "PageVC.h"
#import "AboutVC.h"
#import "GraphView.h"
#import "AboutView.h"

@interface PageVC ()

@property (strong, nonatomic) UIPageViewController *pageController;

@end

@implementation PageVC

- (void) loadView {
    
    [super loadView];
    // create the pageController
    self.pageController = [self initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageController.dataSource = self;
    [self.pageController.view setFrame:[[self view] bounds]];
    
    
    
    // create view controllers
    AboutVC *aboutVC = [[AboutVC alloc] init];
    
    // add VC's to arr, add arr to the pageController
    NSArray *viewControllers = [NSArray arrayWithObjects:aboutVC, nil];
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // add the page turn thingies
    [self addChildViewController:self.pageController];
    UIView *tempView = [self.pageController view];
    [self.view addSubview:tempView];
//    [self.pageController didMoveToParentViewController:self];
    
//    [self.view addSubview:graphView];
//    self.view = aboutVC.view;
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

- (NSInteger) presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return 2;
}

- (NSInteger) presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

@end
