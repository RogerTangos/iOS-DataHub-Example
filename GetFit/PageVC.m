//
//  PageVC.m
//  GetFit
//
//  Created by Albert Carter on 12/28/14.
//  Copyright (c) 2014 CSAIL Big Data Initiative. All rights reserved.
//

#import "PageVC.h"
#import "GraphVC.h"
#import "AboutVC.h"

@interface PageVC ()
@property (strong, nonatomic) NSNumber *currentPage;
@property (strong, nonatomic) GraphVC *graphVC;
@property (strong, nonatomic) AboutVC *aboutVC;


@end

@implementation PageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.graphVC = [[GraphVC alloc]init];
    self.aboutVC = [[AboutVC alloc] init];
    
    self.currentPage = [[NSNumber alloc] initWithInt:0];
    
    if (self.graphVC != nil) {
        self.dataSource = self;
        
        [self setViewControllers:@[self.graphVC]
                       direction:UIPageViewControllerNavigationDirectionForward
                        animated:NO
                      completion:NULL];
        
        
    }
}

#pragma mark - UIPageViewControllerDelegate


- (UIViewController *) pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSLog(@"AfterCurrentPage called. pageAfterCall = %d", [self.currentPage intValue]);
    
    if ([self.currentPage intValue] == 1) {
        return nil;
    } else {
        int value = [self.currentPage intValue];
        self.currentPage = [NSNumber numberWithInt:value + 1];
        return self.aboutVC;
    }
    
}

- (UIViewController *) pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSLog(@"BeforeCurrentPage called. pageBeforeCall = %d", [self.currentPage intValue]);
    
    if ([self.currentPage intValue] == 0) {
        return nil;
    } else {
        int value = [self.currentPage intValue];
        self.currentPage = [NSNumber numberWithInt:value - 1];
        
        return self.graphVC;
    }
}

- (NSInteger) presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return 2;
}

- (NSInteger) presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return [self.currentPage integerValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
