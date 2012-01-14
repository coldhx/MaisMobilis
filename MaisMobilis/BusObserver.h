//
//  BusObserver.h
//  MaisMobilis
//
//  Created by tom on 1/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "BusStop_Line.h"
#import "DataController.h"
#import "Line.h"
#import "Alert.h"

@interface BusObserver : NSObject
{
    NSMutableDictionary * _observerInstances;
    AVAudioPlayer * _player;
}

+ (BusObserver *) getInstance;
- (void) addObserverWithAlert:(Alert *)alert forLine:(NSString *)lineID andBusstop:(NSString *)busstopID withTolerance:(NSNumber *)tolerance;
- (void) removeObserverWithID:(NSString *)id;
- (void) startAudioWorkaround;
- (void) beginObserving:(NSDictionary *)objects;
@end
