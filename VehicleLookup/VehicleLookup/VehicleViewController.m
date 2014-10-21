//
//  VehicleViewController.m
//  SampleApp
//
//  Created by Ashish Agarwal on 2014-10-18.
//  Copyright (c) 2014 Ashish Agarwal. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <AddressBookUI/AddressBookUI.h>

#import "VehicleViewController.h"
#import "MapViewController.h"
#import "UserPrefs.h"
#import "AFNetworking.h"
#import "Vehicle.h"

@interface VehicleViewController ()

@property (strong, nonatomic) IBOutlet UILabel *vehicleAddressLabel;
@property (strong, nonatomic) IBOutlet UILabel *fuelEfficiencyLabel;
@property (strong, nonatomic) IBOutlet UILabel *fuelLabel;
@property (strong, nonatomic) IBOutlet UIButton *viewCarButton;

@property (strong, nonatomic) Vehicle *vehicle;

-(IBAction)viewCarButtonPressed:(id)sender;

@end

@implementation VehicleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.vehicle = [[Vehicle alloc] init];
    
    [self downloadVehicleData];
}

-(void) downloadVehicleData {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [[manager requestSerializer] setValue:[UserPrefs mojioApiToken] forHTTPHeaderField:@"MojioAPIToken"];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"LastContactTime", @"sortBy", @"true", @"desc", nil];
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.moj.io:443/v1/Vehicles"];
    [manager GET:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray *data = [responseObject objectForKey:@"Data"];
            NSDictionary *firstVehicleObject = [data firstObject];
            
            NSNumber *fuelEfficiency = [firstVehicleObject objectForKey:@"LastFuelEfficiency"];
            NSNumber *fuelLevel = [firstVehicleObject objectForKey:@"FuelLevel"];
            NSNumber *lat = [[firstVehicleObject objectForKey:@"LastLocation"] objectForKey:@"Lat"];
            NSNumber *lng = [[firstVehicleObject objectForKey:@"LastLocation"] objectForKey:@"Lng"];
            
            Location *vehicleLocation = [[Location alloc] initWithLatitude:lat.doubleValue andLongitude:lng.doubleValue];
            
            CLLocation *location = [[CLLocation alloc] initWithLatitude:vehicleLocation.latitude longitude:vehicleLocation.longitude];
            CLGeocoder *geocoder = [[CLGeocoder alloc] init];
            
            // Get the address from the location coordinates and display it
            [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placeMarks, NSError *error) {
                CLPlacemark *placemark = [placeMarks lastObject];
                NSString *address = [NSString stringWithFormat:@"%@", ABCreateStringWithAddressDictionary(placemark.addressDictionary, YES)];
                self.vehicle.location.lastKnownAddress = address;
                [self performSelectorOnMainThread:@selector(displayVehicleAddress) withObject:nil waitUntilDone:YES];
            }];
            
            [self.vehicle setVehicleName:[firstVehicleObject objectForKey:@"Name"]];
            [self.vehicle setFuelEfficiency:fuelEfficiency.doubleValue];
            [self.vehicle setFuelLevel:fuelLevel.doubleValue];
            [self.vehicle setLocation:vehicleLocation];
            
            [self performSelectorOnMainThread:@selector(displayVehicleData) withObject:nil waitUntilDone:NO];
            
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
    }];
    
}

-(void) displayVehicleData {
    self.fuelLabel.text = [NSString stringWithFormat:@"%f", self.vehicle.fuelLevel];
    self.fuelEfficiencyLabel.text = [NSString stringWithFormat:@"%f", self.vehicle.fuelEfficiency];
    
}

-(void) displayVehicleAddress {
    self.vehicleAddressLabel.text = self.vehicle.location.lastKnownAddress;
}

-(IBAction)viewCarButtonPressed:(id)sender {
    
    if (self.vehicle.location == nil) {
        return;
    }
    
    [self performSegueWithIdentifier:@"showCarSegue" sender:nil];
}

#pragma mark - Navigation
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showCarSegue"]) {
        MapViewController *mapController = [segue destinationViewController];
        mapController.vehicle = self.vehicle;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
