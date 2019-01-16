//
//  LDEventStringAccumulator.m
//  DarklyEventSource
//
//  Created by Mark Pokorny on 5/30/18. +JMJ
//  Copyright © 2018 Catamorphic Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LDEventStringAccumulator.h"
#import "NSString+LDEventSource.h"
#import "NSArray+LDEventSource.h"

@implementation LDEventStringAccumulator
-(void)accumulateEventStringWithString:(NSString*)eventString {
    if (eventString.length == 0) { return; }
    if (self.eventString == nil) {
        self.eventString = eventString;
        return;
    }
    self.eventString = [self.eventString stringByAppendingString:eventString];
}

-(BOOL)isReadyToParseEvent {
    if (self.eventString.length == 0) { return NO; }
    return self.eventString.hasEventTerminator;
}

-(void)reset {
    self.eventString = nil;
}

-(void)removeFirstEvent {
    NSArray<NSString*> *eventStringParts = [self.eventString componentsSeparatedByString:LDEventSourceEventTerminator];
    if (eventStringParts.count > 1) {
        self.eventString = [[eventStringParts subArrayFromIndex:1] componentsJoinedByString:LDEventSourceEventTerminator];
    } else {
        [self reset];
    }
}

@end
