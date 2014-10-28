//
//  DateTableViewCell.h
//  车商官家
//
//  Created by HLKJ on 14-10-23.
//  Copyright (c) 2014年 HLKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *Name;
@property (strong, nonatomic) IBOutlet UILabel *Date;
@property (strong, nonatomic) IBOutlet UIPickerView *PickDate;
@end
