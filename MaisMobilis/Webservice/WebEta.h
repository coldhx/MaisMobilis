//
//  WebEta.h
//  MaisMobilis
//
//  Created by Rita Silva on 1/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebEta : NSObject

+ (NSString *) getEtaForBusID:(NSString *)busID;
+ (NSString *) getBusStopForBusstopID:(NSString *)busID;

@end
