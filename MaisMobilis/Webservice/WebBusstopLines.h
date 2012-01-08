//
//  WebBusstopLines.h
//  MaisMobilis
//
//  Created by tom on 1/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebBusstopLines : NSObject

+ (void) persistReferencePoints:(NSArray *)jsonObjects;
+ (void) getAllBusstopLines;

@end
