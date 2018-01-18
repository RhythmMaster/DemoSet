//
//  TransitionAnimationViewControllerFirst.h
//  DemoSet
//
//  Created by tang on 2018/1/17.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CollectionViewCell;
@interface TransitionAnimationViewControllerFirst : UIViewController
- (CollectionViewCell *)getSelectedCell;
@end

@interface CollectionViewCell: UICollectionViewCell
@property(nonatomic, strong) UIImageView *picView;
@end
