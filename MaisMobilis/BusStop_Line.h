//
//  BusStop_Line.h
//  MaisMobilis
//
//  Created by tom on 1/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BusStop_Line : NSManagedObject

@property (nonatomic, retain) NSString * busStopID;
@property (nonatomic, retain) NSString * lineID;

@end
