//
//  ListDropView.m
//  ListDropProject
//
//  Created by SunShine on 16/7/29.
//  Copyright © 2016年 SunShuai. All rights reserved.
//

#import "ListDropView.h"

#define BackColor [UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:244.0f/255.0f alpha:1.0]

typedef enum tableViewType{
    LEFT_TABLEVIEW = 102,
    RIGHT_TABLEVIEW,
    SINGLE_TABLEVIEW
}TableViewType;

@interface ListDropView ()
{
    UITableView *_leftTableView;
    UITableView *_rightTableView;
    UIView *_backGroundView;
    UITableView *_singleTableView;
    UIButton *_abreastBtn;
    UIButton *_singleBtn;
    BOOL _abreast;
    BOOL _single;
    BOOL _abreastShow;
    BOOL _singleShow;
    BOOL _backViewShow;
    BOOL _layoutFirst;
    UIButton *_isCommonBtn;//判断两次点击的button是否是同一个button，用于backView的动画效果
}
@end

@implementation ListDropView

- (id)initWithTwoDropListSuperView:(UIView *)superView
{
    return [self initWithDropListSuperView:superView abreast:YES single:YES];
}

- (id)initWithAbreastDropListSuperView:(UIView *)superView
{
    return [self initWithDropListSuperView:superView abreast:YES single:NO];
}

- (id)initWithSigleDropListSuperView:(UIView *)superView
{
    return [self initWithDropListSuperView:superView abreast:NO single:YES];
}

- (id)initWithDropListSuperView:(UIView *)superView
                        abreast:(BOOL)abreast
                         single:(BOOL)single
{
    self = [super initWithFrame:CGRectMake(0, 20, CGRectGetWidth(superView.frame), CGRectGetHeight(superView.frame) - 20)];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [superView addSubview:self];
        _abreast = abreast;
        _single = single;
        [self setUpBackGroundView];
        if (abreast) {
            [self setUpLeftTableView];
            [self setUpRightTableView];
            [self setUpAbreastBtnWithSuperView];
        }
        if (single) {
            [self setUpSingleTableView];
            [self setUpSingleBtnWithSuperView];
        }
    }
    return self;
}

- (void)setUpBackGroundView
{
    _backGroundView = [[UIView alloc] init];
    _backGroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backViewShowOrHide)];
    [_backGroundView addGestureRecognizer:tapGesture];
    [self addSubview:_backGroundView];
}

- (void)setUpLeftTableView
{
    _leftTableView = [[UITableView alloc] init];
    _leftTableView.backgroundColor = [UIColor whiteColor];
    _leftTableView.tag = LEFT_TABLEVIEW;
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_leftTableView];
}

- (void)setUpRightTableView
{
    _rightTableView = [[UITableView alloc] init];
    _rightTableView.backgroundColor = [UIColor whiteColor];
    _rightTableView.tag = RIGHT_TABLEVIEW;
    _rightTableView.delegate = self;
    _rightTableView.dataSource = self;
    _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_rightTableView];
}

- (void)setUpSingleTableView
{
    _singleTableView = [[UITableView alloc] init];
    _singleTableView.backgroundColor = [UIColor whiteColor];
    _singleTableView.tag = SINGLE_TABLEVIEW;
    _singleTableView.delegate = self;
    _singleTableView.dataSource = self;
    _singleTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_singleTableView];
}

- (void)setUpAbreastBtnWithSuperView
{
    _abreastBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _abreastBtn.layer.cornerRadius = 10;
    [_abreastBtn setTitle:@"并排" forState:UIControlStateNormal];
    [_abreastBtn addTarget:self action:@selector(showOrHideAbreastView:) forControlEvents:UIControlEventTouchUpInside];
    _abreastBtn.layer.borderWidth = 0.5;
    [self addSubview:_abreastBtn];
}

- (void)setUpSingleBtnWithSuperView
{
    _singleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_singleBtn addTarget:self action:@selector(showOrHideSingleView:) forControlEvents:UIControlEventTouchUpInside];
    [_singleBtn setTitle:@"单排" forState:UIControlStateNormal];
    _singleBtn.layer.cornerRadius = 10;
    _singleBtn.layer.borderWidth = 0.5;
    [self addSubview:_singleBtn];
}

- (void)showOrHideAbreastView:(UIButton *)btn
{
    [self clickBtnBackViewShowOrHide:btn];
    if (_singleShow) {
        [self singleHide];
    }
    if (!_abreastShow && _backViewShow) {
        [self abreastShow];
        return;
    }
    [self abreastHide];
}

- (void)showOrHideSingleView:(UIButton *)btn
{
    [self clickBtnBackViewShowOrHide:btn];
    if (_abreastShow) {
        [self abreastHide];
    }
    if (!_singleShow && _backViewShow) {
        [self singleShow];
        return;
    }
    [self singleHide];
}

- (void)clickBtnBackViewShowOrHide:(UIButton *)btn
{
    if (!_backViewShow) {
        [self backViewShow];
    } else if (_isCommonBtn == btn) {
        [self backViewHide];
    }
    _isCommonBtn = btn;
}

- (void)backViewShowOrHide
{
    if (!_backViewShow) {
        [self backViewShow];
        return;
    }
    [self backViewHide];
}

- (void)layoutSubviews
{
    CGFloat scale = 3;
    CGFloat leftWidth = CGRectGetWidth(self.frame) / scale;
    CGFloat rightWidth = leftWidth * 2;
    _abreastBtn.frame = _abreastBtn.frame = _single ? CGRectMake(0, 0, CGRectGetWidth(self.frame) / 2, 30) : CGRectMake(0, 0, CGRectGetWidth(self.frame), 30);
    _singleBtn.frame = _abreast ? CGRectMake(CGRectGetMaxX(_abreastBtn.frame), 0, CGRectGetWidth(_abreastBtn.frame), 30) : CGRectMake(0, 0, CGRectGetWidth(self.frame), 30);
    if (!_layoutFirst) {
        _backGroundView.frame = CGRectMake(0, 30, CGRectGetWidth(self.frame), 0);
        _leftTableView.frame = CGRectMake(0, 30, leftWidth, 0);
        _rightTableView.frame = CGRectMake(leftWidth, CGRectGetMinY(_leftTableView.frame), rightWidth, 0);
        _singleTableView.frame = CGRectMake(0, 30, CGRectGetWidth(_backGroundView.frame), 0);
        _layoutFirst = YES;
    }
    
}

- (void)abreastShow
{
    [UIView animateWithDuration:0.3 animations:^{
        _leftTableView.frame = CGRectMake(CGRectGetMinX(_leftTableView.frame), CGRectGetMinY(_leftTableView.frame), CGRectGetWidth(_leftTableView.frame), 220);
        _rightTableView.frame = CGRectMake(CGRectGetMinX(_rightTableView.frame), CGRectGetMinY(_rightTableView.frame), CGRectGetWidth(_rightTableView.frame), 220);
    }];
    _abreastShow = YES;
}

- (void)abreastHide
{
    [UIView animateWithDuration:0.3 animations:^{
        _leftTableView.frame = CGRectMake(CGRectGetMinX(_leftTableView.frame), CGRectGetMinY(_leftTableView.frame), CGRectGetWidth(_leftTableView.frame), 0);
        _rightTableView.frame = CGRectMake(CGRectGetMinX(_rightTableView.frame), CGRectGetMinY(_rightTableView.frame), CGRectGetWidth(_rightTableView.frame), 0);
    }];
    _abreastShow = NO;
}

- (void)singleShow
{
    [UIView animateWithDuration:0.3 animations:^{
        _singleTableView.frame = CGRectMake(CGRectGetMinX(_singleTableView.frame), CGRectGetMinY(_singleTableView.frame), CGRectGetWidth(_singleTableView.frame), 220);
    }];
    _singleShow = YES;
}

- (void)singleHide
{
    [UIView animateWithDuration:0.3 animations:^{
        _singleTableView.frame = CGRectMake(CGRectGetMinX(_singleTableView.frame), CGRectGetMinY(_singleTableView.frame), CGRectGetWidth(_singleTableView.frame), 0);
    }];
    _singleShow = NO;
}

- (void)backViewShow
{
    [UIView animateWithDuration:0.3 animations:^{
        _backGroundView.frame = CGRectMake(0, 30, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - 30);
    }];
    _backViewShow = YES;
}

- (void)backViewHide
{
    [UIView animateWithDuration:0.3 animations:^{
        _backGroundView.frame = CGRectMake(0, 30, CGRectGetWidth(self.frame), 0);
    }];
    _backViewShow = NO;
    if (_abreastShow) {
        [self abreastHide];
    }
    if (_singleShow) {
        [self singleHide];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (tableView.tag) {
        case LEFT_TABLEVIEW:
        {
            if (_dataSource && [_dataSource respondsToSelector:@selector(LeftTableViewNumberOfRowsInSection:)]) {
                return [_dataSource LeftTableViewNumberOfRowsInSection:section];
            }
            return 0;
        }
            break;
        case RIGHT_TABLEVIEW:
        {
            if (_dataSource && [_dataSource respondsToSelector:@selector(RightTableViewNumberOfRowsInSection:)]) {
                return [_dataSource RightTableViewNumberOfRowsInSection:section];
            }
            return 0;
        }
            break;
        case SINGLE_TABLEVIEW:
        {
            if (_dataSource && [_dataSource respondsToSelector:@selector(SingleTableViewNumberOfRowsInSection:)]) {
                return [_dataSource SingleTableViewNumberOfRowsInSection:section];
            }
            return 0;
        }
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    switch (tableView.tag) {
        case LEFT_TABLEVIEW:
        {
            if (_dataSource && [_dataSource respondsToSelector:@selector(leftTableView:cellForRowAtIndexPath:)]) {
                cell  = [_dataSource leftTableView:tableView cellForRowAtIndexPath:indexPath];
                cell.backgroundColor = BackColor;
            }
            return cell;
        }
            break;
        case RIGHT_TABLEVIEW:
        {
            if (_dataSource && [_dataSource respondsToSelector:@selector(rightTableView:cellForRowAtIndexPath:)]) {
                cell = [_dataSource rightTableView:tableView cellForRowAtIndexPath:indexPath];
                cell.backgroundColor = BackColor;
            }
            return cell;
        }
            break;
        case SINGLE_TABLEVIEW:
        {
            if (_dataSource && [_dataSource respondsToSelector:@selector(singleTableView:cellForRowAtIndexPath:)]) {
                cell = [_dataSource singleTableView:tableView cellForRowAtIndexPath:indexPath];
                cell.backgroundColor = BackColor;
            }
            return cell;
        }
            break;
        default:
            return nil;
            break;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (tableView.tag) {
        case LEFT_TABLEVIEW:
        {
            if (_delegate && [_delegate respondsToSelector:@selector(leftTableView:heightForRowAtIndexPath:)]) {
                return [_delegate leftTableView:tableView heightForRowAtIndexPath:indexPath];
            }
            return 0;
        }
            break;
        case RIGHT_TABLEVIEW:
        {
            if (_delegate && [_delegate respondsToSelector:@selector(rightTableView:heightForRowAtIndexPath:)]) {
                return [_delegate rightTableView:tableView heightForRowAtIndexPath:indexPath];
            }
            return 0;

        }
            break;
        case SINGLE_TABLEVIEW:
        {
            if (_delegate && [_delegate respondsToSelector:@selector(singleTableView:heightForRowAtIndexPath:)]) {
                return [_delegate singleTableView:tableView heightForRowAtIndexPath:indexPath];
            }
            return 0;

        }
            break;
        default:
            return 0;
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (tableView.tag) {
        case LEFT_TABLEVIEW:
        {
            if (_delegate && [_delegate respondsToSelector:@selector(leftTableView:didSelectRowAtIndexPath:)]) {
                [_delegate leftTableView:tableView didSelectRowAtIndexPath:indexPath];
            }
        }
            break;
        case RIGHT_TABLEVIEW:
        {
            if (_delegate && [_delegate respondsToSelector:@selector(rightTableView:didSelectRowAtIndexPath:)]) {
                [_delegate rightTableView:tableView didSelectRowAtIndexPath:indexPath];
                [self backViewHide];
            }
        }
            break;
        case SINGLE_TABLEVIEW:
        {
            if (_delegate && [_delegate respondsToSelector:@selector(singleTableView:didSelectRowAtIndexPath:)]) {
                [_delegate singleTableView:tableView didSelectRowAtIndexPath:indexPath];
                [self backViewHide];
            }
        }
            break;
        default:
            break;
    }
    
}

- (void)reloadRightTableView
{
    [_rightTableView reloadData];
}

- (void)setAbreastBtnTitle:(NSString *)str
{
    [_abreastBtn setTitle:str forState:UIControlStateNormal];
}

- (void)setSingleBtnTitle:(NSString *)str
{
    [_singleBtn setTitle:str forState:UIControlStateNormal];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
