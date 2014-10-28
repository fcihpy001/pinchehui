//
//  ChangePasswordViewController.m
//  ChatDemo-UI2.0
//
//  Created by HLKJ on 14-10-17.
//  Copyright (c) 2014年 HLKJ. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "AFNetworking.h"
#import "SetGetUIDCID.h"
@interface ChangePasswordViewController ()

@property (strong, nonatomic) IBOutlet UITextField *oldPass;//旧密码
@property (strong, nonatomic) IBOutlet UITextField *NewPass;//新密码
@property (strong, nonatomic) IBOutlet UITextField *ConfirmPass;//确认密码

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _oldPass.userInteractionEnabled = YES;
    _oldPass.delegate = self;
    _NewPass.delegate = self;
    _ConfirmPass.delegate = self;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_oldPass resignFirstResponder];
    [_NewPass resignFirstResponder];
    [_ConfirmPass resignFirstResponder];
    return  YES;
}
- (IBAction)Confirmation:(id)sender {
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    [mgr GET:[NSString stringWithFormat:@"http://appwx.25ren.com/api.php?c=member&a=chgpass&userid=51&login_pass=%@",_NewPass.text]parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSLog(@"%@",responseObject);

        if ([[responseObject objectForKey:@"error"]integerValue ] == 1){
            NSLog(@"%@",[responseObject objectForKey:@"message"]);
            
            return;
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //失败设置为no
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"login"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
