//
//  AddFriendOfThirdViewController.m
//  车商官家
//
//  Created by mac on 14-10-21.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "AddFriendOfThirdViewController.h"
#import "PhoneListAddFriendViewController.h"
@interface AddFriendOfThirdViewController ()

@end

@implementation AddFriendOfThirdViewController

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
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    
    [self setTitleAndBackButton];
    
    //view
    UIView * firstView = [[UIView alloc]initWithFrame:CGRectMake(0, 30+64, 320, 44)];
    firstView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:firstView];
    
    UIView * secondView = [[UIView alloc]initWithFrame:CGRectMake(0, firstView.frame.origin.y+74, 320, 44)];
    secondView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:secondView];
    
    //前面图标
    UIImageView * phoneImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 44, 44)];
    phoneImageView.image = [UIImage imageNamed:@""];
    [firstView addSubview:phoneImageView];
    
    UIImageView * phoneListImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 44, 44)];
    phoneListImageView.image = [UIImage imageNamed:@""];
    [secondView addSubview:phoneListImageView];
    
    //输入框和button
    self.phoneNumber = [[UITextField alloc]initWithFrame:CGRectMake(70, 0, 180, 44)];
    self.phoneNumber.placeholder = @"请输入要查找的手机号";
    [firstView addSubview:self.phoneNumber];
    
    self.addFriendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addFriendButton.frame = CGRectMake(280, 12, 20, 20);
    [self.addFriendButton setBackgroundImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    [self.addFriendButton addTarget:self action:@selector(clickAddFriendButton:) forControlEvents:UIControlEventTouchUpInside];
    [firstView addSubview:self.addFriendButton];
    
    
    self.phoneListAddFriend = [UIButton buttonWithType:UIButtonTypeCustom];
    self.phoneListAddFriend.frame = CGRectMake(70, 0, 250, 44);
    [self.phoneListAddFriend setTitle:@"从通讯录添加好友" forState:UIControlStateNormal];
    [self.phoneListAddFriend setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.phoneListAddFriend.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.phoneListAddFriend addTarget:self action:@selector(clickPhoneListAddFriendButton:) forControlEvents:UIControlEventTouchUpInside];
    [secondView addSubview:self.phoneListAddFriend];
    
    //指向右的 图标
    UIImageView * accImageView = [[UIImageView alloc]initWithFrame:CGRectMake(210, 17, 10, 10)];
    accImageView.image = [UIImage imageNamed:@""];
    [self.phoneListAddFriend addSubview:accImageView];
}

//点击从通讯录添加好友
- (void)clickPhoneListAddFriendButton:(UIButton *)sender
{
    PhoneListAddFriendViewController * phoneListView = [[PhoneListAddFriendViewController alloc]init];
    [self.navigationController pushViewController:phoneListView animated:YES];
}

//点击输入框后面添加好友按钮
- (void)clickAddFriendButton:(UIButton *)sender
{
#warning 点击加好友页面的添加按钮， 加入判断，用户输入的名字 是否存在。
    NSString *buddyName = self.phoneNumber.text;
    if ([self didBuddyExist:buddyName]) {
        NSString *message = [NSString stringWithFormat:@"'%@'已经是你的好友了!", buddyName];
        [WCAlertView showAlertWithTitle:message
                                message:nil
                     customizationBlock:nil
                        completionBlock:nil
                      cancelButtonTitle:@"确定"
                      otherButtonTitles: nil];
        
    }
    else if([self hasSendBuddyRequest:buddyName])
    {
        NSString *message = [NSString stringWithFormat:@"您已向'%@'发送好友请求了!", buddyName];
        [WCAlertView showAlertWithTitle:message
                                message:nil
                     customizationBlock:nil
                        completionBlock:nil
                      cancelButtonTitle:@"确定"
                      otherButtonTitles: nil];
        
    }else{
        [self showMessageAlertView];
    }
    
}

- (void)showMessageAlertView{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"你需要发送验证申请！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([alertView cancelButtonIndex] != buttonIndex) {
        UITextField *messageTextField = [alertView textFieldAtIndex:0];
        
        NSString *messageStr = @"";
        NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
        NSString *username = [loginInfo objectForKey:kSDKUsername];
        if (messageTextField.text.length > 0) {
            messageStr = [NSString stringWithFormat:@"%@：%@", username, messageTextField.text];
        }
        else{
            messageStr = [NSString stringWithFormat:@"%@ 邀请你为好友", username];
        }
        [self sendFriendApplyAtIndexPath:nil
                                 message:messageStr];
    }
}

- (void)sendFriendApplyAtIndexPath:(NSIndexPath *)indexPath
                           message:(NSString *)message
{
    NSString *buddyName = self.phoneNumber.text;
    if (buddyName && buddyName.length > 0) {
        [self showHudInView:self.view hint:@"正在发送申请..."];
        EMError *error;
        [[EaseMob sharedInstance].chatManager addBuddy:buddyName message:message error:&error];
        [self hideHud];
        if (error) {
            [self showHint:@"发送申请失败，请重新操作"];
        }
        else{
            [self showHint:@"发送申请成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (BOOL)didBuddyExist:(NSString *)buddyName{
    NSArray *buddyList = [[[EaseMob sharedInstance] chatManager] buddyList];
    for (EMBuddy *buddy in buddyList) {
        if ([buddy.username isEqualToString:buddyName] &&
            buddy.followState != eEMBuddyFollowState_NotFollowed) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)hasSendBuddyRequest:(NSString *)buddyName{
    NSArray *buddyList = [[[EaseMob sharedInstance] chatManager] buddyList];
    for (EMBuddy *buddy in buddyList) {
        if ([buddy.username isEqualToString:buddyName] &&
            buddy.followState == eEMBuddyFollowState_NotFollowed &&
            buddy.isPendingApproval) {
            return YES;
        }
    }
    return NO;
}

- (void)setTitleAndBackButton
{
    //title
    UILabel * navBarTitleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    navBarTitleView.textAlignment = NSTextAlignmentCenter;
    navBarTitleView.text = @"添加好友";
    navBarTitleView.font = [UIFont systemFontOfSize:20];
    navBarTitleView.textColor = [UIColor whiteColor];
    
    [self.navigationItem setTitleView:navBarTitleView];
    
    //返回
    UIButton * backBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backBarButton.frame = CGRectMake(0, 0, 50, 44);
    [backBarButton setTitle:@"返回" forState:UIControlStateNormal];
    backBarButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBarButton addTarget:self action:@selector(clickBackBarButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBarButton = [[UIBarButtonItem alloc]initWithCustomView:backBarButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;
}

- (void)clickBackBarButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
