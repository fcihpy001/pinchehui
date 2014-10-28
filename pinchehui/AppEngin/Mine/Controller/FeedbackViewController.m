//
//  FeedbackViewController.m
//  ChatDemo-UI2.0
//
//  Created by HLKJ on 14-10-17.
//  Copyright (c) 2014年 HLKJ. All rights reserved.
//

#import "FeedbackViewController.h"
#import "AFNetworking.h"
#import "SetGetUIDCID.h"
@interface FeedbackViewController ()

@property (nonatomic, strong)UITextField *Feedback;

@end
@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _Feedback = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    [_Feedback becomeFirstResponder];
    _Feedback.backgroundColor = [UIColor whiteColor];
    _Feedback.placeholder = @"请填写对软件的使用意见,帮助我们优化软件功能 200个字";
    [_Feedback becomeFirstResponder];
    _Feedback.delegate = self;
    [self.view addSubview:_Feedback];
    
}
- (IBAction)Submit:(id)sender {
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    SetGetUIDCID *Set = [[SetGetUIDCID alloc]init];
//    
//    NSString * uid = [NSString stringWithFormat:@"%d",[Set getUID]];
//    NSLog(@"uid====%@",uid);
    [mgr GET:[NSString stringWithFormat:@"http://appwx.25ren.com/api.php?c=guestbook&a=add&userid=51&content=%@",_Feedback.text] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        
        if ([[responseObject objectForKey:@"error"]integerValue ] == 0){
            NSLog(@"%@",[responseObject objectForKey:@"message"]);
            UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:@"提示" message:@"提交信息成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertView show];
            return;
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //失败设置为no

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
