# ZYDropDownList
Represents a control that allows the user to select a single item from a drop-down list.
一个让用户从下拉框中选取单个选项的控件.

![image](https://github.com/zhiyuanFan/ZYDropDownList/raw/master/Demo.gif)


使用方法:
[[ZYDropDownList alloc] initWithFrame:CGRectMake(x, y, width, height)];

代理属性: delegate

代理方法:

*方法名:
```
- (void)dropDownList:(ZYDropDownList *)dropDownList didSelectItem:(ZYListItem *)selectedItem;
```
*描述:
该方法在选择下拉框中的item时触发.

数据源: listItemArray , 存放ZYListItem类型的数组

