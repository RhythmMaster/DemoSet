//
//  WaterfallCollectionViewController.m
//  DemoSet
//
//  Created by tang on 2018/3/8.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "WaterfallCollectionViewController.h"
#import "CustomCollectionViewLayout.h"

@interface WaterfallCollectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) CustomCollectionViewLayout *flowLayout;
@end

@implementation WaterfallCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self collectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark delete collectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (!section) {
        return 15;
    }
    return 4;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = RadomColor;
    UILabel *label = [UILabel new];
    [cell.contentView addSubview:label];
    label.text = @(indexPath.row).stringValue;
    label.frame = CGRectMake(0, 0, 20, 30);
    [label sizeToFit];
    return cell;
}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSInteger width = (kScreenW - 3) / 4;
//    CGSize size = CGSizeMake(width, width);
////    if (indexPath.row % 3 == 0) {
////        return CGSizeMake(kScreenW - 3 * width - 3, width);
////    }
//    return size;
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//    if (section) {
//        return CGSizeMake(kScreenW, 1.0);
//    }
//    return CGSizeMake(kScreenW, 0);;
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        self.flowLayout = [CustomCollectionViewLayout new];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        [self.view addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        
    }
    return _collectionView;
}

@end
