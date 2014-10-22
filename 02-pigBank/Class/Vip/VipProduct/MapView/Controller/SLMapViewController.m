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

@end

@implementation SLMapViewController

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
        annotation.title = self.outletsInfo.title;
        annotation.subtitle = self.outletsInfo.outletsDetail.address;
    } else if (self.merchantDetail) {
        annotation.coordinate = CLLocationCoordinate2DMake([self.merchantDetail.latitude doubleValue], [self.merchantDetail.longitude doubleValue]);
        annotation.title = self.merchantDetail.fullName;
        annotation.subtitle = self.merchantDetail.address;
    }
    [mapView addAnnotation:annotation];
    MKCoordinateRegion region = MKCoordinateRegionMake(annotation.coordinate, span);
    [mapView setRegion:region animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
