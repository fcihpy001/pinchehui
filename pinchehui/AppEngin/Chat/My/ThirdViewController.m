//
//  ThirdViewController.m
//  ChatDemo-UI2.0
//
//  Created by mac on 14-10-13.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "ThirdViewController.h"
#import "ChatListViewController.h"
#import "ContactsViewController.h"
#import "ChatViewController.h"
#import "ApplyViewController.h"
#import "CreateGroupViewController.h"
#import "AddFriendOfThirdViewController.h"



//两次提示的默认间隔
static const CGFloat kDefaultPlaySoundInterval = 3.0;

@interface ThirdViewController ()<IChatManagerDelegate>
{
    
}
@property (strong, nonatomic)NSDate *lastPlaySoundDate;
@property (nonatomic) int messageNumber;
@property (nonatomic) int applyNumber;

@end

@implementation ThirdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //获取未读消息数，此时并没有把self注册为SDK的delegate，读取出的未读数是上次退出程序时的
//    [self didUnreadMessagesCountChanged];
#warning 把self注册为SDK的delegate
    [self registerNotifications];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupUntreatedApplyCount) name:@"setupUntreatedApplyCount" object:nil];
    
    //最近联系人
    self.chatListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.chatListButton.frame = CGRectMake(0, 0, 160, 35);
    [self.chatListButton setTitle:@"最近联系人" forState:UIControlStateNormal];
    [self.chatListButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    [self.chatListButton setBackgroundColor:[UIColor yellowColor]];
    self.chatListButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.chatListButton addTarget:self action:@selector(showChatView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.chatListButton];
    //边框线
    [self createLineView:CGRectMake(159, 0, 0.5, 35)];
    
    //好友列表
    self.friendListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.friendListButton.frame = CGRectMake(160, 0, 160, 35);
    [self.friendListButton setTitle:@"我的好友" forState:UIControlStateNormal];
    [self.friendListButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.friendListButton addTarget:self action:@selector(showFriendView:) forControlEvents:UIControlEventTouchUpInside];
    self.friendListButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:self.friendListButton];
    
    self.chatFriendListView = [[UIView alloc]initWithFrame:CGRectMake(0, 32, 160, 3)];
    self.chatFriendListView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.chatFriendListView];
    
    
    //设置内容
    
    _chatListVC = [[ChatListViewController alloc] init];
    _chatListVC.view.frame = CGRectMake(0, 35, 320, 568-35);
    
    [self.view addSubview:_chatListVC.view];
    
    _contactsVC = [[ContactsViewController alloc] init];
    _contactsVC.view.frame = CGRectMake(0, 35, 320, 568-35);
    
    [self.view addSubview:_contactsVC.view];
    _contactsVC.view.hidden = YES;
    
    
    _rightBarView = [[UIView alloc]initWithFrame:CGRectMake(160+60, 0, 100, 44*3+2)];
    _rightBarView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_rightBarView];
    _rightBarView.hidden = YES;
    
    UIView * lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 44, 100, 1)];
    lineView1.backgroundColor = [UIColor whiteColor];
    [_rightBarView addSubview:lineView1];
    UIView * lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 89, 100, 1)];
    lineView2.backgroundColor = [UIColor whiteColor];
    [_rightBarView addSubview:lineView2];
    
    UIButton * firstButton = [self makeButtonWithFrame:CGRectMake(0, 0, 100, 44) AndTitle:@"添加好友" AndTag:1];
    UIButton * secondButton = [self makeButtonWithFrame:CGRectMake(0, 44, 100, 44) AndTitle:@"邀请好友" AndTag:2];
    UIButton * thirdButton = [self makeButtonWithFrame:CGRectMake(0, 88, 100, 44) AndTitle:@"发起群聊" AndTag:3];
    [_rightBarView addSubview:firstButton];
    [_rightBarView addSubview:secondButton];
    [_rightBarView addSubview:thirdButton];
    
    //点击屏幕，让_rightBarView.hidden = YES;
    _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    
//    [self setupUnreadMessageCount];
//    [self setupUntreatedApplyCount];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToChatView:) name:@"goToChatView" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToContactsView:) name:@"goToContactsView" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableViewData:) name:@"reloadTableViewData" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(goToApplyView:) name:@"pushApplyView" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(goToGroupView:) name:@"pushGroupView" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadApplyViewDataSource:) name:@"reloadApplyViewDataSource" object:nil];
    
}

- (void)tapGesture:(UITapGestureRecognizer *)tapGesture
{
    _rightBarView.hidden = YES;
    [self.view removeGestureRecognizer:tapGesture];
}

- (UIButton *)makeButtonWithFrame:(CGRect)frame AndTitle:(NSString *)title AndTag:(int)tagNumber
{
    
    UIButton * but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = frame;
    [but setTitle:title forState:UIControlStateNormal];
    [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    but.tag = tagNumber;
    but.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [but addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    return but;
}

- (void)clickButton:(UIButton *)sender
{
    switch (sender.tag) {
        case 1:
        {
            //添加好友
            _rightBarView.hidden = YES;
            AddFriendOfThirdViewController * addFriendView = [[AddFriendOfThirdViewController alloc]init];
            [self.navigationController pushViewController:addFriendView animated:YES];
        }
            break;
        case 2:
        {
            //邀请好友
            _rightBarView.hidden = YES;
            AddFriendOfThirdViewController * addFriendView = [[AddFriendOfThirdViewController alloc]init];
            [self.navigationController pushViewController:addFriendView animated:YES];
        }
            break;
        case 3:
        {
            //发起群聊
            _rightBarView.hidden = YES;
            CreateGroupViewController *createChatroom = [[CreateGroupViewController alloc] init];
            [self.navigationController pushViewController:createChatroom animated:YES];
        }
            break;
            
    }
}


- (void)reloadTableViewData:(NSNotification *)notification
{
    [self.chatListVC refreshDataSource];
}

- (void)reloadApplyViewDataSource:(NSNotification *)notification
{
    [self.contactsVC reloadApplyView];
}

//  好友列表中的申请与通知
- (void)goToApplyView:(NSNotification *)not
{
    [self.navigationController pushViewController:[ApplyViewController shareController] animated:YES];
}

//  好友列表中的群组
- (void)goToGroupView:(NSNotification *)not
{
    NSDictionary * dict = [not userInfo];
    [self.navigationController pushViewController:[dict valueForKey:@"groupView"] animated:YES];
}

//点击好友或者最近聊天列表的对话框，进入聊天页面
- (void)goToChatView:(NSNotification *)infomation
{
    
    NSDictionary * dict = [infomation userInfo];
    
    ChatViewController * chatController = [dict valueForKey:@"chatController"];
    chatController.title = [dict valueForKey:@"title"];    
    [self.navigationController pushViewController:chatController animated:YES];
    
}

- (void)goToContactsView:(NSNotification *)infomation
{
    NSDictionary * dict = [infomation userInfo];
    
    ChatViewController *chatVC = [dict valueForKey:@"chatVC"];
    chatVC.title = [dict valueForKey:@"title"];
    
    [self.navigationController pushViewController:chatVC animated:YES];
}

//最近联系人列表
- (void)showChatView:(UIButton *)sender
{
    if (self.rightBarView.hidden == NO) {
        self.rightBarView.hidden = YES;
        [self.view removeGestureRecognizer:self.tapGesture];
    }
    [self setChatFriendViewFrame:1];
    _chatListVC.view.hidden = NO;
    _contactsVC.view.hidden = YES;
}

//好友列表
- (void)showFriendView:(UIButton *)sender
{
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadApplyViewDataSource" object:nil userInfo:nil];
    [self.contactsVC reloadDataSource];
    [self.contactsVC reloadApplyView];
    [self.contactsVC reloadGroupView];
    if (self.rightBarView.hidden == NO) {
        self.rightBarView.hidden = YES;
        [self.view removeGestureRecognizer:self.tapGesture];
    }
    [self setChatFriendViewFrame:2];
    _chatListVC.view.hidden = YES;
    _contactsVC.view.hidden = NO;
}

- (void)createLineView:(CGRect)frame
{
    UIView * lineView = [[UIView alloc]initWithFrame:frame];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView];
}

- (void)setChatFriendViewFrame:(int)number
{
    if (number == 1) {
        [UIView animateWithDuration:0.3 animations:^(void){
            self.chatFriendListView.frame = CGRectMake(0, 32, 160, 3);
        }];
    }else if (number == 2){
        [UIView animateWithDuration:0.3 animations:^(void){
            self.chatFriendListView.frame = CGRectMake(160, 32, 160, 3);
        }];
    }
}

#pragma mark - private

-(void)registerNotifications
{
    [self unregisterNotifications];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}

-(void)unregisterNotifications
{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

-(void)unSelectedTapTabBarItems:(UITabBarItem *)tabBarItem
{
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont systemFontOfSize:14], UITextAttributeFont,[UIColor whiteColor],UITextAttributeTextColor,
                                        nil] forState:UIControlStateNormal];
}

-(void)selectedTapTabBarItems:(UITabBarItem *)tabBarItem
{
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont systemFontOfSize:14],
                                        UITextAttributeFont,[UIColor colorWithRed:0.393 green:0.553 blue:1.000 alpha:1.000],UITextAttributeTextColor,
                                        nil] forState:UIControlStateSelected];
}

// 统计未读消息数
//-(void)setupUnreadMessageCount
//{
//    NSArray *conversations = [[[EaseMob sharedInstance] chatManager] conversations];
//    NSInteger unreadCount = 0;
//    for (EMConversation *conversation in conversations) {
//        unreadCount += conversation.unreadMessagesCount;
//    }
//    if (_chatListVC) {
//        if (unreadCount > 0) {
//            _messageNumber = unreadCount;
//            _chatListVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",_messageNumber+_applyNumber];
//        }else{
//            _chatListVC.tabBarItem.badgeValue = nil;
//        }
//    }
//}

//- (void)setupUntreatedApplyCount
//{
//    NSInteger unreadCount = [[[ApplyViewController shareController] dataSource] count];
//    if (_contactsVC) {
//        if (unreadCount > 0) {
//            _applyNumber = unreadCount;
//            _contactsVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",_messageNumber+_applyNumber];
//        }else{
//            _contactsVC.tabBarItem.badgeValue = nil;
//        }
//    }
//}

#pragma mark - IChatManagerDelegate 消息变化

- (void)didUpdateConversationList:(NSArray *)conversationList
{
    NSLog(@"消息变化");
    [_chatListVC refreshDataSource];
}

// 未读消息数量变化回调
//-(void)didUnreadMessagesCountChanged
//{
//    NSLog(@"未读消息数量变化回调");
//    [self setupUnreadMessageCount];
//}

//- (void)didFinishedReceiveOfflineMessages:(NSArray *)offlineMessages{
//    [self setupUnreadMessageCount];
//}

- (BOOL)needShowNotification:(NSString *)fromChatter
{
    BOOL ret = YES;
    NSArray *igGroupIds = [[EaseMob sharedInstance].chatManager ignoredGroupList];
    for (NSString *str in igGroupIds) {
        if ([str isEqualToString:fromChatter]) {
            ret = NO;
            break;
        }
    }
    
    if (ret) {
        EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
        
        do {
            if (options.noDisturbing) {
                NSDate *now = [NSDate date];
                NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute
                                                                               fromDate:now];
                
                NSInteger hour = [components hour];
                //        NSInteger minute= [components minute];
                
                NSUInteger startH = options.noDisturbingStartH;
                NSUInteger endH = options.noDisturbingEndH;
                if (startH>endH) {
                    endH += 24;
                }
                
                if (hour>=startH && hour<=endH) {
                    ret = NO;
                    break;
                }
            }
        } while (0);
    }
    
    return ret;
}

// 收到消息回调
-(void)didReceiveMessage:(EMMessage *)message
{
    NSLog(@"收到消息回调");
    BOOL needShowNotification = message.isGroup ? [self needShowNotification:message.conversation.chatter] : YES;
    if (needShowNotification) {
#if !TARGET_IPHONE_SIMULATOR
        
        BOOL isAppActivity = [[UIApplication sharedApplication] applicationState] == UIApplicationStateActive;
        if (!isAppActivity) {
            [self showNotificationWithMessage:message];
        }
#endif
    }
}

- (void)showNotificationWithMessage:(EMMessage *)message
{
    EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
    //发送本地推送
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate date]; //触发通知的时间
    
    if (options.displayStyle == ePushNotificationDisplayStyle_messageSummary) {
        id<IEMMessageBody> messageBody = [message.messageBodies firstObject];
        NSString *messageStr = nil;
        switch (messageBody.messageBodyType) {
            case eMessageBodyType_Text:
            {
                messageStr = ((EMTextMessageBody *)messageBody).text;
            }
                break;
            case eMessageBodyType_Image:
            {
                messageStr = @"[图片]";
            }
                break;
            case eMessageBodyType_Location:
            {
                messageStr = @"[位置]";
            }
                break;
            case eMessageBodyType_Voice:
            {
                messageStr = @"[音频]";
            }
                break;
            case eMessageBodyType_Video:{
                messageStr = @"[视频]";
            }
                break;
            default:
                break;
        }
        
        NSString *title = message.from;
        if (message.isGroup) {
            NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
            for (EMGroup *group in groupArray) {
                if ([group.groupId isEqualToString:message.conversation.chatter]) {
                    title = [NSString stringWithFormat:@"%@(%@)", message.groupSenderName, group.groupSubject];
                    break;
                }
            }
        }
        
        notification.alertBody = [NSString stringWithFormat:@"%@:%@", title, messageStr];
    }
    else{
        notification.alertBody = @"您有一条新消息";
    }
    
#warning 去掉注释会显示[本地]开头, 方便在开发中区分是否为本地推送
    //notification.alertBody = [[NSString alloc] initWithFormat:@"[本地]%@", notification.alertBody];
    
    notification.alertAction = @"打开";
    notification.timeZone = [NSTimeZone defaultTimeZone];
    //发送通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    UIApplication *application = [UIApplication sharedApplication];
    application.applicationIconBadgeNumber += 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
