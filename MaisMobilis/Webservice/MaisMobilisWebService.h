//
//  MaisMobilisWebService.h
//  MaisMobilis
//
//  Created by tom on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MaisMobilisWebService : NSObject
+(NSArray *) doGET:(NSString *)resource withQueryString:(NSString *)queryString;
@end
