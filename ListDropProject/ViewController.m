//
//  ViewController.m
//  ListDropProject
//
//  Created by SunShine on 16/7/29.
//  Copyright © 2016年 SunShuai. All rights reserved.
//

#import "ViewController.h"
#import "ListDropView.h"

#define VIEW_WIDTH     CGRectGetWidth(self.view.bounds)
#define VIEW_HEIGHT    CGRectGetHeight(self.view.bounds)

@interface ViewController ()<ListDropDelegate,ListDropDataSource>
{
    NSDictionary *_dic;
    NSArray *_rightArr;
    NSArray *_singleArr;
    ListDropView *_dropView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _dropView = [[ListDropView alloc] initWithTwoDropListSuperView:self.view];
    _dropView.delegate = self;
    _dropView.dataSource = self;
    
    NSArray *food = @[@"全部美食", @"火锅", @"川菜", @"西餐", @"自助餐"];
    NSArray *travel = @[@"全部旅游", @"周边游", @"景点门票", @"国内游", @"境外游"];
    _dic = [NSDictionary dictionaryWithObjectsAndKeys:food,@"美食",travel,@"旅游", nil];
    _singleArr = @[@"智能排序", @"离我最近", @"评价最高", @"最新发布", @"人气最高", @"价格最低", @"价格最高"];
    
    
}

- (NSInteger)LeftTableViewNumberOfRowsInSection:(NSInteger)section
{
    return [[_dic allKeys] count];
}

- (NSInteger)RightTableViewNumberOfRowsInSection:(NSInteger)section
{
    return [_rightArr count];
}

- (NSInteger)SingleTableViewNumberOfRowsInSection:(NSInteger)section
{
    return [_singleArr count];
}

- (UITableViewCell *)leftTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuse = @"left";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    cell.textLabel.text = [[_dic allKeys] objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (UITableViewCell *)rightTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuse = @"right";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    cell.textLabel.text = [_rightArr objectAtIndex:indexPath.row];
    return cell;
}

- (UITableViewCell *)singleTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuse = @"single";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    cell.textLabel.text = [_singleArr objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (CGFloat)leftTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

- (CGFloat)rightTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;

}

- (CGFloat)singleTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    return 35;

}

- (void)leftTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *keyArr = [_dic allKeys];
    _rightArr = [_dic objectForKey:[keyArr objectAtIndex:indexPath.row]];
    [_dropView reloadRightTableView];
}

- (void)rightTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = [_rightArr objectAtIndex:indexPath.row];
    NSLog(@"----------%@",title);
    [_dropView setAbreastBtnTitle:title];
    
}

- (void)singleTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = [_singleArr objectAtIndex:indexPath.row];
    NSLog(@"----------%@",title);
    [_dropView setSingleBtnTitle:title];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
