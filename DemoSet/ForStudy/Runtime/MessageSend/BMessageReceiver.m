//
//  BMessageReceiver.m
//  DemoSet
//
//  Created by tang on 2017/12/5.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "BMessageReceiver.h"

@implementation BMessageReceiver

-(void)forwardingTargetForSelectorFunction {
    NSLog(@"%s", __func__);
}

- (void)signatureFunction {
    NSLog(@"%s", __func__);
}
@end
