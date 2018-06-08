//
//  TZLPickerViewController.m
//  DemoSet
//
//  Created by tang on 2018/6/6.
//  Copyright © 2018年 HZ. All rights reserved.
//

#import "TZLPickerViewController.h"

//FIXME: 选择的回调的数据对象
@implementation TZLPickerDataModel
@end


//FIXME: 日期对象
@interface TZLPickerDate()
@property (strong, nonatomic) NSMutableArray *yearArr; // 年数组
@property (strong, nonatomic) NSMutableArray *monthArr; // 月数组
@property (strong, nonatomic) NSMutableArray *dayArr; // 日数组
@property (strong, nonatomic) NSMutableArray *hourArr; // 时数组
@property (strong, nonatomic) NSMutableArray *minuteArr; // 分数组
@property (strong, nonatomic) NSArray *timeArr; // 当前时间数组

@property (copy, nonatomic) NSString *year; // 选中年
@property (copy, nonatomic) NSString *month; //选中月
@property (copy, nonatomic) NSString *day; //选中日
@property (copy, nonatomic) NSString *hour; //选中时
@property (copy, nonatomic) NSString *minute; //选中分
/** 保存年月日的数据 */
@property(nonatomic, strong) NSMutableArray *customDateArr;
@end
@implementation TZLPickerDate
- (instancetype)init {
    if (self = [super init]) {
        self.customDateArr = [NSMutableArray new];
        [self.customDateArr addObject:self.yearArr];
        [self.customDateArr addObject:self.monthArr];
        [self.customDateArr addObject:self.dayArr];
//        [self showDate];
        
    }
    return self;
}

- (void)showDate {
    NSDate *date = [NSDate date];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *defaultDate = nil;
    if (self.defaultDate == nil) {
        defaultDate = [dateFormatter stringFromDate:date];
    } else {
        if (![self.defaultDate containsString:@":"]) {
            self.defaultDate = [self.defaultDate stringByAppendingString:@" 00:00"];
        }
        date = [dateFormatter dateFromString:self.defaultDate];
        defaultDate = [dateFormatter stringFromDate:date];;
    }
    NSString *newDate = [[[defaultDate stringByReplacingOccurrencesOfString:@"-" withString:@";"] stringByReplacingOccurrencesOfString:@":" withString:@";"] stringByReplacingOccurrencesOfString:@" " withString:@";"];
    NSMutableArray *timerArray = [NSMutableArray arrayWithArray:[newDate componentsSeparatedByString:@";"]];
    self.year = timerArray[0];
    [timerArray replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%@年", timerArray[0]]];
    self.month = timerArray[1];
    [timerArray replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%@月", timerArray[1]]];
    self.day = timerArray[2];
    [timerArray replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%@日", timerArray[2]]];
    self.hour = timerArray[3];
    [timerArray replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%@时", timerArray[3]]];
    self.minute = timerArray[4];
    [timerArray replaceObjectAtIndex:4 withObject:[NSString stringWithFormat:@"%@分", timerArray[4]]];
    [dateFormatter setDateFormat:@"yyyy年;MM月;dd日;HH时;mm分"];
    defaultDate = [dateFormatter stringFromDate:date];
    self.userDate = defaultDate;
    [self refreshDay];
}

/// 获取年份
- (NSMutableArray *)yearArr {
    if (!_yearArr) {
        _yearArr = [NSMutableArray array];
        for (int i = 1970; i < 2199; i ++) {
            [_yearArr addObject:[NSString stringWithFormat:@"%02d年", i]];
        }
    }
    return _yearArr;
}

/// 获取月份
- (NSMutableArray *)monthArr {
    //    NSDate *today = [NSDate date];
    //    NSCalendar *c = [NSCalendar currentCalendar];
    //    NSRange days = [c rangeOfUnit:NSCalendarUnitMonth inUnit:NSCalendarUnitYear forDate:today];
    if (!_monthArr) {
        _monthArr = [NSMutableArray array];
        for (int i = 1; i <= 12; i ++) {
            [_monthArr addObject:[NSString stringWithFormat:@"%02d月", i]];
        }
    }
    return _monthArr;
}

/// 获取当前月的天数
- (NSMutableArray *)dayArr {
    if (!_dayArr) {
        _dayArr = [NSMutableArray array];
        for (int i = 1; i <= 31; i ++) {
            [_dayArr addObject:[NSString stringWithFormat:@"%d日", i]];
        }
    }
    return _dayArr;
}

/// 获取小时
- (NSMutableArray *)hourArr {
    if (!_hourArr) {
        _hourArr = [NSMutableArray array];
        for (int i = 0; i < 24; i ++) {
            [_hourArr addObject:[NSString stringWithFormat:@"%d时", i]];
        }
    }
    return _hourArr;
}

/// 获取分钟
- (NSMutableArray *)configMinuteArray {
    NSMutableArray *minuteArray = [NSMutableArray array];
    for (int i = 0; i <= 60 - self.minuteInterval; i ++) {
        if (i % self.minuteInterval == 0) {
            [minuteArray addObject:[NSString stringWithFormat:@"%d分", i]];
            continue;
        }
    }
    return minuteArray;
}
//刷新日
- (void)refreshDay {
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 1; i < [self getDayNumber:self.year.integerValue month:self.month.integerValue].integerValue + 1; i ++) {
        [arr addObject:[NSString stringWithFormat:@"%02d日", i]];
    }
    [self.customDateArr replaceObjectAtIndex:2 withObject:arr];
    self.customArr = self.customDateArr.copy;
}
- (void)refreshDayWithYear:(NSString *)year month:(NSString *)month {
    NSMutableArray *arr = [NSMutableArray array];
    NSInteger day = [self getDayNumber:year.integerValue month:month.integerValue].integerValue + 1;
    for (NSInteger i = 1; i < day; i ++) {
        [arr addObject:[NSString stringWithFormat:@"%ld日", i]];
    }
    [self.customDateArr replaceObjectAtIndex:2 withObject:arr];
    self.customArr = self.customDateArr.copy;
}

// 比较选择的时间是否小于当前时间
- (int)compareDate:(NSString *)date01 withDate:(NSString *)date02{
    int ci;
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy年,MM月,dd日,HH时,mm分"];
    NSDate *dt1 = [[NSDate alloc] init];
    NSDate *dt2 = [[NSDate alloc] init];
    dt1 = [df dateFromString:date01];
    dt2 = [df dateFromString:date02];
    NSComparisonResult result = [dt1 compare:dt2];
    switch (result) {
            //date02比date01大
        case NSOrderedAscending: ci=1;break;
            //date02比date01小
        case NSOrderedDescending: ci=-1;break;
            //date02=date01
        case NSOrderedSame: ci=0;break;
        default: NSLog(@"erorr dates %@, %@", dt2, dt1);break;
    }
    return ci;
}

- (NSString *)getDayNumber:(NSInteger)year month:(NSInteger)month{
    NSArray *days = @[@"31", @"28", @"31", @"30", @"31", @"30", @"31", @"31", @"30", @"31", @"30", @"31"];
    if (2 == month && 0 == (year % 4) && (0 != (year % 100) || 0 == (year % 400))) {
        return @"29";
    }
    return days[month - 1];
}
@end

//FIXME: TZLPickerViewController
@interface TZLPickerViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>
//UI部分
@property(nonatomic) UIView *pickerBackView;
@property(nonatomic) UIView *optionView;
@property(nonatomic) UIButton *sureBtn;
@property(nonatomic) UILabel *titleLb;
@property(nonatomic) UIButton *cancelBtn;
@property(nonatomic) UIPickerView *pickerView;
//总的components数组 存放的对象是数据
@property(nonatomic) NSMutableArray<NSArray *> *components;
//选择的
@property(nonatomic, strong) NSIndexPath *selIndexPath;

/** 日期model */
@property(nonatomic, strong) TZLPickerDate *pickerDate;
@end

@implementation TZLPickerViewController
- (instancetype)init {
    if (self = [super init]) {
        //在这里写这句代码 不然背景黑屏
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    self.components = [NSMutableArray new];
    [self sureBtn];
    [self cancelBtn];
    [self titleLb];
    [self pickerView];
    
    [self initSet];
    
}

#pragma mark method method
- (void)initSet {
    switch (self.pickerType) {
        case PickerViewCustomType:
        {
            if (self.customArr && self.customArr.count) {
                [self.components addObject:self.customArr];
                [self.pickerView reloadAllComponents];
            }
            break;
        }
        case PickerViewDateType:
        {
            self.pickerDate = [TZLPickerDate new];
            self.pickerDate.defaultDate = self.defaultDate;
            [self.pickerDate showDate];
            self.components = self.pickerDate.customArr.copy;
            [self.pickerView reloadAllComponents];
            NSArray *tmpArr = [self.pickerDate.userDate componentsSeparatedByString:@";"];
            NSInteger yearRow = [self.components[0] indexOfObject:tmpArr[0]];
            NSInteger monthRow = [self.components[1] indexOfObject:tmpArr[1]];
            NSInteger dayRow = [self.components[2] indexOfObject:tmpArr[2]];
            [self.pickerView selectRow:yearRow inComponent:0 animated:YES];
            [self.pickerView selectRow:monthRow inComponent:1 animated:YES];
            [self.pickerView selectRow:dayRow inComponent:2 animated:YES];
            break;
            
        }
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark method action
- (void)sureAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
//    NSString *backStr = self.components[self.selIndexPath.section][self.selIndexPath.row];
    TZLPickerDataModel *model = [TZLPickerDataModel new];
    model.indexPath = self.selIndexPath;
    model.pickerId = nil;
    if (self.pickerType == PickerViewDateType) {
        NSInteger yearRow = [self.pickerView selectedRowInComponent:0];
        NSInteger monthRow = [self.pickerView selectedRowInComponent:1];
        NSInteger dayRow = [self.pickerView selectedRowInComponent:2];
        NSString *text = @"";
        text = [text stringByAppendingString:self.components[0][yearRow]];
        text = [text stringByAppendingString:self.components[1][monthRow]];
        text = [text stringByAppendingString:self.components[2][dayRow]];
        model.pickerText = text;
    } else {
        model.pickerText = (self.customArr && self.customArr.count) ? self.customArr[self.selIndexPath.row] : nil;
    }
    self.dateBlock(model);
}

- (void)cancelAction:(UIButton *)sender {
//    [self hidePickerViewAnimation];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark method method
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark delete pickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.components.count;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.components[component].count;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    //去除分割线
//    [pickerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if (obj.frame.size.height < 1) {
//            [obj setBackgroundColor:[UIColor clearColor]];
//        }
//    }];
    
    UILabel *label;
    if (!view) {
        label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor orangeColor];
    } else {
        label = (UILabel *)view;
    }
    label.text = self.components[component][row];
    return label;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selIndexPath = [NSIndexPath indexPathForRow:row inSection:component];
    if (self.pickerType == PickerViewDateType) {
        if (component == 1) {//选择了月份,随之就要更新当月有多少天
            NSInteger yearRow = [self.pickerView selectedRowInComponent:0];
            NSString *year = self.components[0][yearRow];
            [self.pickerDate refreshDayWithYear:year month:self.components[1][row]];
            self.components = self.pickerDate.customArr.copy;
            [self.pickerView reloadComponent:2];
        }
    }
}


#pragma  mark lazy
- (UIView *)pickerBackView {
    if (!_pickerBackView) {
        _pickerBackView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenH - 260 * hScale, kScreenW, 260 * hScale)];
        _pickerBackView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_pickerBackView];
    }
    return _pickerBackView;
}
- (UIView *)optionView {
    if (!_optionView) {
        _optionView = [UIView new];
        [self.pickerBackView addSubview:_optionView];
        [_optionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(0);
            make.height.equalTo(45);
        }];
        _optionView.backgroundColor = [UIColor orangeColor];
    }
    return _optionView;
}

- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.optionView addSubview:_sureBtn];
        [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(0);
            make.centerY.equalTo(0);
            make.top.bottom.equalTo(0);
        }];
        _sureBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sureBtn setTitle:@"确定    " forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.optionView addSubview:_cancelBtn];
        [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(0);
            make.top.bottom.equalTo(0);
        }];
        _cancelBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancelBtn setTitle:@"   取消" forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}
- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [UILabel new];
        [self.optionView addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(0);
        }];
        _titleLb.text = @"这是标题";
        _titleLb.textColor = [UIColor whiteColor];
        _titleLb.font = [UIFont systemFontOfSize:15];
    }
    return _titleLb;
}
- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [UIPickerView new];
        [self.pickerBackView addSubview:_pickerView];
        [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.top.equalTo(self.optionView.mas_bottom);
        }];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        
    }
    return _pickerView;
}

@end
