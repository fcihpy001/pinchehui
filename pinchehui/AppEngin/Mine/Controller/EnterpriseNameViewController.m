//
//  EnterpriseNameViewController.m
//  车商官家
//
//  Created by HLKJ on 14-10-22.
//  Copyright (c) 2014年 HLKJ. All rights reserved.
//

#import "EnterpriseNameViewController.h"
#import "AFNetworking.h"
#import "MyProfileTableViewController.h"
@interface EnterpriseNameViewController ()

@end

@implementation EnterpriseNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(260, -3,100, 46);
    // [button setBackgroundImage:[UIImage imageNamed:@"header_right.png"] forState:UIControlStateNormal];
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightActiongy) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = right;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)rightActiongy{
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr GET:[NSString stringWithFormat:@"http://appwx.25ren.com/api.php?c=member&a=modifymember&userid=51&companyname=%@",_Entrepes.text] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        
        if ([[responseObject objectForKey:@"error"]integerValue ] == 0){
            NSLog(@"%@",[responseObject objectForKey:@"message"]);
            UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:@"提示" message:@"修改信息成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
           [[NSNotificationCenter defaultCenter]postNotificationName:@"MyProfileTableViewController" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
            return;
            
        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

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
