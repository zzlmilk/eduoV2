//
//  SLMapViewController.m
//  02-pigBank
//
//  Created by 陆承东 on 14/10/22.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MAMapKit/MAMapKit.h>

#import "SLAnnotation.h"

#import "SLBackButton.h"

#import "SLChangeCoordinateTool.h"

#import "SLMapViewController.h"

@interface SLMapViewController () <MAMapViewDelegate>

@property (nonatomic, weak) MAMapView *mapView;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end

@implementation SLMapViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setNavBar];
}

#pragma mark ----- 设置导航栏样式
- (void)setNavBar
{
    UINavigationBar *navBar = self.navigationController.navigationBar;
    // 设置背景
    [navBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    SLBackButton *backButton = [SLBackButton button];
    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
    
    self.title = @"地图";
}

#pragma mark ----- backButtonClicked返回按钮点击事件
- (void)backButtonClicked:(SLBackButton *)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSubviews];
}

#pragma mark ----- 添加所有子控件
- (void)addSubviews
{
    MAMapView *mapView = [[MAMapView alloc] initWithFrame:self.view.frame];
    mapView.delegate = self;
    self.mapView = mapView;
    [self.view addSubview:mapView];
    
    [self setSubviewsData];
}

#pragma mark ----- 设置子控件属性
- (void)setSubviewsData
{
    if (self.outletsInfo) {
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([self.outletsInfo.outletsDetail.latitude doubleValue], [self.outletsInfo.outletsDetail.longitude doubleValue]);
        [self setMapViewDataWithCoordinate:coordinate title:self.outletsInfo.title subTitle:self.outletsInfo.outletsDetail.address];
    } else if (self.merchantDetail) {
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([self.merchantDetail.latitude doubleValue], [self.merchantDetail.longitude doubleValue]);
        [self setMapViewDataWithCoordinate:coordinate title:self.merchantDetail.fullName subTitle:self.merchantDetail.address];
    } else if (self.privilegeProduct) {
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([self.privilegeProduct.privilegeDetail.merchantDetail.latitude doubleValue], [self.privilegeProduct.privilegeDetail.merchantDetail.longitude doubleValue]);
        [self setMapViewDataWithCoordinate:coordinate title:self.privilegeProduct.privilegeDetail.merchantDetail.fullName subTitle:self.privilegeProduct.privilegeDetail.merchantDetail.address];
    } else if (self.activityDetail) {
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([self.activityDetail.latitude doubleValue], [self.activityDetail.longitude doubleValue]);
        [self setMapViewDataWithCoordinate:coordinate title:self.activityDetail.title subTitle:self.activityDetail.address];
    }
}

- (void)setMapViewDataWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title subTitle:(NSString *)subTitle
{
    SLLog(@"%f%f", coordinate.latitude, coordinate.longitude);
    
    SLChangeCoordinateParameters *parameters = [[SLChangeCoordinateParameters alloc] init];
    parameters.key = @"b25b57d75bd1f96f72d9da42b183b9f5";
    parameters.locations = [NSString stringWithFormat:@"%f,%f", coordinate.latitude, coordinate.longitude];
    parameters.coordsys = @"baidu";
    
    [SLChangeCoordinateTool changeCoordinateWithParameters:parameters success:^(SLChangeCoordinateResult *result) {
        if ([result.info isEqualToString:@"ok"]) {
            NSArray *array = [result.locations componentsSeparatedByString:@","];
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([array[0] doubleValue], [array[1] doubleValue]);
            
            MACoordinateSpan span = MACoordinateSpanMake(0.021321, 0.019366);
            MACoordinateRegion region = MACoordinateRegionMake(coordinate, span);
            [self.mapView setRegion:region animated:YES];
            
            SLAnnotation *annotation = [[SLAnnotation alloc] init];
            annotation.coordinate = coordinate;
            annotation.title = title;
            annotation.subtitle = subTitle;
            [self.mapView addAnnotation:annotation];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark ----- mapView代理方法 ----- 自定义大头针样式
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[SLAnnotation class]]) {
        
        static NSString *ID = @"SLAnnotation";
        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:ID];
        if (annotationView == nil) {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ID];
        }
        
        annotationView.annotation = annotation;
        annotationView.image = [UIImage imageNamed:@"default_voiceguide_selecte"];
        
        return annotationView;
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
