//
//  PersonDetailViewController.m
//  ChatDemo-UI2.0
//
//  Created by HLKJ on 14-10-16.
//  Copyright (c) 2014年 HLKJ. All rights reserved.
//

#import "PersonDetailViewController.h"
#import "SettingsViewController.h"
#import "MainViewController.h"
#import "MyProfileTableViewController.h"
#import "PublishCarTableViewController.h"
#import <SDWebImage/SDImageCache.h>
#import <SDWebImage/SDWebImageCompat.h>
#import <SDWebImage/SDWebImageManager.h>
#import <SDWebImage/UIImageView+WebCache.h>


@interface PersonDetailViewController ()

@property (nonatomic, strong)UIButton *logoButton;//头像
@property (nonatomic, strong)UILabel *Phone;//电话
@property (nonatomic, strong)UILabel *Authentication;//认证

@property (nonatomic, strong)UITableView *MytableView;//
@property (nonatomic, strong)UIImageView *image;
@end

@implementation PersonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _MytableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, 320, [UIScreen mainScreen].bounds.size.height - 49.0f-84.0f) style:UITableViewStylePlain];
    _MytableView.delegate = self;
    _MytableView.dataSource = self;
    _MytableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_MytableView];
    
    if ([_MytableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_MytableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
}

#pragma mark - buut点击事件
-(void)GoPersonDetai{
    MyProfileTableViewController *myprofile = [[MyProfileTableViewController alloc]init];
    [self.navigationController pushViewController:myprofile animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //头像
            _image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 70, 70)];
            //圆角设置
            _image.layer.cornerRadius = 35;//(值越大，角就越圆)
            _image.layer.masksToBounds = YES;
            _image.image  = [UIImage imageNamed:@"tx.png"];
            _image.userInteractionEnabled = YES;
            
//            dispatch_async(dispatch_get_global_queue(0, 0), ^{
//                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://appwx.25ren.com/data/upload/20141022/544729b1f2ffb.jpg"]];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    self->_image.image = [UIImage imageWithData:data];
//                });
//            });
          
            [_image setImageWithURL:[NSURL URLWithString:@"http://appwx.25ren.com/data/upload/20141022/544729b1f2ffb.jpg"] placeholderImage:[UIImage imageNamed:@"tx.png"]];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(GoPersonDetai)];
            [_image addGestureRecognizer:tap];
            [cell.contentView addSubview:_image];
           
            //电话
            _Phone = [[UILabel alloc]initWithFrame:CGRectMake(80, 10, 110, 30)];
            _Phone.backgroundColor = [UIColor whiteColor];
            _Phone.text = @"18610809927";
            _Phone.font =[UIFont systemFontOfSize:16];
            //认证
            _Authentication = [[UILabel alloc]initWithFrame:CGRectMake(190 ,10, 50, 30)];
            _Authentication.backgroundColor = [UIColor whiteColor];
            _Authentication.text = @"已认证";
            _Authentication.font = [UIFont systemFontOfSize:16];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [cell.contentView addSubview:_Authentication];
            [cell.contentView addSubview:_Phone];
            [cell.contentView addSubview:_logoButton];
            
        }
        else if (indexPath.row == 1) {

            cell.textLabel.text = @"发布车源";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }
        else if (indexPath.row == 2)
        {
            cell.textLabel.text = @"在售的车";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if (indexPath.row == 3)
        {
            
            cell.textLabel.text = @"已售的车";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if (indexPath.row == 4)
        {
            
            cell.textLabel.text = @"我的特卖";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if (indexPath.row == 5){
            
            cell.textLabel.text = @"下架的车";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if (indexPath.row == 6){
            cell.textLabel.text = @"我的收藏";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }
        else if (indexPath.row == 7){
            cell.textLabel.text = @"我的贷款";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if (indexPath.row == 8){
            cell.textLabel.text = @"我的统计";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }

    }
    
    return cell;
}



#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 90;
    }
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        MyProfileTableViewController *myProfice = [[MyProfileTableViewController alloc]init];
        [self.navigationController pushViewController:myProfice animated:YES];
    }
    else if (indexPath.row == 1)
    {
        PublishCarTableViewController *publishCar = [[PublishCarTableViewController alloc]init];
        [self.navigationController pushViewController:publishCar animated:YES];
    }
    else if (indexPath.row == 2)
    {
 
    }else if (indexPath.row == 3){
        // TTAlertNoTitle(@"当前最新版本");
        TTAlert(@"当前最新版本");
        
    }else if (indexPath.row ==4){
        TTAlert(@"当前版本1.0");
        
    }
}



@end
