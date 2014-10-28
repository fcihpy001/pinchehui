//
//  Register2ViewController.m
//  车商官家
//
//  Created by mac on 14-10-17.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "Register2ViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "LoginViewController.h"
@interface Register2ViewController ()

@end

@implementation Register2ViewController

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
    // Do any additional setup after loading the view from its nib.
    
    //title
    UILabel * navBarTitleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    navBarTitleView.textAlignment = NSTextAlignmentCenter;
    navBarTitleView.text = @"注册-完善资料";
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
    
    //下一步
    UIButton * nextBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBarButton.frame = CGRectMake(0, 0, 70, 44);
    [nextBarButton setTitle:@"注册" forState:UIControlStateNormal];
    nextBarButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [nextBarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextBarButton addTarget:self action:@selector(clickNextBarButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBarButton = [[UIBarButtonItem alloc]initWithCustomView:nextBarButton];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    
    self.backView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.backView.layer.borderWidth = 0.5;
    self.backView.layer.cornerRadius = 5;
    
    
    
    //注册成功后，提示注册成功
    self.registSuccessLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 450, 100, 44)];
    self.registSuccessLabel.text = @"注册成功";
    self.registSuccessLabel.backgroundColor = [UIColor lightGrayColor];
    self.registSuccessLabel.textAlignment = NSTextAlignmentCenter;
    self.registSuccessLabel.textColor = [UIColor whiteColor];
    self.registSuccessLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:self.registSuccessLabel];
    
    self.registSuccessLabel.hidden = YES;
    
    
    [self.iconImageButton addTarget:self action:@selector(clickIconImageButton:) forControlEvents:UIControlEventTouchUpInside];
    self.userRealName.delegate = self;
    self.describeSelf.delegate = self;
    self.describeSelf.textColor = [UIColor lightGrayColor];
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSelfView:)];
    [self.view addGestureRecognizer:tapGesture];
    
    
    //默认 用户没有选择上传头像
    self.isChooseIconImage = NO;
}

- (void)tapSelfView:(UITapGestureRecognizer *)sender
{
    [self.userRealName resignFirstResponder];
    [self.describeSelf resignFirstResponder];
}

//点击返回
- (void)clickBackBarButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//点击注册
- (void)clickNextBarButton:(UIButton *)sender
{
    [self.userRealName resignFirstResponder];
    [self.describeSelf resignFirstResponder];
    [self showHudInView:self.view hint:@"正在注册..."];
    self.view.userInteractionEnabled = NO;
    //判断姓名 只能为 汉子
    BOOL nameTextFieldIsError = NO;
    NSString *regex = @"[\u4e00-\u9fa5]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if (self.userRealName.text.length > 0) {
        if(![pred evaluateWithObject: self.userRealName.text])
        {
            nameTextFieldIsError = YES;
        }
    }
    
    if (self.isChooseIconImage == NO) {
        [self showAlertViewWithMessage:@"请上传头像！"];
    }else if(self.userRealName.text.length == 0){
        [self showAlertViewWithMessage:@"姓名不能为空！"];
    }else if (nameTextFieldIsError == YES){
        [self showAlertViewWithMessage:@"姓名只能为汉字！"];
    }else if (self.describeSelf.text.length == 0){
        [self showAlertViewWithMessage:@"请填写个人介绍，让别人更加了解你！"];
    }else{
        //通过验证
        
        //判断，如果用户上传图片
        AFHTTPRequestOperationManager * mgr = [AFHTTPRequestOperationManager manager];
        
//        NSMutableDictionary * imageDict = [[NSMutableDictionary alloc]init];
//        [imageDict setObject:self.imageUrlPath forKey:@"image"];
        
        [mgr POST:[NSString stringWithFormat:@"%@/api.php?c=common&a=upload",URL_HEAD_STR] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileData:UIImageJPEGRepresentation(self.image, 0.05) name:@"iconImage" fileName:@"iconImage.png" mimeType:@"png"];
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSMutableDictionary * returnDict = [[NSMutableDictionary alloc]initWithDictionary:responseObject];
            int errorNumber = [[returnDict valueForKey:@"error"] intValue];
            
            if (errorNumber != 0) {
                NSLog(@"上传图片错误!====%@",returnDict);
                [self showAlertViewWithMessage:[returnDict valueForKey:@"message"]];
                self.view.userInteractionEnabled = YES;
                [self hideHud];
            }else{
                NSLog(@"上传成功！====%@",returnDict);
                self.imageUrlPath = [[returnDict valueForKey:@"list"] valueForKey:@"file_url"];
                AFHTTPRequestOperationManager *mgr1 = [AFHTTPRequestOperationManager manager];
                //参数字典，包括 手机号，密码...
                NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
                [dict setObject:self.phoneStr forKey:@"mobile"];
                [dict setObject:self.phoneStr forKey:@"login_name"];
                [dict setObject:self.passWordStr forKey:@"login_pass"];
                [dict setObject:self.userRealName.text forKey:@"username"];
                [dict setObject:self.describeSelf.text forKey:@"sign_words"];
                [dict setObject:self.imageUrlPath forKey:@"avatar_url"];
                
                //        头像的字段：avatar_url
                //        个人说明的字段：　sign_words
                
                // 注册用户
                [mgr1 POST:[NSString stringWithFormat:@"%@api.php?c=member&a=register",URL_HEAD_STR] parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    
                    NSMutableDictionary * responseDict = [[NSMutableDictionary alloc]initWithDictionary:responseObject];
                    
                    int errorNumber = [[responseDict valueForKey:@"error"] intValue];
                    if (errorNumber != 0) {
                        //注册失败，提示失败原因
                        NSLog(@"注册失败！原因：=%@",[responseDict valueForKey:@"message"]);
                        NSLog(@"responseDict=%@",responseDict);
                        [self showAlertViewWithMessage:[responseDict valueForKey:@"message"]];
                        self.view.userInteractionEnabled = YES;
                        [self hideHud];
                    }else{
                        //注册成功
                        // 注册成为环信用户
                        NSLog(@"responseDict=%@",responseDict);
#warning 注册新规则，当用户注册成功之后 拿到user ID ，把userID当做账号密码 注册环信。登陆时候也一样

                        NSString * userID = [NSString stringWithFormat:@"%@",[[[responseDict valueForKey:@"list"] objectAtIndex:0] valueForKey:@"uid"]];
                        NSLog(@"uid=%@",userID);
                        
                        [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:userID
                                                                             password:userID
                                                                       withCompletion:
                         ^(NSString *username, NSString *password, EMError *error) {
                             NSLog(@"asdasdasdasd=%@",error);
                             NSLog(@"name=%@,password=%@",username,password);
                             if (!error) {
                                 NSLog(@"chenggong");
                                 TTAlertNoTitle(@"注册成功,请登录");
                                 self.registSuccessLabel.hidden = NO;
                                 self.view.userInteractionEnabled = NO;
                                 [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(timeIsOver:) userInfo:nil repeats:NO];
                                 
                             }else{
                                 NSLog(@"shibai");
                                 switch (error.errorCode) {
                                     case EMErrorServerNotReachable:
                                         TTAlertNoTitle(@"连接服务器失败!");
                                         break;
                                     case EMErrorServerDuplicatedAccount:
                                         TTAlertNoTitle(@"您注册的用户已存在!");
                                         break;
                                     case EMErrorServerTimeout:
                                         TTAlertNoTitle(@"连接服务器超时!");
                                         break;
                                     default:
                                         TTAlertNoTitle(@"注册失败");
                                         break;
                                 }
                                 self.view.userInteractionEnabled = YES;
                                 [self hideHud];
                             }
                         } onQueue:nil];
                    }
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    [self showAlertViewWithMessage:[error localizedDescription]];
                    self.view.userInteractionEnabled = YES;
                    [self hideHud];
                }];
            }
            
        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self showAlertViewWithMessage:[error localizedDescription]];
            self.view.userInteractionEnabled = YES;
            [self hideHud];
        }];
        
        
    }
//    self.view.userInteractionEnabled = YES;
//    [self hideHud];
}

#pragma -mark  textfield  代理方法

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.userRealName resignFirstResponder];
    return YES;
}

#pragma -mark  textView 代理方法

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return YES;
    }
    return YES;
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"一句话介绍自己，让更多人认识你！"]) {
        textView.text = @"";
    }
    textView.textColor = [UIColor blackColor];
    return YES;
}

//-(void)textViewDidChange:(UITextView *)textView
//{
//    textView.textColor = [UIColor blackColor];
//}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]||[textView.text isEqualToString:@"一句话介绍自己，让更多人认识你！"]) {
        textView.text = @"一句话介绍自己，让更多人认识你！";
        textView.textColor = [UIColor lightGrayColor];
    }
}

- (void)timeIsOver:(NSTimer *)timer
{
    self.registSuccessLabel.hidden = YES;
    [self hideHud];
    self.view.userInteractionEnabled = YES;
    LoginViewController * loginView = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:loginView animated:YES];
}

- (void)showAlertViewWithMessage:(NSString *)message
{
    
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

//点击修改用户头像按钮，调用 相册或者相机
- (void)clickIconImageButton:(UIButton *)sedner
{
    [self openPics];
}


#pragma -mark调用相册拍照方法  开始______________________
// 打开相机
- (void)openCamera {
    // UIImagePickerControllerCameraDeviceRear 后置摄像头
    // UIImagePickerControllerCameraDeviceFront 前置摄像头
    BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    if (!isCamera) {
        NSLog(@"没有摄像头");
        return ;
    }
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    // 编辑模式
    imagePicker.allowsEditing = YES;
    [self  presentViewController:imagePicker animated:YES completion:^{
    }];
}

// 打开相册
- (void)openPics
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"使用摄像头拍摄", @"本地相册",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        if (!isCamera) {
            NSLog(@"没有摄像头");
            return ;
        }
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        // 编辑模式
        imagePicker.allowsEditing = YES;
        [self  presentViewController:imagePicker animated:YES completion:^{
        }];
        
        NSLog(@"摄像头拍摄");
    }else if (buttonIndex == 1) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = self;
        [self  presentViewController:imagePicker animated:YES completion:^{
        }];
        NSLog(@"本地图片");
        
    }
}
// 选中照片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"%@", info);
    
    self.image= [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
//    self.circleImage = [self circleImage:image withParam:0];
    
    self.isChooseIconImage = YES;
    [self.iconImageButton setImage:self.image forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(UIImage*) circleImage:(UIImage*) image withParam:(CGFloat) inset {
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    CGRect rect = CGRectMake(inset, inset, image.size.width - inset * 2.0f, image.size.height - inset * 2.0f);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    [image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

// 取消相册
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
#pragma -mark调用相册 拍照方法结束______________________


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
