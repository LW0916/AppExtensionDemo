//
//  TodayViewController.m
//  TodayExtension
//
//  Created by linwei on 2019/9/11.
//  Copyright © 2019 linwei. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) NSArray *dataArray;
@end

@implementation TodayViewController
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}
- (NSArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = @[@"列表1",@"列表2",@"列表3",@"列表4",@"列表5",@"列表6",@"列表7",@"列表8"];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 将小部件展现模型设置为可展开
    if (@available(iOS 10.0, *)) {
        self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
    } else {
        // Fallback on earlier versions
    }
    [self.view addSubview:self.tableView];

    // Do any additional setup after loading the view.
}
#pragma mrak -UITableViewDelegate&UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //点击某一行后 让颜色变回来
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *title = self.dataArray[indexPath.row];
    NSString *urlString = [NSString stringWithFormat:@"TodayExtensionDemo://today?title=%@",title];
    NSString*urlStringEncoding = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    [self.extensionContext openURL:[NSURL URLWithString:urlStringEncoding] completionHandler:nil];

}
#pragma mark -NCWidgetProviding
- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (int i=0 ; i<8; i++) {
        int x = arc4random() % 100;
        NSString *userName = [[[NSUserDefaults alloc] initWithSuiteName:@"com.bonc.appextension.TodayExtension"] valueForKey:@"userName"];
        NSString *str = [NSString stringWithFormat:@"%@ 列表%d",userName,x];
        [array addObject:str];
    }
    self.dataArray =array;
    [self.tableView reloadData];
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
    
    completionHandler(NCUpdateResultNewData);
}
#define NewHeight 400
- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize  API_AVAILABLE(ios(10.0)){
    if (@available(iOS 10.0, *)) {
        if (activeDisplayMode == NCWidgetDisplayModeExpanded) {
            // 设置展开的新高度
            self.preferredContentSize = CGSizeMake(0, NewHeight);
        }else{
            self.preferredContentSize = maxSize;
        }
    } else {
        
    }
}
@end
