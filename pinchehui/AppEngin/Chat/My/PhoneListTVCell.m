//
//  PhoneListTVCell.m
//  车商官家
//
//  Created by mac on 14-10-21.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "PhoneListTVCell.h"

@implementation PhoneListTVCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 200, 30)];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont systemFontOfSize:17];
        [self addSubview:_nameLabel];
        
        _phoneNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 35, 200, 20)];
        _phoneNumberLabel.textColor = [UIColor blackColor];
        _phoneNumberLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_phoneNumberLabel];
        
        self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.addButton.frame = CGRectMake(220, 15, 80, 30);
        [self.addButton setTitle:@"邀请" forState:UIControlStateNormal];
        [self.addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:self.addButton];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
