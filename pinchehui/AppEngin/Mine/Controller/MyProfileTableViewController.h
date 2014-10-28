//
//  MyProfileTableViewController.h
//  ChatDemo-UI2.0
//
//  Created by HLKJ on 14-10-20.
//  Copyright (c) 2014年 HLKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyProfileTableViewController : UITableViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
@property (nonatomic,strong)NSString *companyname;
@property (nonatomic,strong)UITableView *mytableview;
@property (strong, nonatomic) UIImage *imageB;  //上传的图片
@property (strong, nonatomic) UIImageView *imageA;
@end
