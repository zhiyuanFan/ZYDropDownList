//
//  ZYDropDownList.m
//  ZYDropDownListDemo
//
//  Created by 樊志远 on 2016/11/24.
//  Copyright © 2016年 fzy. All rights reserved.
//

#import "ZYDropDownList.h"
#import "ZYListItem.h"

@interface ZYDropDownList()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITextField *_txtField;
}

/** tableView */
@property (nonatomic , strong) UITableView *listTableView;


@end

static NSString *cellId = @"reuseCell";
static CGFloat cellHeight = 40;
@implementation ZYDropDownList

- (UITableView *)listTableView {
    if (!_listTableView) {
        _listTableView = [[UITableView alloc] init];
        
        _listTableView.layer.borderWidth = 1;
        _listTableView.layer.backgroundColor = [UIColor blackColor].CGColor;
        
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        _listTableView.tableFooterView = [[UIView alloc] init];
        [_listTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    }
    return _listTableView;
}

- (void)setListItemArray:(NSArray<ZYListItem *> *)listItemArray {
    _listItemArray = listItemArray;
    [_listTableView reloadData];
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    
    CGFloat imageWH = self.bounds.size.height;
    NSLog(@"imageWH : %f",imageWH);
    
    _txtField = [[UITextField alloc] initWithFrame:self.bounds];
    _txtField.delegate = self;
    _txtField.placeholder = @"--请选择--";
    _txtField.backgroundColor = [UIColor clearColor];
    
    UIView *paddingLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, imageWH, imageWH)];
    _txtField.leftView = paddingLeftView;
    _txtField.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *paddingRightView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageWH, imageWH)];
    paddingRightView.image = [UIImage imageNamed:@"downArrow"];

    _txtField.rightView = paddingRightView;
    _txtField.rightViewMode = UITextFieldViewModeAlways;
    
    _txtField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _txtField.layer.borderWidth = 1;
    
    [self addSubview:_txtField];
}

#pragma mark - Text Field Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {

    [_txtField resignFirstResponder];
    NSLog(@"view frame : %@",NSStringFromCGRect(self.frame));
    NSInteger cellCount = self.listItemArray.count > 5 ? 5 : self.listItemArray.count;
    CGFloat tableViewX = self.frame.origin.x;
    CGFloat tableViewY = self.frame.origin.y  + self.frame.size.height;
    CGFloat tableViewWidth = self.frame.size.width;
    CGFloat tableViewHeight = cellHeight * cellCount == 0 ? 50 : cellHeight * cellCount;
    
    self.listTableView.frame = CGRectMake(tableViewX, tableViewY, tableViewWidth, tableViewHeight);
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (![window.subviews containsObject:self.listTableView]) {
        [window addSubview:self.listTableView];
    } else {
        [self.listTableView removeFromSuperview];
    }
}

#pragma mark - Table View Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listItemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    ZYListItem *item = self.listItemArray[indexPath.row];
    cell.textLabel.text = item.itemValue;
    return cell;
    
}

#pragma mark - Table View Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZYListItem *item = self.listItemArray[indexPath.row];
    _txtField.text = item.itemValue;
    if ([self.delegate respondsToSelector:@selector(dropDownList:didSelectItem:)]) {
        [self.delegate dropDownList:self didSelectItem:item];
    }
    [self.listTableView removeFromSuperview];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)dealloc {
    NSLog(@"delloc");
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if ([window.subviews containsObject:self.listTableView]) {
        [self.listTableView removeFromSuperview];
    }
}

@end
