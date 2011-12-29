//
//  Bus.h
//  MaisMobilis
//
//  Created by Rita Silva on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Bus : NSManagedObject

@property (nonatomic, retain) NSString * busID;
@property (nonatomic, retain) NSString * lastStopID;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSString * lineID;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSNumber * meanVelocity;
@property (nonatomic, retain) NSNumber * precision;
@property (nonatomic, retain) NSNumber * timeStamp;

@end
