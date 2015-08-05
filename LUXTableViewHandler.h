//
//  LUXTableViewHandler.h
//  LUXTableView
//
//  Created by 鲁鑫 on 7/30/15.
//  Copyright (c) 2015 luxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol LUXTableViewDataSourceProtocol <NSObject>

- (void)configureCellDataWithModel:(id)Model;

@end

typedef void(^displayCellDataBlock)(UITableViewCell *cell, id model);
typedef void(^tableViewSelectedBlock)(UITableView *tableView,NSIndexPath *indexPath, id model);
typedef UIView *(^configureSectionHeaderViewBlock)(NSInteger section, id model);

@interface LUXTableViewHandler : NSObject<UITableViewDataSource, UITableViewDelegate>
/**
 *  (DEBUG专用)行数
 */
@property (nonatomic, assign) NSInteger rowNum;
/**
 *  tableView
 */
@property (nonatomic, weak) UITableView *tableView;
/**
 *  如果是通过xib初始化，这个值可以在xib中进行设置
 */
@property (nonatomic, copy) IBInspectable NSString *cellIdentifier;
//这两个需要同时设置(如果allowManySections=YES的话)
/**
 *  是否允许多section，默认为NO
 */
@property (nonatomic, assign) BOOL allowManySections;
/**
 *  二级数组的名字
 */
@property (nonatomic, copy) NSString *secLevelArrName;
/**
 *  行高
 */
@property (nonatomic, assign) CGFloat rowHeight;
/**
 *  sectionHeader的高度
 */
@property (nonatomic, assign) CGFloat sectionHeaderHeight;
/**
 *  自定义sectionHeaderView
 *  UIView *(^configureSectionHeaderViewBlock)(NSInteger section, id model)
 */
@property (nonatomic, strong) configureSectionHeaderViewBlock configureSectionHeaderView;
/**
 *  显示数据的方法
 *  void(^displayCellDataBlock)(UITableViewCell *cell, id model)
 */
@property (nonatomic, strong) displayCellDataBlock displayCellData;
/**
 *  处理cell的点击事件
 *  void(^tableViewSelectedBlock)(UITableView *tableView,NSIndexPath *indexPath, id model)
 */
@property (nonatomic, strong) tableViewSelectedBlock selectedBlock;

/**
 *  初始化方法
 *
 *  @param tableView tableview
 *
 *  @return handler实例
 */
- (instancetype)initWithTableView:(UITableView *)tableView;
/**
 *  新增元素
 *
 *  @param itemsArr 数组
 */
- (void)addItemsWithArr:(NSArray *)itemsArr;

/**
 *  重新加载元素
 *
 *  @param itemsArr 数组
 */
- (void)reloadItemsWithArr:(NSArray *)itemsArr;

@end
