//
//  Register2ViewController.h
//  车商官家
//
//  Created by mac on 14-10-17.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Register2ViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSMutableData * receiveData;
    
    
}
@property (strong, nonatomic) IBOutlet UIView *backView; //背景view
@property (strong, nonatomic) IBOutlet UIButton *iconImageButton;
@property (strong, nonatomic) IBOutlet UITextField *userRealName;
@property (strong, nonatomic) IBOutlet UITextView *describeSelf;

@property (strong, nonatomic) NSString * phoneStr;
@property (strong, nonatomic) NSString * yanZhengMaStr;
@property (strong, nonatomic) NSString * passWordStr;

@property (strong, nonatomic) UILabel * registSuccessLabel; //注册成功后，提示注册成功。
@property (strong, nonatomic) NSString * imageUrlPath;   //返回图片的路径
@property (strong, nonatomic) UIImage * image;  //上传的图片
@property (nonatomic) BOOL isChooseIconImage;  //判断是否用户上传图片

@property (nonatomic) BOOL isUpImageSuccess;  //判断是否上传图片成功

@end
