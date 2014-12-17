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

        
    }
    return self;
}

- (void) addGraphOne {
    UIView *catView = [[UIView alloc] initWithFrame:CGRectMake(20, 60, 320-40, 200- 40)];
    
    UIImage *image = [UIImage imageNamed:@"GraphOne.jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];

    imageView.frame = catView.bounds;
    
    [catView addSubview:imageView];
    
    [self addSubview:catView];
    
    
}

- (void) addGraphTwo {
    UIView *catView = [[UIView alloc] initWithFrame:CGRectMake(20, 250, 320-40, 200- 40)];
    
    UIImage *image = [UIImage imageNamed:@"GraphTwo.jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    imageView.frame = catView.bounds;
    
    [catView addSubview:imageView];
    
    [self addSubview:catView];

    
}



@end
