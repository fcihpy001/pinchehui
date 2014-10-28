//
//  RegisterViewController.h
//  ChatDemo-UI2.0
//
//  Created by mac on 14-10-11.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController<UITextFieldDelegate>
{
    BOOL isAgree;  //是否同意用户协议
    
}
@property (strong, nonatomic) IBOutlet UIView *phoneNumberView;
@property (strong, nonatomic) IBOutlet UIView *passWordView;


@property (strong, nonatomic) IBOutlet UITextField *phoneNumber;
@property (strong, nonatomic) IBOutlet UITextField *yanzhengNumber;
@property (strong, nonatomic) IBOutlet UITextField *passWord;
@property (strong, nonatomic) IBOutlet UIButton *getYanZhengButton;

@property (strong, nonatomic) NSString * receiveYanZhengMa; 
@property (nonatomic) int timerNumber; //记录获取验证码之后一分钟倒计时
@property (strong, nonatomic) UILabel * registSuccessLabel; //注册成功后，提示注册成功。

@end
