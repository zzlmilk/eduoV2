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

#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

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
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)]];
        [self.scrollView addSubview:imageView];
    }
    
}

- (void)imageTap:(UITapGestureRecognizer *)recognizer
{
    SLMerchantDetail *merchantDetail = self.item.merchantDetailFrame.merchantDetail;
    
    int count = (int)merchantDetail.merchantPhotoList.count;
    
    // 1.封装图片数据
    NSMutableArray *myphotos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 一个MJPhoto对应一张显示的图片
        MJPhoto *mjphoto = [[MJPhoto alloc] init];
        
        mjphoto.srcImageView = self.scrollView.subviews[i]; // 来源于哪个UIImageView
        SLMerchantPhoto *merchantPhoto = merchantDetail.merchantPhotoList[i];
        NSString *photoUrl = merchantPhoto.pictureUrl;
        mjphoto.url = [NSURL URLWithString:photoUrl]; // 图片路径
        
        [myphotos addObject:mjphoto];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = recognizer.view.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = myphotos; // 设置所有的图片
    [browser show];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
