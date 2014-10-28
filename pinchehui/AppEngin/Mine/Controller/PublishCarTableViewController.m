//
//  PublishCarTableViewController.m
//  车商官家
//
//  Created by HLKJ on 14-10-23.
//  Copyright (c) 2014年 HLKJ. All rights reserved.
//

#import "PublishCarTableViewController.h"
#import "DateTableViewCell.h"
@interface PublishCarTableViewController ()

@end

@implementation PublishCarTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,100, 320, [UIScreen mainScreen].bounds.size.height - 49.0f-84.0f) style:UITableViewStylePlain];
   _mytableiview.delegate = self;
    _mytableiview.dataSource = self;
    _mytableiview.backgroundColor = [UIColor whiteColor];

    _mytableiview.frame = CGRectMake(0,190, 320, [UIScreen mainScreen].bounds.size.height - 49.0f-84.0f);
    if ([_mytableiview respondsToSelector:@selector(setSeparatorInset:)]) {
        [_mytableiview setSeparatorInset:UIEdgeInsetsZero];
    }
}

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
        
        cell.textLabel.text = @"品牌车型";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }else if (indexPath.row == 1){
        
        cell.textLabel.text = @"颜色";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
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
//        ModifyPhoneViewController *ModifyPhone = [[ModifyPhoneViewController alloc]init];
//        [self.navigationController pushViewController:ModifyPhone animated:YES];
    }
    else if (indexPath.row == 2)
    {
        
    }else if (indexPath.row == 3){
        // TTAlertNoTitle(@"当前最新版本");

    }else if (indexPath.row == 4){

        
    }else if (indexPath.row == 5){

    }else if (indexPath.row == 6){

    }else if (indexPath.row == 7){

    }
}

@end
