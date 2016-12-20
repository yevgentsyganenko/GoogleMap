//
//  CLGLocationManager.h
//  Ratiio_iOS
//
//  Created by Voronok Vitaliy on 11/24/15.
//  Copyright © 2015 IDPGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CLGLocationManagerDelegate <NSObject>

- (void)locationAuthorizationStatusDidChange;
- (void)locationDidUpdate;

@end

@interface CLGLocationManager : NSObject
@property (nonatomic, strong)   id<CLGLocationManagerDelegate>  delegate;

+ (instancetype)sharedManager;

- (void)startUpdatingLocation;
- (void)stopUpdatingLocation;

@end
