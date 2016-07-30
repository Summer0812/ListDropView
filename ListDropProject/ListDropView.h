//
//  ListDropView.h
//  ListDropProject
//
//  Created by SunShine on 16/7/29.
//  Copyright © 2016年 SunShuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ListDropDelegate <NSObject>

- (CGFloat)leftTableView:(UITableView *)tableView
 heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)rightTableView:(UITableView *)tableView
  heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)singleTableView:(UITableView *)tableView
   heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)leftTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)rightTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)singleTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol ListDropDataSource <NSObject>

- (NSInteger)LeftTableViewNumberOfRowsInSection:(NSInteger)section;

- (NSInteger)RightTableViewNumberOfRowsInSection:(NSInteger)section;

- (NSInteger)SingleTableViewNumberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)leftTableView:(UITableView *)tableView
             cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (UITableViewCell *)rightTableView:(UITableView *)tableView
              cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (UITableViewCell *)singleTableView:(UITableView *)tableView
               cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface ListDropView : UIView<UITableViewDelegate,UITableViewDataSource>

- (id)initWithTwoDropListSuperView:(UIView *)superView;

- (id)initWithAbreastDropListSuperView:(UIView *)superView;

- (id)initWithSigleDropListSuperView:(UIView *)superView;

- (void)reloadRightTableView;

- (void)setAbreastBtnTitle:(NSString *)str;

- (void)setSingleBtnTitle:(NSString *)str;

@property (nonatomic,weak) id<ListDropDataSource> dataSource;
@property (nonatomic,weak) id<ListDropDelegate> delegate;

@end
