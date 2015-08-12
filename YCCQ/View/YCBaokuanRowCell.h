//
//  YCBaokuanRowCell.h
//  YCCQ
//
//  Created by Liu Feng on 15/7/11.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCBaokuanRowCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *carImageView;
@property (weak, nonatomic) IBOutlet UILabel *carNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *carPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *oldPrice;
@end
