//
//  WebReferencePoint.h
//  MaisMobilis
//
//  Created by tom on 1/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebReferencePoint : NSObject
+ (void) persistReferencePoints : (NSArray *) jsonObjects;
+ (void) getAllReferencePoints;
+ (void) getLinesWithLineID:(NSString *)lineID;

@end
