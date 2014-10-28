//
//  ForgetPasswordViewController.h
//  ChatDemo-UI2.0
//
//  Created by mac on 14-10-13.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetPasswordViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumber;
@property (strong, nonatomic) IBOutlet UITextField *yanZhengMa;
@property (strong, nonatomic) IBOutlet UITextField *passWord;
@property (strong, nonatomic) IBOutlet UIButton *yanZhengMaButton;

@property (strong, nonatomic) NSString * receiveYanZhengMa;
@property (strong, nonatomic) UILabel * registerSuccessLabel; //修改密码成功后，提示修改成功
@property (nonatomic) int timerNumber;

@end
