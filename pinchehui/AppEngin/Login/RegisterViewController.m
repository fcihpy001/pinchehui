//
//  RegisterViewController.m
//  ChatDemo-UI2.0
//
//  Created by mac on 14-10-11.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"

#import "AFHTTPRequestOperationManager.h"

#import "Register2ViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

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
    
    isAgree = NO;
    //title
    UILabel * navBarTitleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
    navBarTitleView.textAlignment = NSTextAlignmentCenter;
    navBarTitleView.text = @"注册";
    navBarTitleView.font = [UIFont systemFontOfSize:20];
    navBarTitleView.textColor = [UIColor whiteColor];
    
    [self.navigationItem setTitleView:navBarTitleView];
    
    //返回
    UIButton * backBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backBarButton.frame = CGRectMake(0, 0, 44, 44);
//    [backBarButton setTitle:@"返回" forState:UIControlStateNormal];
    backBarButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBarButton setImage:[UIImage imageNamed:@"back_arrow.png"] forState:UIControlStateNormal];
//    [backBarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBarButton addTarget:self action:@selector(clickBackBarButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBarButton = [[UIBarButtonItem alloc]initWithCustomView:backBarButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    //注册成功后，提示注册成功
    self.registSuccessLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 450, 100, 44)];
    self.registSuccessLabel.text = @"注册成功";
    self.registSuccessLabel.backgroundColor = [UIColor lightGrayColor];
    self.registSuccessLabel.textAlignment = NSTextAlignmentCenter;
    self.registSuccessLabel.textColor = [UIColor whiteColor];
    self.registSuccessLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:self.registSuccessLabel];
    
    self.registSuccessLabel.hidden = YES;
    

    
    //下一步
    UIButton * nextBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBarButton.frame = CGRectMake(0, 0, 70, 44);
    [nextBarButton setTitle:@"下一步" forState:UIControlStateNormal];
    nextBarButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [nextBarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextBarButton addTarget:self action:@selector(clickNextBarButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBarButton = [[UIBarButtonItem alloc]initWithCustomView:nextBarButton];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.phoneNumberView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.phoneNumberView.layer.borderWidth = 0.5;
    self.phoneNumberView.layer.cornerRadius = 5;
    
    self.passWordView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.passWordView.layer.borderWidth = 0.5;
    self.passWordView.layer.cornerRadius = 5;
    
    self.getYanZhengButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.getYanZhengButton.layer.borderWidth = 0.5;
    self.getYanZhengButton.layer.cornerRadius = 5;
    
    
    self.phoneNumber.delegate = self;
    self.phoneNumber.tag = 1;
    self.yanzhengNumber.delegate = self;
    self.yanzhengNumber.tag = 2;
    self.passWord.delegate = self;
    self.passWord.tag = 3;
    
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSelfView:)];
    [self.view addGestureRecognizer:tapGesture];
    
    //每次编辑textfield都会执行的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                name:@"UITextFieldTextDidChangeNotification"
                                              object:nil];
}

- (void)tapSelfView:(UITapGestureRecognizer *)sender
{
    [self.phoneNumber resignFirstResponder];
    [self.yanzhengNumber resignFirstResponder];
    [self.passWord resignFirstResponder];
}

//点击同意协议按钮，同意协议或者不同意，默认不同意
- (IBAction)clickAgreeDelegate:(UIButton *)sender
{
    
    if (isAgree == NO) {
        [sender setImage:[UIImage imageNamed:@"agree_yes"] forState:UIControlStateNormal];
        isAgree = YES;
    }else{
        [sender setImage:[UIImage imageNamed:@"agree_no"] forState:UIControlStateNormal];
        isAgree = NO;
    }
    
}

//点击查看协议内容
- (IBAction)delegateButton:(id)sender
{
    
    
    
}
//点击《注册用户级别划分规则》
- (IBAction)LevelButton:(id)sender
{
    
    
    
}

//点击下一步，需要判断是否输入手机和验证码，并且判断是否正确
- (void)clickNextBarButton:(UIButton *)sender
{
    [self.phoneNumber resignFirstResponder];
    [self.yanzhengNumber resignFirstResponder];
    [self.passWord resignFirstResponder];
    
    //判断输入是否存在问题
    [self.view endEditing:YES];  //取消当前view或者subviews的第一响应者
    
    //密码：字母，数字，字符
    BOOL isPassWordError = NO;
    if (self.passWord.text.length > 0) {
        NSString *passWord = @"^[A-Za-z0-9_]{6,15}$";
        NSPredicate *passWordPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passWord];
        if(![passWordPred evaluateWithObject:self.passWord.text]){
            isPassWordError = YES;
        }
    }
    
//    else if (![self.yanzhengNumber.text isEqualToString:self.receiveYanZhengMa]){
//        [self showAlertViewWithMessage:@"验证码输入错误！"];
//    }
    
    if (self.phoneNumber.text.length == 0) {
        [self showAlertViewWithMessage:@"手机号不能为空！"];
    }else if (self.phoneNumber.text.length != 11){
        [self showAlertViewWithMessage:@"请输入正确的手机号！"];
    }else if ([self.phoneNumber.text isChinese]){
        [self showAlertViewWithMessage:@"请输入正确的手机号！"];
    }else if (self.yanzhengNumber.text.length == 0){
        [self showAlertViewWithMessage:@"验证码不能为空！"];
    }else if (self.passWord.text.length == 0){
        [self showAlertViewWithMessage:@"密码不能为空！"];
    }else if (self.passWord.text.length<6||self.passWord.text.length>15){
        [self showAlertViewWithMessage:@"密码只能是6-15位数字、字母、符号组合！"];
    }else if (isPassWordError == YES){
        [self showAlertViewWithMessage:@"密码只能是6-15位数字、字母、符号组合！"];
    }else{
        //下一步
        
        Register2ViewController * register2View = [[Register2ViewController alloc]init];
        register2View.phoneStr = self.phoneNumber.text;
        register2View.yanZhengMaStr = self.yanzhengNumber.text;
        register2View.passWordStr = self.passWord.text;
        
        [self.navigationController pushViewController:register2View animated:YES];
    }
    
}

- (void)timeIsOver:(NSTimer *)timer
{
    self.registSuccessLabel.hidden = YES;
    self.view.userInteractionEnabled = YES;
    LoginViewController * loginView = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:loginView animated:YES];
}

//返回
- (void)clickBackBarButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma  - mark  获取验证码
//获取验证码
- (IBAction)getYanZhengMa:(UIButton *)sender
{
    //当点击获取验证码之后，变为一分钟倒计时，倒计时结束之后显示 重新获取验证码
    self.getYanZhengButton.enabled = NO;
    if (self.phoneNumber.text.length == 0) {
        self.getYanZhengButton.enabled = YES;
        [self showAlertViewWithMessage:@"电话号码不能为空！"];
    }else if (self.phoneNumber.text.length != 11){
        self.getYanZhengButton.enabled = YES;
        [self showAlertViewWithMessage:@"请输入正确的电话号码！"];
    }
    else{
        //发送验证码
        
        AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
        [mgr GET:[NSString stringWithFormat:@"%@api.php?c=sms&a=reggetsmscode&mobile=%@",URL_HEAD_STR,self.phoneNumber.text] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
            
            NSMutableDictionary * yanZhengMaDict = [[NSMutableDictionary alloc]initWithDictionary:responseObject];
            int errorNumber = [[yanZhengMaDict valueForKey:@"error"] intValue];
            
            if (errorNumber != 0) {
                //没通过短信验证码 验证
                NSLog(@"验证短信失败!原因：%@",[yanZhengMaDict valueForKey:@"message"]);
                NSLog(@"yanZhengMaDict=%@",yanZhengMaDict);
                [self showAlertViewWithMessage:[yanZhengMaDict valueForKey:@"message"]];
                self.getYanZhengButton.enabled = YES;
            }else{
                NSLog(@"yanZhengMaDict=%@",yanZhengMaDict);
                self.receiveYanZhengMa = [[[yanZhengMaDict valueForKey:@"list"] objectAtIndex:0] valueForKey:@"sms_code"];
                self.getYanZhengButton.enabled = NO;
                self.timerNumber = 60;
                [self.getYanZhengButton setTitle:[NSString stringWithFormat:@"重新获取(%ds)",self.timerNumber] forState:UIControlStateNormal];
                [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerEnvent:) userInfo:nil repeats:YES];
                
            }
            
                }failure:^(AFHTTPRequestOperation *operation, NSError *error){
                    [self showAlertViewWithMessage:[error localizedDescription]];
                    [self hideHud];
                    self.getYanZhengButton.enabled = YES;
                }];
    }
    
}


- (void)showAlertViewWithMessage:(NSString *)message
{
    
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}


- (void)timerEnvent:(NSTimer *)timer
{
    
    if (self.timerNumber > 0) {
        
        self.timerNumber = self.timerNumber - 1;
        [self.getYanZhengButton setTitle:[NSString stringWithFormat:@"重新获取(%ds)",self.timerNumber] forState:UIControlStateNormal];
    }else{
        [timer invalidate];
        [self.getYanZhengButton setTitle:@"重新获取" forState:UIControlStateNormal];
        self.getYanZhengButton.enabled = YES;
    }
    
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


#pragma -mark  textfield  代理方法

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.phoneNumber resignFirstResponder];
    [self.yanzhengNumber resignFirstResponder];
    [self.passWord resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
