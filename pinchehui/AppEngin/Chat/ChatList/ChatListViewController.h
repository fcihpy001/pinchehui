/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ChatListViewController : BaseViewController

@property (strong, nonatomic) UITableView           *tableView;
@property (strong, nonatomic) NSMutableArray * dataArray;
@property (strong, nonatomic) NSMutableArray * idArray;
@property (strong, nonatomic) NSMutableArray * chatterOrGroupArray; //标记当前是好友还是群组

- (void)refreshDataSource;

- (void)networkChanged:(EMConnectionState)connectionState;

@end
