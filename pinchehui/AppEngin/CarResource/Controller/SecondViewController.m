//
//  SecondViewController.m
//  ChatDemo-UI2.0
//
//  Created by mac on 14-10-13.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "SecondViewController.h"
#import "CarResourceModel.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

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
    
    [self setSubViews];
    
    
    
}

- (void)setSubViews
{
    _carListTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, 320, 568-64-94) style:UITableViewStylePlain];
    _carListTableView.delegate = self;
//<<<<<<< .mine
    _carListTableView.tag = 1;
//=======
    _carListTableView.tag = 1;
    _carListTableView.clipsToBounds = YES;
//>>>>>>> .r9
    _carListTableView.dataSource = self;
    [self.view addSubview:_carListTableView];
    
    typeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -456, 320, 568-64-94) style:UITableViewStylePlain];
    typeTableView.tag = 2;
    typeTableView.hidden = YES;
    typeTableView.delegate = self;
    typeTableView.dataSource = self;
    [self.view addSubview:typeTableView];
    
    isTypeTableViewShow = NO;
    
    _typeButton = [self makeButtonWithFrame:CGRectMake(0, 0, 80, 44) AndTitle:@"类型" AndTag:1];
    _brandButton = [self makeButtonWithFrame:CGRectMake(80, 0, 80, 44) AndTitle:@"品牌" AndTag:2];
    _priceButton = [self makeButtonWithFrame:CGRectMake(160, 0, 80, 44) AndTitle:@"价格" AndTag:3];
    _moreButton = [self makeButtonWithFrame:CGRectMake(240, 0, 80, 44) AndTitle:@"更多" AndTag:4];
    [self.view addSubview:_typeButton];
    [self.view addSubview:_brandButton];
    [self.view addSubview:_priceButton];
    [self.view addSubview:_moreButton];
    
}

- (void)clickButton:(UIButton *)sender
{
    switch (sender.tag) {
        case 1:
        {
            //类型
            if (isTypeTableViewShow == NO) {
                typeTableView.hidden = NO;
                [UIView animateWithDuration:0.5 animations:^(void){
                    self->typeTableView.frame = CGRectMake(0, 44, 320, 568-64-94);
                }completion:^(BOOL isFinished){
                }];
                isTypeTableViewShow = YES;
            }else{
                [UIView animateWithDuration:0.5 animations:^(void){
                    self->typeTableView.frame = CGRectMake(0, -456, 320, 568-64-94);
                }completion:^(BOOL isFinished){
                    self->typeTableView.hidden = YES;
                }];
                isTypeTableViewShow = NO;
            }
            
        }
            break;
        case 2:
        {
            //品牌
        }
            break;
        case 3:
        {
            //价格
        }
            break;
        case 4:
        {
            //更多
        }
            break;
            
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

#pragma mark 每当有一个cell进入视野范围内就会调用，返回当前这行显示的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"cell";
    /*
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = @"aaa";
    
    */
    
    CarCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[CarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
 
    }
    
    CarResourceModel *carmodel = [[CarResourceModel alloc]init];
    
    cell.infoname.text = @"name";
    cell.infosubname.text = @"sub";
    cell.price.text = @"价格";
    cell.city.text = @"beijing";
    cell.time.text = @"3天前";
    return cell;
}



#pragma mark 点击了cell后的操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //点击cell执行方法
    
    CarDetailInfoController *cardetail = [[CarDetailInfoController alloc]init];
    [self.navigationController pushViewController:cardetail animated:YES];
    
}


//button
- (UIButton *)makeButtonWithFrame:(CGRect)frame AndTitle:(NSString *)title AndTag:(int)tagNumber
{
    
    UIButton * but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = frame;
    [but setTitle:title forState:UIControlStateNormal];
    [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    but.tag = tagNumber;
    but.layer.borderColor = [UIColor lightGrayColor].CGColor;
    but.layer.borderWidth = 0.5;
    [but setBackgroundColor:[UIColor whiteColor]];
    but.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [but addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    return but;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
