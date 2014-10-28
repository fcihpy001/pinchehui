//
//  MyProfileTableViewController.m
//  ChatDemo-UI2.0
//
//  Created by HLKJ on 14-10-20.
//  Copyright (c) 2014年 HLKJ. All rights reserved.
//

#import "MyProfileTableViewController.h"
#import "AFNetworking.h"
#import "SetGetUIDCID.h"
#import "ModifyPhoneViewController.h"
#import "EnterpriseNameViewController.h"
#import "AddressViewController.h"
#import "Sign_wordsViewController.h"
#import "CompanydespViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "EnterpriseNameViewController.h"
#import "TSLocateView.h"
@interface MyProfileTableViewController ()

@property (nonatomic,strong)NSMutableDictionary *mydic;
@property (nonatomic,strong)NSMutableDictionary *mydic1;
@property (nonatomic,strong)NSMutableArray *myarray;
@property (nonatomic,strong)UIButton *InlogoButton;//我的资料头像
@property (nonatomic,strong)UILabel *phone;//手机
@property (nonatomic,strong)UILabel *Name;//名字
@property (nonatomic,strong)UILabel *QyName;//企业名称
@property (nonatomic,strong)UILabel *QyIntroduction;//企业简介
@property (nonatomic,strong)UIButton *SID;//身份证
@property (nonatomic,strong)UILabel *introd;
@property (nonatomic,strong)UIButton *business;//营业执照
@property (nonatomic,strong)UILabel *Address;//经营地址
@property (nonatomic,strong)UILabel *City;//城市



@end

@implementation MyProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(StartAFNetworking) name:@"MyProfileTableViewController" object:nil];
    [self.tableView reloadData];
    [self StartAFNetworking];
   // [self UpdateImage];

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
    
    self.imageB= [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    //    self.circleImage = [self circleImage:image withParam:0];
    
//    self.isChooseIconImage = YES;
//  [self.imageA setImage:self.imageB forState:UIControlStateNormal];
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

#pragma mark - 网络请求
- (void)StartAFNetworking{
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    SetGetUIDCID *Set = [[SetGetUIDCID alloc]init];
//    NSString * uid = [NSString stringWithFormat:@"%d",[Set getUID]];
//    NSLog(@"uid===%@",uid);
    [mgr GET:[NSString stringWithFormat:@"http://appwx.25ren.com/api.php?c=member&a=getdata_byid&userid=51"]parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self->_mydic = [NSMutableDictionary dictionaryWithDictionary:responseObject];
        self->_myarray = [self->_mydic objectForKey:@"list"];
        NSLog(@"mydic1===?%@",self->_mydic1);
        NSLog(@"%@",responseObject);
        [self.tableView reloadData];
        NSLog(@"mydic====??%@",self->_mydic);
        self->_mydic1 = [self->_myarray objectAtIndex:0];
        
        if ([[responseObject objectForKey:@"error"]integerValue ]== 0){
            NSLog(@"%@",[responseObject objectForKey:@"message"]);            
            return;
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

    }];
    
}
//- (void)UpdateImage{
//    AFHTTPRequestOperationManager * mgr = [AFHTTPRequestOperationManager manager];
//    
//    //        NSMutableDictionary * imageDict = [[NSMutableDictionary alloc]init];
//    //        [imageDict setObject:self.imageUrlPath forKey:@"image"];
//    
//    [mgr POST:[NSString stringWithFormat:@"%@/api.php?c=common&a=upload",URL_HEAD_STR] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        
//        [formData appendPartWithFileData:UIImageJPEGRepresentation(self.imageB, 0.05) name:@"iconImage" fileName:@"iconImage.png" mimeType:@"png"];
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
////        
////        NSMutableDictionary * returnDict = [[NSMutableDictionary alloc]initWithDictionary:responseObject];
//
//            
//    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//    }];
//    
//
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSString *cellIdentifier = [NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }else{
        [cell removeFromSuperview];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
        if (indexPath.row == 0) {
            
            cell.textLabel.text = @"头像";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            //头像
            _imageA = [[UIImageView alloc] initWithFrame:CGRectMake(200, 10, 70, 70)];
            //圆角设置
            _imageA.layer.cornerRadius = 35;//(值越大，角就越圆)
            _imageA.layer.masksToBounds = YES;
            _imageA.image  = [UIImage imageNamed:@"tx.png"];
            _imageA.userInteractionEnabled = YES;
            
            //            dispatch_async(dispatch_get_global_queue(0, 0), ^{
            //                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://appwx.25ren.com/data/upload/20141022/544729b1f2ffb.jpg"]];
            //                dispatch_async(dispatch_get_main_queue(), ^{
            //                    self->_image.image = [UIImage imageWithData:data];
            //                });
            //            });
            
            [_imageA setImageWithURL:[NSURL URLWithString:@"http://appwx.25ren.com/data/upload/20141022/544729b1f2ffb.jpg"] placeholderImage:[UIImage imageNamed:@"tx.png"]];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickIconImageButton:)];
            [_imageA addGestureRecognizer:tap];
            [cell.contentView addSubview:_imageA];
 
        }
        else if (indexPath.row == 1) {
            
            cell.textLabel.text = @"手机";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            _phone = [[UILabel alloc]initWithFrame:CGRectMake(100, 5, 180, 40)];
            _phone.text = [NSString stringWithFormat:@"%@",[_mydic1 valueForKey:@"mobile"]];
            _phone.font = [UIFont systemFontOfSize:16];

            [cell.contentView addSubview:_phone];
            
        }
        else if (indexPath.row == 2)
        {
            cell.textLabel.text = @"姓名";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            _Name = [[UILabel alloc]initWithFrame:CGRectMake(100, 5, 180, 40)];
            _Name.text = [NSString stringWithFormat:@"%@",[_mydic1 valueForKey:@"login_name"]];
            _Name.font = [UIFont systemFontOfSize:16];
            [cell.contentView addSubview:_Name];
        }
        else if (indexPath.row == 3)
        {
            
            cell.textLabel.text = @"所在城市";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            _City = [[UILabel alloc]initWithFrame:CGRectMake(100, 5, 180, 40)];
            _City.font = [UIFont systemFontOfSize:16];
           _City.text = [NSString stringWithFormat:@"%@",[_mydic1 valueForKey:@"province"]];
            _City.text = [NSString stringWithFormat:@"%@",[_mydic1 valueForKey:@"city"]];
//            NSLog(@"_companyname==%@",_City);
            [cell.contentView addSubview:_City];
        }
        else if (indexPath.row == 4)
        {
            
            cell.textLabel.text = @"企业名称";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            _QyName = [[UILabel alloc]initWithFrame:CGRectMake(100, 5, 180, 40)];
            _QyName.font = [UIFont systemFontOfSize:16];
            _QyName.text = [NSString stringWithFormat:@"%@",[_mydic1 valueForKey:@"companyname"]];
            NSLog(@"_companyname==%@",_companyname);
            [cell.contentView addSubview:_QyName];
        }
        else if (indexPath.row == 5){
            
            cell.textLabel.text = @"经营地址";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            _Address = [[UILabel alloc]initWithFrame:CGRectMake(100, 5, 180, 40)];
            _Address.text = [NSString stringWithFormat:@"%@",[_mydic1 objectForKey:@"companyaddress"]];
            _Address.font = [UIFont systemFontOfSize:16];
            [cell.contentView addSubview:_Address];
        }
        else if (indexPath.row == 6){
            cell.textLabel.text = @"简介";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            _introd = [[UILabel alloc]initWithFrame:CGRectMake(100, 5, 180, 40)];
            _introd.text = [NSString stringWithFormat:@"%@",[_mydic1 objectForKey:@"sign_words"]];
            _introd.font = [UIFont systemFontOfSize:16];
            [cell.contentView addSubview:_introd];
        } else if (indexPath.row == 7){
            cell.textLabel.text = @"企业简介";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            _QyIntroduction = [[UILabel alloc]initWithFrame:CGRectMake(100, 5, 180, 40)];
            _QyIntroduction.text = [NSString stringWithFormat:@"%@",[_mydic1 objectForKey:@"companydesp"]];
            _QyIntroduction.font = [UIFont systemFontOfSize:16];
            [cell.contentView addSubview:_QyIntroduction];
        }else if (indexPath.row == 8){
            cell.textLabel.text = @"商家认证申请";
            cell.backgroundColor = [UIColor grayColor];
                
           
       }else if (indexPath.row == 9){
    
           UILabel *SidLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, 70, 50, 30)];
           SidLabel.text = @"身份证";
           SidLabel.font = [UIFont systemFontOfSize:16];
           SidLabel.backgroundColor = [UIColor whiteColor];
           
           _SID = [UIButton buttonWithType:UIButtonTypeCustom];
           _SID.frame = CGRectMake(0, 0, 80, 70);
           [_SID setImage:[UIImage imageNamed:@"tx.png"] forState:UIControlStateNormal];
//         [_SID addTarget:self action:@selector(GoPersonDetai) forControlEvents:UIControlEventTouchUpInside];
           [cell.contentView addSubview:SidLabel];
           [cell.contentView addSubview:_SID];
           
    
        }
    return cell;
    
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 90;
    
    }else if (indexPath.row == 8){
        return 45;
    }else if (indexPath.row == 7){
        return 100;
    }else if (indexPath.row == 9){
        return 100;
    }
    
    else return 55;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
//        MyProfileTableViewController *myProfice = [[MyProfileTableViewController alloc]init];
//        [self.navigationController pushViewController:myProfice animated:YES];
    }
    else if (indexPath.row == 1)
    {
        ModifyPhoneViewController *ModifyPhone = [[ModifyPhoneViewController alloc]init];
        [self.navigationController pushViewController:ModifyPhone animated:YES];
    }
    else if (indexPath.row == 2)
    {
        
    }else if (indexPath.row == 3){
        // TTAlertNoTitle(@"当前最新版本");
//        TTAlert(@"当前最新版本");
        TSLocateView *locateView = [[TSLocateView alloc] initWithTitle:@"选择城市" delegate:self];
        [locateView showInView:self.view];
        
    }else if (indexPath.row == 4){
        EnterpriseNameViewController *enter = [[EnterpriseNameViewController alloc]init];
        [self.navigationController pushViewController:enter animated:YES];
        
    }else if (indexPath.row == 5){
        AddressViewController *address = [[AddressViewController alloc]init];
        [self.navigationController pushViewController:address animated:YES];
    }else if (indexPath.row == 6){
        Sign_wordsViewController *sign = [[Sign_wordsViewController alloc]init];
        [self.navigationController pushViewController:sign animated:YES];
    }else if (indexPath.row == 7){
        CompanydespViewController *compan = [[CompanydespViewController alloc]init];
        [self.navigationController pushViewController:compan animated:YES];
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_phone resignFirstResponder];
    [_Name  resignFirstResponder];
    [_QyName resignFirstResponder];
    [_QyIntroduction resignFirstResponder];
    return  YES;
}


@end
