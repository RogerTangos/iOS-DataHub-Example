//
//  MinuteStore.h
//  GetFit
//
//  Created by Albert Carter on 12/29/14.
//  Copyright (c) 2014 CSAIL Big Data Initiative. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MinuteEntry.h"

@interface MinuteStore : NSObject
+ (instancetype) sharedStore;

- (MinuteEntry *) createMinuteEntrywithActivity:(NSString *) activity
                          intensity:(NSString *)intensity
                           duration:(NSInteger)duration
                         andEndTime:(NSDate *)endTime;
- (void) removeMinuteEntry:(MinuteEntry *)minuteEntry;

// need to be implemented
- (void) postToGetFit;
- (void) postToDataHub;

@end
