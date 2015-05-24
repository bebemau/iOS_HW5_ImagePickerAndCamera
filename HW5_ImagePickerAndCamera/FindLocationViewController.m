//
//  FindLocationViewController.m
//  HW5_ImagePickerAndCamera
//
//  Created by Man, Keren on 5/21/15.
//  Copyright (c) 2015 Man, Keren. All rights reserved.
//

//#import "FindLocationViewController.h"
//#import <CoreLocation/CoreLocation.h>
//#import <MapKit/MapKit.h>
//
//@interface FindLocationViewController ()<CLLocationManagerDelegate, MKMapViewDelegate>
//@property (nonatomic, strong) CLLocationManager *locationManager;
//@property (weak, nonatomic) IBOutlet MKMapView *mapView;
//
//@end
//
//@implementation FindLocationViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    
//    self.mapView.delegate = self;
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    
//    if (self.locationManager == nil){
//        self.locationManager = [[CLLocationManager alloc]init];
//        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
//        self.locationManager.delegate = self;
//     }
//    
//    if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined){
//        [self.locationManager requestWhenInUseAuthorization];
//    }
//}
//
//
//-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
//    if(status== kCLAuthorizationStatusAuthorizedWhenInUse){
////        [self.locationManager startUpdatingLocation];
//        self.mapView.showsUserLocation = YES;
//    }
//}
//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
//    //[self.locationManager stopUpdatingLocation];
//    NSLog(@"Location: %@", locations);
//}
//
//-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
//    [mapView setRegion:MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 10, 10) animated:YES];
//}
//
//- (IBAction)btnCancel_tapped:(id)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



// his code starts here

#import "FindLocationViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface FindLocationViewController () <CLLocationManagerDelegate, MKMapViewDelegate, UISearchBarDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLGeocoder *geocoder;
@property (nonatomic, strong) MKLocalSearch *localSearch;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@end

@implementation FindLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (self.locationManager == nil) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        self.locationManager.delegate = self;
    }
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestWhenInUseAuthorization];
    }
}

#pragma mark - MKMapView
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    [mapView setRegion:MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 10, 10) animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        MKPinAnnotationView *greenPin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"GreenPin"];
        if (greenPin == nil) {
            greenPin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"GreenPin"];
            greenPin.pinColor = MKPinAnnotationColorGreen;
            greenPin.animatesDrop = YES;
            greenPin.canShowCallout = YES;
            
            UIButton *calloutButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [calloutButton addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
            
            greenPin.rightCalloutAccessoryView = calloutButton;
            
            return greenPin;
        }else{
            greenPin.annotation = annotation;
            return greenPin;
        }
    }
    
    return nil;
    
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    NSLog(@"%@", view.annotation.title);
}

#pragma mark - CLLocationManager delegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.locationManager startUpdatingLocation];
        self.mapView.showsUserLocation = YES;
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    MKLocalSearchRequest *searchRequest = [[MKLocalSearchRequest alloc] init];
    searchRequest.region = self.mapView.region;
    searchRequest.naturalLanguageQuery = searchBar.text;
    
    self.localSearch = [[MKLocalSearch alloc] initWithRequest:searchRequest];
    [self.localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        [self.mapView removeAnnotations:self.mapView.annotations];
        
        for (MKMapItem *mapItem in response.mapItems) {
            [self.mapView addAnnotation:mapItem.placemark];
        }
    }];
}



@end
