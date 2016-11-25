//
//  ViewController.m
//  ZYDropDownListDemo
//
//  Created by 樊志远 on 2016/11/24.
//  Copyright © 2016年 fzy. All rights reserved.
//

#import "ViewController.h"
#import "ZYDropDownList.h"
#import "ZYListItem.h"

@interface ViewController ()<ZYDropDownListDelegate>
{
    ZYDropDownList *_ddlist;
    UILabel *_selectedLabel;
}

/** dataArray */
@property (nonatomic , strong) NSMutableArray *dataArray;


@end

static NSInteger itemIndex = 0;
@implementation ViewController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _ddlist = [[ZYDropDownList alloc] initWithFrame:CGRectMake(50, 110, 200, 30)];
    _ddlist.delegate = self;
    [self.view addSubview:_ddlist];
    
    UIButton *addItemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addItemBtn.frame = CGRectMake(270, 110, 100, 30);
    [addItemBtn setBackgroundColor:[UIColor orangeColor]];
    [addItemBtn setTitle:@"添加Item" forState:UIControlStateNormal];
    [addItemBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addItemBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [addItemBtn addTarget:self action:@selector(addItemBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addItemBtn];
    
    _selectedLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 190, 300, 30)];
    _selectedLabel.text = @"请选择Item";
    [self.view addSubview:_selectedLabel];
}

- (void)addItemBtnOnClick {
    ZYListItem *item = [[ZYListItem alloc] init];
    item.itemKey = itemIndex;
    item.itemValue = [NSString stringWithFormat:@"item %zd",itemIndex];
    [self.dataArray addObject:item];
    itemIndex ++;
    _ddlist.listItemArray = self.dataArray;
}


#pragma mark - ZYDropDownListDelegate
- (void)dropDownList:(ZYDropDownList *)dropDownList didSelectItem:(ZYListItem *)selectedItem {
    NSLog(@"selectedKey : %zd , selectedValue : %@",selectedItem.itemKey,selectedItem.itemValue);
    _selectedLabel.text = [NSString stringWithFormat:@"selectedKey : %zd , selectedValue : %@",selectedItem.itemKey,selectedItem.itemValue];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
