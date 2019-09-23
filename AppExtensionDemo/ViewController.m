//
//  ViewController.m
//  AppExtensionDemo
//
//  Created by linwei on 2019/9/11.
//  Copyright © 2019 linwei. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) NSArray *dataArray;
@property (nonatomic , strong) NSArray *controllerArray;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *mySharedDefaults = [[NSUserDefaults alloc] initWithSuiteName: @"com.bonc.appextension.TodayExtension"];
    [mySharedDefaults setObject:@"林伟" forKey:@"userName"];
    [mySharedDefaults synchronize];
    self.navigationItem.title = @"首页";
    [self.view addSubview:self.tableView];
    
    // Do any additional setup after loading the view.
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}
- (NSArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = @[@"通知"];
    }
    return _dataArray;
}
- (NSArray *)controllerArray{
    if (_controllerArray == nil) {
        _controllerArray = @[@"Notification"];
    }
    return _controllerArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


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
    NSString * className = [NSString stringWithFormat:@"LW%@ViewController", self.controllerArray [indexPath.row]];
    
    Class aVCClass = NSClassFromString(className);
    //创建vc对象
    UIViewController * vc = [[aVCClass alloc] init];
    //推出vc
    [self.navigationController pushViewController:vc animated:YES];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
@end
