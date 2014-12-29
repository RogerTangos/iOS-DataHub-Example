//
//  MinuteEntry.m
//  GetFit
//
//  Created by Albert Carter on 12/29/14.
//  Copyright (c) 2014 CSAIL Big Data Initiative. All rights reserved.
//

#import "MinuteEntry.h"
#import "MinuteStore.h"

@implementation MinuteEntry

-(instancetype) initEntryWithActivity:(NSString *)activity
                            intensity:(NSString *)intensity
                             duration:(NSInteger)duration
                           andEndTime:(NSDate *)endTime {
    self = [super init];
    
    if (self) {
        _activity = activity;
        _intensity = intensity;
        _duration = duration;
        _endTime = endTime;
    }
    
    return self;
}



@end
