//
//  TZLPickerViewController.h
//  DemoSet
//
//  Created by tang on 2018/6/6.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, PickerViewType) {
    PickerViewGenderType,
    PickerViewDateType,
    PickerViewTimeType,
    PickerViewCustomType,//普通自定义的只是传入一个字符串之类的
    PickerViewCustomObjectType,//普通自定义的只是传入一个对象(只限这种类型,需要组装一下TZLPickerDataModel)的
};

//FIXME: 选择的回调的数据对象
@interface TZLPickerDataModel: NSObject
/** 保存component 和row */
@property(nonatomic, strong) NSIndexPath *indexPath;
/** 选择的id(如果有的话) */
@property(nonatomic, copy) NSString *pickerId;
/** 选择的text */
@property(nonatomic, copy) NSString *pickerText;
@end


@interface TZLPickerDate: NSObject
/**  */
@property(nonatomic, strong) NSArray *customArr;
/** 分钟间隔 */
@property(nonatomic, assign) NSInteger minuteInterval;
/** 需要设置的默认时间 */
@property(nonatomic, strong) NSString *defaultDate;
/** 默认时间 */
@property(nonatomic, strong) NSString *userDate;


- (void)refreshDayWithYear:(NSString *)year month:(NSString *)month;
- (void)showDate;
@end

typedef void (^PickerDateBlock)(TZLPickerDataModel *row);

//FIXME: TZLPickerViewController
@interface TZLPickerViewController : UIViewController
@property(nonatomic, strong) NSArray *customArr;
@property(nonatomic, assign) PickerViewType pickerType;
@property(nonatomic,copy) PickerDateBlock dateBlock;
/** 需要设置的默认时间 */
@property(nonatomic, strong) NSString *defaultDate;
@end
