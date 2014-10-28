//
//  PhoneListAddFriendViewController.h
//  车商官家
//
//  Created by mac on 14-10-21.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhoneListAddFriendViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * firstNameArray;
    NSMutableArray * lastNameArray;
    NSMutableArray * phoneNumberArray;
}
@property (strong, nonatomic) UITableView * mainTableView;
@end
