//
//  ThirdViewController.h
//  ChatDemo-UI2.0
//
//  Created by mac on 14-10-13.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatListViewController.h"
#import "ContactsViewController.h"

@interface ThirdViewController : UIViewController

@property (strong, nonatomic) UIButton * chatListButton;
@property (strong, nonatomic) UIButton * friendListButton;
@property (strong, nonatomic) UIView * chatFriendListView; //选中聊天记录列表或者好友列表时，该view滑动到对应下面
@property (strong, nonatomic) ChatListViewController *chatListVC;
@property (strong, nonatomic) ContactsViewController *contactsVC;

@property (strong, nonatomic) UIView * rightBarView;
@property (strong, nonatomic) UITapGestureRecognizer * tapGesture;
- (void)jumpToChatList;

//- (void)setupUntreatedApplyCount;

@end
