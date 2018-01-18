//
//  TransitionAnimationViewControllerFirst.m
//  DemoSet
//
//  Created by tang on 2018/1/17.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "TransitionAnimationViewControllerFirst.h"
#import "TransitionAnimationViewControllerSecond.h"
#import "CustomTransitionAnimation.h"

@interface TransitionAnimationViewControllerFirst () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate, UIScrollViewDelegate>
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) CollectionViewCell *selectedCell;
@end

@implementation TransitionAnimationViewControllerFirst

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"这是列表";
    self.view.backgroundColor = [UIColor whiteColor];
    [self collectionView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    /****************注意点****************/
    //最好这里给代理 如果在viewDidLoad里面给代理 会导致 push到下一页面 在pop回来 代理被无法重新被指向
    //在viewDidDisappear:(BOOL)animated 可以看到 这时候 self.navigationController.delegate已经指向了 我们push的页面 也就是  <TransitionAnimationViewControllerSecond: 0x7fb6e1798cc0>
    self.navigationController.delegate = self;
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    //pointer
    /*
     结果: po self.navigationController.delegate
    <TransitionAnimationViewControllerSecond: 0x7fb6e1798cc0>
     */
}

#pragma mark delete collectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (kScreenViewWidth - 15 * 2 - 10 * 2) / 3.0;
    CGSize size = CGSizeMake(width, width * 2);
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(15, 15, 15, 15);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TransitionAnimationViewControllerSecond *secondVC = [TransitionAnimationViewControllerSecond new];
    self.selectedCell = (CollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [self.navigationController pushViewController:secondVC animated:YES];
}

#pragma mark UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        CustomTransitionAnimation *animation = [[CustomTransitionAnimation alloc] initWithFlag:YES];
        return animation;
    } else if (operation == UINavigationControllerOperationPop) {
        return nil;
    }
    return nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"-------偏移量: %@", NSStringFromCGPoint(scrollView.contentOffset));
}

- (CollectionViewCell *)getSelectedCell {
    return self.selectedCell;
}

#pragma  mark lazy
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumLineSpacing = 20;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self.view addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        
    }
    return _collectionView;
}


@end



@implementation CollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self picView];
    }
    return self;
}

- (UIImageView *)picView {
    if (!_picView) {
        _picView = [UIImageView new];
        [self.contentView addSubview:_picView];
        [_picView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        _picView.contentMode = UIViewContentModeScaleAspectFill;
        _picView.clipsToBounds = YES;
        _picView.image = [UIImage imageNamed:@"未命名.png"];
    }
    return _picView;
}
@end
