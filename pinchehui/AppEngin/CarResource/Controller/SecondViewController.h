//
//  SecondViewController.h
//  ChatDemo-UI2.0
//
//  Created by mac on 14-10-13.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarCell.h"
#import "CarDetailInfoController.h"

@interface SecondViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIPopoverControllerDelegate>
{
    UITableView * typeTableView;
    BOOL isTypeTableViewShow;
}
@property (strong, nonatomic) UIButton * typeButton;  //类型
@property (strong, nonatomic) UIButton * brandButton; //品牌
@property (strong, nonatomic) UIButton * priceButton; //价格
@property (strong, nonatomic) UIButton * moreButton;  //更多


@property (strong, nonatomic) UITableView * carListTableView; //车源列表 tableView

@end
