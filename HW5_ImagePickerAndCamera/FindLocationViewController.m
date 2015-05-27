//
//  FindLocationViewController.m
//  HW5_ImagePickerAndCamera
//
//  Created by Man, Keren on 5/21/15.
//  Copyright (c) 2015 Man, Keren. All rights reserved.


#import "FindLocationViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface FindLocationViewController ()<CLLocationManagerDelegate, MKMapViewDelegate, UISearchBarDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) MKLocalSearch *localSearch;
@end

@implementation FindLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mapView.delegate = self;
    self.searchBar.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (self.locationManager == nil){
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        self.locationManager.delegate = self;
     }
    
    if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined){
        [self.locationManager requestWhenInUseAuthorization];
    }
}


-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if(status== kCLAuthorizationStatusAuthorizedWhenInUse){
        [self.locationManager startUpdatingLocation];
        //self.mapView.showsUserLocation = YES;
    }
}

//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
//    [self.locationManager stopUpdatingLocation];
//    NSLog(@"Location: %@", locations);
//}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    [mapView setRegion:MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 10, 10) animated:YES];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    static NSString *calloutIdentifier = @"CalloutAnnotation";
    
    if ([annotation isKindOfClass:[MKPlacemark class]]) {
        MKPinAnnotationView *redPin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"RedPin"];
        if (redPin == nil) {
            redPin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"RedPin"];
            redPin.pinColor = MKPinAnnotationColorRed;
            redPin.animatesDrop = YES;
            redPin.canShowCallout = YES;
        
            CGSize            size = CGSizeMake(100, 40);
            MKAnnotationView *view = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:calloutIdentifier];
            view.frame             = CGRectMake(0.0, 0.0, size.width, size.height);
            view.backgroundColor   = [UIColor whiteColor];
            UIButton *button       = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            button.frame           = CGRectMake(5.0, 5.0, size.width - 10.0, size.height - 10.0);
            [button setTitle:@"Check In" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(Checkin_Tapped) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:button];
            view.canShowCallout    = NO;
            
            redPin.rightCalloutAccessoryView = view;
        
            return redPin;
        }else{
            redPin.annotation = annotation;
            return redPin;
        }
    }
            
    return nil;
}

-(void)Checkin_Tapped{
    NSLog(@"blah");
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    NSLog(@"%@", view.annotation.title);
}


- (IBAction)btnCancel_tapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    MKLocalSearchRequest *searchRequest = [[MKLocalSearchRequest alloc] init];
    searchRequest.region = self.mapView.region;
    searchRequest.naturalLanguageQuery = self.searchBar.text;
    
    if(self.localSearch.isSearching){
        [self.localSearch cancel];
        self.localSearch = nil;
    }
    
    self.localSearch = [[MKLocalSearch alloc] initWithRequest:searchRequest];
    [self.localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        for(MKMapItem *item in response.mapItems){
            [self.mapView addAnnotation:item.placemark];
        }
    }];
}

@end

