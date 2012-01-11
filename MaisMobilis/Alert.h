//
//  Alert.h
//  MaisMobilis
//
//  Created by Rita Silva on 1/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Alert : NSManagedObject

@property (nonatomic, retain) NSString * alertID;
@property (nonatomic, retain) NSNumber * busStopDelayNumber;
@property (nonatomic, retain) NSString * routeID;
@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) NSDate * stopTime;

@end
