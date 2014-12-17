//
//  GraphView.m
//  GetFit
//
//  Created by Albert Carter on 12/17/14.
//  Copyright (c) 2014 CSAIL Big Data Initiative. All rights reserved.
//

#import "GraphView.h"

@implementation GraphView

- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addGraphOne];
        [self addGraphTwo];
        [self addGraphThree];

        
    }
    return self;
}

- (void) addGraphOne {
    NSLog(@"Graph 1 added");
//    CGRect frame = self.window.bounds;
    
    UIImage *img = [UIImage imageNamed:@"GraphOne.jpg"];
    CGRect frame = CGRectMake(20, 20, img.size.width, img.size.height);
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:frame];
    logoView.tintColor = [UIColor orangeColor];
//    [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GraphOne.jpg"]];
    

    
    
    
    [self addSubview:logoView];
    
    
    
}

- (void) addGraphTwo {
    NSLog(@"Graph 2 added");
}

- (void) addGraphThree {
    NSLog(@"Graph 3 added");
}




@end
