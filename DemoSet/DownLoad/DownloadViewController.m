//
//  DownloadViewController.m
//  DemoSet
//
//  Created by tang on 2017/11/9.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "DownloadViewController.h"

@interface DownloadViewController ()

@end

@implementation DownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
//    [NSObject POST:@"http://wvideo.spriteapp.cn/video/2016/0116/569a048739c11_wpc.mp4" parameters:nil downloadProgress:^(NSProgress *downloadProgress) {
//        NSLog(@"-----------:%@", downloadProgress);
//    } completionHandler:^(id jsonObj, NSError *error) {
//        
//    }];
    
    [NSObject downloadWithURL:@"http://wvideo.spriteapp.cn/video/2016/0116/569a048739c11_wpc.mp4" fileDir:@"xx" progress:^(NSProgress *downloadProgress) {
        
    } success:^(NSString *filePath) {

    } failure:^(NSURLSessionDataTask *task, NSError *error) {

    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
