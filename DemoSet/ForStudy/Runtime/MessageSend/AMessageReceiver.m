//
//  AMessageReceiver.m
//  DemoSet
//
//  Created by tang on 2017/12/5.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "AMessageReceiver.h"
#import <objc/runtime.h>
#import "BMessageReceiver.h"

/* 当一个对象无法接收某一消息时，就会启动所谓“消息转发(message forwarding)”机制，通过这一机制，我们可以告诉对象如何处理未知的消息。默认情况下，对象接收到未知的消息，会导致程序崩溃，通过控制台，我们可以看到以下异常信息：
 
 这段异常信息实际上是由NSObject的“doesNotRecognizeSelector”方法抛出的。不过，我们可以采取一些措施，让我们的程序执行特定的逻辑，而避免程序的崩溃。
 
 消息转发机制基本上分为三个步骤：
 
 1>、动态方法解析
 2>、备用接收者
 3>、完整转发
 消息的转发流程图：
 http://upload-images.jianshu.io/upload_images/1370993-a5b09924e04bdb43.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/700
 相关文章链接：http://www.jianshu.com/p/adf0d566c887 */

@implementation AMessageReceiver

/* 1.动态方法解析
 对当前类添加一个方法 */
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSLog(@"--------------动态方法解析--------------");
    NSString *selName = NSStringFromSelector(sel);
    if ([selName isEqualToString:@"resolveInstanceFunction"]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        /* C的方式
         class_addMethod([self class], @selector(resolveInstanceFunction), (IMP)newTestFunction, "v@:");
         */
        class_addMethod([self class], @selector(resolveInstanceFunction), method_getImplementation(class_getInstanceMethod([self class], @selector(newTestMethod))), "v@:");
#pragma clang diagnostic pop
        return YES;
    }
    return NO;
}


void newTestFunction() {
    NSLog(@"%s", __func__);
}
- (void)newTestMethod {
    NSLog(@"%s", __func__);
    
    
}


/* 2.备用接收者 */
- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSLog(@"--------------备用接收者--------------");
    NSString *selName = NSStringFromSelector(aSelector);
    if ([selName isEqualToString:@"forwardingTargetForSelectorFunction"]) {
        return [BMessageReceiver new];
    }
    return [super forwardingTargetForSelector:aSelector];
}

/* 3.完整的消息转发 */
// 我们首先要通过, 指定方法签名，若返回nil，则表示不处理。
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSLog(@"指定方法签名");
    NSString *selName = NSStringFromSelector(aSelector);
    if ([selName isEqualToString:@"signatureFunction"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}
// 通过anInvocation对象做很多处理，比如修改实现方法，修改响应对象等
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"--------------anInvocation--------------");
    [anInvocation setSelector:@selector(signatureFunction)];
    [anInvocation invokeWithTarget:[BMessageReceiver new]];
}

// 消息没法实现会调用这个方法
- (void)doesNotRecognizeSelector:(SEL)aSelector {
    NSLog(@"哈哈哈哈没人睬你：%@,然后崩了...../(ㄒoㄒ)/~~", NSStringFromSelector(aSelector));
}
@end
