//
//  SLMapViewController.m
//  02-pigBank
//
//  Created by 陆承东 on 14/10/22.
//  Copyright (c) 2014年 陆承东. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#import "SLMapViewController.h"

#import "SLAnnotation.h"

@interface SLMapViewController () <MKMapViewDelegate>

@property (nonatomic, weak) MKMapView *mapView;

@property (strong, nonatomic) CLGeocoder *geocoder;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end

@implementation SLMapViewController

- (CLGeocoder *)geocoder
{
    if (_geocoder == nil) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    mapView.delegate = self;
    mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    self.mapView = mapView;
    [self.view addSubview:mapView];
    
    // 创建显示区域
    MKCoordinateSpan span = MKCoordinateSpanMake(0.021321, 0.019366);
    // 创建显示的大头针
    SLAnnotation *annotation = [[SLAnnotation alloc] init];
    if (self.outletsInfo) {
        annotation.coordinate = CLLocationCoordinate2DMake([self.outletsInfo.outletsDetail.latitude doubleValue], [self.outletsInfo.outletsDetail.longitude doubleValue]);
        self.coordinate = annotation.coordinate;
        annotation.title = self.outletsInfo.title;
        annotation.subtitle = self.outletsInfo.outletsDetail.address;
    } else if (self.merchantDetail) {
        annotation.coordinate = CLLocationCoordinate2DMake([self.merchantDetail.latitude doubleValue], [self.merchantDetail.longitude doubleValue]);
        self.coordinate = annotation.coordinate;
        annotation.title = self.merchantDetail.fullName;
        annotation.subtitle = self.merchantDetail.address;
    }
    [mapView addAnnotation:annotation];
    MKCoordinateRegion region = MKCoordinateRegionMake(annotation.coordinate, span);
    [mapView setRegion:region animated:YES];
}

// 在此方法中自定义annotationView
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *ID = @"datouzhen";
    
    MKPinAnnotationView *pinAnnotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    
    if (pinAnnotationView == nil) {
        pinAnnotationView = [[MKPinAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:ID];
    }
    
    pinAnnotationView.annotation = annotation;
    pinAnnotationView.canShowCallout = YES;
    pinAnnotationView.animatesDrop = YES;
    UIButton *leftCalloutAccessoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftCalloutAccessoryButton setTitle:@"本页导航" forState:UIControlStateNormal];
    [leftCalloutAccessoryButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    leftCalloutAccessoryButton.titleLabel.font = SLFont14;
    leftCalloutAccessoryButton.frame = CGRectMake(0, 0, 60, pinAnnotationView.frame.size.height);
    [leftCalloutAccessoryButton addTarget:self action:@selector(leftCalloutAccessoryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    pinAnnotationView.leftCalloutAccessoryView = leftCalloutAccessoryButton;
    
    UIButton *rightCalloutAccessoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightCalloutAccessoryButton setTitle:@"系统导航" forState:UIControlStateNormal];
    [rightCalloutAccessoryButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    rightCalloutAccessoryButton.titleLabel.font = SLFont14;
    rightCalloutAccessoryButton.frame = CGRectMake(0, 0, 60, pinAnnotationView.frame.size.height);
    [rightCalloutAccessoryButton addTarget:self action:@selector(rightCalloutAccessoryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    pinAnnotationView.rightCalloutAccessoryView = rightCalloutAccessoryButton;
    
    return pinAnnotationView;
    
}

- (void)rightCalloutAccessoryButtonClick:(UIButton *)button
{
    CLLocation *toLocation = [[CLLocation alloc] initWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
    
    [self.geocoder reverseGeocodeLocation:toLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) return;
        
        CLPlacemark *placemark = [placemarks firstObject];
        
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithPlacemark:placemark]];
        
        NSMutableDictionary *options = [NSMutableDictionary dictionary];
        options[MKLaunchOptionsDirectionsModeKey] = MKLaunchOptionsDirectionsModeDriving;
        options[MKLaunchOptionsShowsTrafficKey] = @YES;
        [MKMapItem openMapsWithItems:@[currentLocation, toLocation] launchOptions:options];
    }];
}

#warning ----- 导航报错
- (void)leftCalloutAccessoryButtonClick:(UIButton *)button
{
    CLLocation *toLocation = [[CLLocation alloc] initWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
    
    [self.geocoder reverseGeocodeLocation:toLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) return;
        
        CLPlacemark *toPlacemark = [placemarks firstObject];
        
        // 2.查找路线
        // 方向请求
        MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
        // 设置起点
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        MKPlacemark *sourcePm = currentLocation.placemark;
        request.source = [[MKMapItem alloc] initWithPlacemark:sourcePm];
        
        // 设置终点
        MKPlacemark *destinationPm = [[MKPlacemark alloc] initWithPlacemark:toPlacemark];
        request.destination = [[MKMapItem alloc] initWithPlacemark:destinationPm];
        
        // 方向对象
        MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
        
        // 计算路线
        [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
            SLLog(@"%@", error);
            // 遍历所有的路线
            for (MKRoute *route in response.routes) {
                // 添加路线遮盖
                [self.mapView addOverlay:route.polyline];
            }
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
