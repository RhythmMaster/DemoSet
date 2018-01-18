//
//  ComprehensiveViewController.m
//  DemoSet
//
//  Created by tang on 2017/11/29.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "ComprehensiveViewController.h"
#import "TZLMenuButtonView.h"

@interface ComprehensiveViewController ()
@property(nonatomic, strong) TZLMenuButtonView *menuView;
@end

@implementation ComprehensiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initView {
    TZLMenuButtonView *menuView = [[TZLMenuButtonView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.5, self.view.frame.size.height - 250, 50, 50) image:[UIImage imageNamed:@"chooser-button-tab"] heightImage:[UIImage imageNamed:@"chooser-button-tab-highlighted"]];
    self.menuView = menuView;
    TZLImageView *itemButton_1 = [[TZLImageView alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-music"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-music-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    TZLImageView *itemButton_2 = [[TZLImageView alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-place"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-place-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    TZLImageView *itemButton_3 = [[TZLImageView alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-camera"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-camera-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    TZLImageView *itemButton_4 = [[TZLImageView alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-thought"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-thought-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    TZLImageView *itemButton_5 = [[TZLImageView alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-sleep"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-sleep-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    menuView.items = @[itemButton_1, itemButton_2, itemButton_3, itemButton_4, itemButton_5];
    [self.view addSubview:menuView];
    [self buttonAciton];
}

- (void)buttonAciton {
    for (int i = 0; i < 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor lightGrayColor];
        button.bounds = CGRectMake(0, 0, 80, 40);
        button.center = CGPointMake((i + 1) * 0.25 * self.view.frame.size.width, self.view.frame.size.height - 60);
        [button setTitle:@[@"path", @"钉钉", @"Facebook"][i] forState:UIControlStateNormal];
        button.tag = i;
        [self.view addSubview:button];
        [button addTarget:self action:@selector(funcitonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}
- (void)funcitonAction:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
            NSLog(@"0");
            break;
        case 1:
            NSLog(@"1");
            break;
        case 2:
            NSLog(@"2");
            break;
        default:
            break;
    }
}

@end
