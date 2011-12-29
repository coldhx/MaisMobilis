//
//  Line.h
//  MaisMobilis
//
//  Created by Rita Silva on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Line : NSManagedObject

@property (nonatomic, retain) NSString * lineID;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * trasporterID;

@end