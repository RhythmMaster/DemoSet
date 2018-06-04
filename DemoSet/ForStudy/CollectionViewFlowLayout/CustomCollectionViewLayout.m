//
//  CustomCollectionViewLayout.m
//  DemoSet
//
//  Created by tang on 2018/3/8.
//  Copyright © 2018年 HZ. All rights reserved.
//



#import "CustomCollectionViewLayout.h"

static const NSInteger numberOfInLine = 4;

@interface CustomCollectionViewLayout()
@property(nonatomic, strong) NSMutableArray *eachHight;
/** 保存attribute */
@property (nonatomic,strong) NSMutableArray * attributes;
@end

@implementation CustomCollectionViewLayout
- (NSMutableArray *)attributes {
    if (_attributes == nil) {
        _attributes = [NSMutableArray new];
    }
    return _attributes;
}
- (NSMutableArray *)eachHight {
    if (!_eachHight) {
        _eachHight = [NSMutableArray new];
        for (int i = 0; i < numberOfInLine; i++) {
            [_eachHight addObject:@(0)];
        }
    }
    return _eachHight;
}

- (void)prepareLayout {
    [super prepareLayout];
    NSInteger section = 1;
    for (NSInteger i = 0; i < section; i++) {
        
        // 计算当前section的每个cell的frame
        NSInteger row = [self.collectionView numberOfItemsInSection:i];
        for (NSInteger j = 0; j < row; j++) {
            NSIndexPath * indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            UICollectionViewLayoutAttributes * attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
            [self.attributes addObject:attribute];
        }
        
    }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes * attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    NSInteger width = kScreenW / numberOfInLine;
    // 计算attribute的frame
    CGFloat X = 0;
    CGFloat Y = 0;
    CGFloat W = 0;
    CGFloat H = 0;
    CGFloat shortHeight = CGFLOAT_MAX;
    NSInteger index = 0;
    for (NSInteger i = 0; i < numberOfInLine; i++) {
        CGFloat tmp = [self.eachHight[i] floatValue];
        if (tmp < shortHeight) {
            shortHeight = tmp;
            index = i;
        }
    }
    X = index * width;
    Y = shortHeight;
    NSInteger num = arc4random_uniform(10);
    if (num > 5) {
        H = width * 2;
    } else {
        H = width;
    }
    NSInteger flag = arc4random_uniform(10);
    if ((index + 1) < numberOfInLine && [self.eachHight[index + 1] integerValue] == [self.eachHight[index] integerValue] && flag < 5) {
        W = width * 2;
        self.eachHight[index + 1] = @(shortHeight +H);
        self.eachHight[index] = @(shortHeight +H);
    } else {
        W = width;
        if (H == width * 2) {
            H = width;
        }
        self.eachHight[index] = @(shortHeight +H);
    }
    attributes.frame = CGRectMake(X, Y, W, H);
    return attributes;
}
/**
 *  返回特定区域的attribute
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSMutableArray * array = [NSMutableArray array];
    
    [self.attributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (CGRectIntersectsRect(rect, obj.frame)) {
            [array addObject:obj];
        }
    }];
    
    return array;
}
- (CGSize)collectionViewContentSize {
    
    // 判断最高的一列
    CGFloat longest = 0;
    for (NSInteger i = 0; i < self.eachHight.count; i++) {
        CGFloat temp = [self.eachHight[i] floatValue];
        if (temp > longest) {
            longest = temp;
        }
    }
    
    return CGSizeMake(self.collectionView.frame.size.width, longest);
}


@end
