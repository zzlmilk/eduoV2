//
//  SLMerchantPhotosCell.m
//  02-pigBank
//
//  Created by 陆承东 on 14/10/23.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import "SLMerchantPhotosCell.h"

#import "UIImageView+WebCache.h"

#import "SLMerchantPhoto.h"

@interface SLMerchantPhotosCell ()

@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation SLMerchantPhotosCell

#pragma mark - 初始化
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"SLMerchantHeadCell";
    SLMerchantPhotosCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SLMerchantPhotosCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addContentView];
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
    }
    return self;
}

// 添加所有子控件
- (void)addContentView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenW, 89)];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.scrollEnabled = YES;
    scrollView.contentSize = CGSizeMake(900, 500);
    self.scrollView = scrollView;
    [self.contentView addSubview:scrollView];
    
    UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, 89.5, [UIScreen mainScreen].bounds.size.width, 0.5)];
    separator.backgroundColor = SLColorRGBA(0, 0, 0, 0.2);
    [self.contentView addSubview:separator];
}

- (void)setItem:(SLMerchantDetailItem *)item
{
    _item = item;
    
    SLMerchantDetail *merchantDetail = item.merchantDetailFrame.merchantDetail;
    
    CGFloat imageW = (screenW - 4 * middleMargin) / 3;
#warning ----- scrollView的contentSize设置成功,但是scrollView无法滚动
    if (merchantDetail.merchantPhotoList.count <= 3) {
        self.scrollView.contentSize = CGSizeZero;
    } else {
        self.scrollView.contentSize = CGSizeMake((imageW + middleMargin) * merchantDetail.merchantPhotoList.count + middleMargin, 0);
    }
    
    for (int i = 0; i < merchantDetail.merchantPhotoList.count; i++) {
        SLMerchantPhoto *merchantPhoto = merchantDetail.merchantPhotoList[i];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * (imageW + middleMargin) + middleMargin, middleMargin, imageW, 70)];
        imageView.userInteractionEnabled = YES;
        [imageView setImageWithURL:[NSURL URLWithString:merchantPhoto.pictureUrl] placeholderImage:[UIImage imageNamed:@"app_bg_default_home_img_normal"]];
        [self.scrollView addSubview:imageView];
    }
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
