//
//  ZYDropDownList.h
//  ZYDropDownListDemo
//
//  Created by 樊志远 on 2016/11/24.
//  Copyright © 2016年 fzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZYListItem,ZYDropDownList;

@protocol ZYDropDownListDelegate <NSObject>

- (void)dropDownList:(ZYDropDownList *)dropDownList didSelectItem:(ZYListItem *)selectedItem;

@end

@interface ZYDropDownList : UIView

/** listItemArray */
@property (nonatomic , strong) NSArray<ZYListItem *> *listItemArray;

/** delegate */
@property (nonatomic , weak) id<ZYDropDownListDelegate> delegate;



@end
