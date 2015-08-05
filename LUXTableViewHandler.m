//
//  LUXTableViewHandler.m
//  LUXTableView
//
//  Created by 鲁鑫 on 7/30/15.
//  Copyright (c) 2015 luxin. All rights reserved.
//

#import "LUXTableViewHandler.h"

@interface LUXTableViewHandler()



@property (nonatomic, strong) NSMutableArray *itemsArr;
@end

@implementation LUXTableViewHandler

- (instancetype)init{
    self = [super init];
    if (self) {
        self.allowManySections = NO;
    }
    return self;
}

- (instancetype)initWithTableView:(UITableView *)tableView {
    self = [self init];
    if (self) {
        self.tableView = tableView;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.allowManySections = NO;
    }
    return self;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (!self.allowManySections) {
        return 1;
    }
    return self.itemsArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.rowNum) {
        return self.rowNum;
    }else{
        if (!self.allowManySections) {
            return self.itemsArr.count;
        }
    }
    return [[self.itemsArr[section] valueForKey:self.secLevelArrName] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (self.cellIdentifier) {
       cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    }else{
        cell = [[UITableViewCell alloc] init];
    }
    
    id model = [self modelsAtIndexPath:indexPath];
    if (!self.displayCellData) {
        if ([cell respondsToSelector:@selector(configureCellDataWithModel:)]) {
            [cell performSelector:@selector(configureCellDataWithModel:) withObject:model];
        }
    }else{
        self.displayCellData(cell, model);
    }
    
    return cell;
}


//optional
//UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.rowHeight) {
        return 44;
    }
    return self.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (!self.sectionHeaderHeight) {
        return 0;
    }
    return self.sectionHeaderHeight;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (!self.configureSectionHeaderView) {
        return nil;
    }
    return self.configureSectionHeaderView(section, self.itemsArr[section]);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!self.selectedBlock) {
        return;
    }
    if (self.allowManySections) {
        self.selectedBlock(tableView ,indexPath ,[self.itemsArr[indexPath.section] valueForKey:self.secLevelArrName][indexPath.row]);
    }else{
        self.selectedBlock(tableView ,indexPath , self.itemsArr[indexPath.row]);
    }
}



- (void)addItemsWithArr:(NSArray *)itemsArr {
    if (itemsArr==nil) {
        return;
    }
    [self.itemsArr addObjectsFromArray:itemsArr];
    [self.tableView reloadData];
}


- (void)reloadItemsWithArr:(NSArray *)itemsArr {
    if (itemsArr==nil) {
        return;
    }
    self.itemsArr = [itemsArr mutableCopy];
    [self.tableView reloadData];
}

- (NSMutableArray *)itemsArr{
    if (_itemsArr == nil) {
        _itemsArr = [NSMutableArray array];
    }
    return _itemsArr;
}

- (id)modelsAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.allowManySections) {
        return self.itemsArr[indexPath.row];
    }
    return [self.itemsArr[indexPath.section] valueForKey:self.secLevelArrName][indexPath.row];
}



@end
