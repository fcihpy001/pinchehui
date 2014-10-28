//
//  PhoneListAddFriendViewController.m
//  车商官家
//
//  Created by mac on 14-10-21.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "PhoneListAddFriendViewController.h"
#import "PhoneListTVCell.h"

#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface PhoneListAddFriendViewController ()

@end

@implementation PhoneListAddFriendViewController

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
	// Do any additional setup after loading the view.
    firstNameArray = [[NSMutableArray alloc]init];
    lastNameArray = [[NSMutableArray alloc]init];
    phoneNumberArray = [[NSMutableArray alloc]init];
    
    [self readAllPeoples];
    [self setTitleAndBackButton];
    
    
}

//获取通讯录
-(void)readAllPeoples

{
    //定义通讯录名字为addressbook
    ABAddressBookRef tmpAddressBook = nil;
    
    //根据系统版本不同，调用不同方法获取通讯录
    if ([[UIDevice currentDevice].systemVersion floatValue]>=6.0) {
        tmpAddressBook=ABAddressBookCreateWithOptions(NULL, NULL);
        dispatch_semaphore_t sema=dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(tmpAddressBook, ^(bool greanted, CFErrorRef error){
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    else
    {
        tmpAddressBook = ABAddressBookCreate();
    }
    //取得通讯录失败
    if (tmpAddressBook==nil) {
        NSLog(@"获取通讯录失败");
        return ;
    };
    //将通讯录中的信息用数组方式读出
    NSArray* tmpPeoples = (__bridge NSArray *)(ABAddressBookCopyArrayOfAllPeople(tmpAddressBook));
    
    //遍历通讯录中的联系人
    for(id tmpPerson in tmpPeoples){
        
        //获取的联系人单一属性:First name
        NSString* tmpFirstName = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonFirstNameProperty);
        NSLog(@"First name:%@", tmpFirstName);
        if ([tmpFirstName isEqualToString:@""]||tmpFirstName == nil ||tmpFirstName == NULL ||tmpFirstName == Nil) {
            [firstNameArray addObject:@""];
        }else{
            [firstNameArray addObject:tmpFirstName];
        }
        
        //获取的联系人单一属性:Last name
        NSString* tmpLastName = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonLastNameProperty);
        if ([tmpLastName isEqualToString:@""]||tmpLastName == nil ||tmpLastName == NULL ||tmpLastName == Nil) {
            [lastNameArray addObject:@""];
        }else{
            [lastNameArray addObject:tmpLastName];
        }
        NSLog(@"Last name:%@", tmpLastName);
        
        //获取的联系人单一属性:Generic phone number
        ABMultiValueRef tmpPhones = ABRecordCopyValue(CFBridgingRetain(tmpPerson), kABPersonPhoneProperty);
        for(NSInteger j = 0; j < ABMultiValueGetCount(tmpPhones); j++)
        {
            NSString* tmpPhoneIndex = (NSString*)CFBridgingRelease(ABMultiValueCopyValueAtIndex(tmpPhones, j));
            NSLog(@"tmpPhoneIndex%d:%@", j, tmpPhoneIndex);
            if (j>0) {
                if ([tmpFirstName isEqualToString:@""]||tmpFirstName == nil ||tmpFirstName == NULL ||tmpFirstName == Nil) {
                    [firstNameArray addObject:@""];
                }else{
                    [firstNameArray addObject:tmpFirstName];
                }
                if ([tmpLastName isEqualToString:@""]||tmpLastName == nil ||tmpLastName == NULL ||tmpLastName == Nil) {
                    [lastNameArray addObject:@""];
                }else{
                    [lastNameArray addObject:tmpLastName];
                }
            }else{
                if ([tmpPhoneIndex isEqualToString:@""]||tmpPhoneIndex == nil ||tmpPhoneIndex == NULL ||tmpPhoneIndex == Nil) {
                    [phoneNumberArray addObject:@""];
                }else{
                    [phoneNumberArray addObject:tmpPhoneIndex];
                }
            }
            
        }
        CFRelease(tmpPhones);
    }
    //当确定联系人数量，创建tableView
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 568) style:UITableViewStylePlain];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
    
    //释放内存
    CFRelease(tmpAddressBook);
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //需要返回 通讯录 数量
    return [phoneNumberArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

#pragma mark 每当有一个cell进入视野范围内就会调用，返回当前这行显示的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"cell";
    
    PhoneListTVCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[PhoneListTVCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    
    cell.nameLabel.text = [NSString stringWithFormat:@"%@%@",[lastNameArray objectAtIndex:indexPath.row],[firstNameArray objectAtIndex:indexPath.row]];
    cell.phoneNumberLabel.text = [phoneNumberArray objectAtIndex:indexPath.row];
    [cell.addButton addTarget:self action:@selector(clickTableViewCellAddButton:) forControlEvents:UIControlEventTouchUpInside];
    cell.addButton.tag = indexPath.row+1;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)clickTableViewCellAddButton:(UIButton *)sender
{
    NSLog(@"点击了邀请或者添加按钮=%d",sender.tag);
    
    
    
}


- (void)setTitleAndBackButton
{
    //title
    UILabel * navBarTitleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    navBarTitleView.textAlignment = NSTextAlignmentCenter;
    navBarTitleView.text = @"通讯录";
    navBarTitleView.font = [UIFont systemFontOfSize:20];
    navBarTitleView.textColor = [UIColor whiteColor];
    
    [self.navigationItem setTitleView:navBarTitleView];
    
    //返回
    UIButton * backBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backBarButton.frame = CGRectMake(0, 0, 50, 44);
    [backBarButton setTitle:@"返回" forState:UIControlStateNormal];
    backBarButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBarButton addTarget:self action:@selector(clickBackBarButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBarButton = [[UIBarButtonItem alloc]initWithCustomView:backBarButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;
}

- (void)clickBackBarButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
