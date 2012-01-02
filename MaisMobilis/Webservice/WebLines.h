//
//  WebLines.h
//  MaisMobilis
//
//  Created by tom on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebLines : NSObject
+ (void) persistLines: (NSArray *)jsonObject;
+ (void) getAllLines;
+ (void)getLinesWithCarrierID: (NSString *)carrierID;
+ (void)getLinesWithBusstopID: (NSString *)busstopID;
+ (void)getLineWithID: (NSString *)lineID;
@end
