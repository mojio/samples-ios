//
//  MapViewController.m
//  SampleApp
//
//  Created by Ashish Agarwal on 2014-10-21.
//  Copyright (c) 2014 Ashish Agarwal. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MapViewController.h"
#import "Location.h"

@interface MapViewController ()

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    Location *vehicleLocation = self.vehicle.location;
    CLLocationCoordinate2D vehicleLocationCoord = CLLocationCoordinate2DMake(vehicleLocation.latitude, vehicleLocation.longitude);
    
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    mapView.mapType = MKMapTypeStandard;
    mapView.showsUserLocation = YES;
    
    // Set the region of the map
    MKCoordinateSpan mapViewSpan = MKCoordinateSpanMake(0.2, 0.2);
    MKCoordinateRegion mapRegion = MKCoordinateRegionMake(vehicleLocationCoord, mapViewSpan);
    [mapView setRegion:mapRegion];
    
    // Add annotation to the map
    MKPointAnnotation *vehicleAnnotation = [[MKPointAnnotation alloc] init];
    [vehicleAnnotation setCoordinate:vehicleLocationCoord];
    [vehicleAnnotation setTitle:self.vehicle.vehicleName];
    [vehicleAnnotation setSubtitle:self.vehicle.location.lastKnownAddress];
    
    [mapView addAnnotation:vehicleAnnotation];
    
    [self.view addSubview:mapView];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
