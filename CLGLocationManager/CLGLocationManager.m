//
//  CLGLocationManager.m
//  Ratiio_iOS
//
//  Created by Voronok Vitaliy on 11/24/15.
//  Copyright © 2015 IDPGroup. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

#import "CLGLocationManager.h"

@interface CLGLocationManager () <CLLocationManagerDelegate>
@property (nonatomic, strong)       CLLocationManager           *locationManager;

@property (nonatomic, assign, getter=isRunning)     BOOL        running;

- (void)setupLocationManager;

- (void)applicationDidEnterBackground;
- (void)applicationDidBecomeActive;

- (void)subscribeToApplicationNotifications;
- (void)unsubscribeFromApplicationNotifications;

@end

@implementation CLGLocationManager

#pragma mark -
#pragma mark Class Methods

+ (instancetype)sharedManager {
    static CLGLocationManager *sharedManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [self new];
        
        sharedManager.locationManager = [CLLocationManager new];
        
        [sharedManager setupLocationManager];
        [sharedManager subscribeToApplicationNotifications];
    });
    
    return sharedManager;
}

#pragma mark -
#pragma mark Initialization and Deallocation

- (void)dealloc {
    [self unsubscribeFromApplicationNotifications];
}

#pragma mark -
#pragma mark Public

- (void)startUpdatingLocation {
    if (!self.isRunning) {
        [self.locationManager startUpdatingLocation];
        
        self.running = YES;
    }
}

- (void)stopUpdatingLocation {
    if (self.isRunning) {
        [self.locationManager stopUpdatingLocation];
        
        self.running = NO;
    }
}

#pragma mark -
#pragma mark Private

- (void)setupLocationManager {
    CLLocationManager *locationManager = self.locationManager;
    
    [locationManager requestAlwaysAuthorization];
    
    [locationManager setDelegate:self];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    locationManager.pausesLocationUpdatesAutomatically = NO;
    
    if ([locationManager respondsToSelector:@selector(allowsBackgroundLocationUpdates)]) {
        locationManager.allowsBackgroundLocationUpdates = YES;
    }
}

- (void)applicationDidEnterBackground {
    CLGBackgroundTaskManager *backgroundTaskManager = [CLGBackgroundTaskManager sharedBackgroundTaskManager];
    
    [backgroundTaskManager beginNewBackgroundTask];
    
    self.backgroundTaskManager = backgroundTaskManager;
}

- (void)applicationDidBecomeActive {
    
}

- (void)subscribeToApplicationNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidEnterBackground)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidBecomeActive)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
}

- (void)unsubscribeFromApplicationNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidEnterBackgroundNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidBecomeActiveNotification
                                                  object:nil];
}

#pragma mark -
#pragma mark CLGLocationManagerDelegate

- (void)locationManager:(CLGLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    if ([self.delegate respondsToSelector:@selector(locationDidUpdate)]) {
        [self.delegate performSelector:@selector(locationDidUpdate)];
    }
}

- (void)locationManager:(CLGLocationManager *)manager didFailWithError:(NSError *)error {
    
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if ([self.delegate respondsToSelector:@selector(locationAuthorizationStatusDidChange)]) {
        [self.delegate performSelector:@selector(locationAuthorizationStatusDidChange)];
    }
}

@end
