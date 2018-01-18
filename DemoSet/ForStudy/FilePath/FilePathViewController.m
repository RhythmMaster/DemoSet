//
//  FilePathViewController.m
//  DemoSet
//
//  Created by tang on 2017/12/1.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "FilePathViewController.h"

#define kSeparateLine NSLog(@"--------------------------")

@interface FilePathViewController ()

@end

@implementation FilePathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    kSeparateLine;
    /* 应用程序包: 存放的可执行文件资源和资源文件 在程序执行期间,这个是不能变动的 */
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    NSLog(@"bundlePath:%@", bundlePath);
    
    kSeparateLine;
    /* 该目录下包括四个子文件: Documents Library SystemData tmp */
    NSString *homePath = NSHomeDirectory();
    NSLog(@"homePath:%@", homePath);
    
    kSeparateLine;
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [documents objectAtIndex:0];
    NSLog(@"documents: %@, documentPath: %@", documents, documentPath);
    
    kSeparateLine;
    NSArray *caches = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [caches objectAtIndex:0];
    NSLog(@"caches: %@, cachePath: %@", caches, cachePath);
    
    kSeparateLine;
    NSString *tmpPath = NSTemporaryDirectory();
    NSLog(@"tmpPath: %@", tmpPath);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
