//
//  Bus.h
//  MaisMobilis
//
//  Created by tom on 1/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Bus : NSManagedObject

@property (nonatomic, retain) NSString * busID;
@property (nonatomic, retain) NSString * lastStopID;
@property (nonatomic, retain) NSString * latitude;
@property (nonatomic, retain) NSString * lineID;
@property (nonatomic, retain) NSString * longitude;
@property (nonatomic, retain) NSString * meanVelocity;
@property (nonatomic, retain) NSString * precision;
@property (nonatomic, retain) NSString * timeStamp;

@end
