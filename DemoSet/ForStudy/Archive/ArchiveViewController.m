//
//  ArchiveViewController.m
//  DemoSet
//
//  Created by tang on 2017/12/1.
//  Copyright © 2017年 HZ. All rights reserved.
//

#import "ArchiveViewController.h"
#import "Person.h"
#import "BeautifulGirl.h"

@interface ArchiveViewController ()

@end

@implementation ArchiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self archive];
    [self fileArchive];
    [self customObjecArchive];
    [self customObjecArchiveByRuntime];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/* 单个对象归档 */
- (void)archive {
    NSArray *array = [NSArray arrayWithObjects:@1, @2, @3, nil];
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = documents.firstObject;
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"testFile.plist"];
    BOOL success = [NSKeyedArchiver archiveRootObject:array toFile:filePath];
    NSLog(@"%d", success);
    NSLog(@"%@", filePath);
    [self unArchiveWithPath:filePath];
}

- (void)unArchiveWithPath:(NSString *)path {
    id array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"%@", array);
}
/* 文件归档 */
- (void)fileArchive {
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"Job", @"YOb", @"Kobr", nil];
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archive = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    //编码
    [archive encodeObject:array forKey:@"array"];
    [archive encodeObject:@"Json" forKey:@"name"];
    
    //编码之后  对象已经存储到data之中
    [archive finishEncoding];
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = documents.firstObject;
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"array.plist"];
    BOOL success = [data writeToFile:filePath atomically:YES];
    NSLog(@"%d", success);
    
    [self fileUnArchiveWithPath:filePath];
    
}
- (void)fileUnArchiveWithPath:(NSString *)path {
    id oringlArray = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"%@", oringlArray);
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSKeyedUnarchiver *unArchive = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    NSArray *array = [unArchive decodeObjectForKey:@"array"];
    NSString *name = [unArchive decodeObjectForKey:@"name"];
    NSLog(@"%@, %@", array, name);
}

/* 自定义对象归档 */
- (void)customObjecArchive {
    Person *person = [Person new];
    person.name = @"Jsonss";
    person.age = 15;
    person.gender = @"男";
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = documents.firstObject;
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"person.plist"];
    BOOL success = [NSKeyedArchiver archiveRootObject:person toFile:filePath];
    NSLog(@"%d", success);
    
    Person *per = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"%@", per);
    
}

/* 自定义对象之利用runtime自动归档 */
- (void)customObjecArchiveByRuntime {
    BeautifulGirl *girl = [BeautifulGirl new];
    girl.name = @"合适";
    girl.age = 21;
    girl.phone = @"11223344";
    girl.address = @"MyHome";
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = documents.firstObject;
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"beautifulGirl.plist"];
    BOOL success = [NSKeyedArchiver archiveRootObject:girl toFile:filePath];
    NSLog(@"%d", success);
    
    BeautifulGirl *aGirl = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"%@", aGirl);
}

@end
