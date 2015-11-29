//
//  ViewController.m
//  NewsCommentLayout
//
//  Created by xiaohaibo on 11/29/15.
//  Copyright © 2015 xiaohaibo. All rights reserved.
//

#import "ViewController.h"
#import "CommentTableViewCell.h"
#import "LayoutContainerView.h"
#import "CommentModel.h"
@interface ViewController ()<UITableViewDataSource ,UITableViewDelegate>
{
    NSMutableArray *_dataSource;
    UITableView    *_tableview;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /*说明：从网易客服端获取的json，为测试用，做了编辑*/
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"json"];
    
    NSData *jsonData = [NSData dataWithContentsOfFile:path options:NSDataReadingMappedIfSafe error:nil];
    
    NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    _dataSource = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dic in dict[@"hotPosts"]) {
        NSMutableArray *arr =[[NSMutableArray alloc] init];
        NSArray *allkey =[dic allKeys];
        NSArray *sortedArray= [allkey sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            
            NSNumber *number1 = [NSNumber numberWithInt:[obj1 intValue]];
            NSNumber *number2 = [NSNumber numberWithInt:[obj2 intValue]];
            
            NSComparisonResult result = [number1 compare:number2];
            
            return result == NSOrderedDescending; // 升序
            
        }];
        
        for (NSString *index in sortedArray) {
            NSDictionary *dict =dic[index];
            CommentModel *model =[[CommentModel alloc] initWithDic:dict];
            model.floor = index;
            [arr addObject:model];
        }
        
        [_dataSource addObject:arr];
    }
    
    
    
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableview.backgroundView = nil;
    if ([_tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableview setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    if ([_tableview respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableview setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableview];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LayoutContainerView * container =[[LayoutContainerView alloc] initWithModels:_dataSource[indexPath.row]];
    return container.frame.size.height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentTableViewCell * ce =[[CommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    ce.selectionStyle = UITableViewCellSelectionStyleNone;
    LayoutContainerView * container =[[LayoutContainerView alloc] initWithModels:_dataSource[indexPath.row]];
    [ce.contentView addSubview:container];
    return ce;
    
}
@end

