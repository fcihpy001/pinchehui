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

#import "LoginViewController.h"
#import "EMError.h"

#import "RegisterViewController.h"
#import "ForgetPasswordViewController.h"
#import "SetGetUIDCID.h"
#import "MainViewController.h"

@interface LoginViewController ()<IChatManagerDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)doRegister:(id)sender;
- (IBAction)doLogin:(id)sender;


@end

@implementation LoginViewController

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
    [self setupForDismissKeyboard];
    _usernameTextField.delegate = self;
    
    

    self.userNameView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.userNameView.layer.borderWidth = 0.5;
    self.userNameView.layer.cornerRadius = 5;
    self.loginButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.loginButton.layer.borderWidth = 0.5;
    self.loginButton.layer.cornerRadius = 5;
    
    self.registerButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.registerButton.layer.borderWidth = 0.5;
    self.registerButton.layer.cornerRadius = 5;
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0) {
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
//    self.navigationController.navigationBarHidden = YES;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0) {
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#warning 此处为 注册
- (IBAction)doRegister:(id)sender
{
    
    RegisterViewController * registerView = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerView animated:YES];
    
}

#warning 登陆.先判断我们的账号密码判断，如果正确，登陆成功。（前提是 我们的账号密码要同步注册在环信里面）
- (void)loginWithUsername:(NSString *)username password:(NSString *)password
{
    [self showHudInView:self.view hint:@"正在登录..."];
    
    userName = username;
    passWord = password;
    
    //先加入 判断，然后加入环信判断，最终确认登陆
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@api.php?c=member&a=login",URL_HEAD_STR]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    NSString *strData = [NSString stringWithFormat:@"login_name=%@&login_pass=%@",username,password];//设置参数
    NSData *data = [strData dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
}


#pragma -mark  异步网络请求代理方法
//接收到服务器回应的时候调用此方法
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
    NSLog(@"receiveResponse==%@",[res allHeaderFields]);
    receiveData = [NSMutableData data];
    
}
//接收到服务器传输数据的时候调用，此方法根据数据大小执行若干次
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receiveData appendData:data];
}
//数据传完之后调用此方法
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    //    NSString *receiveStr = [[NSString alloc]initWithData:receiveData encoding:NSUTF8StringEncoding];
    
    //    NSLog(@"%@",receiveStr);
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:receiveData options:NSJSONReadingMutableLeaves error:nil];
    int number = [[dict valueForKey:@"error"] intValue];
    NSString * errorStr = [dict valueForKey:@"message"];
#warning 服务器关闭，先取消登陆验证,如需回复正常，打开下面屏蔽代码
    if (number != 0) {
        [self showAlertViewWithMessage:errorStr];
    }else{
        //当验证通过，同步登陆 环信
        
        NSLog(@"result=%@",dict);
        NSString * userID = [[[dict valueForKey:@"list"] objectAtIndex:0] valueForKey:@"ID"];
        NSLog(@"userID=%@",userID);
        SetGetUIDCID * setGet = [[SetGetUIDCID alloc]init];
        //暂时没有cid 给初值0
        [setGet setUID:userID setCID:@"0"];
        
        MainViewController * main = [[MainViewController alloc] init];
        [self.navigationController pushViewController:main animated:YES];
        
//        [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:userID
//                                                            password:userID
//                                                          completion:
//         ^(NSDictionary *loginInfo, EMError *error) {
//             [self hideHud];
//             if (loginInfo && !error) {
//                 [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
//                 [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
//             }else {
//                 switch (error.errorCode) {
//                     case EMErrorServerNotReachable:
//                         TTAlertNoTitle(@"连接服务器失败!");
//                         break;
//                     case EMErrorServerAuthenticationFailure:
//                         TTAlertNoTitle(@"用户名或密码错误");
//                         break;
//                     case EMErrorServerTimeout:
//                         TTAlertNoTitle(@"连接服务器超时!");
//                         break;
//                     default:
//                         TTAlertNoTitle(@"登录失败");
//                         break;
//                 }
//             }
//         } onQueue:nil];

        
    }
    [self hideHud];
}

- (void)showAlertViewWithMessage:(NSString *)message
{
    
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    
}

//网络请求过程中，出现任何错误（断网，连接超时等）会进入此方法
-(void)connection:(NSURLConnection *)connection
 didFailWithError:(NSError *)error
{
    NSLog(@"connectiondidError====%@",[error localizedDescription]);
    
}



- (IBAction)doLogin:(id)sender {
    if (![self isEmpty]) {
        [self.view endEditing:YES];
        if ([self.usernameTextField.text isChinese]) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"用户名不支持中文"
                                  message:nil
                                  delegate:nil
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:nil];
            
            [alert show];
            
            return;
        }

        [self loginWithUsername:_usernameTextField.text password:_passwordTextField.text];
    }
}
- (IBAction)forgetPassword:(id)sender
{
    ForgetPasswordViewController * forgetPwdView = [[ForgetPasswordViewController alloc]init];
    [self.navigationController pushViewController:forgetPwdView animated:YES];
}


- (BOOL)isEmpty{
    BOOL ret = NO;
    NSString *username = _usernameTextField.text;
    NSString *password = _passwordTextField.text;
    if (username.length == 0 || password.length == 0) {
        ret = YES;
        [WCAlertView showAlertWithTitle:@"提示"
                                message:@"请输入账号和密码"
                     customizationBlock:nil
                        completionBlock:nil
                      cancelButtonTitle:@"确定"
                      otherButtonTitles: nil];
    }
    
    return ret;
}


#pragma  mark - TextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == _usernameTextField) {
        _passwordTextField.text = @"";
    }
    
    return YES;
}

@end
