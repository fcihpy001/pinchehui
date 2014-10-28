//
//  ForgetPasswordViewController.m
//  ChatDemo-UI2.0
//
//  Created by mac on 14-10-13.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "LoginViewController.h"
#import "AFHTTPRequestOperationManager.h"
@interface ForgetPasswordViewController ()

@end

@implementation ForgetPasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //title
    UILabel * navBarTitleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
    navBarTitleView.textAlignment = NSTextAlignmentCenter;
    navBarTitleView.text = @"找回密码";
    navBarTitleView.font = [UIFont systemFontOfSize:20];
    navBarTitleView.textColor = [UIColor whiteColor];
    
    [self.navigationItem setTitleView:navBarTitleView];
    
    //返回
    UIButton * backBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backBarButton.frame = CGRectMake(0, 0, 50, 44);
    backBarButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBarButton setImage:[UIImage imageNamed:@"back_arrow.png"] forState:UIControlStateNormal];
    [backBarButton addTarget:self action:@selector(clickBackBarButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBarButton = [[UIBarButtonItem alloc]initWithCustomView:backBarButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    
    //确定
    UIButton * rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBarButton.frame = CGRectMake(0, 0, 50, 44);
    [rightBarButton setTitle:@"确定" forState:UIControlStateNormal];
    rightBarButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [rightBarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBarButton addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBar = [[UIBarButtonItem alloc]initWithCustomView:rightBarButton];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    
    self.backView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.backView.layer.borderWidth = 0.5;
    self.backView.layer.cornerRadius = 3;
    
    self.phoneNumber.delegate = self;
    self.phoneNumber.tag = 1;
    
    self.yanZhengMa.delegate = self;
    self.yanZhengMa.tag = 2;
    
    self.passWord.delegate = self;
    self.passWord.tag = 3;
    
    //修改密码成功后，提示修改成功
    self.registerSuccessLabel = [[UILabel alloc]initWithFrame:CGRectMake(85, 350, 150, 44)];
    self.registerSuccessLabel.text = @"修改密码成功";
    self.registerSuccessLabel.backgroundColor = [UIColor lightGrayColor];
    self.registerSuccessLabel.textAlignment = NSTextAlignmentCenter;
    self.registerSuccessLabel.textColor = [UIColor whiteColor];
    self.registerSuccessLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:self.registerSuccessLabel];
    
    self.registerSuccessLabel.hidden = YES;
    
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSelfView:)];
    [self.view addGestureRecognizer:tapGesture];
    
    //每次编辑textfield都会执行的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                name:@"UITextFieldTextDidChangeNotification"
                                              object:nil];

    
}

//点击 获取验证码
- (IBAction)getYanZhengMa:(UIButton *)sender
{
    self.yanZhengMaButton.enabled = NO;
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr GET:[NSString stringWithFormat:@"%@api.php?c=sms&a=getpwdgetsmscode&mobile=%@",URL_HEAD_STR,self.phoneNumber.text] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSMutableDictionary * yanZhengMaDict = [[NSMutableDictionary alloc]initWithDictionary:responseObject];
        int errorNumber = [[yanZhengMaDict valueForKey:@"error"] intValue];
        
        if (errorNumber != 0) {
            //没通过短信验证码 验证
            NSLog(@"验证短信失败!原因：%@",[yanZhengMaDict valueForKey:@"message"]);
            [self showAlertViewWithMessage:[yanZhengMaDict valueForKey:@"message"]];
            self.yanZhengMaButton.enabled = YES;
        }else{
            self.receiveYanZhengMa = [[yanZhengMaDict valueForKey:@"list"] valueForKey:@"sms_code"];
//            self.yanZhengMaButton.enabled = NO;
            self.timerNumber = 60;
            [self.yanZhengMaButton setTitle:[NSString stringWithFormat:@"重新获取(%ds)",self.timerNumber] forState:UIControlStateNormal];
            [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerEnvent:) userInfo:nil repeats:YES];
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        self.yanZhengMaButton.enabled = YES;
        [self showAlertViewWithMessage:[error localizedDescription]];
        [self hideHud];
    }];
    
    //当点击获取验证码之后，变为一分钟倒计时，倒计时结束之后显示 重新获取验证码
    self.yanZhengMaButton.enabled = NO;
    _timerNumber = 60;
    [self.yanZhengMaButton setTitle:[NSString stringWithFormat:@"重新获取(%ds)",_timerNumber] forState:UIControlStateNormal];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerEnvent:) userInfo:nil repeats:YES];
    
}

- (void)timerEnvent:(NSTimer *)timer
{
    
    if (self.timerNumber > 0) {
        self.yanZhengMaButton.enabled = NO;
        self.timerNumber = self.timerNumber - 1;
        [self.yanZhengMaButton setTitle:[NSString stringWithFormat:@"重新获取(%ds)",self.timerNumber] forState:UIControlStateNormal];
    }else{
        [timer invalidate];
        [self.yanZhengMaButton setTitle:@"重新获取" forState:UIControlStateNormal];
        self.yanZhengMaButton.enabled = YES;
    }
    
}


//点击确认，验证码如果正确，修改密码为新密码。
- (void)next:(UIButton *)sender
{
    
    //密码：字母，数字，字符
    BOOL isPassWordError = NO;
    if (self.passWord.text.length > 0) {
        NSString *passWord = @"^[A-Za-z0-9_]{6,15}$";
        NSPredicate *passWordPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passWord];
        if(![passWordPred evaluateWithObject:self.passWord.text]){
            isPassWordError = YES;
        }
    }
    
    if (self.phoneNumber.text.length == 0) {
        [self showAlertViewWithMessage:@"请输入手机号！"];
    }else if (self.phoneNumber.text.length !=11){
        [self showAlertViewWithMessage:@"请输入正确的手机号！"];
    }else if (self.yanZhengMa.text.length == 0){
        [self showAlertViewWithMessage:@"请输入验证码！"];
    }else if (![_receiveYanZhengMa isEqualToString:self.yanZhengMa.text]){
        [self showAlertViewWithMessage:@"请输入正确的验证码！"];
    }else if (self.passWord.text.length == 0){
        [self showAlertViewWithMessage:@"密码不能为空！"];
    }else if (isPassWordError == YES){
        [self showAlertViewWithMessage:@"密码只能是6-15位数字、字母、符号组合！"];
    }else{
        
        //提交修改密码请求
        AFHTTPRequestOperationManager * mgr = [AFHTTPRequestOperationManager manager];
        
        NSMutableDictionary * parameterDict = [[NSMutableDictionary alloc]init];
        [parameterDict setObject:_phoneNumber.text forKey:@"mobile"];
        [parameterDict setObject:_passWord.text forKey:@"login_pass"];
        
        [mgr POST:[NSString stringWithFormat:@"%@/api.php?c=member&a=getpass",URL_HEAD_STR] parameters:parameterDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSMutableDictionary * responseDict = [[NSMutableDictionary alloc]initWithDictionary:responseObject];
            int errorNumber = [[responseDict valueForKey:@"error"] intValue];
            if (errorNumber != 0) {
                NSLog(@"网络请求失败!====%@",responseDict);
                [self showAlertViewWithMessage:[responseDict valueForKey:@"message"]];
                self.view.userInteractionEnabled = YES;
//                [self hideHud];
            }else{
                NSLog(@"网络请求成功。===%@",responseDict);
                self.registerSuccessLabel.hidden = NO;
                self.view.userInteractionEnabled = NO;
                [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(timeIsOver:) userInfo:nil repeats:NO];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self showAlertViewWithMessage:[error localizedDescription]];
            self.view.userInteractionEnabled = YES;
            [self hideHud];
        }];
        
        
    }
}

- (void)timeIsOver:(NSTimer *)timer
{
    self.registerSuccessLabel.hidden = YES;
    self.view.userInteractionEnabled = YES;
    LoginViewController * loginView = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:loginView animated:YES];
}


- (void)showAlertViewWithMessage:(NSString *)message
{
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}


//判断输入的手机号码，如果超过11位之后，再次输入，还是显示11位
-(void)textFiledEditChanged:(NSNotification *)obj{
    UITextField *textField = (UITextField *)obj.object;
    
    NSString *toBeString = textField.text;
    //    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if (textField.tag == 1) {
        if (toBeString.length > 11) {
            textField.text = [toBeString substringToIndex:11];
        }
    }else if (textField.tag == 2){
        if (toBeString.length > 6) {
            textField.text = [toBeString substringToIndex:6];
        }
    }else if (textField.tag == 3){
        if (toBeString.length > 15) {
            textField.text = [toBeString substringToIndex:15];
        }
    }
    
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
}

- (void)tapSelfView:(UITapGestureRecognizer *)sender
{
    [self.phoneNumber resignFirstResponder];
    [self.yanZhengMa resignFirstResponder];
    [self.passWord resignFirstResponder];
}


#pragma -mark  textfield  代理方法


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}


-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.phoneNumber resignFirstResponder];
    [self.yanZhengMa resignFirstResponder];
    [self.passWord resignFirstResponder];
    return YES;
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
